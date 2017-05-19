inherited fTariffServs: TfTariffServs
  Caption = #1058#1072#1088#1080#1092#1080#1082#1072#1094#1080#1103' '#1074#1080#1076#1086#1074' '#1091#1089#1083#1091#1075
  ClientHeight = 712
  ClientWidth = 834
  ExplicitWidth = 850
  ExplicitHeight = 770
  PixelsPerInch = 96
  TextHeight = 14
  inherited sbMain: TSpTBXStatusBar
    Top = 687
    Width = 834
    inherited SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
      CustomWidth = 641
    end
  end
  inherited dckTop: TSpTBXDock
    Width = 834
    Height = 26
    ExplicitWidth = 834
    ExplicitHeight = 26
    inherited tbrMain: TSpTBXToolbar
      Images = ilMainSmall
      ExplicitWidth = 33
      ExplicitHeight = 26
    end
  end
  object scbMain: TScrollBox [2]
    Left = 0
    Top = 26
    Width = 834
    Height = 661
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 2
    ExplicitTop = 42
    ExplicitHeight = 611
    object pnlView: TPanel
      Left = 0
      Top = 0
      Width = 834
      Height = 661
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 328
      ExplicitTop = 304
      ExplicitWidth = 185
      ExplicitHeight = 41
      object pnlServices: TPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 177
        Align = alTop
        TabOrder = 0
        ExplicitTop = -3
        object grd1: TDBGridEh
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 826
          Height = 169
          Align = alClient
          DynProps = <>
          TabOrder = 0
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object pnlTariffServ: TPanel
        Left = 0
        Top = 180
        Width = 834
        Height = 337
        Align = alClient
        TabOrder = 1
        ExplicitHeight = 157
        object dck1: TSpTBXDock
          Left = 1
          Top = 1
          Width = 832
          Height = 26
          object tbr1: TSpTBXToolbar
            Left = 0
            Top = 0
            Images = ilMainSmall
            TabOrder = 0
            Caption = 'tbr1'
          end
        end
        object grd2: TDBGridEh
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 826
          Height = 303
          Align = alClient
          DynProps = <>
          TabOrder = 1
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object splBottom: TRxSplitter
        Left = 0
        Top = 517
        Width = 834
        Height = 3
        ControlFirst = pnlTariffServ
        ControlSecond = pnlTariffVals
        Align = alBottom
        ParentColor = True
        ExplicitLeft = -16
        ExplicitTop = 346
      end
      object splTop: TRxSplitter
        Left = 0
        Top = 177
        Width = 834
        Height = 3
        ControlFirst = pnlServices
        ControlSecond = pnlTariffServ
        Align = alTop
        ParentColor = True
        ExplicitLeft = -16
        ExplicitTop = 438
      end
      object pnlTariffVals: TPanel
        Left = 0
        Top = 520
        Width = 834
        Height = 141
        Align = alBottom
        TabOrder = 4
        object dck2: TSpTBXDock
          Left = 1
          Top = 1
          Width = 832
          Height = 26
          object tbr2: TSpTBXToolbar
            Left = 0
            Top = 0
            Images = ilMainSmall
            TabOrder = 0
            Caption = 'tbr2'
          end
        end
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
