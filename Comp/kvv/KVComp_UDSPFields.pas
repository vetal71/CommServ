unit KVComp_UDSPFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBGridEh, IniFiles, DB;

type
  TFieldDefItem = class
    Name     : String;
    Index    : Integer;
    Caption  : String;
    Width    : Integer;
    EditMask : String;
    Visible  : Boolean;
    procedure GetFieldDef (Field : TField);
    procedure SetFieldDef (Field : TField);
  end;

type
  TFieldDefList = class(TList)
  private
    INI : TIniFile;
    DataSet : TDataSet;
    FileName : String;
    TableName : String;
    function DataSetExists : Boolean;
    procedure SortFieldsDef;
  public
    Grid : TDBGridEh;
    constructor Create(aGrid : TDBGridEh);
    destructor Destroy; override;
    function FindColumn (Field : TField) : TColumnEh;
    procedure GetFieldsDef;
    procedure SetFieldsDef;
    procedure GetFieldsDefFromGrid;
    procedure GetStorageFieldsDef (const aStorageName,aStorageTopic : String);
    procedure SetStorageFieldsDef (const aStorageName,aStorageTopic : String;
      aCommonSetup : Boolean = False);
    procedure SetGridColumns;
  end;

{ Получить/установить ширину поля с учетом свойств Grid }
function GetFieldDisplayWidth(Grid : TDBGridEh; Field : TField) : Integer;
procedure SetFieldDisplayWidth (Grid : TDBGridEh; DataSet : TDataSet; Field : TField; Width : Integer);

{ Получить/установить строку форматирования поля }
const
  FT_NUMERIC_SET = [ftSmallint,ftInteger,ftWord, ftFloat,ftCurrency];
  FT_DATE_SET = [ftDate,ftTime,ftDateTime];

function GetFieldDisplayFormat (F : TField) : String;
procedure SetFieldDisplayFormat (F : TField; const FmtString : String);

implementation

const
  DefaultStorageFileName = 'flddef.ini';
  DefaultStorageTableName = 'FIELDSDESCRIPTIONS';

const
  MAX_FIELD_INDEX = 9999;

procedure ClearList (List : TList);
var
  i : Integer;
begin
  for i:=0 to List.Count-1 do
   TObject(List[i]).Free;
  List.Clear;
end;

{ Получить ширину поля с учетом свойств Grid }
function GetFieldDisplayWidth(Grid : TDBGridEh; Field : TField) : Integer;
var
  C : TColumnEh;
  F : TField;
  TM: TTextMetric;
  i,dw : Integer;
begin
  Result := Field.DisplayWidth;
  if (not Assigned(Grid)) then exit;
  if (not Grid.HandleAllocated) then exit;
  C := Nil;
  GetTextMetrics(Grid.Canvas.Handle, TM);
  dw := Grid.Canvas.TextWidth('0') - TM.tmOverhang;
  with Grid do begin
    for i:=0 to Columns.Count-1 do begin
      F := Columns[i].Field;
      if (not Assigned(F)) then continue;
      if (F.FieldName = Field.FieldName) then begin
        C := Columns[i];
        break;
      end;
    end;
    if (not Assigned(C)) then exit;
    if (dw <> 0) then
      Result := (C.Width - TM.tmOverhang - 4) div dw;
  end;
end;

{ Установить ширину поля с учетом свойств Grid }
procedure SetFieldDisplayWidth (Grid : TDBGridEh; DataSet : TDataSet; Field : TField; Width : Integer);
var
  L : TList;
  C : TColumnEh;
  F : TField;
  z : Double;
  i : Integer;
begin
  if (Width <= 0) then exit;
  if (not Assigned(Grid)) then begin
    Field.DisplayWidth := Width;
    exit;
  end;
  C := Nil;
  for i:=0 to Grid.Columns.Count-1 do begin
    F := Grid.Columns[i].Field;
    if (not Assigned(F)) then continue;
    if (F.FieldName = Field.FieldName) then begin
      C := Grid.Columns[i];
      break;
    end;
  end;
  if (not Assigned(C)) then  begin
    Field.DisplayWidth := Width;
    exit;
  end;
  L := TList.Create;
  try
    z := 1.0 * C.Width / GetFieldDisplayWidth(Grid,Field);
    for i:=0 to DataSet.FieldCount-1 do L.Add(Pointer(DataSet.Fields[i].DisplayWidth));
    C.Width := round(z*Width);
    for i:=0 to DataSet.FieldCount-1 do DataSet.Fields[i].DisplayWidth := Integer(L[i]);
    Field.DisplayWidth := Width;
  finally
    L.Free;
  end;
end;

{ Получить/установить строку форматирования поля }
function GetFieldDisplayFormat (F : TField) : String;
begin
  if (F.DataType in FT_NUMERIC_SET) then
    Result := TNumericField(F).DisplayFormat
  else if (F.DataType in FT_DATE_SET) then
    Result := TDateTimeField(F).DisplayFormat
  else
    Result := F.EditMask;
