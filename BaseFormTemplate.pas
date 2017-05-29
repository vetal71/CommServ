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
  protected
    procedure AppShowHint(Sender: TObject);
  protected
    function ReportGroup: Integer; virtual;
  public
    procedure BuildMenu(ASource: TSpTBXToolbar; AIndex: Integer = 0);
  end;

var
  frmBase: TBaseForm;

implementation

uses
  RegularExpressions;

{$R *.dfm}

{ TTimeLabelItem }

procedure TBaseForm.BuildMenu(ASource: TSpTBXToolbar; AIndex: Integer = 0);
var
  I, J: Integer;
  Dest, Sub: TMenuItem;
  Re  : TRegEx;

  function NewMenuItem(ASourceItem: TTBCustomItem): TMenuItem;
  begin
    Result := TMenuItem.Create(Owner);
    Result.Name       := Re.Replace(ASourceItem.Name, 'tbi|tbs', 'mi');
    Result.Caption    := ASourceItem.Caption;
    Result.ImageIndex := ASourceItem.ImageIndex;
    Result.Enabled    := ASourceItem.Enabled;
    Result.OnClick    := ASourceItem.OnClick;
  end;

begin
  Dest := TMenuItem.Create(Owner);
  Dest.Caption := ASource.Caption;
  Dest.Name    := StringReplace(ASource.Name, 'tbr', 'mi', []);
  miActions.Insert(AIndex, Dest);
  miActions.Insert(AIndex + 1, NewLine);
  for I := 0 to ASource.Items.Count - 1 do
  begin
    if (ASource.Items[ I ] is TSpTBXSeparatorItem) then
    begin
      Dest.Add(NewLine);
    end
    else if (ASource.Items[ I ] is TSpTBXSubmenuItem) then
    begin
      Sub := NewMenuItem(ASource.Items[ I ]);
      Dest.Add(Sub);
      for J := 0 to ASource.Items[ I ].Count - 1 do
      begin
        Sub.Add(NewMenuItem(ASource.Items[ I ].Items[ J ]));
      end;
    end
    else if (ASource.Items[ I ] is TSpTBXItem) then
    begin
      Dest.Add(NewMenuItem(ASource.Items[ I ]));
    end;
  end;
end;

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

  Application.OnHint := AppShowHint;
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

procedure TBaseForm.AppShowHint(Sender: TObject);
begin
  if Assigned(lblAppHint) then
    lblAppHint.Caption := Application.Hint;
end;

procedure TBaseForm.tmMainTimerTimer(Sender: TObject);
begin
  lblTime.Caption := FormatDateTime('hh:mm:ss', Now);
end;

end.
