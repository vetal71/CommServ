unit KVComp_UDataSetPanel;

interface

uses
  IOUtils,
  Variants, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Db, DBGridEh, Menus, IniFiles, SpTBXItem, TB2Item,
  ClipBrd, ShellApi, DBClient, KVComp_UDSPFields, KVComp_FDSPFieldView,
  ActiveX, ComObj, CommCtrl, Vcl.StdCtrls, EhLibUniDAC;

const
//  vpmSort          = 3001;
//  vpmFind          = 3002;
//  vpmQFilterTrue   = 3003;
//  vpmQFilterFalse  = 3004;
//  vpmQFilterRoll   = 3005;
//  vpmQFilterDrop   = 3006;
//  vpmComplexFilter = 3007;
//  vpmFilterCond    = 3008;
//  vpmFixFields     = 3009;
//  vpmDropFixFields = 3010;
//  vpmHideFields    = 3011;
//  vpmShowAllFields = 3012;
  vpmFieldsSetup   = 3013;
//  vpmPrint         = 3014;
//  vpmFieldSum      = 3015;
//  vpmSelectAll     = 3016;
//  vpmSetCondFilter = 3017;
//  vpmDropAndSetCondFilter = 3018;
//  vpmSortDesc      = 3019;
//  vpmExcelExport         = 3020;

{----------------------------------------------------------------------------}
{ TFieldsDefStorage - хранение описаний полей                                }
{----------------------------------------------------------------------------}
type
 TFieldsDefStorageType = (fdsDatabase, fdsIniFile);

type
 TFieldsDefStorage = class (TComponent)
 private
   FStorageName  : String;
   FStorageTopic : String;
 public
   bLoadFieldsIndex : Boolean;
   DataSetPanel : Pointer;
   constructor Create(aOwner: TComponent); override;
   procedure LoadFieldDef (Field : TField; var FldIndex : Integer);
   procedure SaveFieldDef (Field : TField);
 published
   property StorageName  : String read FStorageName  write FStorageName;
   property StorageTopic : String read FStorageTopic write FStorageTopic;
 end;

{----------------------------------------------------------------------------}
{ TDataSetPanel                                                              }
{----------------------------------------------------------------------------}
type
  TLogChangesEvent = procedure (LogChangesType : Integer;
    const DataSetName, UniqueKeyNames, UniqueKeyValues, ChangesText : String) of object;

type
  TDataSetPanel = class(TPanel)
  private

    FDataSource  : TDataSource;
    FTitle       : TLabel;
    FGrid        : TDBGridEh;
    FStorage     : TFieldsDefStorage;
    FToolbar     : TSpTBXToolbar;

    bActivate    : Boolean;

 protected
   procedure ReadState(Reader: TReader); override;
 private
   procedure CMActivate(var Message: TMessage); message CM_ACTIVATE;
   procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
   procedure WMSize(var Message: TWMSize); message WM_SIZE;
   procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;

   procedure ReadGrid(Stream: TStream);
   procedure WriteGrid(Stream: TStream);
   procedure ReadStorage(Stream: TStream);
   procedure WriteStorage(Stream: TStream);

 protected
   procedure DefineProperties(Filer: TFiler); override;

   //-------------------------------------------------------------------------//
