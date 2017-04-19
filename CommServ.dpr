program CommServ;

uses
  Vcl.Forms,
  BaseFormTemplate in 'BaseFormTemplate.pas' {frmBase};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