end;

procedure SetFieldDisplayFormat (F : TField; const FmtString : String);
begin
  if (F.DataType in FT_NUMERIC_SET) then
    TNumericField(F).DisplayFormat := FmtString
  else if (F.DataType in FT_DATE_SET) then
    TDateTimeField(F).DisplayFormat := FmtString
  else
    F.EditMask := FmtString;
end;

{------------------------------------------------------------------------------}
{ TFieldDefItem                                                                }
{------------------------------------------------------------------------------}
procedure TFieldDefItem.GetFieldDef (Field : TField);
begin
  Name     := Field.FieldName;
  Index    := Field.Index;
  Caption  := Field.DisplayLabel;
  Width    := Field.DisplayWidth;
  Visible  := Field.Visible;
  EditMask := GetFieldDisplayFormat(Field);
end;

procedure TFieldDefItem.SetFieldDef (Field : TField);
begin
  Field.Index := Index;
  Field.DisplayLabel := Caption;
  Field.DisplayWidth := Width;
  Field.Visible := Visible;
  SetFieldDisplayFormat(Field,EditMask);
end;

{------------------------------------------------------------------------------}
{ TFieldDefList                                                                }
{------------------------------------------------------------------------------}
constructor TFieldDefList.Create(aGrid : TDBGridEh);
begin
  inherited Create;
  Grid := aGrid;
end;

destructor TFieldDefList.Destroy;
begin
  ClearList(Self);
  inherited Destroy;
end;

function TFieldDefList.DataSetExists : Boolean;
begin
  Result := False;
  if (not Assigned(Grid)) then exit;
  if (not Assigned(Grid.DataSource)) then exit;
  DataSet := Grid.DataSource.DataSet;
  if (not Assigned(DataSet)) then exit;
  Result := True;
end;

function TFieldDefList.FindColumn (Field : TField) : TColumnEh;
var
  i : Integer;
begin
  for i:=0 to Grid.Columns.Count-1 do begin
    Result := Grid.Columns[i];
    if (Result.Field = Field) then exit;
  end;
  Result := Nil;
end;

procedure TFieldDefList.SortFieldsDef;
var
  i,j : Integer;
  A,B : TFieldDefItem;
begin
  for i:=0 to Count-2 do
    for j:=i+1 to Count-1 do begin
      A := Items[i];
      B := Items[j];
      if (A.Index > B.Index) then begin
        Items[i] := B;
        Items[j] := A;
      end;
    end;
  for i:=0 to Count-1 do
    TFieldDefItem(Items[i]).Index := i;
end;

procedure TFieldDefList.GetFieldsDef;
var
  Item : TFieldDefItem;
  i : Integer;
begin
  if (not DataSetExists) then exit;
  ClearList(Self);
  for i:=0 to DataSet.FieldCount-1 do begin
    Item := TFieldDefItem.Create;
    Item.GetFieldDef(DataSet.Fields[i]);
    Add(Item);
  end;
end;

procedure TFieldDefList.SetFieldsDef;
var
  Item : TFieldDefItem;
  F : TField;
  i : Integer;
begin
  SortFieldsDef;
  for i:=0 to Count-1 do begin
    Item := Items[i];
    F := DataSet.FindField(Item.Name);
    if (not Assigned(F)) then continue;
    F.Index := Item.Index;
    F.DisplayLabel := Item.Caption;
    F.DisplayWidth := Item.Width;
    F.Visible := Item.Visible;
    SetFieldDisplayFormat(F,Item.EditMask);
  end;
end;

procedure TFieldDefList.GetFieldsDefFromGrid;
var
  TM: TTextMetric;
  Item : TFieldDefItem;
  C : TColumnEh;
  F : TField;
  i,dw : Integer;
begin
  if (not DataSetExists) then exit;
  GetTextMetrics(Grid.Canvas.Handle, TM);
  dw := Grid.Canvas.TextWidth('0') - TM.tmOverhang;
  ClearList(Self);
  for i:=0 to Grid.Columns.Count-1 do begin
    C := Grid.Columns[i];
    F := C.Field;
    Item := TFieldDefItem.Create;
    Item.GetFieldDef(F);
    Item.Index   := Count;
    Item.Caption := C.Title.Caption;
    if (dw <> 0) then
      Item.Width   := (C.Width-4-TM.tmOverhang) div dw;
    Item.Visible := True;
    Add(Item);
  end;
  for i:=0 to DataSet.FieldCount-1 do begin
    F := DataSet.Fields[i];
    C := FindColumn(F);
    if (Assigned(C))then continue;
    Item := TFieldDefItem.Create;
    Item.GetFieldDef(F);
    Item.Index := Count;
    Item.Visible := False;
    Add(Item);
  end;
end;

