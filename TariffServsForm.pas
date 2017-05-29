unit TariffServsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, RxSplit, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Data.DB, MemDS, DBAccess, Uni, KVComp_UDataSetPanel, DataModule,
  Vcl.StdCtrls, Common.DBUtils;

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
    procedure tbiAddTariffClick(Sender: TObject);
    procedure tbiEditTariffClick(Sender: TObject);
    procedure tbiDelTariffClick(Sender: TObject);
    procedure tbiDelTariffValClick(Sender: TObject);
    procedure tbiAddTariffValClick(Sender: TObject);
    procedure tbiEditTariffValClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure EditTariff(AMode: TEditMode);
    procedure EditTariffVal(AMode: TEditMode);
  public
    procedure AfterConstruction; override;
  end;

var
  fTariffServs: TfTariffServs;

implementation

uses
  DlgServiceEditor, Common.StrFuncs, DlgTariffServEditor, DlgTariffValEditor;

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

procedure TfTariffServs.tbiAddTariffClick(Sender: TObject);
begin
  inherited;
  EditTariff(emAppend);
end;

procedure TfTariffServs.tbiAddTariffValClick(Sender: TObject);
begin
  inherited;
  EditTariffVal(emAppend);
end;

procedure TfTariffServs.tbiDelTariffClick(Sender: TObject);
begin
  // Удаление вида тарифа
  if ConfirmWarn(Format('Вы действительно хотите удалить вид тарифа "%s"?'#13 +
    'Также будут удалены все связанные данные. Удалить ?', [qryTariffServ['ServTitle']])) then
  begin
    try
      qryTariffServ.Delete;
    except
      on E: Exception do
      begin
        qryTariffServ.Cancel;
        ShowErrorFmt('Ошибка при удалении данных по видам тарифов.'#13'%s', [E.Message]);
      end;
    end;
  end;
end;

procedure TfTariffServs.tbiDelTariffValClick(Sender: TObject);
begin
  inherited;
  // Удаление тарифа
  if ConfirmWarn('Вы действительно хотите удалить действующий тариф ?') then
  begin
    try
      qryTariffVal.Delete;
    except
      on E: Exception do
      begin
        qryTariffVal.Cancel;
        ShowErrorFmt('Ошибка при удалении данных тарифа.'#13'%s', [E.Message]);
      end;
    end;
  end;
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

procedure TfTariffServs.tbiEditTariffClick(Sender: TObject);
begin
  inherited;
  EditTariff(emEdit);
end;

procedure TfTariffServs.tbiEditTariffValClick(Sender: TObject);
begin
  inherited;
  EditTariffVal(emEdit);
end;

procedure TfTariffServs.EditTariff(AMode: TEditMode);
var
  F: TfTariffServEditor;
begin
  F := TfTariffServEditor.Create(Owner, qryTariffServ, AMode);
  try
    F.ParentService := qryServices['ServiceKindName'];
    if F.ShowModal = mrOk then
      try
        qryTariffServ.Post;
      except
        on E: Exception do
        begin
          qryTariffServ.Cancel;
          ShowErrorFmt('Ошибка при сохранении данных по тарифам.'#13'%s', [E.Message]);
        end;
      end
    else
      qryTariffServ.Cancel;
  finally
    F.Free;
  end;
end;

procedure TfTariffServs.EditTariffVal(AMode: TEditMode);
var
  F: TfTariffValEditor;
begin
  F := TfTariffValEditor.Create(Owner, qryTariffVal, AMode);
  try
    F.ParentTariff := qryTariffServ['ServTitle'];
    if F.ShowModal = mrOk then
      try
        qryTariffVal.Post;
      except
        on E: Exception do
        begin
          qryTariffVal.Cancel;
          ShowErrorFmt('Ошибка при сохранении значения тарифа.'#13'%s', [E.Message]);
        end;
      end
    else
      qryTariffVal.Cancel;
  finally
    F.Free;
  end;
end;

procedure TfTariffServs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := caFree;
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
