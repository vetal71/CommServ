unit DlgBaseTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TB2Dock, SpTBXItem, Vcl.ExtCtrls,
  Vcl.StdCtrls, Uni;

type
  TDlgBase = class(TForm)
    pnlButton: TPanel;
    pnlMain: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
  end;

var
  DlgBase: TDlgBase;

implementation

{$R *.dfm}

end.
