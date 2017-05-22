unit KVComp_FDlgDBDict;

interface

uses
  Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Uni, StdCtrls, ExtCtrls, DBGridEh, MemDS, DBAccess,
  ToolCtrlsEh, DBGridEhToolCtrls, EhLibVCL, GridsEh, DBAxisGridsEh,
  EhLibUniDAC, DBGridEhGrouping, DynVarsEh;

type
  TfDict = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    dsMain: TUniDataSource;
    grdMain: TDBGridEh;
    pnlButtons: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure grdMainGridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    function Execute : Boolean;

  end;

{ Вызов справочника }
function CreateDlgDBPick(const AConnection: TUniConnection; const ASQL: TStrings;
  const aCaption: string; var ACode: Integer): Boolean;

implementation

{$R *.DFM}

function CreateDlgDBPick (const AConnection: TUniConnection; const ASQL: TStrings;
  const aCaption: string; var ACode: Integer): Boolean;
var
  Form : TfDict;
  Query : TUniQuery;
begin
  if AConnection = nil then Exit;
  Result := False;
  Form   := TfDict.Create(Application);
  Query  := TUniQuery.Create(nil);
  with Query do
  try
    Connection := AConnection;
    Form.Caption := aCaption;
    Form.dsMain.DataSet := Query;
    SQL.Assign(ASQL);
    Screen.Cursor := crSQLWait;
    try
      Open;
    except on E: Exception do
      ShowMessageFmt('Ошибка: %s', [E.Message]);
    end;
    if (not VarIsNull(ACode)) then
      Locate('CODE', ACode, []);
    Screen.Cursor := crDefault;
    if (Form.Execute) and (not Query.IsEmpty) then begin
      Result := True;
      ACode := Fields[0].AsInteger;
    end;
  finally
    Query.Free;
    Form.Free;
  end;
end;

{------------------------------------------------------------------------------}
{ Работа с формой                                                              }
{------------------------------------------------------------------------------}
procedure TfDict.grdMainGridDblClick(Sender: TObject);
begin
  if dsMain.DataSet.IsEmpty then exit;
  Close;
  ModalResult := mrOK;
end;

procedure TfDict.btnCancelClick(Sender: TObject);
begin
  Close;
  ModalResult := mrCancel;
end;

//------------------------------------------------------------------------------
{Доступность элементов управления}
//------------------------------------------------------------------------------
function TfDict.Execute: Boolean;
begin
  Result := (ShowModal = mrOk);
end;

procedure TfDict.FormShow(Sender: TObject);
begin
  btnOK.Enabled := not dsMain.DataSet.IsEmpty;
end;

end.
