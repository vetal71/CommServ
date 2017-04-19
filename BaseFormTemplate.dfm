object BaseForm: TBaseForm
  Left = 0
  Top = 0
  ClientHeight = 397
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TSpTBXStatusBar
    Left = 0
    Top = 372
    Width = 678
    Height = 25
    object giAuthInfo: TTBGroupItem
      object lblAuth: TSpTBXLabelItem
        Caption = #1040#1074#1090#1086#1088#1080#1079#1086#1074#1072#1085':'
        FontSettings.Size = 90
        FontSettings.Style = [fsBold]
      end
      object lblUser: TSpTBXLabelItem
        Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
      end
    end
    object SpTBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object lbl3: TSpTBXLabelItem
      Caption = #1044#1072#1090#1072':'
    end
  end
  object MainMenu: TMainMenu
    Left = 336
    Top = 168
    object miActions: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
    end
    object miService: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
    end
    object miHelp: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
    end
  end
end
