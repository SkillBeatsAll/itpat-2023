unit frm2FA_Help_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, FMX.Objects, ShellAPI, Windows, QRCode_u, FMX.Clipboard,
  FMX.Platform;

type
  Tfrm2FA_Help = class(TForm)
    StyleBook1: TStyleBook;
    Label1: TLabel;
    memUserInstructions: TMemo;
    Label2: TLabel;
    imgAppleStore: TImage;
    imgAndroidStore: TImage;
    imgBrowser: TImage;
    imgQRCode: TImage;
    lblSecret: TText;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure imgAppleStoreClick(Sender: TObject);
    procedure imgAndroidStoreClick(Sender: TObject);
    procedure imgBrowserClick(Sender: TObject);
    procedure lblSecretClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm2FA_Help: Tfrm2FA_Help;
  arrMemoLines: array [1 .. 10] of String;
  QRCodeBitmap: FMX.Graphics.TBitmap;

implementation

uses frmAuthentication_u;

{$R *.fmx}

procedure Tfrm2FA_Help.FormActivate(Sender: TObject);
var
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
  pixelColor: TAlphaColor;
  vBitMapData: TBitmapData;
  rSrc, rDest: TRectF;
  i: Integer;
  sTOTP_Url: String;
begin

  lblSecret.Text := frmAuthentication_u.sGeneratedSecret;
  memUserInstructions.Lines.Clear;
  for i := 1 to Length(arrMemoLines) do
  begin
    memUserInstructions.Lines.Add(arrMemoLines[i]);
  end;
  memUserInstructions.Lines.Add('Your secret: ' + '"' +
    frmAuthentication_u.sGeneratedSecret + '"');

  { from https://github.com/foxitsoftware/DelphiZXingQRCode }
  { ported to FMX from VCL }
  // initialization
  sTOTP_Url := 'otpauth://totp/' + frmAuthentication_u.sUsername +
    '@EnviroPOS?secret=' + frmAuthentication_u.sGeneratedSecret + '&issuer=' +
    frmAuthentication_u.sUsername;
  QRCode := TDelphiZXingQRCode.Create;
  QRCodeBitmap := FMX.Graphics.TBitmap.Create;
  try
    QRCode.Data := sTOTP_Url;
    QRCode.Encoding := TQRCodeEncoding(0);
    QRCode.QuietZone := StrToIntDef('Auto', 4);
    QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          pixelColor := TAlphaColors.Slateblue
        else
          pixelColor := TAlphaColors.Cream;

        if QRCodeBitmap.Map(TMapAccess.Write, vBitMapData) then
          try
            vBitMapData.SetPixel(Column, Row, pixelColor);
          finally
            QRCodeBitmap.Unmap(vBitMapData);
          end;
      end;
    end;
  finally
    QRCode.Free;
  end;
  imgQRCode.Bitmap.SetSize(QRCodeBitmap.Width, QRCodeBitmap.Height);

  rSrc := TRectF.Create(0, 0, QRCodeBitmap.Width, QRCodeBitmap.Height);
  rDest := TRectF.Create(0, 0, imgQRCode.Bitmap.Width, imgQRCode.Bitmap.Height);

  if imgQRCode.Bitmap.Canvas.BeginScene then
    try
      imgQRCode.Bitmap.Canvas.Clear(TAlphaColors.White);

      imgQRCode.Bitmap.Canvas.DrawBitmap(QRCodeBitmap, rSrc, rDest, 1);
    finally
      imgQRCode.Bitmap.Canvas.EndScene;
    end;

  imgQRCode.DisableInterpolation := true;
  imgQRCode.WrapMode := TImageWrapMode.Stretch;
end;

procedure Tfrm2FA_Help.FormCreate(Sender: TObject);

begin

  arrMemoLines[1] := 'To use 2FA (2-factor authentication):';
  arrMemoLines[2] := '';
  arrMemoLines[3] := '(1) Install Authy from your App Store.';
  arrMemoLines[4] := '(2) Click on the + ("Add Account").';
  arrMemoLines[5] := '(3) Enter your secret code / scan the QR code';
  arrMemoLines[6] := 'below.';
  arrMemoLines[7] := '(4) Give it a name and save it.';
  arrMemoLines[8] := '(5) Close this window and login!';
  arrMemoLines[9] :=
    'You can also use an online 2FA solution (click the banner)';
  arrMemoLines[10] := '';
end;

procedure Tfrm2FA_Help.imgAndroidStoreClick(Sender: TObject);
var
  sUrl: String;
begin
  sUrl := 'https://play.google.com/store/apps/details?id=com.authy.authy';
  ShellExecute(HInstance, 'open', PChar(sUrl), nil, nil, SW_NORMAL)
end;

procedure Tfrm2FA_Help.imgAppleStoreClick(Sender: TObject);
var
  sUrl: String;
begin
  sUrl := 'https://apps.apple.com/us/app/twilio-authy/id494168017';
  ShellExecute(HInstance, 'open', PChar(sUrl), nil, nil, SW_NORMAL);
end;

procedure Tfrm2FA_Help.imgBrowserClick(Sender: TObject);
var
  sUrl: String;
begin
  sUrl := 'https://totp.danhersam.com/#/' +
    frmAuthentication_u.sGeneratedSecret;
  ShellExecute(HInstance, 'open', PChar(sUrl), nil, nil, SW_NORMAL)
end;

procedure Tfrm2FA_Help.lblSecretClick(Sender: TObject);
var
  uClipBoard: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService,
    uClipBoard) then
    uClipBoard.SetClipboard(frmAuthentication_u.sGeneratedSecret);
end;

end.
