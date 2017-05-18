object DlgBase: TDlgBase
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 172
  ClientWidth = 494
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 14
  object pnlButton: TPanel
    Left = 0
    Top = 137
    Width = 494
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      494
      35)
    object btnCancel: TButton
      Left = 391
      Top = 6
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      Left = 285
      Top = 6
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 1
    end
  end
  object pnlMain: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 488
    Height = 131
    Align = alClient
    TabOrder = 1
  end
end
