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
  MMSystem, frmInventoryManagement_u, frmAdminCentre_u, frmHelpBrowser_u;

type
  TfrmEnviroPOSMain = class(TForm)
    MultiView1: TMultiView;
    btnOpenCloseView: TButton;
    StyleBook1: TStyleBook;
    btnHelp: TSpeedButton;
    btnInventory: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ToolBar1: TToolBar;
    layoutStatistics: TLayout;
    rectStat1: TRectangle;
    rectStat2: TRectangle;
    rectStat5: TRectangle;
    rectStat6: TRectangle;
    rectStat4: TRectangle;
    rectStat3: TRectangle;
    Glyph1: TGlyph;
    Glyph2: TGlyph;
    Glyph3: TGlyph;
    glyphProfitStatus: TGlyph;
    Glyph5: TGlyph;
    Glyph6: TGlyph;
    lblStat1: TLabel;
    lblStat2: TLabel;
    lblStat5: TLabel;
    lblStat6: TLabel;
    lblStat4: TLabel;
    lblStat3: TLabel;
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
    Label1: TLabel;
    Glyph7: TGlyph;
    lblWelcomeUsername: TLabel;
    lblTime: TLabel;
    timerTime: TTimer;
    lblStatValue1: TLabel;
    lblStatValue2: TLabel;
    lblStatValue3: TLabel;
    lblStatValue5: TLabel;
    lblStatValue4: TLabel;
    lblStatValue6: TLabel;
    FillRGBEffect1: TFillRGBEffect;
    btnAdminCentre: TSpeedButton;
    procedure btnOpenCloseViewClick(Sender: TObject);
    procedure ToolBar1MouseEnter(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnNewOrderClick(Sender: TObject);
    procedure btnCustomersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInventoryClick(Sender: TObject);
    procedure timerTimeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdminCentreClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure updateStatistics;
  end;

var
  frmEnviroPOSMain: TfrmEnviroPOSMain;

implementation

uses frmAuthentication_u;

{$R *.fmx}
{$R *.Surface.fmx MSWINDOWS}

procedure TfrmEnviroPOSMain.btnAdminCentreClick(Sender: TObject);
begin
  frmAdminCentre.Show;
end;

procedure TfrmEnviroPOSMain.btnCustomersClick(Sender: TObject);
begin
  frmDialog.Show;
  PlaySound('SYSTEMEXCLAMATION', 0, SND_ASYNC); // mimic real dialog sound!
end;

procedure TfrmEnviroPOSMain.btnHelpClick(Sender: TObject);
begin
  frmHelpBrowser.Show;
end;

procedure TfrmEnviroPOSMain.btnHomeClick(Sender: TObject);
begin
  layoutStatistics.Visible := true;
  layoutStatistics.Enabled := true;
end;

procedure TfrmEnviroPOSMain.btnInventoryClick(Sender: TObject);
begin
  frmInventoryManagement.Show;
end;

procedure TfrmEnviroPOSMain.btnNewOrderClick(Sender: TObject);
begin
  { Dialog asking user if they want to start an order }
  TDialogService.MessageDialog('Do you want to start a new order?',
    TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbCancel, 0,
    procedure(const AResult: TModalResult)
    // dialog passes result to this procedure
    begin
      case AResult of
        mrYes: // if yes, show new order form
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

procedure TfrmEnviroPOSMain.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  // properly end program when home screen is closed
  Application.Terminate;
end;

procedure TfrmEnviroPOSMain.FormShow(Sender: TObject);
begin
  timerTime.Enabled := true;
  dmDatabase.tblEmployees.Locate('EmployeeID',
    frmAuthentication.iEmployeeID, []);
  lblWelcomeUsername.Text := 'Welcome, ' + dmDatabase.tblEmployees['FirstName'];

  { Show user statistics based on their user type! }
  if frmAuthentication.sUserType = 'Cashier' then
  begin
    rectStat4.Visible := false;
    rectStat5.Visible := false;
    rectStat6.Visible := false;
    btnInventory.Visible := false;
    btnAdminCentre.Visible := false;
  end
  else if frmAuthentication.sUserType = 'Supplier' then
  begin
    rectStat5.Visible := false;
    rectStat6.Visible := false;
    btnAdminCentre.Visible := false;
  end;

  updateStatistics;
end;

{ Procedure to update displayed time per second }
procedure TfrmEnviroPOSMain.timerTimeTimer(Sender: TObject);
begin
  lblTime.Text := TimeToStr(Time);
end;

procedure TfrmEnviroPOSMain.ToolBar1MouseEnter(Sender: TObject);
begin
  if MultiView1.IsShowed = false then
    MultiView1.ShowMaster;
end;

{ Procedure updateStatistics
  * Called by various aspects of the program to update stats on homescreen
  - Fetches latest statistics from the database }
procedure TfrmEnviroPOSMain.updateStatistics;
var
  iSales, iTotalStock, iTotalProducts, iMax: Integer;
  rProfit, rRevenue, rTotalCosts: Real;
  sBestSeller: String;
begin
  { Variable initialization }
  iSales := 0;
  iTotalStock := 0;
  iTotalProducts := 0;
  iMax := 0;
  rProfit := 0;
  rRevenue := 0;
  rTotalCosts := 0;
  sBestSeller := '';

  with dmDatabase do
  begin
    { Calculatations }
    { 2 loops:
      - Orders loop: Loops through the orders table to get total sales and revenue
      - Inventory loop: Loops through inventory to find total costs (expenses),
      total amount of products, and totalStock. (also determines best seller)
    }
    tblOrders.First;
    while not tblOrders.Eof do
    begin
      Inc(iSales);
      rRevenue := rRevenue + tblOrders['OrderValue'];
      tblOrders.Next;
    end;

    tblInventory.First;
    while not tblInventory.Eof do
    begin
      Inc(iTotalProducts);
      rTotalCosts := rTotalCosts +
        (tblInventory['CostPrice'] * tblInventory['SoldQty']);
      Inc(iTotalStock, StrToInt(tblInventory['StockQty']));

      { Check if it is the best seller }
      if tblInventory['SoldQty'] > iMax then
      begin
        iMax := tblInventory['SoldQty'];
        sBestSeller := tblInventory['ProductName'];
      end;
      tblInventory.Next;
    end;
    rProfit := rRevenue - rTotalCosts;

    { Update the labels to reflect the statistics }
    lblStatValue1.Text := IntToStr(iSales);
    lblStatValue2.Text := IntToStr(iTotalStock);
    lblStatValue3.Text := IntToStr(iTotalProducts);
    lblStatValue4.Text := sBestSeller;
    lblStatValue4.Hint := sBestSeller; { hint incase text too long }
    lblStatValue5.Text := FloatToStrF(rRevenue, ffcurrency, 8, 2);
    lblStatValue6.Text := FloatToStrF(rProfit, ffcurrency, 8, 2);

    { Dynamically update profit status }
    if rProfit < 0 then // loss
    begin
      glyphProfitStatus.ImageIndex := 9; // loss icon
      FillRGBEffect1.Color := TAlphaColors.Red;
    end
    else if rProfit = 0 then // breakeven (income = expenses)
    begin
      glyphProfitStatus.ImageIndex := 10; // break even icon
      FillRGBEffect1.Color := TAlphaColors.Yellow;
    end
    else if rProfit > 0 then // profit
    begin
      glyphProfitStatus.ImageIndex := 11; // profit icon
      FillRGBEffect1.Color := TAlphaColors.Springgreen;
    end;
  end;
end;

end.
