unit TestForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, KVComp_UDataSetPanel,
  Data.DB, MemDS, DBAccess, Uni, DataModule;

type
  TfTest = class(TBaseForm)
    dsTest: TUniDataSource;
    qryTest: TUniQuery;
    tbrTest: TSpTBXToolbar;
    dsp1: TDataSetPanel;
    procedure tbi2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

var
  fTest: TfTest;

implementation

uses
  Common.StrFuncs;

{$R *.dfm}

{ TfTest }

procedure TfTest.AfterConstruction;
begin
  inherited;
  try
    qryTest.Open;
    dsp1.LoadFieldsDef;
  except
    ShowError('Ошибка открытия...');
  end;
end;

procedure TfTest.tbi2Click(Sender: TObject);
begin
  inherited;
  ShowMessage('Изменение записи...');
end;

end.
