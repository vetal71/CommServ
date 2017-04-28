unit DlgConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseTemplate, Vcl.StdCtrls,
  Vcl.ExtCtrls, Common.Config, dxGDIPlusClasses;

type
  TdlgConn = class(TDlgBase)
    lblUser: TLabel;
    cbUsers: TComboBox;
    lblPassword: TLabel;
    edtPassword: TEdit;
    imgLogin: TImage;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FLoginPass: string;
    function GetLoginUser: string;
    function GetLoginPass: string;
  public
    property LoginUser : string read GetLoginUser;
    property LoginPass : string read GetLoginPass;
  end;

var
  dlgConn : TdlgConn;

implementation

uses System.IniFiles, Common.Consts;

{$R *.dfm}

procedure TdlgConn.btnOKClick(Sender: TObject);
begin
  inherited;
  if (cbUsers.Text = '') then
    cbUsers.SetFocus
  else if (edtPassword.Text = '') then
    edtPassword.SetFocus
  else
    ModalResult := mrOk;
end;

procedure TdlgConn.FormCreate(Sender: TObject);
begin
  inherited;
  cbUsers.Items.Delimiter := ';';
  cbUsers.Items.DelimitedText := Config.Values['DBUsersList'];
end;

procedure TdlgConn.FormDestroy(Sender: TObject);
begin
  inherited;
  // сохранение списка пользователей в ini
  if cbUsers.Items.IndexOf( cbUsers.Text ) < 0 then
    cbUsers.Items.Add( cbUsers.Text );
  Config.Values['DBUsersList'] := cbUsers.Items.DelimitedText;
end;

function TdlgConn.GetLoginPass: string;
begin
  Result := edtPassword.Text;
end;

function TdlgConn.GetLoginUser: string;
begin
  Result := cbUsers.Text;
end;

end.

