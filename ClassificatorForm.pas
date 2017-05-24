unit ClassificatorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseFormTemplate, System.ImageList,
  Vcl.ImgList, cxGraphics, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.Menus, SpTBXItem, TB2Dock, TB2Toolbar, TB2Item, Vcl.ComCtrls, RxSplit;

type
  TfClassificator = class(TBaseForm)
    pnlLeft: TPanel;
    pnlRight: TPanel;
    spl1: TRxSplitter;
    tvDict: TTreeView;
    tbr1: TSpTBXToolbar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fClassificator: TfClassificator;

implementation

{$R *.dfm}

end.
