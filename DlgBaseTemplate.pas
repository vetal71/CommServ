unit DlgBaseTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TB2Dock, SpTBXItem, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TDlgBase = class(TForm)
    pnlButton: TPanel;
    pnlMain: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DlgBase: TDlgBase;

implementation

{$R *.dfm}

end.