private
   procedure SetDataSource (aValue : TDataSource);
   procedure SetToolbar (Value : TSpTBXToolbar);
   procedure SetTitle(const Value: string);
   function GetTitle: string;
   procedure CreatePopupMenus;
   procedure OnPopupClick (Sender: TObject);

   function  GetGridCellClick : TDBGridEhClickEvent;
   procedure SetGridCellClick (Value : TDBGridEhClickEvent);
   function  GetGridColEnter : TNotifyEvent;
   procedure SetGridColEnter (Value : TNotifyEvent);
   function  GetGridColExit : TNotifyEvent;
   procedure SetGridColExit (Value : TNotifyEvent);
   function  GetGridDblClick : TNotifyEvent;
   procedure SetGridDblClick (Value : TNotifyEvent);
   function  GetGridDragDrop : TDragDropEvent;
   procedure SetGridDragDrop(Value : TDragDropEvent);
   function  GetGridDragOver : TDragOverEvent;
   procedure SetGridDragOver(Value : TDragOverEvent);
   function  GetGridDrawColumnCell : TDrawColumnEhCellEvent;
   procedure SetGridDrawColumnCell (Value : TDrawColumnEhCellEvent);
   function  GetGridEndDock: TEndDragEvent;
   procedure SetGridEndDock(const Value: TEndDragEvent);
   function  GetGridEndDrag: TEndDragEvent;
   procedure SetGridEndDrag(const Value: TEndDragEvent);
   function  GetGridGetCellParams : TGetCellEhParamsEvent;
   procedure SetGridGetCellParams (Value : TGetCellEhParamsEvent);
   function  GetGridKeyDown : TKeyEvent;
   procedure SetGridKeyDown (Value : TKeyEvent);
   function  GetGridKeyUp : TKeyEvent;
   procedure SetGridKeyUp (Value : TKeyEvent);
   function  GetGridKeyPress : TKeyPressEvent;
   procedure SetGridKeyPress (Value : TKeyPressEvent);
   function  GetGridMouseDown: TMouseEvent;
   procedure SetGridMouseDown(const Value: TMouseEvent);
   function  GetGridMouseMove: TMouseMoveEvent;
   procedure SetGridMouseMove(const Value: TMouseMoveEvent);
   function  GetGridMouseUp: TMouseEvent;
   procedure SetGridMouseUp(const Value: TMouseEvent);
   function  GetGridTitleClick : TDBGridEhClickEvent;
   procedure SetGridTitleClick (Value : TDBGridEhClickEvent);
 public
   { Проверка активности DataSet }
   function DataSetActive : Boolean;
 public
   constructor Create(aOwner: TComponent); override;
   destructor Destroy; override;
   procedure InnerSetup;

   procedure FieldsSetup;
   procedure LoadFieldsDef;
   procedure SaveFieldsDef(aCommonSetup : Boolean = False);

   { Выполнить действие, связанное с пунктом Popup-меню }
   procedure ExecutePopup (aTag : Integer);

 published
   property DataSource : TDataSource read FDataSource write SetDataSource;
   property Title      : string read GetTitle write SetTitle;
   property Grid       : TDBGridEh read FGrid;
   property Storage    : TFieldsDefStorage read FStorage;
   property Toolbar    : TSpTBXToolbar read FToolbar write SetToolbar;

   property OnGridCellClick      : TDBGridEhClickEvent read GetGridCellClick write SetGridCellClick;
   property OnGridColEnter       : TNotifyEvent read GetGridColEnter write SetGridColEnter;
   property OnGridColExit        : TNotifyEvent read GetGridColExit write SetGridColExit;
   property OnGridDblClick       : TNotifyEvent read GetGridDblClick write SetGridDblClick;
   property OnGridDragDrop: TDragDropEvent read GetGridDragDrop write SetGridDragDrop;
   property OnGridDragOver: TDragOverEvent read GetGridDragOver write SetGridDragOver;
   property OnGridDrawColumnCell : TDrawColumnEhCellEvent read GetGridDrawColumnCell write SetGridDrawColumnCell;
   property OnGridEndDock: TEndDragEvent read GetGridEndDock write SetGridEndDock;
   property OnGridEndDrag: TEndDragEvent read GetGridEndDrag write SetGridEndDrag;
   property OnGridGetCellParams  : TGetCellEhParamsEvent read GetGridGetCellParams write SetGridGetCellParams;
   property OnGridKeyDown        : TKeyEvent read GetGridKeyDown write SetGridKeyDown;
   property OnGridKeyUp          : TKeyEvent read GetGridKeyUp write SetGridKeyUp;
   property OnGridKeyPress       : TKeyPressEvent read GetGridKeyPress write SetGridKeyPress;
   property OnGridMouseDown: TMouseEvent read GetGridMouseDown write SetGridMouseDown;
   property OnGridMouseMove: TMouseMoveEvent read GetGridMouseMove write SetGridMouseMove;
   property OnGridMouseUp: TMouseEvent read GetGridMouseUp write SetGridMouseUp;
   property OnGridTitleClick     : TDBGridEhClickEvent read GetGridTitleClick write SetGridTitleClick;
 end;

