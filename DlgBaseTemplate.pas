unit DlgBaseTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TB2Dock, SpTBXItem, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TDlgBase = class(TForm)
    pnlButton: TPanel;
    pnlMain: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
  protected
    function ValidFields: Boolean; virtual;
  public
    { Public declarations }
  end;

var
  DlgBase: TDlgBase;

implementation

{$R *.dfm}

procedure TDlgBase.btnOKClick(Sender: TObject);
begin
  if ValidFields then
  begin
    ModalResult := mrOk;
  end;
end;

function TDlgBase.ValidFields: Boolean;
begin
  Result := True;
end;

end.
