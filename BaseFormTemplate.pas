unit BaseFormTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, TB2Item, SpTBXItem;

type
  TBaseForm = class(TForm)
    MainMenu: TMainMenu;
    miActions: TMenuItem;
    miService: TMenuItem;
    miHelp: TMenuItem;
    sbMain: TSpTBXStatusBar;
    giAuthInfo: TTBGroupItem;
    lblUser: TSpTBXLabelItem;
    lblAuth: TSpTBXLabelItem;
    SpTBXSeparatorItem1: TSpTBXSeparatorItem;
    lbl3: TSpTBXLabelItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBase: TBaseForm;

implementation

{$R *.dfm}

end.
