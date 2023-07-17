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
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDatabase: TdmDatabase;

const
  sConnectionString
    : String =
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=%pathtodb%/assets/database/PAT_DB.mdb'
    + ';Mode=Share Deny None;Jet OLEDB:System database="";Jet OLEDB:Registry Path="";'
    + 'Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;'
    + 'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'
    + 'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False'
    + ';Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False;';

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TdmDatabase.DataModuleCreate(Sender: TObject);
var
  sPath: String;
begin
  // ensure connection path is correct each time
  sPath := System.SysUtils.GetCurrentDir;
  // replaces the variable with the actual path (needed for program to run on different pcs)
  conEnviroPosDB.ConnectionString := StringReplace(sConnectionString,
    '%pathtodb%', sPath, []);

  { connect DB, and make tables active :) }
  conEnviroPosDB.Connected := true;
  tblCredentials.Active := true;
  tblEmployees.Active := true;
  tblOrders.Active := true;
  tblOrderDetails.Active := true;
  tblCustomers.Active := true;
  tblInventory.Active := true;
end;

end.
