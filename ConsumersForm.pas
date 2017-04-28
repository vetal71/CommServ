unit ConsumersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item,
  RxSplit, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Uni,
  DataModule, Data.DB, DBAccess, MemDS;

type
  TfConsumers = class(TBaseForm)
    pnlView: TPanel;
    pnlOrg: TPanel;
    splMain: TRxSplitter;
    pnlObjects: TPanel;
    dckOrg: TSpTBXDock;
    tbrOrg: TSpTBXToolbar;
    grdOrgs: TDBGridEh;
    dckObject: TSpTBXDock;
    tbrObject: TSpTBXToolbar;
    grdObjects: TDBGridEh;
    qryOrgs: TUniQuery;
    dsOrgs: TUniDataSource;
    qryObjects: TUniQuery;
    dsObjects: TUniDataSource;
    tbi1: TSpTBXItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

  procedure ShowConsumersList;

implementation

uses
  Common.StrFuncs, EhLibUniDAC;

{$R *.dfm}

procedure ShowConsumersList;
begin
  with TfConsumers.Create(Application) do
  try
    Show;
  except on E: Exception do
    ShowError(E.Message);
  end;
end;

{ TfConsumers }

procedure TfConsumers.AfterConstruction;
begin
  inherited;
  if qryOrgs.Active then
    qryOrgs.Close;
  try
    qryOrgs.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Ќе удалось получить список организаций.'#13'%s', [ E.Message ]);
  end;
  if qryObjects.Active then
    qryObjects.Close;
  try
    qryObjects.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Ќе удалось получить список потребителей.'#13'%s', [ E.Message ]);
  end;
end;

procedure TfConsumers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfConsumers.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 84 ) and ( Shift - [ssCtrl] = [] ) then
  begin
    if ActiveControl is TDBGridEh then
    begin
      (ActiveControl as TDBGridEh).STFilter.Visible := not
        (ActiveControl as TDBGridEh).STFilter.Visible;
    end;
  end;
end;

end.
