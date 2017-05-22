unit ConsumersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Data.DB, DBAccess, Uni, MemDS,
  RxSplit, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.StdCtrls,
  Common.DBUtils, KVComp_UDataSetPanel;

type
  TfConsumers = class(TBaseForm)
    tbrConsumers: TSpTBXToolbar;
    tbiAddConsumer: TSpTBXItem;
    tbiEditConsumer: TSpTBXItem;
    tbiDeleteConsumer: TSpTBXItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    lblFilterType: TSpTBXLabelItem;
    tbcTypeConsumer: TTBControlItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    tbsPrint: TSpTBXSubmenuItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    tbiFilterExt: TSpTBXItem;
    cbTypeConsumer: TComboBox;
    pnlView: TPanel;
    pnlOrg: TPanel;
    splMain: TRxSplitter;
    pnlObjects: TPanel;
    dckObject: TSpTBXDock;
    tbrObjects: TSpTBXToolbar;
    tbiAddObject: TSpTBXItem;
    tbiEditObject: TSpTBXItem;
    tbiDeleteObject: TSpTBXItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbiHistoryAttrs: TSpTBXItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    tbiFilterExtObject: TSpTBXItem;
    qryOrgs: TUniQuery;
    dsOrgs: TUniDataSource;
    qryObjects: TUniQuery;
    dsObjects: TUniDataSource;
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
    miN2: TMenuItem;
    miReportMan: TMenuItem;
    dspConsumers: TDataSetPanel;
    dspObjects: TDataSetPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actFilterConsumerExecute(Sender: TObject);
    procedure actFilterObjectExecute(Sender: TObject);
    procedure actAddConsumerExecute(Sender: TObject);
    procedure actEditConsumerExecute(Sender: TObject);
    procedure actDelConsumerExecute(Sender: TObject);
    procedure cbTypeConsumerChange(Sender: TObject);
    procedure qryOrgsAfterOpen(DataSet: TDataSet);
    procedure qryObjectsAfterOpen(DataSet: TDataSet);
  private
    procedure ShowGridFilter(AGrid: TDBGridEh);
    procedure EditCustomer(AMode: TEditMode);
  public
    procedure AfterConstruction; override;
  end;
  
  procedure ShowConsumersList;

implementation

uses
  Common.StrFuncs, DlgConsumerEditor;

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

procedure TfConsumers.actAddConsumerExecute(Sender: TObject);
begin
  // Новый потребитель
  EditCustomer(emAppend);
end;

procedure TfConsumers.actDelConsumerExecute(Sender: TObject);
begin
  inherited;
  // Удаление потребителя
  if ConfirmWarn(Format('Вы действительно хотите удалить потребителя "%s"?'#13 +
    'Также будут удалены все объекты и начисления. Удалить ?', [qryOrgs['ConsumerName']])) then
  begin
    // TODO выполнение процедуры удаления
    try
      qryOrgs.Edit;
      qryOrgs.FieldValues['IsDeleted'] := 1;
      qryOrgs.Refresh;
    except
      on E: Exception do
      begin
        qryOrgs.Cancel;
        ShowErrorFmt('Ошибка при удалении данных по потребителю.'#13'%s', [E.Message]);
      end;
    end;
  end;
end;

procedure TfConsumers.actEditConsumerExecute(Sender: TObject);
begin
  // Редактирование потребителя
  EditCustomer(emEdit);
end;

procedure TfConsumers.actFilterConsumerExecute(Sender: TObject);
begin
  inherited;
  ShowGridFilter(dspConsumers.Grid);
end;

procedure TfConsumers.actFilterObjectExecute(Sender: TObject);
begin
  inherited;
  ShowGridFilter(dspObjects.Grid);
end;

procedure TfConsumers.AfterConstruction;
begin
  inherited;
  cbTypeConsumer.Items := GetItemsByQuery('ConsumerKindRefId', 'ConsumerKindName', 'ConsumersKindRef', True);
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

end;

procedure TfConsumers.EditCustomer(AMode: TEditMode);
var
  F: TfConsumerEditor;
begin
  F := TfConsumerEditor.Create(Owner, qryOrgs, AMode);
  try
    if F.ShowModal = mrOk then
      try
        qryOrgs.Post;
      except
        on E: Exception do
        begin
          qryOrgs.Cancel;
          ShowErrorFmt('Ошибка при сохранении данных по потребителю.'#13'%s', [E.Message]);
        end;
      end
    else
      qryOrgs.Cancel;
  finally
    F.Free;
  end;
end;

procedure TfConsumers.cbTypeConsumerChange(Sender: TObject);
begin
  inherited;
  if cbTypeConsumer.ItemIndex = 0 then
    qryOrgs.FilterSQL := ''
  else if cbTypeConsumer.ItemIndex > 0 then
    qryOrgs.FilterSQL := Format('ConsumerKindId=%d', [cbTypeConsumer.ItemIndex]);
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

procedure TfConsumers.qryObjectsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dspObjects.LoadFieldsDef;
end;

procedure TfConsumers.qryOrgsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dspConsumers.LoadFieldsDef;
end;

procedure TfConsumers.ShowGridFilter(AGrid: TDBGridEh);
begin
  AGrid.STFilter.Visible := not AGrid.STFilter.Visible;
end;

end.
