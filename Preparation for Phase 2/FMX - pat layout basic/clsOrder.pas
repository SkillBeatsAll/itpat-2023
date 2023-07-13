unit clsOrder;

interface

uses System.Generics.Collections, System.SysUtils, System.Types, System.UITypes,
  System.Classes,
  System.Variants, clsOrderDetails, dbmEnviroPOSDB_u, ADODB;

type
  TOrder = class(TObject)
  private
    fCustomerID, fOrderID: Integer;
    fTotalPrice: Real;
    fOrderedItems: TObjectList<TOrderDetails>;

  public
    constructor Create(iCustID, iEmployeeID: Integer);
    procedure addItem(aProductID, aProductQty: Integer);
    procedure removeItem(aProductID: Integer);
    procedure updateItemQty(aProductID, aProductQty: Integer);
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
begin

  { add item to order }
  with dmDatabase do
  begin
    { locate product }

    { determine if Item already in order }
    bAlreadyExists := false;
    for objOrder in fOrderedItems do
    begin
      if objOrder.fProductID = aProductID then
      begin
        { Item exists, therefore simply update quantity! }
        bAlreadyExists := true;
        objOrder.updateQty(aProductQty);
      end;
    end;

    { Item not in order, therefore add as a first-time item! }
    if not bAlreadyExists then
      fOrderedItems.Add(objOrder.Create(aProductID, aProductQty, fOrderID));
  end;
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
end;

function TOrder.getOrderID: Integer;
begin
  result := fOrderID;
end;

procedure TOrder.processOrder;
begin

end;

procedure TOrder.removeItem(aProductID: Integer);
begin

end;

procedure TOrder.updateItemQty(aProductID, aProductQty: Integer);
begin

end;

end.
