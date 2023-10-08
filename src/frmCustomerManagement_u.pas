unit frmCustomerManagement_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.SVGIconImage, FMX.StdCtrls, FMX.Controls.Presentation, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Effects, FMX.Filter.Effects,
  FMX.ImgList, FMX.ListBox, dbmEnviroPOSDB_u, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Controls,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, FMX.Layouts,
  FMX.Bind.Navigator, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  Data.Win.ADODB, FMX.DialogService;

type
  TfrmCustomerManagement = class(TForm)
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Label1: TLabel;
    SVGIconImage1: TSVGIconImage;
    cmbCustomers: TComboBox;
    Glyph1: TGlyph;
    FillRGBEffect1: TFillRGBEffect;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblFirstName_Cust: TLabel;
    lblEmail_Cust: TLabel;
    lblOrders_Cust: TLabel;
    lblSelectWarning: TLabel;
    lblLastName_Cust: TLabel;
    Line1: TLine;
    Label6: TLabel;
    Label7: TLabel;
    Line2: TLine;
    grdOrders: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    grdOrderDetails: TStringGrid;
    colProductID: TIntegerColumn;
    colProdName: TStringColumn;
    colProdCode: TStringColumn;
    colSinglePrice: TCurrencyColumn;
    colQuantity: TIntegerColumn;
    colTotalPrice: TCurrencyColumn;
    btnFilter: TButton;
    cmbFilters: TComboBox;
    btnDeleteOrder: TButton;
    btnDeleteCustomer: TButton;
    procedure cmbCustomersChange(Sender: TObject);
    procedure grdOrdersCellClick(const Column: TColumn; const Row: Integer);
    procedure btnDeleteOrderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnDeleteCustomerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomerManagement: TfrmCustomerManagement;
  iCustID, iGrid, iOrderID: Integer;

implementation

uses frmEnviroPOSMain_u;

{$R *.fmx}

procedure TfrmCustomerManagement.btnDeleteCustomerClick(Sender: TObject);
var
  iOrderToDelete: Integer;
begin
  TDialogService.MessageDialog('Do you want to delete the SELECTED customer?',
    TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbCancel, 0,
    procedure(const AResult: TModalResult)
    // dialog passes result to this procedure
    begin
      case AResult of
        mrYes: // if yes, delete
          begin
            with dmDatabase do
            begin
              { loop through orders table, then through orderdetails table if the order that needs to be deleted is found }
              tblCustomers.Delete;
              tblOrders.First;
              while not tblOrders.Eof do
              begin
                if tblOrders['CustomerID'] = iCustID then
                begin
                  iOrderToDelete := tblOrders['OrderID'];
                  tblOrders.Delete;
                  tblOrderDetails.First;
                  while not tblOrderDetails.Eof do
                  begin
                    if tblOrderDetails['OrderID'] = iOrderToDelete then
                    begin
                      tblOrderDetails.Delete;
                    end;
                    tblOrderDetails.Next;
                  end;
                end;

                tblOrders.Next;
              end;
            end;
            ShowMessage('Customer deleted!');
            FormShow(Self);
          end;
      end;
    end);
end;

procedure TfrmCustomerManagement.btnDeleteOrderClick(Sender: TObject);
begin
  TDialogService.MessageDialog('Do you want to delete the SELECTED order?',
    TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    var
      i, j: Integer;
    begin
      case AResult of
        mrYes:
          begin
            // code to delete order
            with dmDatabase do
            begin
              iOrderID := StrToInt(grdOrders.Cells[0, grdOrders.Row]);
              tblOrders.Locate('OrderID', iOrderID, []);
              tblOrders.Delete;

              { delete order details associated with the order }
              tblOrderDetails.First;
              while not tblOrderDetails.Eof do
              begin
                if tblOrderDetails['OrderID'] = iOrderID then
                begin
                  tblOrderDetails.Delete;
                end;
                tblOrderDetails.Next;
              end;

              { update total order count }
              tblCustomers.Locate('CustomerID', iCustID, []);
              tblCustomers.Edit;
              tblCustomers['TotalOrders'] := tblCustomers['TotalOrders'] - 1;
              tblCustomers.Post;

              ShowMessage('Order deleted!');
              { Refresh grid }
              ADOQuery1.Close;
              ADOQuery1.SQL.Text :=
                'SELECT o.OrderID, o.EmployeeID, o.OrderDate, o.OrderValue FROM tblOrders o WHERE CustomerID = '
                + inttostr(iCustID);
              ADOQuery1.Open;

              { Clear order details grid }
              for i := 0 to iGrid + 1 do
              begin
                for j := 0 to 5 do
                begin
                  grdOrderDetails.Cells[j, i] := '';
                end;
              end;
            end;
          end;

      end;
    end);
end;

procedure TfrmCustomerManagement.btnFilterClick(Sender: TObject);
begin
  with dmDatabase do
  begin
    ADOQuery1.Close;
    if cmbFilters.ItemIndex = 0 then // date asc
    begin
      ADOQuery1.SQL.Text :=
        'SELECT o.OrderID, o.EmployeeID, o.OrderDate, o.OrderValue' +
        ' FROM tblOrders o WHERE CustomerID = ' + inttostr(iCustID) +
        ' ORDER BY OrderDate ASC'
    end
    else if cmbFilters.ItemIndex = 1 then // date desc
    begin
      ADOQuery1.SQL.Text :=
        'SELECT o.OrderID, o.EmployeeID, o.OrderDate, o.OrderValue' +
        ' FROM tblOrders o WHERE CustomerID = ' + inttostr(iCustID) +
        ' ORDER BY OrderDate DESC'
    end;
    ADOQuery1.Open;
  end;