procedure TFieldDefList.GetStorageFieldsDef (const aStorageName, aStorageTopic : String);

  procedure GetFromIniFile;
  var
    SectName : String;
    Item : TFieldDefItem;
    F : TField;
    i : Integer;
  begin
    FileName := Trim(aStorageName);
    if (FileName = '') then FileName := DefaultStorageFileName;
    INI := TIniFile.Create(FileName);
    try
      for i:=0 to DataSet.FieldCount-1 do begin
        F := DataSet.Fields[i];
        SectName := AnsiUpperCase(aStorageTopic)+'_'+F.FieldName;
        Item := TFieldDefItem.Create;
        Item.Name     := F.FieldName;
        Item.Index    := INI.ReadInteger(SectName, 'Index', F.Index);
        Item.Caption  := INI.ReadString (SectName, 'DisplayLabel', F.DisplayLabel);
        Item.Width    := INI.ReadInteger(SectName, 'DisplayWidth', F.DisplayWidth);
        Item.Visible  := INI.ReadBool   (SectName, 'Visible',      F.Visible);
        Item.EditMask := INI.ReadString (SectName, 'EditMask',     F.EditMask);
        Add(Item);
      end;
    finally
      INI.Free;
    end;
  end;

begin
  if (not DataSetExists) then exit;
  GetFromIniFile;
end;

procedure TFieldDefList.SetStorageFieldsDef (const aStorageName, aStorageTopic : String;
  aCommonSetup : Boolean = False);

  procedure SetIniFile;
  var
    SectName : String;
    F : TField;
    i : Integer;
  begin
    FileName := Trim(aStorageName);
    if (FileName = '') then FileName := DefaultStorageFileName;
    INI := TIniFile.Create(FileName);
    try
      for i:=0 to DataSet.FieldCount-1 do begin
        F := DataSet.Fields[i];
        SectName := AnsiUpperCase(aStorageTopic)+'_'+F.FieldName;
        INI.WriteInteger(SectName, 'Index', F.Index);
        INI.WriteString (SectName, 'DisplayLabel', F.DisplayLabel);
        INI.WriteInteger(SectName, 'DisplayWidth', F.DisplayWidth);
        INI.WriteBool   (SectName, 'Visible',      F.Visible);
        INI.WriteString (SectName, 'EditMask',     GetFieldDisplayFormat(F));
      end;
    finally
      INI.Free;
    end;
  end;

begin
  if (not DataSetExists) then exit;
  SetIniFile;
end;

procedure TFieldDefList.SetGridColumns;
var
  TM: TTextMetric;

  procedure GetDefaulfFieldsDef;
  var
    F : TField;
    Item : TFieldDefItem;
    i : Integer;
  begin
    for i:=0 to DataSet.FieldCount-1 do begin
      F := DataSet.Fields[i];
      Item := TFieldDefItem.Create;
      try
        Item.Name     := F.FieldName;
        Item.Index    := F.Index;
        Item.Caption  := F.DisplayLabel;
        Item.Width    := F.DisplayWidth;
        Item.Visible  := F.Visible;
        Item.EditMask := F.EditMask;
      finally
        Add(Item);
      end;
    end;
  end;

  procedure SynchronizeDisplayWidth;
  var
    C : TColumnEh;
    F : TField;
    w : Integer;
    i : Integer;
  begin
    for i:=0 to Grid.Columns.Count-1 do begin
      C := Grid.Columns[i];
      F := C.Field;
      w := F.DisplayWidth * (Grid.Canvas.TextWidth('0') - TM.tmOverhang) + TM.tmOverhang + 4;
      if (not F.Visible) then w := 0;
      C.Width := w;
    end;
  end;

var
  Item : TFieldDefItem;
  F : TField;
  i : Integer;
  SelectedFldIndex : Integer;
begin
  if (not DataSetExists) then exit;
  if (Count = 0) then
    GetDefaulfFieldsDef;
  GetTextMetrics(Grid.Canvas.Handle, TM);
  DataSet.DisableControls;
  Grid.Columns.BeginUpdate;
  SelectedFldIndex := Grid.SelectedIndex;             // Сохранение выделенного поля
  try
    SortFieldsDef;
    Grid.Columns.Clear;
    for i:=0 to Count-1 do begin
      Item := Items[i];
      F := DataSet.FindField(Item.Name);
      if (not Assigned(F)) then continue;
      F.Index := Item.Index;
      F.DisplayLabel := Item.Caption;
      F.DisplayWidth := Item.Width;
      F.Visible := Item.Visible;
      SetFieldDisplayFormat(F,Item.EditMask);
      if (Item.Visible) then
        Grid.Columns.Add.FieldName := F.FieldName
    end;
    Grid.SelectedIndex := SelectedFldIndex ;          // Установка на выделеное поле
    SynchronizeDisplayWidth;
  finally
    Grid.Columns.EndUpdate;
    DataSet.EnableControls;
  end;
end;

end.
