unit KVComp_FDSPFieldView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, KVComp_UDSPFields,
  DB, Uni, DBGridEh, rxPlacemnt;

type
  TFieldViewDialog = class(TForm)
    GroupBox1: TGroupBox;
    btnClose: TButton;
    lbFields: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edLabel: TEdit;
    edWidth: TEdit;
    udWidth: TUpDown;
    edMask: TEdit;
    cbVisible: TCheckBox;
    btnSave: TButton;
    cbCommonSetup: TCheckBox;
    FormStorage1: TFormStorage;
    procedure lbFieldsClick(Sender: TObject);
    procedure edLabelChange(Sender: TObject);
    procedure edMaskChange(Sender: TObject);
    procedure cbVisibleClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure udWidthClick(Sender: TObject; Button: TUDBtnType);
    procedure edWidthExit(Sender: TObject);
  private
    DataSetPanel : Pointer;
    DataSet : TDataSet;
    Grid : TDBGridEh;
    Field   : TField;
    procedure DataSetToForm;
    procedure ChangeFieldDisplayWidth;
  public
    procedure Execute (aDataSetPanel : Pointer; aDataSet : TDataSet);
  end;

implementation

uses
  KVComp_UDataSetPanel;

{$R *.DFM}

procedure TFieldViewDialog.Execute (aDataSetPanel : Pointer; aDataSet : TDataSet);

  function IsRussianName (const S : String) : Boolean;
  const
    EngCharSet = ['A'..'Z','a'..'z'];
  var
    tmpStr : String;
  begin
    tmpStr := AnsiUpperCase(Trim(S));
    Result := (tmpStr <> '') and (not (tmpStr[1] in EngCharSet));
  end;

  function FindColumn (Field : TField) : TColumnEh;
  var
    i : Integer;
  begin
    for i:=0 to Grid.Columns.Count-1 do begin
      Result := Grid.Columns[i];
      if (Result.Field = Field) then exit;
    end;
    Result := Nil;
  end;

  procedure SetFieldDisplayLabel (Field : TField);
  var
    C : TColumnEh;
  begin
    if (IsRussianName(Field.DisplayLabel)) then exit;
    C := FindColumn(Field);
    if (not Assigned(C)) then exit;
    Field.DisplayLabel := C.Title.Caption;
  end;

var
  F : TField;
  i : Integer;

begin
  DataSetPanel := aDataSetPanel;
  DataSet := aDataSet;
  if (not Assigned(DataSet)) then exit;
  if (not DataSet.Active) then exit;
  if (DataSet.FieldCount < 1) then exit;

  lbFields.Clear;
  Grid := TDataSetPanel(DataSetPanel).Grid;

  GroupBox1.Hint := GroupBox1.Caption + '. Наименование описания - ' +
    UpperCase(TDataSetPanel(DataSetPanel).Storage.StorageTopic);
  Caption:=Format(' Настройка полей (%s)', [TDataSetPanel(DataSetPanel).Storage.StorageTopic]);
  for i:=0 to Grid.Columns.Count-1 do begin
    F := Grid.Columns[i].Field;
    if (not Assigned(F)) then break;
    lbFields.Items.AddObject(F.FieldName,F);
  end;

  for i:=0 to DataSet.FieldCount-1 do begin
    Field := DataSet.Fields[i];
    if (Assigned(FindColumn(Field))) then continue;
    lbFields.Items.AddObject(Field.FieldName,Field);
    Field.Visible := False;
  end;

  for i:=0 to lbFields.Items.Count-1 do
    TField(lbFields.Items.Objects[i]).Index := i;

  DataSet.DisableControls;
  try
    for i:=0 to DataSet.FieldCount-1 do begin
      Field := DataSet.Fields[i];
      SetFieldDisplayWidth (Grid, DataSet, Field, GetFieldDisplayWidth(Grid,Field));
      SetFieldDisplayLabel (Field);
    end;
  finally
    DataSet.EnableControls;
  end;

  lbFields.ItemIndex := 0;
  DataSetToForm;
  ShowModal;
end;

procedure TFieldViewDialog.DataSetToForm;
begin
  if (lbFields.ItemIndex < 0) or (lbFields.ItemIndex >= DataSet.FieldCount) then exit;
  Field := DataSet.FindField(lbFields.Items[lbFields.ItemIndex]);
  edLabel.Text      := Field.DisplayLabel;
  udWidth.Position  := GetFieldDisplayWidth(Grid, Field);
  edMask.Text       := GetFieldDisplayFormat(Field);
  cbVisible.Checked := Field.Visible;
end;

procedure TFieldViewDialog.lbFieldsClick(Sender: TObject);
begin
  DataSetToForm;
end;

procedure TFieldViewDialog.edLabelChange(Sender: TObject);
begin
  if (lbFields.ItemIndex < 0) or (lbFields.ItemIndex >= DataSet.FieldCount) then exit;
  Field := DataSet.FindField(lbFields.Items[lbFields.ItemIndex]);
  Field.DisplayLabel := edLabel.Text;
end;

procedure TFieldViewDialog.edMaskChange(Sender: TObject);
begin
  if (lbFields.ItemIndex < 0) or (lbFields.ItemIndex >= DataSet.FieldCount) then exit;
  Field := DataSet.FindField(lbFields.Items[lbFields.ItemIndex]);
  SetFieldDisplayFormat(Field,edMask.Text);
end;

procedure TFieldViewDialog.cbVisibleClick(Sender: TObject);
var
  L : KVComp_UDSPFields.TFieldDefList;
begin
  if (lbFields.ItemIndex < 0) or (lbFields.ItemIndex >= DataSet.FieldCount) then exit;
  Field := DataSet.FindField(lbFields.Items[lbFields.ItemIndex]);
  Field.Visible := cbVisible.Checked;
  L := KVComp_UDSPFields.TFieldDefList.Create(Grid);
  try
    L.GetFieldsDef;
    L.SetGridColumns;
  finally
    L.Free;
  end;
end;

procedure TFieldViewDialog.btnSaveClick(Sender: TObject);
begin
  TDataSetPanel(DataSetPanel).SaveFieldsDef(cbCommonSetup.Checked);
end;

procedure TFieldViewDialog.udWidthClick(Sender: TObject;
  Button: TUDBtnType);
begin
  ChangeFieldDisplayWidth;
end;

procedure TFieldViewDialog.ChangeFieldDisplayWidth;
begin
  if (lbFields.ItemIndex < 0) or (lbFields.ItemIndex >= DataSet.FieldCount) then exit;
  Field := DataSet.FindField(lbFields.Items[lbFields.ItemIndex]);
  SetFieldDisplayWidth (Grid, DataSet, Field, udWidth.Position);
end;

procedure TFieldViewDialog.edWidthExit(Sender: TObject);
var
  N : Integer;
begin
  if (not edWidth.Modified) then exit;
  N := StrToIntDef(Trim(edWidth.Text),0);
  if (N < udWidth.Min) then
    N := udWidth.Min
  else if (N > udWidth.Max) then
    N := udWidth.Max;
  udWidth.Position := N;
  ChangeFieldDisplayWidth;
end;

end.
