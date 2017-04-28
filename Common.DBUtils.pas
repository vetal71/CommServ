unit Common.DBUtils;

interface

uses
  System.Variants, System.SysUtils, Data.DB,
  DataModule, Uni, Common.Config, System.Classes;

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

// выпонить инструкцию
procedure RunExecSQL (const aSQL : String);

implementation

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
        Log.Error(Format('Ќе удалось прочитать атрибуты организации из базы данных.'#13'%s', [E.Message]), 'DATABASE');
        raise Exception.CreateFmt('Ќе удалось прочитать атрибуты организации из базы данных.'#13'%s', [E.Message]);
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

{ ќпределение числа записей в DataSet }
function GetRecordCount(DataSet : TDataSet) : Integer;
begin
  Result := 0;
  try
    DataSet.First;
    Result := DataSet.RecordCount;
  except
  end;
end;

function GetFieldValueEx(const aFieldName,aFromStr,aWhereStr,aOrderStr : String;
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
        Log.Error(Format('Ќе удалось получить значение пол€ %s из %s'#13'%s', [aFieldName, aFromStr, E.Message]), 'DATABASE');
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
        Log.Error(Format('Ќе удалось выполнить SQL запрос.'#13'(%s)'#13'%s', [aSQL, E.Message]), 'DATABASE');
        raise Exception.CreateFmt('Ќе удалось выполнить SQL запрос.'#13'(%s)'#13'%s', [aSQL, E.Message]);
      end;
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
