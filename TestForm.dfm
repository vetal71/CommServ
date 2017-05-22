inherited fTest: TfTest
  Caption = 'fTest'
  ClientHeight = 586
  ClientWidth = 795
  ExplicitWidth = 811
  ExplicitHeight = 644
  PixelsPerInch = 96
  TextHeight = 14
  inherited sbMain: TSpTBXStatusBar
    Top = 561
    Width = 795
    ExplicitTop = 576
    ExplicitWidth = 795
    inherited SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
      CustomWidth = 602
    end
  end
  inherited dckTop: TSpTBXDock
    Width = 795
    Height = 26
    ExplicitWidth = 795
    ExplicitHeight = 26
    inherited tbrMain: TSpTBXToolbar
      Left = 79
      Images = ilMainSmall
      ExplicitLeft = 79
      ExplicitWidth = 33
      ExplicitHeight = 26
    end
    object tbrTest: TSpTBXToolbar
      Left = 0
      Top = 0
      Images = ilMainSmall
      TabOrder = 1
      Caption = 'tbrTest'
      object tbi3: TSpTBXItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Enabled = False
        ImageIndex = 4
      end
      object tbi2: TSpTBXItem
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        ImageIndex = 3
        OnClick = tbi2Click
      end
      object tbi1: TSpTBXItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Enabled = False
        ImageIndex = 2
      end
    end
  end
  object dsp1: TDataSetPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Width = 789
    Height = 529
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    DataSource = dsTest
    Title = #1041#1072#1085#1082#1080
    Toolbar = tbrTest
    FGrid = {
      54504630095444424772696445680447726964044C656674020003546F700215
      0557696474680315030648656967687403FC0105416C69676E0708616C436C69
      656E741F436F6C756D6E44656656616C7565732E5469746C652E416C69676E6D
      656E740708746143656E7465720A44617461536F75726365070C66546573742E
      6473546573740844796E50726F70730E00074F7074696F6E730B086467546974
      6C65730B6467496E64696361746F720E6467436F6C756D6E526573697A650A64
      67436F6C4C696E65730A6467526F774C696E6573066467546162730F6467436F
      6E6669726D44656C6574650E646743616E63656C4F6E4578697400094F707469
      6F6E7345680B0A6467684669786564334411646768486967686C69676874466F
      63757311646768436C65617253656C656374696F6E126467684175746F536F72
      744D61726B696E670C646768496E635365617263681264676850726566657249
      6E635365617263680D6467684469616C6F6746696E640F646768436F6C756D6E
      526573697A650D646768436F6C756D6E4D6F766512646768457874656E645665
      72744C696E657300085461624F726465720200001854526F7744657461696C50
      616E656C436F6E74726F6C45680D526F7744657461696C44617461000000}
    FStorage = {
      5450463011544669656C647344656653746F72616765000B53746F726167654E
      616D65060A666C646465662E696E690C53746F72616765546F70696306045445
      53540000}
  end
  inherited ilMainLarge: TcxImageList
    FormatVersion = 1
  end
  inherited ilMainSmall: TcxImageList
    FormatVersion = 1
  end
  object dsTest: TUniDataSource
    DataSet = qryTest
    Left = 382
    Top = 312
  end
  object qryTest: TUniQuery
    Connection = dm.dbConn
    SQL.Strings = (
      'select * from Banks')
    Left = 336
    Top = 312
  end
end
