program EnviroPOS;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmAuthentication_u in 'frmAuthentication_u.pas' {frmAuthentication},
  Base32Utility_u in 'Base32Utility_u.pas',
  frm2FA_Help_u in 'frm2FA_Help_u.pas' {frm2FA_Help},
  frmRegister_u in 'frmRegister_u.pas' {frmRegister},
  OTPUtility_u in 'OTPUtility_u.pas',
  QRCode_u in 'QRCode_u.pas',
  clsOrder in 'clsOrder.pas',
  clsOrderDetails in 'clsOrderDetails.pas',
  dbmEnviroPOSDB_u in 'dbmEnviroPOSDB_u.pas' {dmDatabase: TDataModule},
  frmAddCustomer_p in 'frmAddCustomer_p.pas' {frmAddCustomer},
  frmCustomerManagement_u in 'frmCustomerManagement_u.pas' {frmCustomerManagement},
  frmDialog_u in 'frmDialog_u.pas' {frmDialog},
  frmEnviroPOSMain_u in 'frmEnviroPOSMain_u.pas' {frmEnviroPOSMain},
  frmNewOrder_u in 'frmNewOrder_u.pas' {frmNewOrder},
  frmInventoryManagement_u in 'frmInventoryManagement_u.pas' {frmInventoryManagement},
  frmAdminCentre_u in 'frmAdminCentre_u.pas' {frmAdminCentre},
  frmHelpBrowser_u in 'frmHelpBrowser_u.pas' {frmHelpBrowser};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAuthentication, frmAuthentication);
  Application.CreateForm(Tfrm2FA_Help, frm2FA_Help);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfrmAddCustomer, frmAddCustomer);
  Application.CreateForm(TfrmCustomerManagement, frmCustomerManagement);
  Application.CreateForm(TfrmDialog, frmDialog);
  Application.CreateForm(TfrmEnviroPOSMain, frmEnviroPOSMain);
  Application.CreateForm(TfrmNewOrder, frmNewOrder);
  Application.CreateForm(TfrmInventoryManagement, frmInventoryManagement);
  Application.CreateForm(TfrmAdminCentre, frmAdminCentre);
  Application.CreateForm(TfrmHelpBrowser, frmHelpBrowser);
  Application.Run;
end.
