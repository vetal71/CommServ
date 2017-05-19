unit DlgBaseDBEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DlgBaseTemplate, Vcl.StdCtrls,
  Vcl.ExtCtrls, Uni, Common.DBUtils, DB;

type
  TDlgDBEditor = class(TDlgBase)
    procedure btnOKClick(Sender: TObject);
  private
    FDataSet: TDataSet;
    FEditMode: TEditMode;
  protected
    function ValidFields: Boolean; virtual;
    procedure OpenData; virtual;
    procedure AssignFields; virtual; abstract;
    procedure InitFields; virtual; abstract;
  public
    property EditMode: TEditMode read FEditMode write FEditMode;
    property DataSet: TDataSet read FDataSet;
  public
    procedure AfterConstruction; override;
  public
    constructor Create(AOwner: TComponent; ADataSet: TDataSet; AMode: TEditMode); overload;
  end;

var
  DlgDBEditor: TDlgDBEditor;

implementation

{$R *.dfm}

{ TDlgDBEditor }

procedure TDlgDBEditor.AfterConstruction;
begin
  inherited;
  OpenData;
  InitFields;
end;

procedure TDlgDBEditor.btnOKClick(Sender: TObject);
begin
  if ValidFields then
  begin
    AssignFields;
    ModalResult := mrOk;
  end;
end;

constructor TDlgDBEditor.Create(AOwner: TComponent; ADataSet: TDataSet;
  AMode: TEditMode);
begin
  inherited Create(AOwner);
  FDataSet  := ADataSet;
  FEditMode := AMode;
end;

procedure TDlgDBEditor.OpenData;
begin
  //
end;

function TDlgDBEditor.ValidFields: Boolean;
begin
  Result := True;
end;

end.
