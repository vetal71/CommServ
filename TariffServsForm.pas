unit TariffServsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, RxSplit, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Data.DB, MemDS, DBAccess, Uni, KVComp_UDataSetPanel, DataModule,
  Vcl.StdCtrls;

type
  TfTariffServs = class(TBaseForm)
    scbMain: TScrollBox;
    pnlView: TPanel;
    pnlServices: TPanel;
    pnlTariffServ: TPanel;
    splTop: TRxSplitter;
    splBottom: TRxSplitter;
    pnlTariffVals: TPanel;
    dckTariffVal: TSpTBXDock;
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
    dspTariffVal: TDataSetPanel;
    tbrTariffVal: TSpTBXToolbar;
    tbiAddTariffVal: TSpTBXItem;
    tbiEditTariffVal: TSpTBXItem;
    tbiDelTariffVal: TSpTBXItem;
    qryTariffVal: TUniQuery;
    dsTariffVal: TUniDataSource;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    chkActual: TCheckBox;
    tbcFilterActual: TTBControlItem;
    procedure qryServicesAfterOpen(DataSet: TDataSet);
    procedure qryTariffServAfterOpen(DataSet: TDataSet);
    procedure chkActualClick(Sender: TObject);
    procedure qryTariffValAfterOpen(DataSet: TDataSet);
    procedure tbiEditServiceClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

var
  fTariffServs: TfTariffServs;

implementation

uses
  DlgServiceEditor, Common.DBUtils, Common.StrFuncs;

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
  if qryTariffVal.Active then
    qryTariffVal.Close;
  chkActualClick(nil);

  BuildMenu(tbrServices, 0);
  BuildMenu(tbrTariffServ, 1);
  BuildMenu(tbrTariffVal, 2);
end;

procedure TfTariffServs.chkActualClick(Sender: TObject);
begin
  inherited;
  if qryTariffVal.Active then
    qryTariffVal.Close;
  if chkActual.Checked then
    qryTariffVal.MacroByName('Limit').Value := ' TOP 1 '
  else
    qryTariffVal.MacroByName('Limit').Clear;
  try
    qryTariffVal.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Не удалось получить значения тарифов.'#13'%s', [ E.Message ]);
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

procedure TfTariffServs.qryTariffValAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dspTariffVal.LoadFieldsDef;
end;

procedure TfTariffServs.tbiEditServiceClick(Sender: TObject);
var
  F: TfServiceEditor;
begin
  F := TfServiceEditor.Create(Owner, qryServices, emEdit);
  try
    if F.ShowModal = mrOk then
      try
        qryServices.Post;
      except
        on E: Exception do
        begin
          qryServices.Cancel;
          ShowErrorFmt('Ошибка при сохранении данных по виду услуги.'#13'%s', [E.Message]);
        end;
      end
    else
      qryServices.Cancel;
  finally
    F.Free;
  end;
end;

(*
procedure Tf_gage.Btn4Click(Sender: TObject);
var ExpClass:TDBGridEhExportClass;
    Ext:String;
begin
     sdExport.FileName   := 'Gage_data';

      if sdExport.Execute
       then
        begin
          case sdExport.FilterIndex of
            1: begin ExpClass := TDBGridEhExportAsXLS;  Ext := 'xls'; end;
            2: begin ExpClass := TDBGridEhExportAsText; Ext := 'txt'; end;
            3: begin ExpClass := TDBGridEhExportAsCSV;  Ext := 'csv'; end;
            4: begin ExpClass := TDBGridEhExportAsHTML; Ext := 'htm'; end;
            5: begin ExpClass := TDBGridEhExportAsRTF;  Ext := 'rtf'; end;
          else ExpClass := nil; Ext := '';
          end;

          if ExpClass <> nil
           then
            begin
             if UpperCase(Copy(sdExport.FileName,Length(sdExport.FileName)-2,3)) <> UpperCase(Ext)
              then sdExport.FileName := sdExport.FileName + '.' + Ext;
             SaveDBGridEhToExportFile(ExpClass, dbgGage, sdExport.FileName, True);
            end;
        end;
end;
*)

end.