procedure Register;

////////////////////////////////////////////////////////////////////////////////
implementation//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

{----------------------------------------------------------------------------}
{ Вспомогательные процедуры                                                  }
{----------------------------------------------------------------------------}
procedure SetFieldWidth (aDataSetPanel : TDataSetPanel; const aFieldName : String; aWidth : Integer);
var
  C : TColumnEh;
  F : TField;
  z : Double;
  i : Integer;
begin
  if (not Assigned(aDataSetPanel)) then exit;
  C := Nil;
  for i:=0 to aDataSetPanel.Grid.Columns.Count-1 do
    if (aDataSetPanel.Grid.Columns[i].Field.FieldName = aFieldName) then begin
      C := aDataSetPanel.Grid.Columns[i];
      break;
    end;
    
  if (not Assigned(C)) then begin
    if (not Assigned(aDataSetPanel.DataSource)) then exit;
    if (not Assigned(aDataSetPanel.DataSource.DataSet)) then exit;
    F := aDataSetPanel.DataSource.DataSet.FindField(aFieldName);
    if (Assigned(F)) then
      F.DisplayWidth := aWidth;
    exit;
  end;

  if (not Assigned(C.Field)) then exit;
  if (C.Field.DisplayWidth > 0) then begin
    z := 1.0 * C.Width / C.Field.DisplayWidth;
    C.Field.DisplayWidth := aWidth;
    C.Width := trunc(z*aWidth);
  end;
end;

