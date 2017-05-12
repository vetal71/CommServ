unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate,
  Vcl.ExtCtrls, Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, ConsumersForm,
  cxGraphics, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList;

type
  TfMain = class(TBaseForm)
    miDictions: TMenuItem;
    miConsumers: TMenuItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    tbi1: TSpTBXItem;
    grpAuth: TTBGroupItem;
    lblUserName: TSpTBXLabelItem;
    lblAuthCaption: TSpTBXLabelItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    grpCalcPeriod: TTBGroupItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    lblCalcPeriod: TSpTBXLabelItem;
    lblCalcPeriodCaption: TSpTBXLabelItem;
    procedure FormCreate(Sender: TObject);
    procedure tbi1Click(Sender: TObject);
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
  Common.Consts, Common.StrFuncs, Common.DBUtils, Common.Config;

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
var
  sCaption: string;
  sOrgName: string;
begin
  inherited;
  sOrgName := OrgParams.OrgName;
  Caption := sCaption.Format(cApplicationTitle, [ sOrgName ]);

  lblCalcPeriod.Caption:= Format('%s г.', [ OrgParams.CalcPeriod ]);
  Config.Values['WorkingDate'] := DateToStr( DateOfPeriod( OrgParams.CalcPeriodIndex ) );
end;

procedure TfMain.SetUserName(const Value: string);
begin
  FUserName := Value;
  lblUserName.Caption := Value;
  // выполним инициализацию SQL Server
  RunExecSQL(Format('exec sp_defaultlanguage %s, %s',[FUserName, 'русский']));
end;

procedure TfMain.tbi1Click(Sender: TObject);
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

end.
