unit ConsumersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item,
  RxSplit, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Uni,
  DataModule, Data.DB, DBAccess, MemDS, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList;

type
  TfConsumers = class(TBaseForm)
    pnlView: TPanel;
    pnlOrg: TPanel;
    splMain: TRxSplitter;
    pnlObjects: TPanel;
    grdConsumers: TDBGridEh;
    dckObject: TSpTBXDock;
    tbrObjects: TSpTBXToolbar;
    grdObjects: TDBGridEh;
    qryOrgs: TUniQuery;
    dsOrgs: TUniDataSource;
    qryObjects: TUniQuery;
    dsObjects: TUniDataSource;
    tbrConsumers: TSpTBXToolbar;
    tbiAddConsumer: TSpTBXItem;
    tbiAddObject: TSpTBXItem;
    tbiEditObject: TSpTBXItem;
    tbiEditConsumer: TSpTBXItem;
    tbiDeleteObject: TSpTBXItem;
    tbiHistoryAttrs: TSpTBXItem;
    tbiDeleteConsumer: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    tbsPrint: TTBSubmenuItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    lblFilterType: TSpTBXLabelItem;
    cbTypeConsumer: TComboBox;
    tbcTypeConsumer: TTBControlItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    tbiFilterExt: TSpTBXItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    tbiFilterExtObject: TSpTBXItem;
    actAddConsumer: TAction;
    miN1: TMenuItem;
    miConsumers: TMenuItem;
    miAddConsumer: TMenuItem;
    miEditConsumer: TMenuItem;
    miDeleteConsumer: TMenuItem;
    miN5: TMenuItem;
    miFilterConsumer: TMenuItem;
    miN7: TMenuItem;
    miPrint: TMenuItem;
    miObjects: TMenuItem;
    miAddObject: TMenuItem;
    miEditObject: TMenuItem;
    miDeleteObject: TMenuItem;
    miN13: TMenuItem;
    miHistoryAttrs: TMenuItem;
    miN15: TMenuItem;
    miFilterObject: TMenuItem;
    actFilterConsumer: TAction;
    actEditConsumer: TAction;
    actDelConsumer: TAction;
    actAddObject: TAction;
    actEditObject: TAction;
    actDelObject: TAction;
    actHistory: TAction;
    actFilterObject: TAction;
    pmObjects: TSpTBXPopupMenu;
    pmConsumers: TSpTBXPopupMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actFilterConsumerExecute(Sender: TObject);
    procedure actFilterObjectExecute(Sender: TObject);
  private
    procedure ShowGridFilter(AGrid: TDBGridEh);
    procedure BuildPopupMenu(ASource: TSpTBXToolbar; ADest: TSpTBXPopupMenu);
  public
    procedure AfterConstruction; override;
  end;

  procedure ShowConsumersList;

implementation

uses
  Common.StrFuncs, EhLibUniDAC;

{$R *.dfm}

procedure ShowConsumersList;
begin
  with TfConsumers.Create(Application) do
  try
    Show;
  except on E: Exception do
    ShowError(E.Message);
  end;
end;

{ TfConsumers }

procedure TfConsumers.actFilterConsumerExecute(Sender: TObject);
begin
  inherited;
  ShowGridFilter(grdConsumers);
end;

procedure TfConsumers.actFilterObjectExecute(Sender: TObject);
begin
  inherited;
  ShowGridFilter(grdObjects);
end;

procedure TfConsumers.AfterConstruction;
begin
  inherited;
  if qryOrgs.Active then
    qryOrgs.Close;
  try
    qryOrgs.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить список организаций.'#13'%s', [ E.Message ]);
  end;
  if qryObjects.Active then
    qryObjects.Close;
  try
    qryObjects.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить список потребителей.'#13'%s', [ E.Message ]);
  end;

  // Создание PopupMenu
  BuildPopupMenu(tbrConsumers, pmConsumers);
  BuildPopupMenu(tbrObjects, pmObjects);
end;

procedure TfConsumers.BuildPopupMenu(ASource: TSpTBXToolbar; ADest: TSpTBXPopupMenu);
var
  I, J: Integer;
  TBItem: TSpTBXItem;
  TBSep:  TSpTBXSeparatorItem;

begin
  for I := 0 to ASource.Items.Count - 1 do
  begin
    if (ASource.Items[ I ] is TSpTBXSeparatorItem) then
    begin
      TBSep := TSpTBXSeparatorItem.Create(Owner);
      TBSep.Name := ASource.Items[ I ].Name + 'Pm';
      ADest.Items.Add(TBSep);
    end
    else if (ASource.Items[ I ] is TSpTBXItem) then
    begin
      for J := 0 to ASource.Items[ I ].Count - 1 do
      begin
        TBItem := TSpTBXItem.Create(Owner);
        StringToComponent( TBItem, ComponentToString(ASource.Items[ I ] as TSpTBXItem) );
        TBItem.Name := ASource.Items[ I ].Name + 'Pm';
        TBItem.Images := nil;
        TBItem.ImageIndex := -1;
        TBItem.OnClick := ASource.Items[ I ].OnClick;
        ADest.Items.Add(TBItem);
      end;
    end;
  end;
end;

procedure TfConsumers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfConsumers.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 84 ) and ( Shift - [ssCtrl] = [] ) then
  begin
    if ActiveControl is TDBGridEh then
    begin
      (ActiveControl as TDBGridEh).STFilter.Visible := not
        (ActiveControl as TDBGridEh).STFilter.Visible;
    end;
  end;
end;

procedure TfConsumers.ShowGridFilter(AGrid: TDBGridEh);
begin
  AGrid.STFilter.Visible := not AGrid.STFilter.Visible;
end;

end.
