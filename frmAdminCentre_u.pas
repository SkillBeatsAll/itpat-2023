unit frmAdminCentre_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.SVGIconImage, FMX.StdCtrls, FMX.Controls.Presentation, dbmEnviroPOSDB_u,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Controls,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, FMX.Layouts,
  FMX.Bind.Navigator, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  Data.Win.ADODB;

type
  TfrmAdminCentre = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    SVGIconImage1: TSVGIconImage;
    StyleBook1: TStyleBook;
    StringGrid1: TStringGrid;
    qryAdminCentre: TADOQuery;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    NavigatorBindSourceDB1: TBindNavigator;
    BindingsList1: TBindingsList;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdminCentre: TfrmAdminCentre;

implementation

{$R *.fmx}

procedure TfrmAdminCentre.FormShow(Sender: TObject);
begin
  qryAdminCentre.Close;
  qryAdminCentre.SQL.Text :=
    'SELECT e.LastName, e.FirstName, e.EmailAddress AS [Email/Username],e.Role,c.Password AS [Password (base64''ed twice)]'
    + ' FROM tblEmployees e, tblCredentials c' +
    ' WHERE e.EmployeeID = c.EmployeeID';
  qryAdminCentre.Open;
end;

end.
