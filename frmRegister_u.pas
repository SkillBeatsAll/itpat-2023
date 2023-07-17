unit frmRegister_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.RegularExpressions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ImageList, FMX.ImgList, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  FMX.Controls.Presentation, FMX.ListBox, UIConsts, FMX.Ani, frm2FA_Help_u,
  dbmEnviroPOSDB_u, OTPUtility_u, FMX.SVGIconImage;

type
  TfrmRegister = class(TForm)
    StyleBook1: TStyleBook;
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
    SVGIconImage1: TSVGIconImage;
    lblStatus: TLabel;
    function passwordStrength(sPassword: String): Integer;
    procedure updatePassStrengthBar(iPassStrength: Integer);
    procedure edtPasswordTyping(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure edtConfirmPasswordTyping(Sender: TObject);
    procedure edtEmailTyping(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sRegisterRole: String;
  end;

var
  frmRegister: TfrmRegister;

const
  sEmailRegex: String = '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';

implementation

uses frmAuthentication_u;

{$R *.fmx}

procedure TfrmRegister.btnRegisterClick(Sender: TObject);
var
  tSecretsFile: TextFile;
begin
  // required so that we can pass through a manager registration if needed
  if cmbAccountType.Visible = true then
  begin
    sRegisterRole := cmbAccountType.Items[cmbAccountType.ItemIndex]
  end;
  { make sure no fields are blank }
  if not(edtFirstName.Text = NullAsStringValue) AND
    NOT(edtLastName.Text = NullAsStringValue) AND
    NOT(edtEmail.Text = NullAsStringValue) AND
    NOT(edtPassword.Text = NullAsStringValue) AND
    NOT(sRegisterRole = NullAsStringValue) then
  begin { passwords match check, and password strength check }
    if (edtPassword.Text = edtConfirmPassword.Text) and
      (passwordStrength(edtPassword.Text) = 5) then
    begin
      { email validation check }
      if TRegEx.IsMatch(edtEmail.Text, sEmailRegex) then
      begin
        with dmDatabase do
        begin
          frmAuthentication_u.sUsername := edtEmail.Text; { username = email }
          if not tblCredentials.Locate('Username',
            frmAuthentication_u.sUsername, []) then
          begin
            // username is unique, therefore proceed with registration
            frmAuthentication_u.sUsername := edtEmail.Text;
            frmAuthentication_u.sPassword := edtPassword.Text;

            { Write user-inputted details into database }
            tblCredentials.Insert;
            tblEmployees.Insert;

            tblEmployees['FirstName'] := edtFirstName.Text;
            tblEmployees['LastName'] := edtLastName.Text;
            tblEmployees['EmailAddress'] := edtEmail.Text;
            tblEmployees['Role'] := sRegisterRole;
            tblEmployees.Post;

            tblCredentials['Username'] := frmAuthentication_u.sUsername;
            // encodes password in base 64 twice
            tblCredentials['Password'] := frmAuthentication.DoubleBase64Helper
              ('encode', edtPassword.Text);
            tblCredentials['EmployeeID'] := tblEmployees['EmployeeID'];
            tblCredentials.Post;

            { generate a secret for the purpose of 2FA }
            frmAuthentication_u.sGeneratedSecret := GenerateOTPSecret(16);
            if not FileExists('secrets.txt') then
            begin
              try
                { Creates secrets.txt file, then immediately closes it to avoid errors }
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
            if (tblEmployees['Role'] = 'Supplier') OR
              (tblEmployees['Role'] = 'Manager') then
            begin
              { If they registered as a supplier / manager, 2FA is compulsory. frm2FA_Help shows guide for 2fa }
              frm2FA_Help.Show;
              frmRegister.Close;
            end
            else
            begin
              frmRegister.Close;
            end;
          end
          else
          begin
            showmessage('Email is already taken!');
          end;

        end;
      end
      else
      begin
        lblStatus.Text := 'Enter a valid e-mail address!';
      end;
    end
    else
    begin
      lblStatus.Text :=
        'Must be at least 8 characters long, 1 uppercase + lowercase character, 1 special, 1 number';
    end;
  end
  else
  begin
    lblStatus.Text := 'One of your fields are blank!'
  end;

end;

procedure TfrmRegister.edtConfirmPasswordTyping(Sender: TObject);
begin
  if not(edtPassword.Text = edtConfirmPassword.Text) then
    lblStatus.Text := 'Passwords must match.'
  else
    lblStatus.Text := '';
end;

procedure TfrmRegister.edtEmailTyping(Sender: TObject);
begin
  if TRegEx.IsMatch(edtEmail.Text, sEmailRegex) then
  begin
    lblStatus.Text := '';
  end
  else
  begin
    lblStatus.Text := 'Please enter a valid e-mail address!';
  end;
end;

procedure TfrmRegister.edtPasswordTyping(Sender: TObject);
begin
  updatePassStrengthBar(passwordStrength(edtPassword.Text));

  { Display to user appropriately }
  if passwordStrength(edtPassword.Text) <> 5 then
    lblStatus.Text :=
      'Must be at least 8 characters long, 1 uppercase + lowercase character, 1 special, 1 number';
  if passwordStrength(edtPassword.Text) = 5 then
    lblStatus.Text := '';
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
    if sPassword[i] in ['a' .. 'z'] then // if current char is lowercase
      bLower := true;
    if sPassword[i] in ['A' .. 'Z'] then // if current char is uppercase
      bUpper := true;
    if sPassword[i] in numbersList then // if current char is a number
      bNumber := true;
    if sPassword[i] in specialsList then // if current char is special
      bSymbol := true;
  end;

  { increment score appropriately (up to a max of 5) }
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

  result := iscore; // returns the score
end;

procedure TfrmRegister.updatePassStrengthBar(iPassStrength: Integer);
begin
  // update bar logic
  { updates password bar and changes the colors appropriately, based on the password strength }
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
