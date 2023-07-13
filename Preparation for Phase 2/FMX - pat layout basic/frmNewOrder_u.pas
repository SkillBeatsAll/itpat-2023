unit frmNewOrder_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.SVGIconImage, FMX.ListBox, System.Rtti, FMX.Grid.Style, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FMX.Effects,
  FMX.Filter.Effects, FMX.ImgList, System.ImageList, FMX.SVGIconImageList,
  dbmEnviroPOSDB_u, FMX.Edit, FMX.Printer, FMX.Memo.Types, FMX.Memo, ShellAPI,
  Windows, clsOrder;

type
  TfrmNewOrder = class(TForm)
    SVGIconImage1: TSVGIconImage;
    StyleBook1: TStyleBook;
    cmbCustomers: TComboBox;
    Glyph1: TGlyph;
    FillRGBEffect1: TFillRGBEffect;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblFirstName_Cust: TLabel;
    lblLastName_Cust: TLabel;
    lblEmail_Cust: TLabel;
    lblOrders_Cust: TLabel;
    lblSelectWarning: TLabel;
    Line1: TLine;
    cmbItems: TComboBox;
    Label6: TLabel;
    edtPrice: TEdit;
    edtQuantity: TEdit;
    edtTotalPrice: TEdit;
    edtStockLeft: TEdit;
    btnAddItem: TSpeedButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    btnRemoveItem: TSpeedButton;
    edtTotalCostOrder: TEdit;
    Label11: TLabel;
    edtCustomerPayment: TEdit;
    edtBalance: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    btnPrint: TSpeedButton;
    btnClear: TSpeedButton;
    btnSaveOrder: TSpeedButton;
    Line2: TLine;
    OrderDetailsGrid: TStringGrid;
    btnStartOrder: TSpeedButton;
    colProdName: TStringColumn;
    colProdCode: TStringColumn;
    colSinglePrice: TCurrencyColumn;
    colQuantity: TIntegerColumn;
    colTotalPrice: TCurrencyColumn;
    colProductID: TIntegerColumn;
    procedure FormActivate(Sender: TObject);
    procedure cmbCustomersChange(Sender: TObject);
    procedure cmbItemsChange(Sender: TObject);
    procedure edtQuantityChange(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure btnStartOrderClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure OrderDetailsGridCellClick(const Column: TColumn;
      const Row: Integer);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure btnSaveOrderClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
    procedure clearForm;
    procedure updateGrid;
  public
    { Public declarations }
  end;

var
  frmNewOrder: TfrmNewOrder;
  iProdID, iCustID, iOrderID, iGrid: Integer;
  rTotalValue: Real;
  custOrder: TOrder;

implementation

{$R *.fmx}

procedure TfrmNewOrder.btnAddItemClick(Sender: TObject);
var
  bAlreadyExists: Boolean;
  iOrderDetailsID: Integer;
begin
  { add item to order }
  with dmDatabase do
  begin
    { locate product }

    tblInventory.Locate('ProductID', iProdID, []);

    { determine if Item already in order }
    bAlreadyExists := false;
    tblOrderDetails.First;
    while not tblOrderDetails.Eof do
    begin
      if (tblOrderDetails['OrderID'] = iOrderID) AND
        (tblOrderDetails['ProductID'] = iProdID) then
      begin
        bAlreadyExists := true;
        iOrderDetailsID := tblOrderDetails['ID'];
      end;

      tblOrderDetails.Next;
    end;

    if bAlreadyExists then
    begin
      { Item already in order, therefore simply add to quantity! }
      tblOrderDetails.Locate('ID', iOrderDetailsID, []);
      tblOrderDetails.Edit;
      tblOrderDetails['Quantity'] := tblOrderDetails['Quantity'] +
        StrToInt(edtQuantity.Text);
      tblOrderDetails['Price'] := tblOrderDetails['Quantity'] * tblInventory
        ['SellingPrice'];
      tblOrderDetails.Post;
    end
    else
    begin
      { Item not in order, therefore add as a first-time item! }
      tblOrderDetails.Append;
      tblOrderDetails['OrderID'] := iOrderID;
      tblOrderDetails['ProductID'] := iProdID;
      tblOrderDetails['Quantity'] := edtQuantity.Text;
      tblOrderDetails['Price'] := tblOrderDetails['Quantity'] * tblInventory
        ['SellingPrice'];
      tblOrderDetails.Post;
    end;
  end;

  updateGrid;
end;

procedure TfrmNewOrder.btnClearClick(Sender: TObject);
begin
  clearForm;
end;

procedure TfrmNewOrder.btnPrintClick(Sender: TObject);
var
  sLine, sFile: String;
  i, j: Integer;
  textToOutput: TStringList;
begin
  textToOutput := TStringList.Create;
  textToOutput.Add('Order from ' + lblFirstName_Cust.Text + ' ' +
    lblLastName_Cust.Text);
  textToOutput.Add('Format: ' + ' Product Name' + #9 + 'Product Code' + #9 +
    'Cost' + #9 + 'Qty' + #9 + 'Total Cost');
  for i := 0 to iGrid do
  begin
    textToOutput.Add('');
    sLine := '';
    for j := 1 to 5 do
    begin
      sLine := sLine + OrderDetailsGrid.Cells[j, i] + #9
    end;
    textToOutput.Add(sLine);
  end;

  textToOutput.Add('Total order cost: ' + #9 + FloatToStrF(rTotalValue,
    ffCurrency, 8, 2));

  sFile := 'Order ' + IntToStr(iOrderID) + ' - ' + lblFirstName_Cust.Text + ' '
    + lblLastName_Cust.Text;
  textToOutput.SaveToFile(sFile);
  ShellExecute(HInstance, 'open', pChar(sFile), nil, nil, SW_NORMAL);

end;

procedure TfrmNewOrder.btnRemoveItemClick(Sender: TObject);
var
  iProductToDelete: Integer;
begin
  iProductToDelete := StrToInt(OrderDetailsGrid.Cells[0,
    OrderDetailsGrid.selected]);
  with dmDatabase do
  begin
    tblOrderDetails.First;
    while not tblOrderDetails.Eof do
    begin
      if (tblOrderDetails['ProductID'] = iProductToDelete) AND
        (tblOrderDetails['OrderID'] = iOrderID) then
      begin
        tblOrderDetails.Delete;
      end;
      tblOrderDetails.Next;
    end;
  end;
  updateGrid;

end;

procedure TfrmNewOrder.btnSaveOrderClick(Sender: TObject);
begin
  with dmDatabase do
  begin
    tblOrders.Locate('OrderID', iOrderID, []);
    tblOrders.Edit;
    tblOrders['OrderValue'] := rTotalValue;
    tblOrders.Post;

    tblCustomers.Locate('CustomerID', iCustID, []);
    tblCustomers.Edit;
    tblCustomers['TotalOrders'] := tblCustomers['TotalOrders'] + 1;
    tblCustomers.Post;
  end;
end;

procedure TfrmNewOrder.btnStartOrderClick(Sender: TObject);
begin
  cmbItems.Enabled := true;
  btnAddItem.Enabled := true;

  {
    with dmDatabase do
    begin
    tblOrders.Append;
    tblOrders['EmployeeID'] := 1; // fill from auth
    tblOrders['CustomerID'] := iCustID;
    tblOrders['OrderDate'] := Now;
    tblOrders['OrderValue'] := 0;
    tblOrders.Post;

    iOrderID := tblOrders['OrderID']
    end;
  }

  custOrder := TOrder.Create(iCustID, 1);
  iOrderID := custOrder.getOrderID;
  { REPLACE 1 WITH EMPLOYEE ID FROM AUTH }
end;

procedure TfrmNewOrder.clearForm;
var
  i, j: Integer;
  _Edit: TEdit;
  _ComboBox: TComboBox;
  _Label: TLabel;
begin
  { declare constant arrays for clearing easier }
{$REGION 'Constant Arrays of Components'}
  const
    arrTEditToClear: TArray<TEdit> = [edtTotalCostOrder, edtQuantity, edtPrice,
      edtTotalPrice, edtStockLeft, edtCustomerPayment, edtBalance];
  const
    arrTComboBoxToClear: TArray<TComboBox> = [cmbCustomers, cmbItems];
  const
    arrTLabelToClear: TArray<TLabel> = [lblOrders_Cust, lblFirstName_Cust,
      lblLastName_Cust, lblEmail_Cust, lblOrders_Cust];
{$ENDREGION}
  for _Edit in arrTEditToClear do
  begin
    _Edit.Text := '';
  end;
  for _ComboBox in arrTComboBoxToClear do
  begin
    _ComboBox.Clear;
  end;
  for _Label in arrTLabelToClear do
  begin
    _Label.Text := '';
  end;

  { clear grid }
  for i := 1 to iGrid do
  begin
    for j := 0 to 5 do
    begin
      OrderDetailsGrid.Cells[j, i] := '';
    end;
  end;

  FormActivate(Self);
end;

procedure TfrmNewOrder.cmbCustomersChange(Sender: TObject);
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

end;

procedure TfrmNewOrder.cmbItemsChange(Sender: TObject);
begin
  with dmDatabase do
  begin
    // extract selected product's id
    iProdID := StrToInt(Copy(cmbItems.Items[cmbItems.ItemIndex], 1,
      Pos(':', cmbItems.Items[cmbItems.ItemIndex]) - 1));
    // locate product based on ID ^
    tblInventory.Locate('ProductID', iProdID, []);

    // fill details
    edtPrice.Text := FloatToStrF(tblInventory['SellingPrice'],
      ffCurrency, 8, 2);
    edtQuantity.Text := '1';
    edtTotalPrice.Text := FloatToStrF(tblInventory['SellingPrice'] *
      edtQuantity.Text, ffCurrency, 8, 2);
    edtStockLeft.Text := tblInventory['StockQty'];
  end;
end;

procedure TfrmNewOrder.edtQuantityChange(Sender: TObject);
begin
  if not(edtQuantity.Text = '') then
  begin
    with dmDatabase do
    begin
      tblInventory.Locate('ProductID', iProdID, []);
      edtTotalPrice.Text := FloatToStrF(tblInventory['SellingPrice'] *
        edtQuantity.Text, ffCurrency, 8, 2);
    end;
  end;
end;

procedure TfrmNewOrder.FormActivate(Sender: TObject);
begin
  { Populate Comboboxes }
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

    { fill products combo with product id, name }
    tblInventory.First;
    while not tblInventory.Eof do
    begin
      cmbItems.Items.Add(IntToStr(tblInventory['ProductID']) + ': ' +
        tblInventory['ProductName'] + ' (' + tblInventory['ProductCode'] + ')');
      tblInventory.Next;
    end;
  end;

end;

procedure TfrmNewOrder.OrderDetailsGridCellClick(const Column: TColumn;
  const Row: Integer);
begin
  btnRemoveItem.Enabled := true;
end;

procedure TfrmNewOrder.updateGrid;
var
  i, j: Integer;
begin
  { Clear Grid }
  for i := 1 to iGrid do
  begin
    for j := 0 to 5 do
    begin
      OrderDetailsGrid.Cells[j, i] := '';
    end;
  end;

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
        edtTotalCostOrder.Text := FloatToStrF(rTotalValue, ffCurrency, 8, 2);
      end;
      tblOrderDetails.Next;
    end;
  end;
end;

end.
