unit clsOrder;

interface

uses System.Generics.Collections, System.SysUtils, System.Types, System.UITypes,
  System.Classes,
  System.Variants, clsOrderDetails, dbmEnviroPOSDB_u, ADODB, FMX.Dialogs;

type
  TOrder = class(TObject)
  private
    fCustomerID, fOrderID: Integer;
    fTotalPrice: Real;
    fOrderedItems: TObjectList<TOrderDetails>;
    function calculateTotalPrice: Real;
  public
    constructor Create(iCustID, iEmployeeID: Integer);
    destructor Destroy; override;
    procedure addItem(aProductID, aProductQty: Integer);
    procedure removeItem(aProductID: Integer);
    procedure processOrder;
    function getOrderID: Integer;

  end;

implementation

{ TOrder }

procedure TOrder.addItem(aProductID, aProductQty: Integer);
var
  objOrder: TOrderDetails;
  bAlreadyExists: Boolean;
  iOrderDetailsID: Integer;
  i: Integer;
begin
  { add item to order }
  with dmDatabase do
  begin
    { determine if Item already in order }
    bAlreadyExists := false;

    for i := 0 to fOrderedItems.Count - 1 do
    begin
      if fOrderedItems.Items[i].fProductID = aProductID then
      begin
        { Item exists, therefore simply update quantity! }
        bAlreadyExists := true;
        fOrderedItems.Items[i].updateQty(aProductQty);
      end;
    end;

    if not bAlreadyExists then
    begin
      { Item not in order, therefore add as a first-time item! }
      objOrder := TOrderDetails.Create(aProductID, aProductQty, fOrderID);
      fOrderedItems.Add(objOrder);
    end;
  end;
end;

function TOrder.calculateTotalPrice: Real;
var
  i: Integer;
begin
  fTotalPrice := 0;
  for i := 0 to fOrderedItems.Count - 1 do
  begin
    fTotalPrice := fTotalPrice + (fOrderedItems.Items[i].fProductPrice *
      fOrderedItems.Items[i].fProductQty)
  end;
  result := fTotalPrice;
end;

constructor TOrder.Create(iCustID, iEmployeeID: Integer);
begin
  fCustomerID := iCustID;
  with dmDatabase do
  begin
    tblOrders.Append;
    tblOrders['EmployeeID'] := iEmployeeID;
    tblOrders['CustomerID'] := fCustomerID;
    tblOrders['OrderDate'] := Now;
    tblOrders['OrderValue'] := 0;
    tblOrders.Post;

    fOrderID := tblOrders['OrderID'];
  end;
  fOrderedItems := TObjectList<TOrderDetails>.Create();
end;

destructor TOrder.Destroy;
var
  i: Integer;
begin
  { Remove all orders from the tblOrderDetails; then delete objects. }
  { Handled by TOrderDetails destructor }
  for i := 0 to fOrderedItems.Count - 1 do
  begin
    fOrderedItems.Items[i].Destroy;
  end;

  { Conclude by delting order from tblOrders }
  with dmDatabase do
  begin
    tblOrders.Locate('OrderID', fOrderID, []);
    tblOrders.Delete;
  end;

  inherited;
end;

function TOrder.getOrderID: Integer;
begin
  result := fOrderID;
end;

procedure TOrder.processOrder;
var
  i: Integer;
begin
  with dmDatabase do
  begin
    tblOrders.Locate('OrderID', fOrderID, []);
    tblOrders.Edit;
    tblOrders['OrderValue'] := calculateTotalPrice;
    tblOrders.Post;

    tblCustomers.Locate('CustomerID', fCustomerID, []);
    tblCustomers.Edit;
    tblCustomers['TotalOrders'] := tblCustomers['TotalOrders'] + 1;
    tblCustomers.Post;

    for i := 0 to fOrderedItems.Count - 1 do
    begin
      with dmDatabase do
      begin
        tblInventory.Locate('ProductID', fOrderedItems.Items[i].fProductID, []);
        tblInventory.Edit;
        tblInventory['StockQty'] := tblInventory['StockQty'] -
          fOrderedItems.Items[i].fProductQty;
        tblInventory['SoldQty'] := tblInventory['SoldQty'] + fOrderedItems.Items
          [i].fProductQty;
        tblInventory.Post;
      end;
    end;
  end;
end;

procedure TOrder.removeItem(aProductID: Integer);
var
  i: Integer;
begin
  for i := 0 to fOrderedItems.Count - 1 do
  begin
    if fOrderedItems.Items[i].fProductID = aProductID then
    begin
      fOrderedItems.Items[i].Destroy;
    end;
  end;
end;

end.
