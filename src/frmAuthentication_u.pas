unit frmAuthentication_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, System.ImageList,
  FMX.ImgList, frmRegister_u, NetEncoding, dbmEnviroPOSDB_u, OTPUtility_u,
  frmEnviroPOSMain_u;

type
  TfrmAuthentication = class(TForm)
    StyleBook1: TStyleBook;
    Image1: TImage;
    lblUsername: TLabel;
    lblPassword: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblStaticText1: TLabel;
    PasswordEditButton1: TPasswordEditButton;
    txtRegister: TText;
    ImageList1: TImageList;
    btnLogin: TButton;
    Label1: TLabel;
    procedure txtRegisterClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    sUserType: string;
    iEmployeeID: Integer;
  published
    function DoubleBase64Helper(sMode, sText: String): String;
  end;

var
  frmAuthentication: TfrmAuthentication;
  sUsername, sPassword, sGeneratedSecret: String;

implementation

{$R *.fmx}

procedure TfrmAuthentication.btnLoginClick(Sender: TObject);
var
  sEnteredUsername, sEnteredPassword: String;
  sLine, sIn_Username, sIn_Secret: String;
  tSecrets: TextFile;
  bFound: Boolean;
  iIn_OTP: Integer;
begin
  sEnteredPassword := DoubleBase64Helper('encode', edtPassword.Text);
  sEnteredUsername := edtUsername.Text;
  with dmDatabase do
  begin
    if (tblCredentials.Locate('Username', sEnteredUsername, [])) AND
      (tblCredentials['Password'] = sEnteredPassword) then
    begin
      { Username + Password Combination = Correct }
      tblEmployees.Locate('EmployeeID', tblCredentials['EmployeeID'], []);
      sUserType := tblEmployees['Role'];
      iEmployeeID := tblEmployees['EmployeeID'];
      // 2fa logic only needed for manager / suppliers
      if (sUserType = 'Manager') OR (sUserType = 'Supplier') then
      begin
        if not fileexists('secrets.txt') then
        begin
          raise Exception.Create('secrets.txt file does not exist.');
        end
        else
        begin
          { loop through the text file and find the username so that we get their secret }
          AssignFile(tSecrets, 'secrets.txt');
          Reset(tSecrets);
          bFound := false;
          while not Eof(tSecrets) do
          begin
            Readln(tSecrets, sLine);
            sIn_Username := Copy(sLine, 1, Pos(',', sLine) - 1);
            if sIn_Username = sEnteredUsername then
            begin
              bFound := true;
              break;
            end;
          end;

          if bFound = true then
          begin
            sIn_Secret := Copy(sLine, Pos(',', sLine) + 1, length(sLine));
            iIn_OTP := StrToInt(InputBox('2-Factor Authentication (2FA)',
              '2FA Code:', '')); // prompt for OTP code
          end
          else
          begin
            raise Exception.Create('Username not present in secrets.txt file.');
          end;
          CloseFile(tSecrets);
        end;
      end
      else
      begin
        sIn_Secret := '[CASHIER]';
      end;

      { if secret is [CASHIER] (therefore cashier) or if OTP is valid for the secret, then... }
      if (sIn_Secret = '[CASHIER]') OR (ValidateTOPT(sIn_Secret, iIn_OTP)) then
      begin
        { successfull login }
        ShowMessage('Successfully logged in!');
        frmEnviroPOSMain.Show;
        Self.Hide;
      end
      else
      begin
        ShowMessage('Your OTP is invalid. Please try again!');
      end;

    end
    else
    begin
      ShowMessage('Incorrect credentials entered.');
    end;

  end;
end;

function TfrmAuthentication.DoubleBase64Helper(sMode, sText: String): String;
begin
  { DoubleBase64Helper Function:
    - Accepts a mode (encode/decode), and text (to encode/decode)^2
    * Returns the encoded/decoded text }
  if LowerCase(sMode) = 'encode' then
  begin
    Result := TNetEncoding.Base64.Encode(TNetEncoding.Base64.Encode(sText));
  end
  else if LowerCase(sMode) = 'decode' then
  begin
    Result := TNetEncoding.Base64.Decode(TNetEncoding.Base64.Decode(sText));
  end
  else
    raise Exception.Create
      ('Invalid mode specified. Choose from either ''encode'' or ''decode''');

end;

procedure TfrmAuthentication.FormActivate(Sender: TObject);
begin
  { Check if a manager exists (only 1 can exist).
    - If one does NOT exist, FORCE user to create one, as there must be a manager. }
  with dmDatabase do
  begin
    if not tblEmployees.Locate('Role', 'Manager', []) then
    begin
      { There is no manager }
      ShowMessage
        ('Because this is your first time using EnviroPOS, we will help you setup a manager account.');
      // pass through role to register form
      frmRegister.sRegisterRole := 'Manager';
      // so as to not confuse the person, hide the combobox which doesnt have manager in it
      frmRegister.cmbAccountType.Visible := false;
      frmRegister.Show;
    end;

  end;
end;

procedure TfrmAuthentication.txtRegisterClick(Sender: TObject);
begin
  frmRegister.Show;
end;

end.
