unit DataModule;

interface

uses
  System.SysUtils, System.Classes, Common.Config, DBAccess, Uni,
  DASQLMonitor, UniSQLMonitor, UniProvider, SQLServerUniProvider, Data.DB;

type
  Tdm = class(TDataModule)
    dbConn: TUniConnection;
    MSSQLProvider: TSQLServerUniProvider;
    SQLMonitor: TUniSQLMonitor;
    procedure dbConnAfterDisconnect(Sender: TObject);
  private
    { Private declarations }
  public
    function Authorize(const aUser, aPass: string): Boolean;
  end;

var
  dm: Tdm;

implementation

resourcestring
  rsAuthError   = 'Пользователю %s не удалось установить соединение с БД.'#13'%s';
  rsDB          = 'DATABASE';
  rsSuccessAuth = 'Пользователь %s установил соединение с базой данных';

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm }

function Tdm.Authorize(const aUser, aPass: string): Boolean;
begin
  with dbConn do begin
    Server := Config.Values['DBServer'];
    UserName := aUser;
    Password := aPass;
    try
      Connected := True;
      Result := Connected;
      Log.Info(rsSuccessAuth.Format(rsSuccessAuth, [aUser]), rsDB);
    except
      on E: Exception do begin
        Result := False;
        Log.Error(Format(rsAuthError, [ aUser, E.Message ]), rsDB);
        raise Exception.CreateFmt(rsAuthError, [ aUser, E.Message ]);
      end;
    end;
  end;
end;

procedure Tdm.dbConnAfterDisconnect(Sender: TObject);
begin
  Log.Info('Соединение с базой данных закрыто.', rsDB);
end;

end.
