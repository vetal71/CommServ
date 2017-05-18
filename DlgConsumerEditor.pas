unit DlgConsumerEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseDBEditor, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, DBAccess, Uni, MemDS, RxDBComb,
  RxToolEdit, RxDBCtrl, RxLookup, DlgCommon, DlgBaseTemplate;

type
  TfConsumerEditor = class(TDlgDBEditor)
    scbMain: TScrollBox;
    lblOrgName: TLabel;
    bvl1: TBevel;
    lblAddress: TLabel;
    qryBanks: TUniQuery;
    dsBanks: TUniDataSource;
    lblTipOrg: TLabel;
    lblRekv: TLabel;
    bvl2: TBevel;
    lblDogovor: TLabel;
    bvl3: TBevel;
    lblMFO: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblOt: TLabel;
    edtDataDog: TDBDateEdit;
    cbTipOrg: TComboBox;
    cbMin: TComboBox;
    edtNazv: TEdit;
    edtAddress: TEdit;
    edtAccount: TEdit;
    edtUnn: TEdit;
    edtDogNum: TEdit;
    edtBankNameExt: TEdit;
    ceBank: TComboEdit;
    procedure ceBankButtonClick(Sender: TObject);
  protected
    function ValidFields: Boolean; override;
    procedure AssignFields; override;
    procedure InitFields; override;
    procedure OpenData; override;
  private
    procedure SetBankMFO(AValue: Variant);
  end;

implementation

uses
  ConsumersForm, DataModule, Common.DBUtils;

{$R *.dfm}

{ TfConsumerEditor }

procedure TfConsumerEditor.OpenData;
begin
  if qryBanks.Active then qryBanks.Close;
  try
    qryBanks.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить список банков.'#13'%s', [ E.Message ]);
  end;
end;

procedure TfConsumerEditor.AssignFields;
begin
  inherited;
  // заполняем данными поля
  with DataSet do
  begin
    FieldByName('nazv').AsString      := edtNazv.Text;
    FieldByName('adres').AsString     := edtAddress.Text;
    FieldByName('rschet').AsString    := edtAccount.Text;
    FieldByName('unn').AsString       := edtUnn.Text;
    FieldByName('ndog').AsInteger     := string.ToInteger(edtDogNum.Text);
    FieldByName('datadog').AsDateTime := edtDataDog.Date;
    FieldByName('kodbank').AsInteger  := string.ToInteger(ceBank.Text);
    FieldByName('tiporg').AsInteger   := cbTipOrg.ItemIndex;
    FieldByName('tipbud').AsInteger   := cbMin.ItemIndex;
  end;
end;

procedure TfConsumerEditor.ceBankButtonClick(Sender: TObject);
const
  cSQLText = 'select kod_bank as CODE, nazv_bank as NAME from bank';
  cCaption = 'Справочник банков';
var
  eCode: Variant;
begin
  inherited;
  eCode := ceBank.Text;
  if ShowDlgCommon(dm.dbConn, cSQLText, cCaption, eCode) then
  begin
    ceBank.Text := eCode;
    SetBankMFO(eCode);
  end;
end;

procedure TfConsumerEditor.InitFields;
begin
  if DataSet = nil then Exit;
  with DataSet do
  begin
    case EditMode of
      emAppend:
        begin
          Self.Caption := 'Новый потребитель';
          DataSet.Append;
          cbTipOrg.ItemIndex := 0;
          cbMin.ItemIndex    := 0;
        end;
      emEdit:
        begin
          Self.Caption := Format('Редактирование потребителя: %s', [ DataSet.FieldByName('nazv').AsString ]);
          DataSet.Edit;
          cbTipOrg.ItemIndex := DataSet.FieldValues['tiporg'];
          cbMin.ItemIndex    := DataSet.FieldValues['tipbud'];
        end;
    end;
    edtNazv.Text    := FieldByName('nazv').AsString;
    edtAddress.Text := FieldByName('adres').AsString;
    edtAccount.Text := FieldByName('rschet').AsString;
    edtUnn.Text     := FieldByName('unn').AsString;
    edtDogNum.Text  := FieldByName('ndog').AsString;
    edtDataDog.Date := FieldByName('datadog').AsDateTime;
    SetBankMFO(FieldByName('kodbank').AsString);
  end;
end;

procedure TfConsumerEditor.SetBankMFO(AValue: Variant);
begin
  if VarIsNull(AValue) then Exit;
  ceBank.Text := AValue;
  edtBankNameExt.Text := GetFieldValue('nazv_bank', 'bank', Format('kod_bank=%s', [AValue]), '?');
end;

function TfConsumerEditor.ValidFields: Boolean;
begin
  Result := (edtNazv.Text > '') and
            (cbTipOrg.ItemIndex > -1);
end;

end.
