inherited fServiceEditor: TfServiceEditor
  Caption = 'fServiceEditor'
  ClientHeight = 122
  Constraints.MinHeight = 150
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlButton: TPanel
    Top = 87
  end
  inherited pnlMain: TPanel
    Height = 81
    object lblServiceName: TLabel
      Left = 10
      Top = 11
      Width = 128
      Height = 14
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1091#1089#1083#1091#1075#1080':'
    end
    object edtServiceName: TEdit
      Left = 10
      Top = 29
      Width = 467
      Height = 22
      TabOrder = 0
    end
  end
end
