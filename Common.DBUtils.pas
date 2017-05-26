unit Common.DBUtils;

interface

uses
  System.Variants, System.SysUtils, Data.DB,
  DataModule, Uni, Common.Config, System.Classes;

type
  TEditMode = (emAppend, emEdit);

type
  TOrgParams = record
    OrgName, OrgAddress, OrgUnn : string;
    OrgMFO: Integer;
    OrgAccount: string;
    OrgBoss, OrgBuh: string;
    CalcPeriodIndex: Integer;
    CalcPeriod: string;
    CalcStartDate, CalcFinishDate: TDate;
  end;

type
  TMyQuery = class(TUniQuery)
  public
    constructor Create(AOwner: TComponent); override;
  end;

function GetFieldValue(const aFieldName,aFromStr,aWhereStr : String;
  aDefaultValue : Variant): Variant;

function OrgParams: TOrgParams;

function GetOrgParams: TOrgParams;

function GenerateKeyValue(const AKey, ATable: string; AWhere: string = ''): Variant;

// выпонить инструкцию
procedure RunExecSQL (const aSQL : String);

function GetItemsByQuery(AKeyField, ANameField, ATableName: string; IsAddAll: Boolean = False): TStringList;
function GetItemsBySQL(ASQL: string): TStringList;

function GetFieldValueEx(const aFieldName,aFromStr,aWhereStr,aOrderStr : String;
  aDefaultValue : Variant) : Variant;

function GetFieldValueBySQL(const aSQL, aFieldName : String; aDefaultValue : Variant) : Variant;

function GetKeyFields(const ATableName: string): string;

implementation

function GetKeyFields(const ATableName: string): string;
const
  cSQL =
    'SELECT column_name FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ' + #13 +
    ' where Constraint_Name in ' + #13 +
    '(select Constraint_name from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where ' + #13 +
    ' CONSTRAINT_TYPE = ''PRIMARY KEY'' and TABLE_NAME = N''%s'')';
var
  Q: TUniQuery;
  SL: TStringList;
