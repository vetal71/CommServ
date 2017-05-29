unit CountersForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, RxSplit,
  KVComp_UDataSetPanel, Data.DB, DBAccess, Uni, MemDS, DataModule, Vcl.StdCtrls;

type
  TfCounters = class(TBaseForm)
    pnlCounters: TPanel;
    pnlObjects: TPanel;
    pnlHouses: TPanel;
    pnlObject: TPanel;
    spl1: TRxSplitter;
    spl2: TRxSplitter;
    dspCounters: TDataSetPanel;
    dspObjects: TDataSetPanel;
    dspHouses: TDataSetPanel;
    qryCounters: TUniQuery;
    qryObjects: TUniQuery;
    qryHouses: TUniQuery;
    dsHouses: TUniDataSource;
    dsObjects: TUniDataSource;
    dsCounters: TUniDataSource;
    tbrCounters: TSpTBXToolbar;
    tbiAddConsumer: TSpTBXItem;
    tbiEditConsumer: TSpTBXItem;
    tbiDeleteConsumer: TSpTBXItem;
    SpTBXSeparatorItem5: TSpTBXSeparatorItem;
    lblFilterType: TSpTBXLabelItem;
    tbcTypeConsumer: TTBControlItem;
    SpTBXSeparatorItem4: TSpTBXSeparatorItem;
    tbsPrint: TSpTBXSubmenuItem;
    tbiTest: TSpTBXItem;
    SpTBXSeparatorItem6: TSpTBXSeparatorItem;
    tbiFilterExt: TSpTBXItem;
    cbTypeConsumer: TComboBox;
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Common.StrFuncs;

{$R *.dfm}

{ TfCounters }

procedure TfCounters.AfterConstruction;
begin
  inherited;
  //cbTypeConsumer.Items := GetItemsByQuery('ConsumerKindRefId', 'ConsumerKindName', 'ConsumersKindRef', True);
  if qryCounters.Active then
    qryCounters.Close;
  try
    qryCounters.Open;
  except on E: Exception do
    raise Exception.CreateFmt('Ќе удалось получить список приборов учета.'#13'%s', [ E.Message ]);
  end;
//  if qryObjects.Active then
//    qryObjects.Close;
//  try
//    qryObjects.Open;
//  except on E: Exception do
//    raise Exception.CreateFmt('Ќе удалось получить список потребителей.'#13'%s', [ E.Message ]);
//  end;
//  if qryDoma.Active then
//    qryDoma.Close;
//  try
//    qryDoma.Open;
//  except on E: Exception do
//    raise Exception.CreateFmt('Ќе удалось получить список домов жилфонда.'#13'%s', [ E.Message ]);
//  end;
  // построение меню
  BuildMenu(tbrCounters, 0);
end;

end.
