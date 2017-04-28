unit Common.Config;

interface

uses
  LoggerPro, System.IniFiles, System.SysUtils, System.Classes,
  Common.Consts, Common.StrFuncs;

//type
//  TConfig = packed record
//    DBServer: string;
//    DBUsersList: string;
//    WorkingDate: TDate;
//  end;

// возвращает объект журналирования
function Log: ILogWriter;
function Config: TStringList;

// чтение настроек
function GetConfigOption: TStringList;
// запись настроек
procedure SetConfigOption(aConfig: TStringList);


implementation

uses
  LoggerPro.FileAppender, System.DateUtils;

var
  _Log: ILogWriter;
  _Config : TStringList;

function Log: ILogWriter;
begin
  Result := _Log;
end;

function Config: TStringList;
begin
  Result := _Config;
end;

//------------------------------------------------------------------------------
function GetConfigOption: TStringList;
var
  _ini: TIniFile;
begin
  Result := TStringList.Create;
  _ini := TIniFile.Create( ExtractFilePath( ParamStr( 0 ) ) + cConfigFile );
  with _ini, Result do
  try
    AddPair('DBServer',    ReadString( 'DATABASE', 'SERVERNAME', '' ) );
    AddPair('DBUsersList', DecodeBase64( ReadString( 'DATABASE', 'USERS', '' ) ) );
    AddPair('WorkingDate', ReadString( 'CONFIG', 'WORKDATE', DateToStr( StartOfTheMonth( Now ) ) ) );
    AddPair('DesignMode',  ReadString( 'CONFIG', 'DESIGNMODE', '0' ) );
  finally
    _ini.Free;
  end;
end;

//------------------------------------------------------------------------------
procedure SetConfigOption(aConfig: TStringList);
var
  _ini: TIniFile;
begin
  _Config := aConfig;
  _ini := TIniFile.Create( ExtractFilePath( ParamStr( 0 ) ) + cConfigFile );
  with _ini, _Config do
  begin
    WriteString( 'DATABASE', 'SERVERNAME', Values['DBServer'] );
    WriteString( 'DATABASE', 'USERS',      EncodeBase64( Values['DBUsersList'] ) );
    WriteString( 'CONFIG',   'WORKDATE',   Values['WorkingDate'] );
    WriteString( 'CONFIG',   'DESIGNMODE', Values['DesignMode'] );

    _ini.Free;
    _Config.Free;
  end;
end;

initialization

{ The TLoggerProFileAppender has its defaults defined as follows:
  DEFAULT_LOG_FORMAT = '%0:s [TID %1:-8d][%2:-10s] %3:s [%4:s]';
  DEFAULT_MAX_BACKUP_FILE_COUNT = 5;
  DEFAULT_MAX_FILE_SIZE_KB = 1000;

  You can override these dafaults passing parameters to the constructor.
  Here's some configuration examples:
  @longcode(#
  // Creates log in the same exe folder without PID in the filename
  _Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 5,
  [TFileAppenderOption.LogsInTheSameFolder])]);

  // Creates log in the AppData/Roaming with PID in the filename
  _Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 5,
  [TFileAppenderOption.IncludePID])]);

  // Creates log in the same folder with PID in the filename
  _Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 5,
  [TFileAppenderOption.IncludePID])]);
  #)
}

// Creates log in the ..\..\ folder without PID in the filename
_Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 500, 'Log', [])]);
// Create logs in the exe' same folder
// _Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 5)]);

// Creates log in the AppData/Roaming with PID in the filename
// _Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 5,
// [TFileAppenderOption.IncludePID])]);

// Creates log in the same folder with PID in the filename
// _Log := BuildLogWriter([TLoggerProFileAppender.Create(10, 5,
// [TFileAppenderOption.IncludePID])]);

_Config := TStringList.Create;
_Config := GetConfigOption;

FormatSettings.DateSeparator := '.';

finalization
  SetConfigOption(Config);
end.
