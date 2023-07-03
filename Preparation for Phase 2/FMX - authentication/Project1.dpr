program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmAuthentication_u in 'frmAuthentication_u.pas' {frmAuthentication},
  frmRegister_u in 'frmRegister_u.pas' {frmRegister},
  frm2FA_Help_u in 'frm2FA_Help_u.pas' {frm2FA_Help},
  QRCode_u in 'QRCode_u.pas',
  dbmEnviroPOSDB_u in 'dbmEnviroPOSDB_u.pas' {dmDatabase: TDataModule},
  OTPUtility_u in 'OTPUtility_u.pas',
  Base32Utility_u in 'Base32Utility_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAuthentication, frmAuthentication);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.CreateForm(Tfrm2FA_Help, frm2FA_Help);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.Run;
end.
