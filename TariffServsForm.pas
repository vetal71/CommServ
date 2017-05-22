unit TariffServsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, RxSplit, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Data.DB, MemDS, DBAccess, Uni, KVComp_UDataSetPanel, DataModule;

type
  TfTariffServs = class(TBaseForm)
    scbMain: TScrollBox;
    pnlView: TPanel;
    pnlServices: TPanel;
    pnlTariffServ: TPanel;
    splTop: TRxSplitter;
    splBottom: TRxSplitter;
    pnlTariffVals: TPanel;
    dck2: TSpTBXDock;
    tbr2: TSpTBXToolbar;
    tbrServices: TSpTBXToolbar;
    tbiDelService: TSpTBXItem;
    tbiEditService: TSpTBXItem;
    tbiAddService: TSpTBXItem;
    dsServices: TUniDataSource;
    qryServices: TUniQuery;
    dspServices: TDataSetPanel;
    tbrTariffServ: TSpTBXToolbar;
    tbiAddTariff: TSpTBXItem;
    tbiEditTariff: TSpTBXItem;
    tbiDelTariff: TSpTBXItem;
    dspTariffServ: TDataSetPanel;
    dsTariffServ: TUniDataSource;
    qryTariffServ: TUniQuery;
    procedure qryServicesAfterOpen(DataSet: TDataSet);
    procedure qryTariffServAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

var
  fTariffServs: TfTariffServs;

implementation

{$R *.dfm}

procedure TfTariffServs.AfterConstruction;
begin
  inherited;
  if qryServices.Active then
    qryServices.Close;
  try
    qryServices.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить список услуг.'#13'%s', [ E.Message ]);
  end;
  if qryTariffServ.Active then
    qryTariffServ.Close;
  try
    qryTariffServ.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить список тарифов по услугам.'#13'%s', [ E.Message ]);
  end;
end;

procedure TfTariffServs.qryServicesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dspServices.LoadFieldsDef;
end;

procedure TfTariffServs.qryTariffServAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dspTariffServ.LoadFieldsDef;
end;

end.
