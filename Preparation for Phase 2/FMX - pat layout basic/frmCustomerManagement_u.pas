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
  Data.Win.ADODB;

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
    OrderDetailsGrid: TStringGrid;
    colProductID: TIntegerColumn;
    colProdName: TStringColumn;
    colProdCode: TStringColumn;
    colSinglePrice: TCurrencyColumn;
    colQuantity: TIntegerColumn;
    colTotalPrice: TCurrencyColumn;
    procedure FormActivate(Sender: TObject);
    procedure cmbCustomersChange(Sender: TObject);
    procedure grdOrdersCellClick(const Column: TColumn; const Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomerManagement: TfrmCustomerManagement;
  iCustID: Integer;

implementation

{$R *.fmx}

procedure TfrmCustomerManagement.cmbCustomersChange(Sender: TObject);
begin
  with dmDatabase do
  begin
    iCustID := StrToInt(Copy(cmbCustomers.Items[cmbCustomers.ItemIndex], 1,
      Pos(':', cmbCustomers.Items[cmbCustomers.ItemIndex]) - 1));
    tblCustomers.Locate('CustomerID', iCustID, []);
    lblFirstName_Cust.Text := tblCustomers['FirstName'];
    lblLastName_Cust.Text := tblCustomers['LastName'];
    lblEmail_Cust.Text := tblCustomers['EmailAddress'];
    lblOrders_Cust.Text := IntToStr(tblCustomers['TotalOrders']) + ' orders';
  end;

  { show the hidden labels }
  Label2.Visible := true;
  Label3.Visible := true;
  Label4.Visible := true;
  Label5.Visible := true;
  lblOrders_Cust.Visible := true;
  { hide warning }
  lblSelectWarning.Visible := false;

  FillRGBEffect1.Color := TAlphaColors.Palegreen;

  with dmDatabase do
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Text :=
      'SELECT o.OrderID, o.EmployeeID, o.OrderDate, o.OrderValue FROM tblOrders o WHERE CustomerID = '
      + IntToStr(iCustID);
    ADOQuery1.Open;
  end;
end;

procedure TfrmCustomerManagement.FormActivate(Sender: TObject);
begin
  with dmDatabase do
  begin
    { fill customers combobox with customer ids, name }
    tblCustomers.First;
    while not tblCustomers.Eof do
    begin
      cmbCustomers.Items.Add(IntToStr(tblCustomers['CustomerID']) + ': ' +
        tblCustomers['FirstName'] + ' ' + tblCustomers['LastName']);
      tblCustomers.Next;
    end;
  end;
end;

procedure TfrmCustomerManagement.grdOrdersCellClick(const Column: TColumn;
  const Row: Integer);
var
  iOrderID, iGrid: Integer;
  rTotalValue: Real;
begin
  iOrderID := StrToInt(grdOrders.Cells[0, Row]);

  with dmDatabase do
  begin
    iGrid := 0;
    rTotalValue := 0;

    tblOrderDetails.First;
    while not tblOrderDetails.Eof do
    begin
      if tblOrderDetails['OrderID'] = iOrderID then
      begin
        { update grid with product/order details }
        tblInventory.Locate('ProductID', tblOrderDetails['ProductID'], []);
        // cell 0 is an invisible cell used to store productid for use later
        OrderDetailsGrid.Cells[0, iGrid] := tblOrderDetails['ProductID'];
        OrderDetailsGrid.Cells[1, iGrid] := tblInventory['ProductName'];
        OrderDetailsGrid.Cells[2, iGrid] := tblInventory['ProductCode'];
        OrderDetailsGrid.Cells[3, iGrid] := tblInventory['SellingPrice'];
        OrderDetailsGrid.Cells[4, iGrid] := tblOrderDetails['Quantity'];
        OrderDetailsGrid.Cells[5, iGrid] := tblOrderDetails['Price'];
        Inc(iGrid);

        { update total }
        rTotalValue := rTotalValue + tblOrderDetails['Price'];
      end;
      tblOrderDetails.Next;
    end;
  end;
end;

end.
