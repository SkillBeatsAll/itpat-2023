unit dbmEnviroPOSDB_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, System.ImageList,
  FMX.ImgList, FMX.SVGIconImageList;

type
  TdmDatabase = class(TDataModule)
    conEnviroPosDB: TADOConnection;
    tblCredentials: TADOTable;
    dscCredentials: TDataSource;
    tblEmployees: TADOTable;
    dscEmployees: TDataSource;
    tblOrders: TADOTable;
    tblOrderDetails: TADOTable;
    tblCustomers: TADOTable;
    tblInventory: TADOTable;
    dscOrders: TDataSource;
    dscOrderDetails: TDataSource;
    dscCustomers: TDataSource;
    dscInventory: TDataSource;
    SVGIconImageList1: TSVGIconImageList;
    dscQuery: TDataSource;
    ADOQuery1: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDatabase: TdmDatabase;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
