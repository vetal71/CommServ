unit TariffServsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, RxSplit, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh;

type
  TfTariffServs = class(TBaseForm)
    scbMain: TScrollBox;
    pnlView: TPanel;
    pnlServices: TPanel;
    pnlTariffServ: TPanel;
    splTop: TRxSplitter;
    splBottom: TRxSplitter;
    pnlTariffVals: TPanel;
    dck1: TSpTBXDock;
    dck2: TSpTBXDock;
    tbr1: TSpTBXToolbar;
    tbr2: TSpTBXToolbar;
    grd1: TDBGridEh;
    grd2: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTariffServs: TfTariffServs;

implementation

{$R *.dfm}

end.
