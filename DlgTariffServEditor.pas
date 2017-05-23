unit DlgTariffServEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseDBEditor, Vcl.StdCtrls,
  Vcl.ExtCtrls, KVComp_UComboExt, DataModule;

type
  TfTariffServEditor = class(TDlgDBEditor)
    lblTariffName: TLabel;
    edtTariffName: TEdit;
    edtServiceName: TEdit;
    bvl1: TBevel;
    lblVAT: TLabel;
    cbVAT: TQueryComboBox;
  private
    FParentService: string;
    procedure SetParentService(const Value: string);
  protected
    function ValidFields: Boolean; override;
    procedure AssignFields; override;
    procedure InitFields; override;
  public
    property ParentService : string read FParentService write SetParentService;
  end;

var
  fTariffServEditor: TfTariffServEditor;

implementation

uses
  Common.DBUtils;

{$R *.dfm}

{ TfTariffServEditor }

procedure TfTariffServEditor.AssignFields;
begin
  inherited;
  // çàïîëíÿåì äàííûìè ïîëÿ
  with DataSet do
  begin
    FieldByName('ServTitle').AsString := edtTariffName.Text;
    FieldByName('VatID').AsInteger    := cbVAT.Code;
  end;
end;

procedure TfTariffServEditor.InitFields;
begin
  inherited;
  cbVAT.Load;
  if DataSet = nil then Exit;
  with DataSet do
  begin
    case EditMode of
      emAppend:
        begin
          Self.Caption := 'Íîâûé âèä òàğèôà';
          DataSet.Append;
          cbVAT.Code := 1;
        end;
      emEdit:
        begin
          Self.Caption := Format('Ğåäàêòèğîâàíèå âèäà òàğèôà: %s', [ DataSet.FieldByName('ServTitle').AsString ]);
          DataSet.Edit;
          cbVAT.Code   := DataSet.FieldValues['VatId'];
        end;
    end;
    edtTariffName.Text := FieldByName('ServTitle').AsString;
  end;
end;

procedure TfTariffServEditor.SetParentService(const Value: string);
begin
  FParentService := Value;
  edtServiceName.Text := Value;
end;

function TfTariffServEditor.ValidFields: Boolean;
begin
  Result := (edtTariffName.Text > '') and
            (cbVAT.Code > 0);
end;

end.
