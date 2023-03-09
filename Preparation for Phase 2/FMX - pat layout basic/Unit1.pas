unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, FMX.StdCtrls, FMX.Objects,
  System.ImageList, FMX.ImgList, FMX.Styles.Objects;

type
  TForm1 = class(TForm)
    MultiView1: TMultiView;
    btnOpenCloseView: TButton;
    StyleBook1: TStyleBook;
    ImageList1: TImageList;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    procedure btnOpenCloseViewClick(Sender: TObject);
    procedure ToolBar1MouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.Surface.fmx MSWINDOWS}

procedure TForm1.btnOpenCloseViewClick(Sender: TObject);
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

procedure TForm1.ToolBar1MouseEnter(Sender: TObject);
begin
  if MultiView1.IsShowed = false then
    MultiView1.ShowMaster;
end;

end.