{----------------------------------------------------------------------------}
{ Регистрация комонент                                                       }
{----------------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents('KVComponents', [TDataSetPanel, TFieldsDefStorage]);
end;

{$REGION 'TFieldsDefStorage'}
{----------------------------------------------------------------------------}
{ TFieldsDefStorage                                                          }
{----------------------------------------------------------------------------}
const
  StdStorageIniFile = 'flddef.ini';

constructor TFieldsDefStorage.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FStorageName  := StdStorageIniFile;
  FStorageTopic := '';
  bLoadFieldsIndex := True;
end;

procedure TFieldsDefStorage.LoadFieldDef (Field : TField; var FldIndex : Integer);
  // Загрузка описаний полей из ini
  procedure LoadFromIniFile;
  var
    F : TIniFile;
    sSectName : String;
  begin
    if (FStorageName = '') then FStorageName := StdStorageIniFile;
    sSectName := FStorageTopic + '_' + Field.FieldName;
    F := TIniFile.Create(FStorageName);
    Field.DisplayLabel := F.ReadString (sSectName, 'DisplayLabel', Field.DisplayLabel);
    if (Assigned(DataSetPanel)) then
      SetFieldWidth(TDataSetPanel(DataSetPanel), Field.FieldName,
        F.ReadInteger(sSectName, 'DisplayWidth', Field.DisplayWidth))
    else
      Field.DisplayWidth := F.ReadInteger(sSectName, 'DisplayWidth', Field.DisplayWidth);

    SetFieldDisplayFormat(Field,
      F.ReadString (sSectName, 'EditMask', GetFieldDisplayFormat(Field)));

    if (bLoadFieldsIndex) then begin
      FldIndex := F.ReadInteger(sSectName, 'Index', Field.Index);
      Field.Index := FldIndex;
    end;
    Field.Visible      := F.ReadBool   (sSectName, 'Visible',      Field.Visible);
    F.Free;
  end;

begin
  FldIndex := 0;
  LoadFromIniFile;
end;

procedure TFieldsDefStorage.SaveFieldDef (Field : TField);
  // Сохранеие описаний полей
  procedure SaveToIniFile;
  var
    F : TIniFile;
    sSectName : String;
  begin
    if (FStorageName = '') then FStorageName := StdStorageIniFile;
    sSectName := FStorageTopic+'_'+Field.FieldName;
    F := TIniFile.Create(FStorageName);
    F.WriteString (sSectName, 'DisplayLabel', Field.DisplayLabel);
    F.WriteInteger(sSectName, 'DisplayWidth', Field.DisplayWidth);
    F.WriteString (sSectName, 'EditMask',     GetFieldDisplayFormat(Field));
    F.WriteInteger(sSectName, 'Index',        Field.Index);
    F.WriteBool   (sSectName, 'Visible',      Field.Visible);
    F.Free;
  end;

begin
  SaveToIniFile;
end;

{$ENDREGION}

{----------------------------------------------------------------------------}
{ TDataSetPanel                                                              }
{----------------------------------------------------------------------------}
constructor TDataSetPanel.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  Parent := TWinControl(aOwner);

  RegisterClasses ([TToolButton]);

  ControlStyle := ControlStyle - [csSetCaption];

  Width  := 300;
  Height := 200;
  BevelOuter := bvNone;
  AlignWithMargins := True;

  bActivate := True;

  FTitle        := TLabel.Create(Self);
  FTitle.Name   := 'GridTitle';
  FTitle.Align  := alTop;
  FTitle.Font.Size  := 11;
  FTitle.Font.Style := [fsBold];
  FTitle.Font.Color := clHighlight;
  FTitle.Alignment  := taCenter;
  FTitle.Caption    := 'Header';
  FTitle.Parent     := Self;

  FGrid         := TDBGridEh.Create(Self);
  FStorage      := TFieldsDefStorage.Create(Self);

  FGrid.Parent  := Self;
  FGrid.Name    := 'Grid';
  FGrid.Align   := alClient;

  FGrid.Options := FGrid.Options - [dgEditing];

  FGrid.SortLocal := True;
  FGrid.OptionsEh := FGrid.OptionsEh + [dghAutoSortMarking, dghIncSearch, dghPreferIncSearch];
  FGrid.ColumnDefValues.EndEllipsis := True;
  FGrid.ColumnDefValues.Title.Alignment   := taCenter;
  FGrid.ColumnDefValues.Title.EndEllipsis := True;
  FGrid.ColumnDefValues.Title.TitleButton := True;
  FGrid.ColumnDefValues.Title.ToolTips    := True;
  FGrid.ColumnDefValues.ToolTips          := True;

end;

destructor TDataSetPanel.Destroy;
begin
  FGrid.Free;      FGrid    := Nil;
  FStorage.Free;   FStorage := Nil;

  inherited Destroy;
end;

procedure TDataSetPanel.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

procedure TDataSetPanel.CMActivate(var Message: TMessage);
begin
  inherited;
end;

procedure TDataSetPanel.WMCommand(var Message: TWMCommand);
begin
  inherited;
end;

procedure TDataSetPanel.WMSize(var Message: TWMSize);
begin
  inherited;
end;

procedure TDataSetPanel.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if (Assigned(Parent) and (Parent is TForm)) then
    (Parent as TForm).ActiveControl := Grid;
  inherited;
end;

function ComponentToString(Component: TComponent): string;
var
  ms: TMemoryStream;
  ss: TStringStream;
begin
  ss := TStringStream.Create(' ');
  ms := TMemoryStream.Create;
  try
    ms.WriteComponent(Component);
    ms.position := 0;
    ObjectBinaryToText(ms, ss);
    ss.position := 0;
    Result := ss.DataString;
  finally
    ms.Free;
    ss.free;
  end;
end;

procedure StringToComponent(Component: TComponent; Value: string);
var
  StrStream:TStringStream;
  ms: TMemoryStream;
begin
  StrStream := TStringStream.Create(Value);
  try
    ms := TMemoryStream.Create;
    try
      ObjectTextToBinary(StrStream, ms);
      ms.position := 0;
      ms.ReadComponent(Component);
    finally
      ms.Free;
    end;
  finally
    StrStream.Free;
  end;
end;

procedure TDataSetPanel.CreatePopupMenus;
var
  I, J: Integer;
  ePopupMenu: TSpTBXPopupMenu;

  function NewSeparator(ASourceItem: TTBCustomItem = nil; AName: string = ''): TSpTBXSeparatorItem;
  begin
    Result      := TSpTBXSeparatorItem.Create(Owner);
    if (AName = '') and (ASourceItem <> nil) then
      Result.Name := ASourceItem.Name + 'Pm';
  end;

  function NewSubMenuItem(ASourceItem: TTBCustomItem): TSpTBXSubmenuItem;
  begin
    Result := TSpTBXSubmenuItem.Create(Owner);
    //StringToComponent( Result, ComponentToString(ASourceItem as TSpTBXSubmenuItem) );
    Result.Name       := ASourceItem.Name + 'Pm';
    Result.Caption    := ASourceItem.Caption;
    Result.Images     := nil;
    Result.ImageIndex := ASourceItem.ImageIndex;
    Result.Enabled    := ASourceItem.Enabled;
    Result.OnClick    := ASourceItem.OnClick;
  end;

  function NewMenuItem(ASourceItem: TTBCustomItem): TSpTBXItem;
  begin
    Result := TSpTBXItem.Create(Owner);
    //StringToComponent( Result, ComponentToString(ASourceItem as TSpTBXItem) );
    Result.Name       := ASourceItem.Name + 'Pm';
    Result.Caption    := ASourceItem.Caption;
    Result.Images     := nil;
    Result.ImageIndex := ASourceItem.ImageIndex;
    Result.Enabled    := ASourceItem.Enabled;
    Result.OnClick    := ASourceItem.OnClick;
  end;

  function NewItem(const ACaption: string; AShortCut: TShortCut;
    AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: THelpContext;
    const AName: string): TSpTBXItem;
  begin
    Result := TSpTBXItem.Create(nil);
    with Result do
    begin
      Caption     := ACaption;
      ShortCut    := AShortCut;
      OnClick     := AOnClick;
      HelpContext := hCtx;
      Checked     := AChecked;
      Enabled     := AEnabled;
      Name        := AName;
    end;
  end;

  function SelfNewItem(const aCaption, aShortCut: String; aOnClick: TNotifyEvent; aTag : Integer; aName: string = ''): TSpTBXItem;
  begin
    Result     := NewItem(aCaption, TextToShortCut(aShortCut), False, True, aOnClick, 0, aName);
    Result.Tag := aTag;
  end;

begin
  if (csDesigning in ComponentState) then Exit;

  if (not Assigned(FToolbar)) then Exit;

  if (not Assigned(PopupMenu)) then begin
    ePopupMenu := TSpTBXPopupMenu.Create(Self);
    ePopupMenu.Name   := 'GridPopupMenu';
    ePopupMenu.Images := FToolbar.Images;
  end;

  for I := 0 to FToolbar.Items.Count - 1 do
  begin
    if (FToolbar.Items[ I ] is TSpTBXSeparatorItem) then
    begin
      ePopupMenu.Items.Add(NewSeparator(FToolbar.Items[ I ]));
    end
    else if (FToolbar.Items[ I ] is TSpTBXSubmenuItem) then
    begin
      ePopupMenu.Items.Add(NewSubMenuItem(FToolbar.Items[ I ]));
      for J := 0 to FToolbar.Items[ I ].Count - 1 do
      begin
        ePopupMenu.Items.Add(NewMenuItem(FToolbar.Items[ I ].Items[ J ]));
      end;
    end
    else if (FToolbar.Items[ I ] is TSpTBXItem) then
    begin
      ePopupMenu.Items.Add(NewMenuItem(FToolbar.Items[ I ]));
    end;
  end;
  ePopupMenu.Items.Add(NewSeparator);
  ePopupMenu.Items.Add(SelfNewItem('Настройка полей', 'F12', OnPopupClick, vpmFieldsSetup, 'tbiSetupFld'));

  PopupMenu := ePopupMenu;
end;

procedure TDataSetPanel.ExecutePopup (aTag : Integer);
begin
//  if (DataSetActive) then
//    DSFilter.DataSet := DataSource.DataSet
//  else
//    DSFilter.DataSet := Nil;

  case aTag of
//    vpmSort : Sort(False);
//    vpmSortDesc : Sort(True);
//    vpmFind : Find;
//
//    vpmQFilterTrue   : SetQuickFilter(True);
//    vpmQFilterFalse  : SetQuickFilter(False);
//    vpmQFilterRoll   : RollQuickFilter;
//    vpmQFilterDrop   : DropQuickFilter;
//    vpmFilterCond    : ShowQuickFilter;
//    vpmComplexFilter : ComplexFilter;
//    vpmSetCondFilter : SetCondFilter(False);
//    vpmDropAndSetCondFilter : SetCondFilter(True);

//    vpmFixFields     : Fix;
//    vpmDropFixFields : DropFix;
//    vpmHideFields    : HideFields;
//    vpmShowAllFields : ShowAllFields;
    vpmFieldsSetup   : FieldsSetup;
//    vpmPrint         : Print;
//    vpmExcelExport   : ExcelExport;
//    vpmFieldSum      : ReduceSum;
//    vpmSelectAll     : RunSelectAll;
//
//    epmNewRecord     : EditRecord(erm_NewRecord);
//    epmEditRecord    : EditRecord(erm_EditRecord);
//    epmDupRecord     : EditRecord(erm_DupRecord);
//    epmDeleteRecord  : DeleteRecord;
  end;

//  case aTag of
//    0,
//    vpmQFilterTrue,
//    vpmQFilterFalse,
//    vpmQFilterRoll,
//    vpmQFilterDrop,
//    vpmComplexFilter,
//    vpmSetCondFilter,
//    vpmDropAndSetCondFilter:
//      if (DataSource.DataSet is TOraDataSet) then
//        LoadFieldsDef();
//  end;
//
//  case aTag of
//    0,
//    vpmQFilterTrue,
//    vpmQFilterFalse,
//    vpmQFilterRoll,
//    vpmQFilterDrop,
//    vpmComplexFilter,
//    vpmSetCondFilter,
//    epmNewRecord,
//    epmEditRecord,
//    epmDeleteRecord :
//      ReduceGroupValues;
//  end;

end;

procedure TDataSetPanel.OnPopupClick (Sender: TObject);
begin
  ExecutePopup(TMenuItem(Sender).Tag);
end;

{----------------------------------------------------------------------------}
{ Свойства Grid                                                              }
{----------------------------------------------------------------------------}
{ OnGridCellClick }
function TDataSetPanel.GetGridCellClick : TDBGridEhClickEvent;
begin
  Result := FGrid.OnCellClick;
end;

procedure TDataSetPanel.SetGridCellClick (Value : TDBGridEhClickEvent);
begin
  FGrid.OnCellClick := Value;
end;

{ OnGridColEnter }
function TDataSetPanel.GetGridColEnter : TNotifyEvent;
begin
  Result := FGrid.OnColEnter;
end;

procedure TDataSetPanel.SetGridColEnter (Value : TNotifyEvent);
begin
  FGrid.OnColEnter := Value;
end;

{ OnGridColColExit }
function TDataSetPanel.GetGridColExit : TNotifyEvent;
begin
  Result := FGrid.OnColExit;
end;

procedure TDataSetPanel.SetGridColExit (Value : TNotifyEvent);
begin
  FGrid.OnColExit := Value;
end;

{ OnGridDblClick }
function  TDataSetPanel.GetGridDblClick : TNotifyEvent;
begin
  Result := FGrid.OnDblClick;
end;

procedure TDataSetPanel.SetGridDblClick (Value : TNotifyEvent);
begin
  FGrid.OnDblClick := Value;
end;

{ OnGridDrawColumnCell }
function TDataSetPanel.GetGridDrawColumnCell : TDrawColumnEhCellEvent;
begin
  Result := FGrid.OnDrawColumnCell;
end;

procedure TDataSetPanel.SetGridDrawColumnCell (Value : TDrawColumnEhCellEvent);
begin
  FGrid.OnDrawColumnCell := Value;
end;

{ OnGridGetCellParams }
function TDataSetPanel.GetGridGetCellParams : TGetCellEhParamsEvent;
begin
  Result := FGrid.OnGetCellParams;
end;

procedure TDataSetPanel.SetGridGetCellParams (Value : TGetCellEhParamsEvent);
begin
  FGrid.OnGetCellParams := Value;
end;

{ OnGridKeyDown }
function  TDataSetPanel.GetGridKeyDown : TKeyEvent;
begin
  Result := FGrid.OnKeyDown;
end;

procedure TDataSetPanel.SetGridKeyDown (Value : TKeyEvent);
begin
  FGrid.OnKeyDown := Value;
end;

{ OnGridKeyUp }
function  TDataSetPanel.GetGridKeyUp : TKeyEvent;
begin
  Result := FGrid.OnKeyUp;
end;

procedure TDataSetPanel.SetGridKeyUp (Value : TKeyEvent);
begin
  FGrid.OnKeyUp := Value;
end;

{ OnGridKeyPress }
function  TDataSetPanel.GetGridKeyPress : TKeyPressEvent;
begin
  Result := FGrid.OnKeyPress;
end;

procedure TDataSetPanel.SetGridKeyPress (Value : TKeyPressEvent);
begin
  FGrid.OnKeyPress := Value;
end;

{ OnGridTitleClick }
function TDataSetPanel.GetGridTitleClick : TDBGridEhClickEvent;
begin
  Result := FGrid.OnTitleClick;
end;

function TDataSetPanel.GetTitle: string;
begin
  if Assigned(FTitle) then
    Result := FTitle.Caption;
end;

procedure TDataSetPanel.SetGridTitleClick (Value : TDBGridEhClickEvent);
begin
  FGrid.OnTitleClick := Value;
end;

procedure TDataSetPanel.SetTitle(const Value: string);
begin
  if Assigned(FTitle) then
    FTitle.Caption := Value;
end;

procedure TDataSetPanel.SetToolbar(Value: TSpTBXToolbar);
begin
  FToolbar := Value;
  CreatePopupMenus;
end;

{----------------------------------------------------------------------------}
{ Внутренние компоненты                                                      }
{----------------------------------------------------------------------------}
procedure TDataSetPanel.InnerSetup;
begin
  CreatePopupMenus;
end;

procedure TDataSetPanel.ReadGrid(Stream: TStream);
begin
  Stream.ReadComponent(FGrid);
  FGrid.DataSource := Self.DataSource;
end;

procedure TDataSetPanel.WriteGrid(Stream: TStream);
begin
  FGrid.DataSource := Self.DataSource;
  Stream.WriteComponent(FGrid);
end;

procedure TDataSetPanel.ReadStorage(Stream: TStream);
begin
  Stream.ReadComponent(FStorage);
end;

procedure TDataSetPanel.WriteStorage(Stream: TStream);
begin
  Stream.WriteComponent(FStorage);
end;

procedure TDataSetPanel.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('FGrid',     ReadGrid,     WriteGrid,     FGrid <> Nil);
  Filer.DefineBinaryProperty('FStorage',  ReadStorage,  WriteStorage,  FStorage <> Nil);
end;

procedure TDataSetPanel.SetDataSource (aValue : TDataSource);
begin
//  FOldBeforeDelete := nil;
  FDataSource := aValue;
  Grid.DataSource := FDataSource;
  if (not bActivate) then exit;
  bActivate := False;
  InnerSetup;
end;

{ Проверка активности DataSet }
function TDataSetPanel.DataSetActive : Boolean;
begin
  Result := False;
  if (not Assigned(DataSource)) then exit;
  if (not Assigned(DataSource.DataSet)) then exit;
  if (not DataSource.DataSet.Active) then exit;
  Result := True;
end;

{----------------------------------------------------------------------------}
{ Поля                                                                       }
{----------------------------------------------------------------------------}
{ Настройка полей }
procedure TDataSetPanel.FieldsSetup;
var
  dlgFieldView : TFieldViewDialog;
begin
  if (not DataSetActive) then exit;
  dlgFieldView := TFieldViewDialog.Create(Nil);
  dlgFieldView.Execute(Self, DataSource.DataSet);
  dlgFieldView.Free;
end;


procedure TDataSetPanel.LoadFieldsDef;
var
  L : KVComp_UDSPFields.TFieldDefList;
begin
  if (not DataSetActive) then exit;
  if (not Assigned(FStorage)) then exit;

  L := KVComp_UDSPFields.TFieldDefList.Create(Grid);
  try
    L.GetStorageFieldsDef (FStorage.StorageName, FStorage.StorageTopic);
    Grid.DataLink.BufferCount := Grid.DataLink.BufferCount + 1;
    Grid.DataLink.BufferCount := Grid.DataLink.BufferCount - 1;
    L.SetGridColumns;
  finally
    L.Free;
  end;
end;

procedure TDataSetPanel.SaveFieldsDef(aCommonSetup : Boolean = False);
var
  L : KVComp_UDSPFields.TFieldDefList;
begin
  if (not DataSetActive) then exit;
  if (not Assigned(FStorage)) then exit;

  L := KVComp_UDSPFields.TFieldDefList.Create(Grid);
  try
    L.SetStorageFieldsDef (FStorage.StorageName, FStorage.StorageTopic);
  finally
    L.Free;
  end;
end;


{ OnGridDragDrop }
function TDataSetPanel.GetGridDragDrop: TDragDropEvent;
begin
  Result := FGrid.OnDragDrop;
end;

procedure TDataSetPanel.SetGridDragDrop(Value: TDragDropEvent);
begin
  FGrid.OnDragDrop := Value;
end;

{ OnGridDragOver }

function TDataSetPanel.GetGridDragOver: TDragOverEvent;
begin
  Result := FGrid.OnDragOver;
end;

procedure TDataSetPanel.SetGridDragOver(Value: TDragOverEvent);
begin
  FGrid.OnDragOver := Value;
end;

{ OnGridEndDock }

function TDataSetPanel.GetGridEndDock: TEndDragEvent;
begin
  Result := FGrid.OnEndDock;
end;

procedure TDataSetPanel.SetGridEndDock(const Value: TEndDragEvent);
begin
  FGrid.OnEndDock := Value;
end;

{ OnGridEndDrag }

function TDataSetPanel.GetGridEndDrag: TEndDragEvent;
begin
  Result := FGrid.OnEndDrag;
end;

procedure TDataSetPanel.SetGridEndDrag(const Value: TEndDragEvent);
begin
  FGrid.OnEndDrag := Value;
end;

{ OnGridMouseDown }

function TDataSetPanel.GetGridMouseDown: TMouseEvent;
begin
  Result := FGrid.OnMouseDown;
end;

procedure TDataSetPanel.SetGridMouseDown(const Value: TMouseEvent);
begin
  FGrid.OnMouseDown := Value;
end;

{ OnGridMouseMove }

function TDataSetPanel.GetGridMouseMove: TMouseMoveEvent;
begin
  Result := OnMouseMove;
end;

procedure TDataSetPanel.SetGridMouseMove(const Value: TMouseMoveEvent);
begin
  OnMouseMove := Value;
end;

{ OnGridMouseUp }

function TDataSetPanel.GetGridMouseUp: TMouseEvent;
begin
  Result := FGrid.OnMouseUp;
end;

procedure TDataSetPanel.SetGridMouseUp(const Value: TMouseEvent);
begin
  FGrid.OnMouseUp := Value;
end;

end.
