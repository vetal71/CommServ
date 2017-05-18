unit DlgConsumerEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseDBEditor, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, DBAccess, Uni, MemDS, RxDBComb,
  RxToolEdit, RxDBCtrl, RxLookup, DlgCommon, DlgBaseTemplate, KVComp_UComboExt;

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
    edtNazv: TEdit;
    edtAddress: TEdit;
    edtAccount: TEdit;
    edtUnn: TEdit;
    edtDogNum: TEdit;
    edtBankNameExt: TEdit;
    ceBank: TComboEdit;
    dDataDog: TDateEdit;
    cbBudgetKind: TQueryComboBox;
    cbConsumerKind: TQueryComboBox;
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
    FieldByName('ConsumerName').AsString      := edtNazv.Text;
    FieldByName('ConsumerAddress').AsString     := edtAddress.Text;
    FieldByName('Account').AsString    := edtAccount.Text;
    FieldByName('UNN').AsString       := edtUnn.Text;
//    FieldByName('ndog').AsInteger     := string.ToInteger(edtDogNum.Text);
//    FieldByName('datadog').AsDateTime := edtDataDog.Date;
    FieldByName('BankId').AsInteger  := string.ToInteger(ceBank.Text);
    FieldByName('ConsumerKindId').AsInteger := cbConsumerKind.Code;
    FieldByName('BudgetKindId').AsInteger   := cbBudgetKind.Code;
  end;
end;

procedure TfConsumerEditor.ceBankButtonClick(Sender: TObject);
const
  cSQLText = 'select BankId as CODE, BankName as NAME from bank';
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
  cbConsumerKind.Load;
  cbBudgetKind.Load;
  if DataSet = nil then Exit;
  with DataSet do
  begin
    case EditMode of
      emAppend:
        begin
          Self.Caption := 'Новый потребитель';
          DataSet.Append;
          cbConsumerKind.Code := 0;
          cbBudgetKind.Code   := 0;
        end;
      emEdit:
        begin
          Self.Caption := Format('Редактирование потребителя: %s', [ DataSet.FieldByName('ConsumerName').AsString ]);
          DataSet.Edit;
          cbConsumerKind.Code := DataSet.FieldValues['ConsumerKindId'];
          cbBudgetKind.Code   := DataSet.FieldValues['BudgetKindId'];
        end;
    end;
    edtNazv.Text    := FieldByName('ConsumerName').AsString;
    edtAddress.Text := FieldByName('ConsumerAddress').AsString;
    edtAccount.Text := FieldByName('Account').AsString;
    edtUnn.Text     := FieldByName('UNN').AsString;
//    edtDogNum.Text  := FieldByName('ndog').AsString;
//    edtDataDog.Date := FieldByName('datadog').AsDateTime;
    SetBankMFO(FieldByName('BankId').AsString);
  end;
end;

procedure TfConsumerEditor.SetBankMFO(AValue: Variant);
begin
  if VarIsNull(AValue) then Exit;
  ceBank.Text := AValue;
  edtBankNameExt.Text := GetFieldValue('BankName', 'Banks', Format('BankId=%s', [AValue]), '?');
end;

function TfConsumerEditor.ValidFields: Boolean;
begin
  Result := (edtNazv.Text > '') and
            (cbConsumerKind.Code > 0);
end;

end.
