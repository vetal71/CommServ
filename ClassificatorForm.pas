unit ClassificatorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, Vcl.ComCtrls, RxSplit,
  VirtualTrees, Uni, DataModule, KVComp_UDataSetPanel, Data.DB, DBAccess,
  Common.DBUtils, MemDS;

type
  TCommonsRefData = packed record
    CommonId: Integer;
    CommonName, CommonTableName: string;
  end;
  PCommonsRefData = ^TCommonsRefData;

type
  TfClassificator = class(TBaseForm)
    pnlLeft: TPanel;
    pnlRight: TPanel;
    spl1: TRxSplitter;
    vstCommons: TVirtualStringTree;
    dspCommons: TDataSetPanel;
    qryCommon: TUniQuery;
    dsCommon: TUniDataSource;
    dckCommons: TSpTBXDock;
    tbrCommons: TSpTBXToolbar;
    tbiAddCommonRec: TSpTBXItem;
    tbiEditCommonRec: TSpTBXItem;
    tbiDelCommonRec: TSpTBXItem;
    tbrCommonsRef: TSpTBXToolbar;
    tbiAddCommon: TSpTBXItem;
    tbiEditCommon: TSpTBXItem;
    tbiDelCommon: TSpTBXItem;
    procedure vstDictListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstCommonsGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex;
      var ImageList: TCustomImageList);
    procedure vstCommonsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstCommonsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure qryCommonAfterOpen(DataSet: TDataSet);
    procedure tbiAddCommonRecClick(Sender: TObject);
    procedure tbiEditCommonRecClick(Sender: TObject);
    procedure tbiDelCommonRecClick(Sender: TObject);
    procedure tbiAddCommonClick(Sender: TObject);
    procedure tbiEditCommonClick(Sender: TObject);
    procedure tbiDelCommonClick(Sender: TObject);
  private
    procedure BuildTree;
    function GetNodeData(const ANode: PVirtualNode): PCommonsRefData;
    procedure InitCommonView(AData: PCommonsRefData);
    procedure EditCommonRec(AMode: TEditMode);
    procedure EditCommon(AMode: TEditMode);
  public
    procedure AfterConstruction; override;
  end;

var
  fClassificator: TfClassificator;

implementation

uses
  DlgCommonRecEditor, Common.StrFuncs, DlgCommonEditor;

{$R *.dfm}

{ TfClassificator }

procedure TfClassificator.AfterConstruction;
begin
  inherited;
  BuildTree;

  // Меню "Действие"
  BuildMenu(tbrCommonsRef, 0);
  BuildMenu(tbrCommons, 1);
end;

procedure TfClassificator.BuildTree;
const
  cSQL_Common = 'select * from CommonsRef';
var
  Q: TUniQuery;
  eRoot, eNode: PVirtualNode;
  eData: PCommonsRefData;
begin
  // Строим дерево справочников
  Q := TUniQuery.Create(Owner);
  with Q, vstCommons do
  try
    NodeDataSize := SizeOf(TCommonsRefData);
    eRoot      := RootNode;

    Connection := dm.dbConn;
    SQL.Text   := cSQL_Common;
    Open;
    while not Eof do
    begin
      eNode := AddChild(eRoot);
      eData := GetNodeData(eNode);
      eData^.CommonId        := FieldByName('CommonRefId').AsInteger;
      eData^.CommonName      := FieldByName('CommonName').AsString;
      eData^.CommonTableName := FieldByName('CommonTableName').AsString;

      Next;
    end;
    FocusedNode := RootNode.FirstChild;
    Selected[FocusedNode] := True;
    vstCommonsChange(vstCommons, FocusedNode);
  finally
    Q.Free;
  end;
end;

procedure TfClassificator.EditCommon(AMode: TEditMode);
const
  cSQL_Insert =
    'insert into CommonsRef(CommonName, CommonTableName) ' + #13#10 +
    ' Values(:CommonName, :CommonTableName)';
  cSQL_Update =
    'update CommonsRef set CommonName = :CommonName, CommonTableName = :CommonTableName ' + #13#10 +
    ' where CommonRefId = :CommonRefId';
var
  F: TfCommonEditor;
  eNode: PVirtualNode;
  eData: PCommonsRefData;
  Q: TMyQuery;
