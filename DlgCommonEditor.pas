unit DlgCommonEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseTemplate, Vcl.StdCtrls,
  Vcl.ExtCtrls, Common.DBUtils, DlgBaseDBEditor;

type
  TfCommonEditor = class(TDlgBase)
    cbTables: TComboBox;
    lblTables: TLabel;
    lblCommonName: TLabel;
    edtCommonName: TEdit;
  private
    FCommonName: string;
    FTableName: string;
    FAllowTableSelect: Boolean;
    FEditMode: TEditMode;
    procedure SetCommonName(const Value: string);
    procedure SetTableName(const Value: string);
    function GetTableName: string;
    function GetCommonName: string;
    procedure SetAllowTableSelect(const Value: Boolean);
    procedure SetEditMode(const Value: TEditMode);
  public
    procedure AfterConstruction; override;
    property TableName : string read GetTableName write SetTableName;
    property CommonName: string read GetCommonName write SetCommonName;
    property EditMode : TEditMode read FEditMode write SetEditMode;
  end;

const
  cSQLItems =
    'SELECT UPPER(so.Name) As TblName FROM sys.objects so '#13#10 +
    'WHERE so.TYPE = ''U'' AND  '#13#10 +
    '  so.Name LIKE ''%Ref'' AND  '#13#10 +
    '  so.Name <> ''COMMONSREF''';
  cSQLItemsNew = 'so.Name NOT IN (SELECT UPPER(cr.CommonTableName) FROM dbo.CommonsRef cr)';

var
  fCommonEditor: TfCommonEditor;

implementation

{$R *.dfm}

{ TfCommonEditor }

procedure TfCommonEditor.AfterConstruction;
begin
  inherited;
  btnOK.ModalResult := mrOk;
  cbTables.Items.Assign(GetItemsBySQL(cSQLItems));
  if cbTables.Items.Count > 0 then
    cbTables.ItemIndex := 0;
end;

function TfCommonEditor.GetCommonName: string;
begin
  Result := edtCommonName.Text;
end;

function TfCommonEditor.GetTableName: string;
begin
  Result := cbTables.Text;
end;

procedure TfCommonEditor.SetAllowTableSelect(const Value: Boolean);
begin
  FAllowTableSelect := Value;
  cbTables.Enabled := Value;
end;

procedure TfCommonEditor.SetCommonName(const Value: string);
begin
  FCommonName := Value;
  edtCommonName.Text := FCommonName;
end;

procedure TfCommonEditor.SetEditMode(const Value: TEditMode);
begin
  FEditMode := Value;
  if FEditMode = emEdit then
  begin
    cbTables.Enabled := False;
    Caption := 'Редактирование справочника';
  end;
  if FEditMode = emAppend then
  begin
    Caption := 'Новый справочник';
    cbTables.Items.Assign(GetItemsBySQL(Format('%s AND %s', [ cSQLItems, cSQLItemsNew ])));
    if cbTables.Items.Count > 0 then
      cbTables.ItemIndex := 0;
  end;
end;

procedure TfCommonEditor.SetTableName(const Value: string);
begin
  FTableName := Value;
  if FTableName > '' then
    cbTables.ItemIndex := cbTables.Items.IndexOf(UpperCase(FTableName));
end;

end.
