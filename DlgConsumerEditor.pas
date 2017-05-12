unit DlgConsumerEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseTemplate, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, DBAccess, Uni, MemDS, RxDBComb,
  RxToolEdit, RxDBCtrl, RxLookup;

type
  TfConsumerEditor = class(TDlgBase)
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
    cbMFO: TDBLookupComboBox;
    lbl2: TLabel;
    lbl3: TLabel;
    edtNazv: TRxDBComboEdit;
    edtAddress: TRxDBComboEdit;
    edtAccount: TRxDBComboEdit;
    edtBankName: TRxDBComboEdit;
    edtUnn: TRxDBComboEdit;
    edtDogNum: TRxDBComboEdit;
    lbl4: TLabel;
    lblOt: TLabel;
    edtDataDog: TDBDateEdit;
    cbTipOrg: TComboBox;
    cbMin: TComboBox;
  protected
    function ValidFields: Boolean; override;
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  ConsumersForm, DataModule;

{$R *.dfm}

{ TfConsumerEditor }

procedure TfConsumerEditor.AfterConstruction;
begin
  inherited;
  if qryBanks.Active then qryBanks.Close;
  try
    qryBanks.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить список банков.'#13'%s', [ E.Message ]);
  end;
end;

function TfConsumerEditor.ValidFields: Boolean;
begin
  Result := (edtNazv.Text > '') and
            (cbTipOrg.ItemIndex > 0);
end;

end.
