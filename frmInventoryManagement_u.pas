unit frmInventoryManagement_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Edit, FMX.StdCtrls, FMX.ScrollBox, FMX.Grid, FMX.Objects,
  FMX.SVGIconImage, FMX.Controls.Presentation, Data.DB, Data.Win.ADODB,
  dbmEnviroPOSDB_u,
  FMX.Bind.Grid, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.DialogService, IdMessage, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, FMX.ListBox;

type
  TfrmInventoryManagement = class(TForm)
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Label1: TLabel;
    SVGIconImage1: TSVGIconImage;
    edtProductID: TEdit;
    grdInventory: TStringGrid;
    btnEdit: TButton;
    btnAdd: TButton;
    btnRemove: TButton;
    btnRequestStock: TButton;
    edtProductSearch: TEdit;
    SearchEditButton1: TSearchEditButton;
    Label2: TLabel;
    edtProductName: TEdit;
    Label3: TLabel;
    edtProductCode: TEdit;
    Label4: TLabel;
    edtCostPrice: TEdit;
    Label5: TLabel;
    edtSellingPrice: TEdit;
    Label6: TLabel;
    edtStockQty: TEdit;
    Label7: TLabel;
    edtSoldQty: TEdit;
    Label8: TLabel;
    qryInventory: TADOQuery;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    LinkControlToFieldProductID: TLinkControlToField;
    LinkControlToFieldProductName: TLinkControlToField;
    LinkControlToFieldProductCode: TLinkControlToField;
    LinkControlToFieldCostPrice: TLinkControlToField;
    LinkControlToFieldSellingPrice: TLinkControlToField;
    LinkControlToFieldSoldQty: TLinkControlToField;
    LinkControlToFieldStockQty: TLinkControlToField;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    cmbFilters: TComboBox;
    btnFilter: TButton;
    procedure grdInventoryCellClick(const Column: TColumn; const Row: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnRequestStockClick(Sender: TObject);
    procedure SearchEditButton1Click(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInventoryManagement: TfrmInventoryManagement;
  iProductID: Integer;

implementation

uses frmAuthentication_u, frmEnviroPOSMain_u;

{$R *.fmx}

procedure TfrmInventoryManagement.btnAddClick(Sender: TObject);
begin
  with dmDatabase do
  begin
    tblInventory.Append;
    tblInventory['ProductName'] := InputBox('Adding a product',
      'Enter Product Name', '');
    tblInventory['ProductCode'] := InputBox('Adding a product',
      'Enter Product Code', '');
    tblInventory['SellingPrice'] := InputBox('Adding a product',
      'Enter Selling Price', '');
    tblInventory['CostPrice'] := InputBox('Adding a product',
      'Enter Cost Price', '');
    tblInventory['StockQty'] := InputBox('Adding a product', 'Enter Stock', '');
    tblInventory['SoldQty'] := 0;
    tblInventory['SupplierID'] := frmAuthentication.iEmployeeID;
    tblInventory.Post;

    showmessage('Added product successfully!');
    // reset grid to show changes.
    FormShow(Self);
  end;
end;

procedure TfrmInventoryManagement.btnEditClick(Sender: TObject);
begin
  if (dmDatabase.tblInventory['SupplierID'] = frmAuthentication.iEmployeeID) OR
    (frmAuthentication.sUserType = 'Manager') then
  begin
    if btnEdit.Text = 'Edit Product' then
    begin

      { enable the buttons to edit }
      edtProductName.Enabled := true;
      edtProductCode.Enabled := true;
      edtCostPrice.Enabled := true;
      edtSellingPrice.Enabled := true;
      edtStockQty.Enabled := true;
      btnEdit.Text := 'Save Edits';
    end
    else if btnEdit.Text = 'Save Edits' then
    begin
      dmDatabase.tblInventory.Post;
      btnEdit.Text := 'Edit Product';

      { disable the buttons again }
      edtProductName.Enabled := false;
      edtProductCode.Enabled := false;
      edtCostPrice.Enabled := false;
      edtSellingPrice.Enabled := false;
      edtStockQty.Enabled := false;

      // reset grid to show changes.
      FormShow(Self);
    end;
  end
  else
    raise Exception.Create('You do not have permission to edit this product!');

end;

procedure TfrmInventoryManagement.btnFilterClick(Sender: TObject);
begin
  qryInventory.Close;
  case cmbFilters.ItemIndex of
    0: // no filter
      begin
        FormShow(Self);
      end;
    1: // Most expensive product
      begin
        qryInventory.SQL.Text :=
          'SELECT SellingPrice AS [Highest Selling Price], ProductName FROM tblInventory'
          + ' WHERE SellingPrice = (SELECT MAX(SellingPrice) FROM tblInventory)';
      end;
    2: // Cheapest product
      begin
        qryInventory.SQL.Text :=
          'SELECT SellingPrice AS [Highest Selling Price], ProductName FROM tblInventory '
          + 'WHERE SellingPrice = (SELECT MIN(SellingPrice) FROM tblInventory)';
      end;
    3: // Total amount of products sold by supplier
      begin
        qryInventory.SQL.Text :=
          'SELECT Count(ProductID) AS [Products Sold] FROM tblInventory' +
          ' WHERE SupplierID = ' + IntToStr(frmAuthentication.iEmployeeID);
      end;
    4: // Average price of products
      begin
        qryInventory.SQL.Text :=
          'SELECT Avg(SellingPrice) AS [Average Price] FROM tblInventory'
      end;
    5: // Sold Quantity (sorted ascending)
      begin
        qryInventory.SQL.Text :=
          'SELECT SoldQty, ProductName FROM tblInventory ORDER BY SoldQty ASC'
      end;
    6: // Sold Quantity (sorted descending)
      begin
        qryInventory.SQL.Text :=
          'SELECT SoldQty, ProductName FROM tblInventory ORDER BY SoldQty DESC'
      end;
  end;
  qryInventory.Open;
end;

procedure TfrmInventoryManagement.btnRemoveClick(Sender: TObject);
begin
  { Ask if user is sure that they want to delete }
  TDialogService.MessageDialog('Do you want to delete the SELECTED product?',
    TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    begin
      case AResult of
        mrYes:
          begin
            // find product to delete; delete it; update grid
            dmDatabase.tblInventory.Locate('ProductID', iProductID, []);
            dmDatabase.tblInventory.Delete;
            FormShow(Self);
          end;
      end;
    end);

end;

procedure TfrmInventoryManagement.btnRequestStockClick(Sender: TObject);
var
  sBody: TStringList;
begin
  { Send email to supplier }

  with dmDatabase do
  begin
    tblInventory.Locate('ProductID', iProductID, []);

    { Actual email body (message) }
    sBody := TStringList.Create;
    sBody.Add('A manager has requested that you restock the following item:');
    sBody.Add('Product Name: ' + tblInventory['ProductName']);
    sBody.Add('Product Code: ' + tblInventory['ProductCode']);
    sBody.Add('');
    sBody.Add('CURRENT STOCK: ' + IntToStr(tblInventory['StockQty']));
    sBody.Add(
      'Please restock as soon as possible to avoid removal as a supplier.');
    sBody.Add('');
    sBody.Add('Yours sincerely,');
    sBody.Add('EnviroPOS Inventory Management System | Automated e-mail');

    tblEmployees.Locate('EmployeeID', tblInventory['SupplierID'], []);

    { Setup Email settings appropriately }
    IdMessage1.Body := sBody;
    IdMessage1.Subject := 'Request for a Restock';
    IdMessage1.From.Name := 'EnviroPOS Inventory System';
    IdMessage1.From.Address := 'enviroposautomated@gmail.com';
    IdMessage1.Recipients.Add.Address := dmDatabase.tblEmployees
      ['EmailAddress'];
    IdMessage1.ContentType := 'text/plain';
  end;

  { Attempt to send E-Mail! }
  IdSMTP1.Connect; // connects to gmail smtp
  try
    if IdSMTP1.Connected = false then
    begin
      raise Exception.Create('Failed to send e-mail.');
    end;

    IdSMTP1.Send(IdMessage1);
    showmessage('Restock request sent to supplier successfully!');
  finally
    IdSMTP1.Disconnect;
  end;

end;

procedure TfrmInventoryManagement.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  frmEnviroPOSMain.updateStatistics;
end;

procedure TfrmInventoryManagement.FormShow(Sender: TObject);
begin
  qryInventory.Close;

  { Show manager (admin) all products; only show supplier their products }
  if frmAuthentication.sUserType = 'Supplier' then
  begin
    qryInventory.SQL.Text := 'SELECT * FROM tblInventory WHERE SupplierID = ' +
      IntToStr(frmAuthentication.iEmployeeID);
  end
  else if frmAuthentication.sUserType = 'Manager' then
  begin
    qryInventory.SQL.Text := 'SELECT * FROM tblInventory';
    btnRequestStock.Visible := true;
  end;
  qryInventory.Open;
end;

procedure TfrmInventoryManagement.grdInventoryCellClick(const Column: TColumn;
const Row: Integer);
begin
  iProductID := StrToInt(grdInventory.Cells[0, Row]);
  with dmDatabase do
  begin
    tblInventory.Locate('ProductID', iProductID, []);
  end;
end;

procedure TfrmInventoryManagement.SearchEditButton1Click(Sender: TObject);
begin
  qryInventory.Close;

  { Find products starting with text in search edit }

  if frmAuthentication.sUserType = 'Manager' then
    qryInventory.SQL.Text :=
      'SELECT * FROM tblInventory WHERE ProductName LIKE ''' +
      edtProductSearch.Text + '%'''
  else if frmAuthentication.sUserType = 'Supplier' then
  begin
    { Crucial: Only show products specific to suppliers }
    qryInventory.SQL.Text :=
      'SELECT * FROM tblInventory WHERE ProductName LIKE ''' +
      edtProductSearch.Text + '%'' AND SupplierID = ' +
      IntToStr(frmAuthentication.iEmployeeID);
  end;

  qryInventory.Open;
end;

end.
