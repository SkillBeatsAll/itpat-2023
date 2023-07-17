unit clsOrderDetails;

interface

uses dbmEnviroPOSDB_u, ADODB;

type
  TOrderDetails = class(TObject)
  private
    fOrderDetailsID: Integer;
  public
    fProductID: Integer;
    fProductPrice: Real;
    fProductQty: Integer;
    constructor Create(aProductID, aProductQty, aOrderID: Integer);
    destructor Destroy; override;
    procedure updateQty(aToAddQty: Integer);
  end;

implementation

{ TOrderDetails }

destructor TOrderDetails.Destroy;
begin
  with dmDatabase do
  begin
    tblOrderDetails.First;
    while not tblOrderDetails.Eof do
    begin
      if (tblOrderDetails['ID'] = fOrderDetailsID) then
      begin
        tblOrderDetails.Delete;
      end;
      tblOrderDetails.Next;
    end;
  end;
  inherited;
end;

procedure TOrderDetails.updateQty(aToAddQty: Integer);
begin
  fProductQty := fProductQty + aToAddQty;
  with dmDatabase do
  begin
    tblOrderDetails.Locate('ID', fOrderDetailsID, []);
    tblOrderDetails.Edit;
    tblOrderDetails['Quantity'] := tblOrderDetails['Quantity'] + aToAddQty;
    tblOrderDetails['Price'] := tblOrderDetails['Quantity'] * tblInventory
      ['SellingPrice'];
    tblOrderDetails.Post;
  end;
end;

constructor TOrderDetails.Create(aProductID, aProductQty, aOrderID: Integer);
begin
  fProductID := aProductID;
  fProductQty := aProductQty;
  with dmDatabase do
  begin
    tblInventory.Locate('ProductID', aProductID, []);
    tblOrderDetails.Append;
    tblOrderDetails['OrderID'] := aOrderID;
    tblOrderDetails['ProductID'] := aProductID;
    tblOrderDetails['Quantity'] := aProductQty;
    tblOrderDetails['Price'] := tblOrderDetails['Quantity'] * tblInventory
      ['SellingPrice'];
    tblOrderDetails.Post;
    fOrderDetailsID := tblOrderDetails['ID'];
    fProductPrice := tblInventory['SellingPrice'];
  end;
end;

end.
