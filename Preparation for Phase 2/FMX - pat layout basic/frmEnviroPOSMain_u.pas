unit frmEnviroPOSMain_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, FMX.StdCtrls, FMX.Objects,
  System.ImageList, FMX.ImgList, FMX.Styles.Objects, FMX.Layouts,
  FMX.Filter.Effects, FMX.Effects, FMX.Ani, FMX.SVGIconImageList, frmNewOrder_u,
  FMX.DialogService, dbmEnviroPOSDB_u, frmCustomerManagement_u, frmDialog_u,
  MMSystem;

type
  TfrmEnviroPOSMain = class(TForm)
    MultiView1: TMultiView;
    btnOpenCloseView: TButton;
    StyleBook1: TStyleBook;
    btnHelp: TSpeedButton;
    btnSales: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ToolBar1: TToolBar;
    layoutStatistics: TLayout;
    rctStat1: TRectangle;
    rctStat2: TRectangle;
    rctStat3: TRectangle;
    rctStat4: TRectangle;
    rctStat5: TRectangle;
    rctStat6: TRectangle;
    Glyph1: TGlyph;
    Glyph2: TGlyph;
    Glyph3: TGlyph;
    Glyph4: TGlyph;
    Glyph5: TGlyph;
    Glyph6: TGlyph;
    lblStat1: TLabel;
    lblStat2: TLabel;
    lblStat3: TLabel;
    lblStat4: TLabel;
    lblStat5: TLabel;
    lblStat6: TLabel;
    FillRGBEffect1: TFillRGBEffect;
    ColorAnimation1: TColorAnimation;
    ColorAnimation2: TColorAnimation;
    ColorAnimation3: TColorAnimation;
    ColorAnimation4: TColorAnimation;
    ColorAnimation5: TColorAnimation;
    ColorAnimation6: TColorAnimation;
    btnNewOrder: TSpeedButton;
    btnCustomers: TSpeedButton;
    btnHome: TSpeedButton;
    Panel1: TPanel;
    procedure btnOpenCloseViewClick(Sender: TObject);
    procedure ToolBar1MouseEnter(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnNewOrderClick(Sender: TObject);
    procedure btnCustomersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnviroPOSMain: TfrmEnviroPOSMain;

implementation

{$R *.fmx}
{$R *.Surface.fmx MSWINDOWS}

procedure TfrmEnviroPOSMain.btnCustomersClick(Sender: TObject);
begin
  frmDialog.Show;
  PlaySound('SYSTEMEXCLAMATION', 0, SND_ASYNC);
end;

procedure TfrmEnviroPOSMain.btnHomeClick(Sender: TObject);
begin
  layoutStatistics.Visible := true;
  layoutStatistics.Enabled := true;
end;

procedure TfrmEnviroPOSMain.btnNewOrderClick(Sender: TObject);
begin
  TDialogService.MessageDialog('Do you want to start a new order?',
    TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbCancel, 0,
    procedure(const AResult: TModalResult)
    begin
      case AResult of
        mrYes:
          frmNewOrder.Show;
      end;
    end);
end;

procedure TfrmEnviroPOSMain.btnOpenCloseViewClick(Sender: TObject);
begin
  if MultiView1.IsShowed then
  begin
    MultiView1.HideMaster
  end
  else
  begin
    MultiView1.ShowMaster;
  end;
end;

procedure TfrmEnviroPOSMain.ToolBar1MouseEnter(Sender: TObject);
begin
  if MultiView1.IsShowed = false then
    MultiView1.ShowMaster;
end;

end.
