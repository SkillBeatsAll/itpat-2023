unit frmHelpBrowser_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser;

type
  TfrmHelpBrowser = class(TForm)
    WebBrowser1: TWebBrowser;
    StyleBook1: TStyleBook;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelpBrowser: TfrmHelpBrowser;

implementation

{$R *.fmx}

procedure TfrmHelpBrowser.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate(System.SysUtils.GetCurrentDir +
    '/assets/help/EnviroPOS Documentation.htm')
end;

end.
