program CommServ;

uses
  Vcl.Forms,
  Vcl.Controls,
  System.SysUtils,
  BaseFormTemplate in 'BaseFormTemplate.pas' {BaseForm},
  MainForm in 'MainForm.pas' {fMain},
  Common.Consts in 'Common.Consts.pas',
  DataModule in 'DataModule.pas' {dm: TDataModule},
  DlgBaseTemplate in 'DlgBaseTemplate.pas' {DlgBase},
  DlgConnection in 'DlgConnection.pas' {dlgConn},
  Common.Config in 'Common.Config.pas',
  Common.StrFuncs in 'Common.StrFuncs.pas',
  Common.DBUtils in 'Common.DBUtils.pas',
  ConsumersForm in 'ConsumersForm.pas' {fConsumers},
  DlgConsumerEditor in 'DlgConsumerEditor.pas' {fConsumerEditor},
  DlgCommon in 'DlgCommon.pas' {FDlgCommon},
  DlgBaseDBEditor in 'DlgBaseDBEditor.pas' {DlgDBEditor},
  TariffServsForm in 'TariffServsForm.pas' {fTariffServs},
  TestForm in 'TestForm.pas' {fTest},
  DlgServiceEditor in 'DlgServiceEditor.pas' {fServiceEditor};

{$R *.res}

var
  User, Pass: string;
  AllowRun: Boolean;

begin
  try
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(Tdm, dm);
  //  dlgConn := TdlgConn.Create(Application);
  //  try
  //    if dlgConn.ShowModal = mrOK then begin
  //      User := dlgConn.LoginUser;
        User := 'sa';
  //      Pass := dlgConn.LoginPass;
        Pass := 'hHTAUOOp7';
        AllowRun := dm.Authorize( User, Pass );
  //    end;
  //  finally
  //    dlgConn.Free;
  //  end;
    if AllowRun then
    begin
      Application.CreateForm(TfMain, fMain);
      fMain.UserName := User;
      Application.Run;
    end;
  except on E: Exception do
    ShowErrorFmt('При запуске программы возникла непредвиденная ошибка.'#13'%s', [E.Message]);
  end;
end.