end;

procedure TfrmCustomerManagement.cmbCustomersChange(Sender: TObject);
var
  i, j: Integer;
begin
  with dmDatabase do
  begin
    iCustID := StrToInt(Copy(cmbCustomers.Items[cmbCustomers.ItemIndex], 1,
      Pos(':', cmbCustomers.Items[cmbCustomers.ItemIndex]) - 1));
    tblCustomers.Locate('CustomerID', iCustID, []);
    lblFirstName_Cust.Text := tblCustomers['FirstName'];
    lblLastName_Cust.Text := tblCustomers['LastName'];
    lblEmail_Cust.Text := tblCustomers['EmailAddress'];
    lblOrders_Cust.Text := inttostr(tblCustomers['TotalOrders']) + ' orders';
  end;

  { show the hidden labels }
  Label2.Visible := true;
  Label3.Visible := true;
  Label4.Visible := true;
  Label5.Visible := true;
  lblOrders_Cust.Visible := true;
  btnDeleteCustomer.Visible := true;
  { hide warning }
  lblSelectWarning.Visible := false;

  FillRGBEffect1.Color := TAlphaColors.Palegreen;

  with dmDatabase do
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Text :=
      'SELECT o.OrderID, o.EmployeeID, o.OrderDate, o.OrderValue FROM tblOrders o WHERE CustomerID = '
      + inttostr(iCustID);
    ADOQuery1.Open;
  end;

  for i := 0 to iGrid + 1 do
  begin
    for j := 0 to 5 do
    begin
      grdOrderDetails.Cells[j, i] := '';
    end;
  end;
end;

procedure TfrmCustomerManagement.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  frmEnviroPOSMain.updateStatistics;
end;

procedure TfrmCustomerManagement.FormShow(Sender: TObject);
var
  i, j: Integer;
  _Label: TLabel;
begin
  cmbCustomers.Clear;
  with dmDatabase do
  begin
    { fill customers combobox with customer ids, name }
    tblCustomers.First;
    while not tblCustomers.Eof do
    begin
      cmbCustomers.Items.Add(inttostr(tblCustomers['CustomerID']) + ': ' +
        tblCustomers['FirstName'] + ' ' + tblCustomers['LastName']);
      tblCustomers.Next;
    end;
  end;

  { clear grids incase previously used }
  grdOrders.ClearColumns;

  for i := 0 to iGrid + 1 do
  begin
    for j := 0 to 5 do
    begin
      grdOrderDetails.Cells[j, i] := '';
    end;
  end;

  { labels to clear }
  const
    arrTLabelToClear: TArray<TLabel> = [lblOrders_Cust, lblFirstName_Cust,
      lblLastName_Cust, lblEmail_Cust, lblOrders_Cust];
  for _Label in arrTLabelToClear do
  begin
    _Label.Text := '';
  end;

  { reset labels }
  Label2.Visible := false;
  Label3.Visible := false;
  Label4.Visible := false;
  Label5.Visible := false;
  lblOrders_Cust.Visible := false;
  { show warning }
  lblSelectWarning.Visible := true;
  btnDeleteCustomer.Visible := false;
  FillRGBEffect1.Color := TAlphaColors.Red;
end;

procedure TfrmCustomerManagement.grdOrdersCellClick(const Column: TColumn;
const Row: Integer);
var
  iOrderID, i, j: Integer;
  rTotalValue: Real;
begin
  iOrderID := StrToInt(grdOrders.Cells[0, Row]);

  with dmDatabase do
  begin
    iGrid := 0;
    rTotalValue := 0;

    { clear grid }
    for i := 0 to iGrid + 1 do
    begin
      for j := 0 to 5 do
      begin
        grdOrderDetails.Cells[j, i] := '';
      end;
    end;

    tblOrderDetails.First;
    while not tblOrderDetails.Eof do
    begin
      if tblOrderDetails['OrderID'] = iOrderID then
      begin
        { update grid with product/order details }
        tblInventory.Locate('ProductID', tblOrderDetails['ProductID'], []);
        // cell 0 is an invisible cell used to store productid for use later
        grdOrderDetails.Cells[0, iGrid] := tblOrderDetails['ProductID'];
        grdOrderDetails.Cells[1, iGrid] := tblInventory['ProductName'];
        grdOrderDetails.Cells[2, iGrid] := tblInventory['ProductCode'];
        grdOrderDetails.Cells[3, iGrid] := tblInventory['SellingPrice'];
        grdOrderDetails.Cells[4, iGrid] := tblOrderDetails['Quantity'];
        grdOrderDetails.Cells[5, iGrid] := tblOrderDetails['Price'];
        Inc(iGrid);

        { update total }
        rTotalValue := rTotalValue + tblOrderDetails['Price'];
      end;
      tblOrderDetails.Next;
    end;
  end;
end;

end.