begin
  Result := '';
  Q  := TMyQuery.Create(nil);
  SL := TStringList.Create;
  with Q do
  try
    SQL.Text := Format(cSQL, [ATableName]);
    try
      Open;
      while (not Q.Eof) do
      begin
        SL.Add(Q.Fields[0].Value);
        Next;
      end;
      Result := StringReplace( SL.Text, ''#$D#$A'', '', [rfReplaceAll]);
    except
      raise EAbort.Create('');
    end;
  finally
    Q.Free;
    SL.Free;
  end;
end;

function GenerateKeyValue(const AKey, ATable: string; AWhere: string = ''): Variant;
const
  cSQL = 'select MAX(%s) + 1 As Code from %s where %s';
begin
  if AWhere = '' then AWhere := '1=1';
  Result := GetFieldValueBySQL(Format(cSQL, [ AKey, ATable, AWhere]), 'Code', 0);
end;

function GetOrgParams: TOrgParams;
const
  cSQLText = 'select * from ParamOrg';
var
  Query : TMyQuery;
begin
  Query := TMyQuery.Create(nil);
  Query.Connection := dm.dbConn;
  with Query do
  try
    SQL.Text := cSQLText;
    try
      Open;
      with Result do
      begin
        OrgName         := FieldValues['NazvOrg'];
        OrgAddress      := FieldValues['AdresOrg'];
        OrgUnn          := FieldValues['UnnOrg'];
        OrgMFO          := FieldValues['KodBank'];
        OrgAccount      := FieldValues['RShetOrg'];
        CalcPeriodIndex := FieldValues['Rasch_Period'];
        OrgBoss         := FieldValues['Fio_Chif'];
        OrgBuh          := FieldValues['Fio_Bux'];
        CalcPeriod      := FieldValues['Period_Name'];
        CalcStartDate   := FieldValues['Start_Period'];
        CalcFinishDate  := FieldValues['End_Period'];
      end;
      Close;

    except
      on E: Exception do
      begin
        Log.Error(Format('Не удалось прочитать атрибуты организации из базы данных.'#13'%s', [E.Message]), 'DATABASE');
        raise Exception.CreateFmt('Не удалось прочитать атрибуты организации из базы данных.'#13'%s', [E.Message]);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function OrgParams: TOrgParams;
begin
  Result := GetOrgParams;
end;

{ Определение числа записей в DataSet }
function GetRecordCount(DataSet : TDataSet) : Integer;
begin
  Result := 0;
  try
    DataSet.First;
    Result := DataSet.RecordCount;
  except
  end;
end;

function GetFieldValueBySQL(const aSQL, aFieldName : String; aDefaultValue : Variant) : Variant;
var
  Query : TMyQuery;
begin
  Query := TMyQuery.Create(nil);
  with Query do
  try
    SQL.Text := aSQL;
    try
      Open;
      if (Common.DBUtils.GetRecordCount(Query) > 0) then
        Result := Query[aFieldName]
      else
        Result := aDefaultValue;
    except
      on E: Exception do
      begin
        Log.Error(Format('Не удалось получить значение поля %s '#13'%s', [aFieldName, E.Message]), 'DATABASE');
        Result := aDefaultValue;
      end;
    end;
  finally
    Query.Free;
  end;
  if (VarIsNull(Result)) then
    Result := aDefaultValue;
end;

function GetFieldValueEx(const aFieldName, aFromStr, aWhereStr, aOrderStr : String;
  aDefaultValue : Variant) : Variant;
const
  sSQL = 'select %s from %s where (%s) %s';
var
  Query : TMyQuery;
begin
  Query := TMyQuery.Create(nil);
  with Query do
  try
    SQL.Text := Format(sSQL, [aFieldName, aFromStr, aWhereStr, aOrderStr]);

    try
      Open;
      if (Common.DBUtils.GetRecordCount(Query) > 0) then
        Result := Query[aFieldName]
      else
        Result := aDefaultValue;
    except
      on E: Exception do
      begin
        Log.Error(Format('Не удалось получить значение поля %s из %s'#13'%s', [aFieldName, aFromStr, E.Message]), 'DATABASE');
        Result := aDefaultValue;
      end;
    end;
  finally
    Query.Free;
  end;
  if (VarIsNull(Result)) then
    Result := aDefaultValue;
end;

function GetFieldValue (const aFieldName,aFromStr,aWhereStr : String;
  aDefaultValue : Variant) : Variant;
begin
  Result := GetFieldValueEx (aFieldName, aFromStr, aWhereStr, '', aDefaultValue);
end;

procedure RunExecSQL (const aSQL : String);
var
  Query : TMyQuery;
begin
  Query := TMyQuery.Create(nil);
  try
    Query.SQL.Text := aSQL;
    try
      Query.ExecSQL;
    except
      on E: Exception do
      begin
        Log.Error(Format('Не удалось выполнить SQL запрос.'#13'(%s)'#13'%s', [aSQL, E.Message]), 'DATABASE');
        raise Exception.CreateFmt('Не удалось выполнить SQL запрос.'#13'(%s)'#13'%s', [aSQL, E.Message]);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function GetItemsByQuery(AKeyField, ANameField, ATableName: string; IsAddAll: Boolean = False): TStringList;
const
  cSQL = 'select %0:s, %1:s from %2:s order by %0:s';
var
  Query : TMyQuery;
  eKey: TObject;
  eName : string;
begin
  Query := TMyQuery.Create(nil);
  Result := TStringList.Create;
  with Query do
  try
    SQL.Text := Format(cSQL, [AKeyField, ANameField, ATableName]);
    try
      Open;
      if IsAddAll then
        Result.Add('(Все)');
      while (not Query.Eof) do
      begin
        eKey  := Pointer(Query.FieldByName(AKeyField).AsInteger);
        eName := Query.FieldByName(ANameField).AsString;
        Result.AddObject(eName, eKey);
        Next;
      end;
    except
      Result := nil;
    end;
  finally
    Query.Free;
  end;
end;

function GetItemsBySQL(ASQL: string): TStringList;
var
  Query : TMyQuery;
  eKey: TObject;
  eName : string;
begin
  Query := TMyQuery.Create(nil);
  Result := TStringList.Create;
  with Query do
  try
    SQL.Text := ASQL;
    try
      Open;
      while (not Query.Eof) do
      begin
        eName := Query.Fields[ 0 ].AsString;
        Result.Add(eName);
        Next;
      end;
    except
      Result.Free;
      Result := nil;
    end;
  finally
    Query.Free;
  end;
end;

{ TMyQuery }

constructor TMyQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.Connection := dm.dbConn;
end;

end.