begin
  F := TfCommonEditor.Create(Owner);
  if vstCommons.SelectedCount = 0 then Exit;
  if AMode = emEdit then
  begin
    eNode := vstCommons.FocusedNode;
    if not Assigned(eNode) then Exit;
    eData := GetNodeData(eNode);
    F.CommonName := eData.CommonName;
    F.TableName  := eData.CommonTableName;
  end;
  F.EditMode   := AMode;
  try
    if F.ShowModal = mrOk then
    begin
      if AMode = emAppend then
      begin
        eNode := vstCommons.AddChild(vstCommons.RootNode);
        if not Assigned(eNode) then Exit;
        eData := GetNodeData(eNode);
      end;
      eData^.CommonName      := F.CommonName;
      eData^.CommonTableName := F.TableName;

      Q := TMyQuery.Create(nil);
      with Q do
      try
        case AMode of
          emAppend: SQL.Text := cSQL_Insert;
          emEdit:
            begin
              SQL.Text := cSQL_Update;
              ParamByName('CommonRefId').AsInteger := eData.CommonId;
            end;
        end;
        ParamByName('CommonName').AsString      := eData.CommonName;
        ParamByName('CommonTableName').AsString := eData.CommonTableName;
        ExecSQL;
      except
        on E: Exception do
        begin
          ShowErrorFmt('Ошибка при сохранении правочника.'#13'%s', [E.Message]);
        end;
      end;

    end;
  finally
    F.Free;
  end;
end;

procedure TfClassificator.EditCommonRec(AMode: TEditMode);
var
  F: TfCommonRecEditor;
begin
  F := TfCommonRecEditor.Create(Owner, dspCommons.Grid.DataSource.DataSet, AMode);
  try
    if F.ShowModal = mrOk then
      try
        qryCommon.Post;
      except
        on E: Exception do
        begin
          qryCommon.Cancel;
          ShowErrorFmt('Ошибка при сохранении элемента справочника.'#13'%s', [E.Message]);
        end;
      end
    else
      qryCommon.Cancel;
  finally
    F.Free;
  end;
end;

function TfClassificator.GetNodeData(
  const ANode: PVirtualNode): PCommonsRefData;
begin
  Result := vstCommons.GetNodeData(ANode)
end;

procedure TfClassificator.InitCommonView(AData: PCommonsRefData);
begin
  if AData = nil then Exit;

  if qryCommon.Active then
    qryCommon.Close;
  qryCommon.SQL.Text := Format('select * from %s', [AData.CommonTableName]);
  qryCommon.UpdatingTable := AData.CommonTableName;
  qryCommon.KeyFields := GetKeyFields(AData.CommonTableName);
  with dspCommons do
  begin
    Storage.StorageTopic := AData.CommonTableName;
    Title                := AData.CommonName;
    try
      qryCommon.Open;
    except
      on E: Exception do
      begin
        ShowErrorFmt('Ошибка при получении элементов справочника.'#13'%s', [E.Message]);
      end;
    end;
  end;
end;

procedure TfClassificator.qryCommonAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dspCommons.LoadFieldsDef;
end;

procedure TfClassificator.tbiAddCommonClick(Sender: TObject);
begin
  inherited;
  EditCommon(emAppend);
end;

procedure TfClassificator.tbiAddCommonRecClick(Sender: TObject);
begin
  inherited;
  EditCommonRec(emAppend);
end;

procedure TfClassificator.tbiDelCommonClick(Sender: TObject);
var
  eNode: PVirtualNode;
  eData: PCommonsRefData;
  Q: TMyQuery;
begin
  inherited;
  // Удаление элемента
  eNode := vstCommons.FocusedNode;
  if not Assigned(eNode) then
  begin
    ShowWarning('Не выбран справочник.');
    Exit;
  end;
  eData := GetNodeData(eNode);
  if ConfirmWarn(Format('Вы действительно хотите удалить справочник %s?', [eData.CommonName])) then
  begin
    Q := TMyQuery.Create(nil);
    with Q do
    try
      SQL.Text := 'delete from CommonsRef where CommonRefId = :CommonRefId';
      ParamByName('CommonRefId').AsInteger := eData.CommonId;
      ExecSQL;
      vstCommons.DeleteNode(eNode);
      vstCommons.FocusedNode := vstCommons.RootNode.FirstChild;
      vstCommons.Selected[vstCommons.FocusedNode] := True;
      vstCommonsChange(vstCommons, vstCommons.FocusedNode);
    except
      on E: Exception do
      begin
        ShowErrorFmt('Ошибка при удалении справочника.'#13'%s', [E.Message]);
      end;
    end;
  end;
end;

procedure TfClassificator.tbiDelCommonRecClick(Sender: TObject);
begin
  inherited;
  // Удаление элемента
  if ConfirmWarn('Вы действительно хотите удалить элемент справочника?') then
  begin
    try
      qryCommon.Delete;
    except
      on E: Exception do
      begin
        qryCommon.Cancel;
        ShowErrorFmt('Ошибка при удалении элемента справочника.'#13'%s', [E.Message]);
      end;
    end;
  end;
end;

procedure TfClassificator.tbiEditCommonClick(Sender: TObject);
begin
  inherited;
  //
  EditCommon(emEdit);
end;

procedure TfClassificator.tbiEditCommonRecClick(Sender: TObject);
begin
  inherited;
  EditCommonRec(emEdit);
end;

procedure TfClassificator.vstCommonsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  eData : PCommonsRefData;
begin
  if not Assigned(Node) then Exit;
  eData := GetNodeData(Node);
  InitCommonView(eData);
end;

procedure TfClassificator.vstCommonsGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex;
  var ImageList: TCustomImageList);
begin
  inherited;
  ImageList  := ilMainSmall;
  case Kind of
    ikNormal   : ImageIndex := 9;
    ikSelected : ImageIndex := 10;
  end;
end;

procedure TfClassificator.vstCommonsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  inherited;
  Node.States := Node.States - [vsSelected];
end;

procedure TfClassificator.vstDictListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  if Column = 0 then
    CellText := GetNodeData(Node).CommonName;
end;

end.
