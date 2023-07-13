unit clsOrderDetails;

interface

uses dbmEnviroPOSDB_u, ADODB;

type
  TOrderDetails = class(TObject)
  private
  public
    fProductID, fProductQty: Integer;
    fProductPrice: Real;
    constructor Create(aProductID, aProductQty, aOrderID: Integer);
    procedure updateQty(aToAddQty: Integer);
  end;

implementation

{ TOrderDetails }

procedure TOrderDetails.updateQty(aToAddQty: Integer);
begin
  fProductQty := fProductQty + aToAddQty;
end;

{ TOrderDetails }

constructor TOrderDetails.Create(aProductID, aProductQty, aOrderID: Integer);
begin
  with dmDatabase do
  begin
    tblOrderDetails.Append;
    tblOrderDetails['OrderID'] := aOrderID;
    tblOrderDetails['ProductID'] := aProductID;
    tblOrderDetails['Quantity'] := aProductQty;
    tblOrderDetails['Price'] := tblOrderDetails['Quantity'] * tblInventory
      ['SellingPrice'];
    tblOrderDetails.Post;
  end;
end;

end.
