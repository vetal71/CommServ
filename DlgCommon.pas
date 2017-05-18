unit DlgCommon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseTemplate, Vcl.StdCtrls,
  Vcl.ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Data.DB, DBAccess, Uni, MemDS;

type
  TFDlgCommon = class(TDlgBase)
    grdCommon: TDBGridEh;
    qryCommon: TUniQuery;
    dsCommon: TUniDataSource;
  private

  public

  end;

function ShowDlgCommon(AConnection: TUniConnection; ASQLText, ACaption: string; var ACode: Variant): Boolean;

implementation

uses
  Common.StrFuncs, EhLibUniDAC;

{$R *.dfm}

function ShowDlgCommon(AConnection: TUniConnection; ASQLText, ACaption: string; var ACode: Variant): Boolean;
var
  FDlgCommon: TFDlgCommon;
begin
  Result := False;
  FDlgCommon := TFDlgCommon.Create(Application);
  with FDlgCommon do
  try
    Caption              := ACaption;
    qryCommon.Connection := AConnection;
    qryCommon.SQL.Text   := ASQLText;
    btnOK.ModalResult    := mrOk;
    btnOK.Default        := True;
    try
      qryCommon.Open;
      if not VarIsNull(ACode) then
        qryCommon.Locate('CODE', ACode, []);
      if ShowModal = mrOk then begin
        ACode := qryCommon['CODE'];
        Result := True;
      end;
    except on E: Exception do
      begin
        ShowErrorFmt('При открытии формы спарвочника возникла ошибка.'#13'%s', [ E.Message ]);
        raise;
      end;
    end;
  finally
    FDlgCommon.Free;
  end;
end;

end.
