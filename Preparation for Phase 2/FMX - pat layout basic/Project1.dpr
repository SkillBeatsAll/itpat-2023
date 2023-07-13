program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmEnviroPOSMain_u in 'frmEnviroPOSMain_u.pas' {frmEnviroPOSMain},
  dbmEnviroPOSDB_u in 'dbmEnviroPOSDB_u.pas' {dmDatabase: TDataModule},
  frmNewOrder_u in 'frmNewOrder_u.pas' {frmNewOrder},
  frmCustomerManagement_u in 'frmCustomerManagement_u.pas' {frmCustomerManagement},
  frmDialog_u in 'frmDialog_u.pas' {frmDialog},
  clsOrder in 'clsOrder.pas',
  clsOrderDetails in 'clsOrderDetails.pas',
  frmAddCustomer_p in 'frmAddCustomer_p.pas' {frmAddCustomer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEnviroPOSMain, frmEnviroPOSMain);
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TfrmNewOrder, frmNewOrder);
  Application.CreateForm(TfrmCustomerManagement, frmCustomerManagement);
  Application.CreateForm(TfrmDialog, frmDialog);
  Application.CreateForm(TfrmAddCustomer, frmAddCustomer);
  Application.Run;
end.
