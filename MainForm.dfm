inherited fMain: TfMain
  Caption = #1050#1086#1084#1084#1091#1085#1072#1083#1100#1085#1099#1077' '#1091#1089#1083#1091#1075#1080': '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
  ClientHeight = 641
  ClientWidth = 1016
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  ExplicitWidth = 1032
  ExplicitHeight = 699
  PixelsPerInch = 96
  TextHeight = 14
  inherited sbMain: TSpTBXStatusBar
    Top = 616
    Width = 1016
    ExplicitTop = 616
    ExplicitWidth = 1016
    inherited grpInfo: TTBGroupItem
      object grpAuth: TTBGroupItem [0]
        object lblAuthCaption: TSpTBXLabelItem
          Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085':'
          FontSettings.Style = [fsBold]
        end
        object lblUserName: TSpTBXLabelItem
          FontSettings.Color = clHighlight
          FontSettings.Style = [fsBold]
        end
      end
      object SpTBXSeparatorItem4: TSpTBXSeparatorItem [1]
      end
    end
    inherited SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
      CustomWidth = 587
    end
    inherited grpDate: TTBGroupItem
      inherited lblData: TSpTBXLabelItem
        FontSettings.Color = clHighlight
        FontSettings.Style = [fsBold]
      end
    end
    object SpTBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object grpCalcPeriod: TTBGroupItem
      object lblCalcPeriodCaption: TSpTBXLabelItem
        Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1087#1077#1088#1080#1086#1076':'
        FontSettings.Style = [fsBold]
      end
      object lblCalcPeriod: TSpTBXLabelItem
        FontSettings.Color = clHighlight
        FontSettings.Style = [fsBold]
      end
    end
  end
  inherited dckTop: TSpTBXDock
    Width = 1016
    ExplicitWidth = 1016
    inherited tbrMain: TSpTBXToolbar
      ExplicitWidth = 94
      object tbi1: TSpTBXItem [0]
        Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083#1080
        ImageIndex = 1
        OnClick = tbi1Click
      end
      object SpTBXSeparatorItem1: TSpTBXSeparatorItem [1]
      end
    end
  end
  inherited MainMenu: TMainMenu
    Images = ilMainSmall
    inherited miActions: TMenuItem
      Visible = False
      inherited miExit: TMenuItem
        ImageIndex = 0
      end
    end
    object miDictions: TMenuItem [1]
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object miConsumers: TMenuItem
        Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083#1080
        Hint = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1077#1081' '#1091#1089#1083#1091#1075
        ImageIndex = 1
      end
    end
  end
  inherited ilMainLarge: TcxImageList
    FormatVersion = 1
  end
  inherited ilMainSmall: TcxImageList
    FormatVersion = 1
  end
end
