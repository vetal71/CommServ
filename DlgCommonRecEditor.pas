unit DlgCommonRecEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseDBEditor, Vcl.StdCtrls,
  Vcl.ExtCtrls, DB, Uni;

type
  TMyEdit = class(TEdit)
  private
    FFieldName: string;
  public
    property FieldName : string read FFieldName write FFieldName;
  end;

type
  TfCommonRecEditor = class(TDlgDBEditor)
  protected
    function ValidFields: Boolean; override;
    procedure AssignFields; override;
    procedure InitFields; override;
  end;

var
  fCommonRecEditor: TfCommonRecEditor;

implementation

uses
  Common.DBUtils;

{$R *.dfm}

{ TfCommonRecEditor }

procedure TfCommonRecEditor.AssignFields;
var
  I: Integer;
  CurentComponent: TComponent;
begin
  inherited;
  for I := 0 to pnlMain.ComponentCount - 1 do
  begin
    CurentComponent := pnlMain.Components[ I ];
    if (CurentComponent is TMyEdit) then
      DataSet.FieldValues[ TMyEdit(CurentComponent).FieldName ] := TMyEdit(CurentComponent).Text;
  end;
end;

procedure TfCommonRecEditor.InitFields;
var
  I: Integer;
  eTop, eLeft: Integer;
  eKeyField: string;

  procedure AddFieldEditor(AField: TField; ATop, ALeft: Integer);
  var
    lbl: TLabel;
    edt: TMyEdit;
  begin
    lbl := TLabel.Create(pnlMain);
    lbl.Parent := pnlMain;
    lbl.SetBounds(ALeft, ATop, 150, 15);
    lbl.Name := 'lbl' + AField.FieldName;
    lbl.Caption  := AField.DisplayLabel + ':';

    edt := TMyEdit.Create(pnlMain);
    edt.Parent := pnlMain;
    edt.SetBounds(ALeft + 155, ATop - 3, 300, 22);
    edt.Name := 'edt' + AField.FieldName;
    edt.Text := VarToStrDef(AField.Value, '');
    edt.FieldName := AField.FieldName;
    // ключевое поле дизейблим
    if CompareStr(eKeyField, AField.FieldName) = 0 then
      edt.Enabled := False;
  end;

begin
  inherited;
  eKeyField := TUniQuery(DataSet).KeyFields;
  case EditMode of
    emAppend:
      begin
        DataSet.Append;
        Caption := 'Новый элемент справочника';
        if eKeyField > '' then
          DataSet.FieldValues[eKeyField] := GenerateKeyValue(
            eKeyField, TUniQuery(DataSet).UpdatingTable);
      end;
    emEdit:
      begin
        DataSet.Edit;
        Caption := 'Редактирование элемента справочника';
      end;
  end;

  eLeft := 15;
  eTop  := 15;
  for I := 0 to DataSet.Fields.Count - 1 do
  begin
    if I > 0 then
    begin
      eTop  := eTop + 30;
    end;
    AddFieldEditor(DataSet.Fields[ I ], eTop, eLeft);
  end;
end;

function TfCommonRecEditor.ValidFields: Boolean;
var
  I: Integer;
begin
  Result := inherited ValidFields;
  for I := 0 to pnlMain.ComponentCount - 1 do
  begin
    if (pnlMain.Components[ I ] is TEdit) then
    begin
      Result := TEdit(pnlMain.Components[ I ]).Text > '';
      if not Result then
        Break;
    end;
  end;
end;

end.
