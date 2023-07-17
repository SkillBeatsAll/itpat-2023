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
  // if fields arent blank
  if not(edtFirstName.Text = '') AND not(edtLastName.Text = '') AND
    not(edtEmail.Text = '') then
  begin
    { regex to check against }
    sEmailRegex := '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    if TRegEx.IsMatch(edtEmail.Text, sEmailRegex) then
    begin
      // valid email!
      with dmDatabase do
      begin
        // write to DB
        tblCustomers.Append;
        tblCustomers['LastName'] := edtLastName.Text;
        tblCustomers['FirstName'] := edtFirstName.Text;
        tblCustomers['EmailAddress'] := edtEmail.Text;
        tblCustomers['TotalOrders'] := 0;
        tblCustomers.Post;
      end;
      ShowMessage('Customer has been added successfully!');
    end
    else
    begin
      raise Exception.Create('Invalid e-mail address!');
    end;
  end
  else
  // exception if blank
  begin
    raise Exception.Create('One of your fields are blank!');
  end;

end;

end.
