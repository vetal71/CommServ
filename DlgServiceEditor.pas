unit DlgServiceEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseDBEditor, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfServiceEditor = class(TDlgDBEditor)
    lblServiceName: TLabel;
    edtServiceName: TEdit;
  protected
    function ValidFields: Boolean; override;
    procedure AssignFields; override;
    procedure InitFields; override;
  end;

var
  fServiceEditor: TfServiceEditor;

implementation

uses
  Common.DBUtils;

{$R *.dfm}

{ TfDlgServiceEditor }

procedure TfServiceEditor.AssignFields;
begin
  inherited;
  // заполняем данными поля
  with DataSet do
  begin
    FieldByName('ServiceKindName').AsString := edtServiceName.Text;
  end;
end;

procedure TfServiceEditor.InitFields;
begin
  if DataSet = nil then Exit;
  with DataSet do
  begin
    case EditMode of
      emAppend:
        begin
          Self.Caption := 'Новый вид услуги';
          DataSet.Append;
        end;
      emEdit:
        begin
          Self.Caption := Format('Редактирование вида услуги: %s', [ DataSet.FieldByName('ServiceKindName').AsString ]);
          DataSet.Edit;
        end;
    end;
    edtServiceName.Text := FieldByName('ServiceKindName').AsString;
  end;
end;

function TfServiceEditor.ValidFields: Boolean;
begin
  Result := edtServiceName.Text > '';
end;

end.
