unit frmRegister_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  FMX.Controls.Presentation, FMX.ListBox, UIConsts, FMX.Ani, frm2FA_Help_u,
  dbmEnviroPOSDB_u, OTPUtility_u;

type
  TfrmRegister = class(TForm)
    StyleBook1: TStyleBook;
    Image1: TImage;
    ImageList1: TImageList;
    edtFirstName: TEdit;
    Label1: TLabel;
    edtLastName: TEdit;
    Label2: TLabel;
    edtEmail: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    Label6: TLabel;
    edtConfirmPassword: TEdit;
    Label3: TLabel;
    cmbAccountType: TComboBox;
    Label5: TLabel;
    btnRegister: TButton;
    RectAnimation1: TRectAnimation;
    rectPass1: TRectangle;
    rectPass2: TRectangle;
    rectPass3: TRectangle;
    rectPass4: TRectangle;
    PasswordEditButton1: TPasswordEditButton;
    PasswordEditButton2: TPasswordEditButton;
    function passwordStrength(sPassword: String): Integer;
    procedure updatePassStrengthBar(iPassStrength: Integer);
    procedure edtPasswordTyping(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegister: TfrmRegister;

implementation

uses frmAuthentication_u;

{$R *.fmx}

procedure TfrmRegister.btnRegisterClick(Sender: TObject);
var
  tSecretsFile: TextFile;
begin
  if not(edtFirstName.Text = NullAsStringValue) AND
    NOT(edtLastName.Text = NullAsStringValue) AND
    NOT(edtEmail.Text = NullAsStringValue) AND
    NOT(edtPassword.Text = NullAsStringValue) AND
    NOT(cmbAccountType.ItemIndex = -1) then
  begin
    if (edtPassword.Text = edtConfirmPassword.Text) and
      (passwordStrength(edtPassword.Text) = 5) then
    begin
      with dmDatabase do
      begin
        if not tblCredentials.Locate('Username', sUsername, [])
        then
        begin
          // username is unique, therefore proceed with registration
          frmAuthentication_u.sUsername :=
            Copy(edtEmail.Text, 1, Pos('@', edtEmail.Text) - 1);
          frmAuthentication_u.sPassword := edtPassword.Text;
          tblCredentials.Insert;
          tblEmployees.Insert;

          tblEmployees['FirstName'] := edtFirstName.Text;
          tblEmployees['LastName'] := edtLastName.Text;
          tblEmployees['EmailAddress'] := edtEmail.Text;
          tblEmployees['Role'] := cmbAccountType.Items
            [cmbAccountType.ItemIndex];
          tblEmployees.Post;

          tblCredentials['Username'] := frmAuthentication_u.sUsername;
          tblCredentials['Password'] := frmAuthentication.DoubleBase64Helper
            ('encode', edtPassword.Text);
          tblCredentials['EmployeeID'] := tblEmployees['EmployeeID'];
          tblCredentials.Post;

          frmAuthentication_u.sGeneratedSecret := GenerateOTPSecret(16);
          if not FileExists('secrets.txt') then
          begin
            try
              FileClose(FileCreate('secrets.txt'));

            except
              showmessage
                ('secrets.txt file could not be made - please create it manually!');
              Exit;
            end;
          end;

          { Text file handling of secret }
          AssignFile(tSecretsFile, 'secrets.txt');
          Append(tSecretsFile);
          Writeln(tSecretsFile, tblCredentials['Username'] + ',' +
            frmAuthentication_u.sGeneratedSecret);
          CloseFile(tSecretsFile);

          showmessage('You have successfully registered!');
          if tblEmployees['Role'] = 'Supplier' then
          begin
            frm2FA_Help.Show;
            frmRegister.Close;
          end
          else
          begin
            frmRegister.Close;
          end;
        end;

      end;
    end
    else
    begin
      showmessage('Your password is too weak');
    end;
  end
  else
  begin
    showmessage('One of your fields are blank!');
  end;

end;

procedure TfrmRegister.edtPasswordTyping(Sender: TObject);
begin
  updatePassStrengthBar(passwordStrength(edtPassword.Text));

end;

function TfrmRegister.passwordStrength(sPassword: String): Integer;
var
  bLength, bLower, bUpper, bSymbol, bNumber: Boolean;
  iscore: Integer;
  i: Integer;
const
  numbersList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  specialsList = ['`', '~', '#', '@', '!', '$', '%', '^', '&', '*', '(', ')',
    '_', '-', '=', '+', '[', '{', ']', '}', '\', '|', ';', ':', '"', '''', '?',
    ',', '.', '<', '>', '/'];
begin
  { Determine Password Strength
    * ONE POINT ADDED PER CATEGORY MET *
    - 8 characters+
    - At least 1 lowercase character
    - At least 1 uppercase character
    - At least 1 symbol
    - At least 1 number

    (You need 5 points to proceed!)
  }
  // Initialization:
  iscore := 0;
  bLength := false;
  bLower := false;
  bUpper := false;
  bSymbol := false;
  bNumber := false;

  if Length(sPassword) >= 8 then
  begin
    bLength := true;
  end;

  for i := 1 to Length(sPassword) do
  begin
    if sPassword[i] in ['a' .. 'z'] then
      bLower := true;
    if sPassword[i] in ['A' .. 'Z'] then
      bUpper := true;
    if sPassword[i] in numbersList then
      bNumber := true;
    if sPassword[i] in specialsList then
      bSymbol := true;
  end;

  if bUpper then
    inc(iscore);

  if bLower then
    inc(iscore);

  if bNumber then
    inc(iscore);

  if bLength then
    inc(iscore);

  if bSymbol then
    inc(iscore);

  result := iscore;
end;

procedure TfrmRegister.updatePassStrengthBar(iPassStrength: Integer);
begin
  // update bar logic
  case iPassStrength of
    0:
      begin
        rectPass1.Fill.Color := claGrey;
        rectPass2.Fill.Color := claGrey;
        rectPass3.Fill.Color := claGrey;
        rectPass4.Fill.Color := claGrey;
      end;
    1 .. 2:
      begin
        rectPass1.Fill.Color := claCrimson;
        rectPass2.Fill.Color := claGrey;
        rectPass3.Fill.Color := claGrey;
        rectPass4.Fill.Color := claGrey;
      end;
    3:
      begin
        rectPass1.Fill.Color := claGold;
        rectPass2.Fill.Color := claGold;
        rectPass3.Fill.Color := claGrey;
        rectPass4.Fill.Color := claGrey;
      end;
    4:
      begin
        rectPass1.Fill.Color := claCoral;
        rectPass2.Fill.Color := claCoral;
        rectPass3.Fill.Color := claCoral;
        rectPass4.Fill.Color := claGrey;
      end;
    5:
      begin
        rectPass1.Fill.Color := claSpringgreen;
        rectPass2.Fill.Color := claSpringgreen;
        rectPass3.Fill.Color := claSpringgreen;
        rectPass4.Fill.Color := claSpringgreen;
      end;

  end;
end;

end.
