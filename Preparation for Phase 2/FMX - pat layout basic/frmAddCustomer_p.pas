unit frmAddCustomer_p;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.SVGIconImage, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  System.RegularExpressions, dbmEnviroPOSDB_u, Data.DB, Data.Win.ADODB;

type
  TfrmAddCustomer = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    StyleBook1: TStyleBook;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    SVGIconImage1: TSVGIconImage;
    edtEmail: TEdit;
    btnAddCustomer: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    qryInsertCustomer: TADOQuery;
    procedure btnAddCustomerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddCustomer: TfrmAddCustomer;

implementation

{$R *.fmx}

procedure TfrmAddCustomer.btnAddCustomerClick(Sender: TObject);
var
  sEmailRegex: String;
begin
  if not(edtFirstName.Text = '') AND not(edtLastName.Text = '') AND
    not(edtEmail.Text = '') then
  begin
    sEmailRegex := '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    if TRegEx.IsMatch(edtEmail.Text, sEmailRegex) then
    begin
      // valid email!
      qryInsertCustomer.Close;
      qryInsertCustomer.SQL.Text :=
        'INSERT INTO tblCustomers (LastName,FirstName,EmailAddress,TotalOrders) VALUES ('
        + QuotedStr(edtLastName.Text) + ',' + QuotedStr(edtFirstName.Text) + ','
        + QuotedStr(edtEmail.Text) + ',' + '''0'')';
      qryInsertCustomer.ExecSQL;
      { ExecSQL since we aren't returning a dataset! }

      ShowMessage('Customer has been added successfully!');
    end
    else
    begin
      raise Exception.Create('Invalid e-mail address!');
    end;
  end
  else
  begin
    raise Exception.Create('One of your fields are blank!');
  end;

end;

end.
