unit DlgTariffValEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseDBEditor, Vcl.StdCtrls,
  Vcl.ExtCtrls, RxCurrEdit, Vcl.Mask, RxToolEdit, System.DateUtils;

type
  TfTariffValEditor = class(TDlgDBEditor)
    lblDateFrom: TLabel;
    lblTariffVal: TLabel;
    dDateFrom: TDateEdit;
    edtTariffVal: TCurrencyEdit;
    edtTariffName: TEdit;
    bvl1: TBevel;
  private
    FParentTariff: string;
    procedure SetParentTariff(const Value: string);
  protected
    function ValidFields: Boolean; override;
    procedure AssignFields; override;
    procedure InitFields; override;
  public
    property ParentTariff : string read FParentTariff write SetParentTariff;
  end;

var
  fTariffValEditor: TfTariffValEditor;

implementation

uses
  Common.Config, Common.DBUtils, Common.StrFuncs;

{$R *.dfm}

{ TfTariffValEditor }

procedure TfTariffValEditor.AssignFields;
begin
  inherited;
  // заполняем данными поля
  with DataSet do
  begin
    FieldByName('DateFrom').AsDateTime := dDateFrom.Date;
    FieldByName('Value').AsFloat       := edtTariffVal.Value;
  end;
end;

procedure TfTariffValEditor.InitFields;
const
  cSQL = 'select top 1 Value from TariffServsVal where ServId=%d order by DateFrom Desc';
var
  OldValue: Extended;
begin
  if DataSet = nil then Exit;
  with DataSet do
  begin
    case EditMode of
      emAppend:
        begin
          Self.Caption := 'Новое значение тарифа';
          DataSet.Append;
          dDateFrom.Date := StrToDateTime( Config.Values['WorkingDate'] );
          OldValue := GetFieldValueBySQL(Format(cSQL, [ DataSet.FieldByName('ServId').AsInteger ]), 'Value', 0);
          edtTariffVal.Value := OldValue;
        end;
      emEdit:
        begin
          Self.Caption := Format('Редактирование вида тарифа: %s', [ FParentTariff ]);
          DataSet.Edit;
          dDateFrom.Date := FieldByName('DateFrom').AsDateTime;
          edtTariffVal.Value := FieldByName('Value').AsFloat;
        end;
    end;
  end;
end;

procedure TfTariffValEditor.SetParentTariff(const Value: string);
begin
  FParentTariff := Value;
  edtTariffName.Text := Value;
end;

function TfTariffValEditor.ValidFields: Boolean;
const
  cSQL = 'select Max(DateFrom) As MaxDate from TariffServsVal where ServId=%d';
var
  MaxDate, EndPeriod: Double;
begin
  // Условия проверки
  // 1. Дата больше максимальной
  // 2. Если дата больше конца рабочего периода - предупреждение
  Result := True;
  MaxDate := GetFieldValueBySQL(Format(cSQL, [ DataSet.FieldByName('ServId').AsInteger ]), 'MaxDate', 0);
  if (MaxDate > 0) then
    Result := dDateFrom.Date >= MaxDate;
  if not Result then
  begin
    ShowWarning(Format('Дата начала действия тарифа должна быть больше предыдущей %s', [ DateToStr(MaxDate) ]));
    Exit;
  end;
  EndPeriod := EndOfTheMonth( StrToDateTime( Config.Values['WorkingDate'] ) );
  if (EndPeriod > 0) then
    Result := dDateFrom.Date <= EndPeriod;
  if not Result then
  begin
    Result := ConfirmWarn('Дата начала действия тарифа за границей рабочего периода. Уверены ?');
  end;

end;

end.
