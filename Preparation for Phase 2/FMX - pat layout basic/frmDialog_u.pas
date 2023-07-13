unit frmDialog_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.SVGIconImage, dbmEnviroPOSDB_u, frmCustomerManagement_u, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Effects, FMX.Filter.Effects, FMX.ImgList,
  frmAddCustomer_p;

type
  TfrmDialog = class(TForm)
    StyleBook1: TStyleBook;
    Glyph1: TGlyph;
    FillRGBEffect1: TFillRGBEffect;
    Label1: TLabel;
    btnManageCustomers: TButton;
    btnAddCustomer: TButton;
    btnCancel: TButton;
    procedure btnManageCustomersClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddCustomerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDialog: TfrmDialog;

implementation

{$R *.fmx}

procedure TfrmDialog.btnAddCustomerClick(Sender: TObject);
begin
  frmAddCustomer.Show;
  self.Close;
end;

procedure TfrmDialog.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmDialog.btnManageCustomersClick(Sender: TObject);
begin
  frmCustomerManagement.Show;
  Self.Close;
end;

end.
