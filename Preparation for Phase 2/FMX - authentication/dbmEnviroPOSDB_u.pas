unit dbmEnviroPOSDB_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdmDatabase = class(TDataModule)
    ADOConnection1: TADOConnection;
    tblCredentials: TADOTable;
    dsCredentials: TDataSource;
    tblEmployees: TADOTable;
    dsEmployees: TDataSource;
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
