unit BaseFormTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, TB2Item, SpTBXItem,
  Vcl.ExtCtrls, TB2Dock, TB2Toolbar, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, cxGraphics;

type
  TTimeLabelItem = class(TSpTBXLabelItem)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TBaseForm = class(TForm)
    MainMenu: TMainMenu;
    miActions: TMenuItem;
    miService: TMenuItem;
    miHelp: TMenuItem;
    sbMain: TSpTBXStatusBar;
    lblDataCaption: TSpTBXLabelItem;
    SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem;
    SpTBXSeparatorItem2: TSpTBXSeparatorItem;
    lblData: TSpTBXLabelItem;
    SpTBXSeparatorItem3: TSpTBXSeparatorItem;
    lblTimeCaption: TSpTBXLabelItem;
    grpInfo: TTBGroupItem;
    grpDate: TTBGroupItem;
    grpTime: TTBGroupItem;
    tmMainTimer: TTimer;
    dckTop: TSpTBXDock;
    tbrMain: TSpTBXToolbar;
    tbiExit: TSpTBXItem;
    miExit: TMenuItem;
    lblAppHint: TSpTBXLabelItem;
    MainActionList: TActionList;
    ilMainLarge: TcxImageList;
    ilMainSmall: TcxImageList;
    procedure FormCreate(Sender: TObject);
    procedure tmMainTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miExitClick(Sender: TObject);
  private
    lblTime: TTimeLabelItem;
    procedure ShowHint(Sender: TObject);
  protected
    function ReportGroup: Integer; virtual;
  public
    { Public declarations }
  end;

var
  frmBase: TBaseForm;

implementation

resourcestring
  rsTimerHello = 'Timer start';

{$R *.dfm}

{ TTimeLabelItem }

constructor TTimeLabelItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.Caption := FormatDateTime('hh:mm:ss', Now);
  Self.FontSettings.Color := clHighlight;
  Self.FontSettings.Style := [fsBold];
end;

{ TBaseForm }

procedure TBaseForm.FormCreate(Sender: TObject);
begin
  // стартуем таймер
  tmMainTimer.Enabled := True;
  lblData.Caption := FormatDateTime('dd.MM.yyyy г.', Now);

  // создаем объект для отображения текущего времени
  lblTime := TTimeLabelItem.Create(grpTime);
  grpTime.Add(lblTime);

  Application.OnHint := ShowHint;

end;

procedure TBaseForm.FormDestroy(Sender: TObject);
begin
  lblTime.Free;
end;

procedure TBaseForm.miExitClick(Sender: TObject);
begin
  Close;
end;

function TBaseForm.ReportGroup: Integer;
begin
  // Переопределение в потомках
end;

procedure TBaseForm.ShowHint(Sender: TObject);
begin
  lblAppHint.Caption := Application.Hint;
end;

procedure TBaseForm.tmMainTimerTimer(Sender: TObject);
begin
  lblTime.Caption := FormatDateTime('hh:mm:ss', Now);
end;

end.
