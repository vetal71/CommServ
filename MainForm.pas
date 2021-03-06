unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate,
  Vcl.ExtCtrls, Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, ConsumersForm,
  cxGraphics, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, TariffServsForm;

type
  TfMain = class(TBaseForm)
    miDictions: TMenuItem;
    miConsumers: TMenuItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbiConsumers: TSpTBXItem;
    grpAuth: TTBGroupItem;
    lblUserName: TSpTBXLabelItem;
    lblAuthCaption: TSpTBXLabelItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    grpCalcPeriod: TTBGroupItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    lblCalcPeriod: TSpTBXLabelItem;
    lblCalcPeriodCaption: TSpTBXLabelItem;
    tbiTariffServs: TSpTBXItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    miTariffServs: TMenuItem;
    miN2: TMenuItem;
    tbiClassificator: TSpTBXItem;
    miN1: TMenuItem;
    miN3: TMenuItem;
    SpTBXSeparatorItem7: TSpTBXSeparatorItem;
    tbiCounters: TSpTBXItem;
    tbiProductSuit: TSpTBXItem;
    procedure FormCreate(Sender: TObject);
    procedure tbiConsumersClick(Sender: TObject);
    procedure tbiTariffServsClick(Sender: TObject);
    procedure tbiClassificatorClick(Sender: TObject);
    procedure tbiCountersClick(Sender: TObject);
  private
    FUserName: string;
    procedure SetUserName(const Value: string);
  public

    property UserName : string read FUserName write SetUserName;
  end;

var
  fMain: TfMain;

implementation

uses
  Common.Consts, Common.StrFuncs, Common.DBUtils, Common.Config,
  ClassificatorForm, CountersForm;

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
var
  sCaption: string;
  sOrgName: string;
begin
  inherited;
  sOrgName := OrgParams.OrgName;
  Caption := sCaption.Format(cApplicationTitle, [ sOrgName ]);

  lblCalcPeriod.Caption:= Format('%s �.', [ OrgParams.CalcPeriod ]);
  Config.Values['WorkingDate'] := DateToStr( DateOfPeriod( OrgParams.CalcPeriodIndex ) );

//  Application.OnHint := AppShowHint;
end;

procedure TfMain.SetUserName(const Value: string);
begin
  FUserName := Value;
  lblUserName.Caption := Value;
  // �������� ������������� SQL Server
  RunExecSQL(Format('exec sp_defaultlanguage %s, %s',[FUserName, '�������']));
end;

procedure TfMain.tbiClassificatorClick(Sender: TObject);
var
  CF: TfClassificator;
begin
  inherited;
  CF := TfClassificator.Create(Application);
  try
    CF.ShowModal;
  finally
    CF.Free;
  end;
end;

procedure TfMain.tbiConsumersClick(Sender: TObject);
var
  CF: TfConsumers;
begin
  inherited;
  CF := TfConsumers.Create(Application);
  try
    CF.ShowModal;
  finally
    CF.Free;
  end;
end;

procedure TfMain.tbiCountersClick(Sender: TObject);
var
  CF: TfCounters;
begin
  inherited;
  CF := TfCounters.Create(Application);
  try
    CF.ShowModal;
  finally
    CF.Free;
  end;
end;

procedure TfMain.tbiTariffServsClick(Sender: TObject);
var
  F: TfTariffServs;
begin
  inherited;
  F := TfTariffServs.Create(Application);
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;

end.
