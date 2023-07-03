unit frmAuthentication_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, System.ImageList,
  FMX.ImgList, frmRegister_u, NetEncoding, dbmEnviroPOSDB_u, OTPUtility_u;

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
    Button1: TButton;
    Label1: TLabel;
    procedure txtRegisterClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  published
    function DoubleBase64Helper(sMode, sText: String): String;
  end;

var
  frmAuthentication: TfrmAuthentication;
  sUsername, sPassword, sGeneratedSecret: String;

implementation

{$R *.fmx}

procedure TfrmAuthentication.Button1Click(Sender: TObject);
var
  sEnteredUsername, sEnteredPassword: String;
  sLine, sIn_Username, sIn_Secret: String;
  tSecrets: TextFile;
  bFound: Boolean;
  iIn_OTP: integer;
begin
  sEnteredPassword := DoubleBase64Helper('encode', edtPassword.Text);
  sEnteredUsername := edtUsername.Text;
  with dmDatabase do
  begin
    if (tblCredentials.Locate('Username', sEnteredUsername, [])) AND
      (tblCredentials['Password'] = sEnteredPassword) then
    begin
      { Username + Password Combination = Correct }
      tblEmployees.Locate('EmployeeID',tblCredentials['EmployeeID'],[]);
      if (tblEmployees['Role'] = 'Manager') OR
        (tblEmployees['Role'] = 'Supplier') then
      begin
        if not fileexists('secrets.txt') then
        begin
          raise Exception.Create('secrets.txt file does not exist.');
        end
        else
        begin
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
              '2FA Code:', ''));
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
        sIn_Secret := '';
      end;

      { if secret is blank (therefore cashier) or if OTP is valid for the secret, then... }
      if (sIn_Secret = '') OR (ValidateTOPT(sIn_Secret, iIn_OTP)) then
      begin
        { successfull login }
        ShowMessage('Successful Login!');
      end
      else begin
        showmessage('Failed login!');
      end;

    end
    else
    begin
      ShowMessage('incorrect creds!');
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

procedure TfrmAuthentication.txtRegisterClick(Sender: TObject);
begin
  frmRegister.Show;
end;

end.
