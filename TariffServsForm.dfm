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
    ExplicitTop = 702
    ExplicitWidth = 834
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
      Left = 79
      Images = ilMainSmall
      ExplicitLeft = 79
      ExplicitWidth = 33
      ExplicitHeight = 26
    end
    object tbrServices: TSpTBXToolbar
      Left = 0
      Top = 0
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      Images = ilMainSmall
      TabOrder = 1
      Caption = #1042#1080#1076#1099' '#1091#1089#1083#1091#1075
      object tbiAddService: TSpTBXItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Enabled = False
        ImageIndex = 4
      end
      object tbiEditService: TSpTBXItem
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        ImageIndex = 3
        OnClick = tbiEditServiceClick
      end
      object tbiDelService: TSpTBXItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Enabled = False
        ImageIndex = 2
      end
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
    object pnlView: TPanel
      Left = 0
      Top = 0
      Width = 834
      Height = 661
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnlServices: TPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 177
        Align = alTop
        TabOrder = 0
        object dspServices: TDataSetPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 826
          Height = 169
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DataSource = dsServices
          Title = #1042#1080#1076#1099' '#1091#1089#1083#1091#1075
          Toolbar = tbrServices
          OnGridDblClick = tbiEditServiceClick
          FGrid = {
            54504630095444424772696445680447726964044C656674020003546F700214
            055769647468033A030648656967687403950005416C69676E0708616C436C69
            656E741B436F6C756D6E44656656616C7565732E456E64456C6C697073697309
            1F436F6C756D6E44656656616C7565732E5469746C652E416C69676E6D656E74
            0708746143656E74657221436F6C756D6E44656656616C7565732E5469746C65
            2E456E64456C6C69707369730921436F6C756D6E44656656616C7565732E5469
            746C652E5469746C65427574746F6E091E436F6C756D6E44656656616C756573
            2E5469746C652E546F6F6C546970730918436F6C756D6E44656656616C756573
            2E546F6F6C54697073090A44617461536F757263650717665461726966665365
            7276732E647353657276696365730844796E50726F70730E00074F7074696F6E
            730B0864675469746C65730B6467496E64696361746F720E6467436F6C756D6E
            526573697A650A6467436F6C4C696E65730A6467526F774C696E657306646754
            6162730F6467436F6E6669726D44656C6574650E646743616E63656C4F6E4578
            697400094F7074696F6E7345680B0A6467684669786564334411646768486967
            686C69676874466F63757311646768436C65617253656C656374696F6E126467
            684175746F536F72744D61726B696E670C646768496E63536561726368126467
            68507265666572496E635365617263680D6467684469616C6F6746696E640F64
            6768436F6C756D6E526573697A650D646768436F6C756D6E4D6F766512646768
            457874656E64566572744C696E65730009536F72744C6F63616C09085461624F
            726465720200001854526F7744657461696C50616E656C436F6E74726F6C4568
            0D526F7744657461696C44617461000000}
          FStorage = {
            5450463011544669656C647344656653746F72616765000B53746F726167654E
            616D65060A666C646465662E696E690C53746F72616765546F70696306085345
            5256494345530000}
        end
      end
      object pnlTariffServ: TPanel
        Left = 0
        Top = 180
        Width = 834
        Height = 337
        Align = alClient
        TabOrder = 1
        object dckTariffServ: TSpTBXDock
          Left = 1
          Top = 1
          Width = 832
          Height = 26
          object tbrTariffServ: TSpTBXToolbar
            Left = 0
            Top = 0
            Images = ilMainSmall
            TabOrder = 0
            Caption = #1042#1080#1076#1099' '#1091#1089#1083#1091#1075
            object tbiAddTariff: TSpTBXItem
              Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              ImageIndex = 4
              OnClick = tbiAddTariffClick
            end
            object tbiEditTariff: TSpTBXItem
              Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              ImageIndex = 3
              OnClick = tbiEditTariffClick
            end
            object tbiDelTariff: TSpTBXItem
              Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              ImageIndex = 2
            end
          end
        end
        object dspTariffServ: TDataSetPanel
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 826
          Height = 303
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          DataSource = dsTariffServ
          Title = #1042#1080#1076#1099' '#1090#1072#1088#1080#1092#1086#1074
          Toolbar = tbrTariffServ
          OnGridDblClick = tbiEditTariffClick
          FGrid = {
            54504630095444424772696445680447726964044C656674020003546F700214
            055769647468033A0306486569676874031B0105416C69676E0708616C436C69
            656E741B436F6C756D6E44656656616C7565732E456E64456C6C697073697309
            1F436F6C756D6E44656656616C7565732E5469746C652E416C69676E6D656E74
            0708746143656E74657221436F6C756D6E44656656616C7565732E5469746C65
            2E456E64456C6C69707369730921436F6C756D6E44656656616C7565732E5469
            746C652E5469746C65427574746F6E091E436F6C756D6E44656656616C756573
            2E5469746C652E546F6F6C546970730918436F6C756D6E44656656616C756573
            2E546F6F6C54697073090A44617461536F757263650719665461726966665365
            7276732E6473546172696666536572760844796E50726F70730E00074F707469
            6F6E730B0864675469746C65730B6467496E64696361746F720E6467436F6C75
            6D6E526573697A650A6467436F6C4C696E65730A6467526F774C696E65730664
            67546162730F6467436F6E6669726D44656C6574650E646743616E63656C4F6E
            4578697400094F7074696F6E7345680B0A646768466978656433441164676848
            6967686C69676874466F63757311646768436C65617253656C656374696F6E12
            6467684175746F536F72744D61726B696E670C646768496E6353656172636812
            646768507265666572496E635365617263680D6467684469616C6F6746696E64
            0F646768436F6C756D6E526573697A650D646768436F6C756D6E4D6F76651264
            6768457874656E64566572744C696E65730009536F72744C6F63616C09085461
            624F726465720200001854526F7744657461696C50616E656C436F6E74726F6C
            45680D526F7744657461696C44617461000000}
          FStorage = {
            5450463011544669656C647344656653746F72616765000B53746F726167654E
            616D65060A666C646465662E696E690000}
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
      end
      object pnlTariffVals: TPanel
        Left = 0
        Top = 520
        Width = 834
        Height = 141
        Align = alBottom
        TabOrder = 4
        object dckTariffVal: TSpTBXDock
          Left = 1
          Top = 1
          Width = 832
          Height = 26
          object tbrTariffVal: TSpTBXToolbar
            Left = 0
            Top = 0
            Images = ilMainSmall
            TabOrder = 0
            Caption = #1042#1080#1076#1099' '#1091#1089#1083#1091#1075
            object tbiAddTariffVal: TSpTBXItem
              Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              ImageIndex = 4
            end
            object tbiEditTariffVal: TSpTBXItem
              Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              ImageIndex = 3
            end
            object tbiDelTariffVal: TSpTBXItem
              Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
              ImageIndex = 2
            end
            object SpTBXSeparatorItem1: TSpTBXSeparatorItem
            end
            object tbcFilterActual: TTBControlItem
              Control = chkActual
            end
            object chkActual: TCheckBox
              Left = 75
              Top = 2
              Width = 150
              Height = 17
              Caption = #1058#1086#1083#1100#1082#1086' '#1076#1077#1081#1089#1090#1074#1091#1102#1097#1080#1077
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = chkActualClick
            end
          end
        end
        object dspTariffVal: TDataSetPanel
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 826
          Height = 107
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          DataSource = dsTariffVal
          Title = #1058#1072#1088#1080#1092#1099
          Toolbar = tbrTariffVal
          FGrid = {
            54504630095444424772696445680447726964044C656674020003546F700214
            055769647468033A0306486569676874025705416C69676E0708616C436C6965
            6E741B436F6C756D6E44656656616C7565732E456E64456C6C6970736973091F
            436F6C756D6E44656656616C7565732E5469746C652E416C69676E6D656E7407
            08746143656E74657221436F6C756D6E44656656616C7565732E5469746C652E
            456E64456C6C69707369730921436F6C756D6E44656656616C7565732E546974
            6C652E5469746C65427574746F6E091E436F6C756D6E44656656616C7565732E
            5469746C652E546F6F6C546970730918436F6C756D6E44656656616C7565732E
            546F6F6C54697073090A44617461536F75726365071866546172696666536572
            76732E647354617269666656616C0844796E50726F70730E00074F7074696F6E
            730B0864675469746C65730B6467496E64696361746F720E6467436F6C756D6E
            526573697A650A6467436F6C4C696E65730A6467526F774C696E657306646754
            6162730F6467436F6E6669726D44656C6574650E646743616E63656C4F6E4578
            697400094F7074696F6E7345680B0A6467684669786564334411646768486967
            686C69676874466F63757311646768436C65617253656C656374696F6E126467
            684175746F536F72744D61726B696E670C646768496E63536561726368126467
            68507265666572496E635365617263680D6467684469616C6F6746696E640F64
            6768436F6C756D6E526573697A650D646768436F6C756D6E4D6F766512646768
            457874656E64566572744C696E65730009536F72744C6F63616C09085461624F
            726465720200001854526F7744657461696C50616E656C436F6E74726F6C4568
            0D526F7744657461696C44617461000000}
          FStorage = {
            5450463011544669656C647344656653746F72616765000B53746F726167654E
            616D65060A666C646465662E696E690C53746F72616765546F70696306095441
            5249464656414C0000}
        end
      end
    end
  end
  inherited MainActionList: TActionList
    Left = 256
    Top = 168
  end
  inherited ilMainLarge: TcxImageList
    FormatVersion = 1
  end
  inherited ilMainSmall: TcxImageList
    FormatVersion = 1
  end
  object dsServices: TUniDataSource
    DataSet = qryServices
    Left = 456
    Top = 98
  end
  object qryServices: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO ServiceKindRef'
      '  (ServiceKindName)'
      'VALUES'
      '  (:ServiceKindName)'
      'SET :ServiceKindRefId = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM ServiceKindRef'
      'WHERE'
      '  ServiceKindRefId = :Old_ServiceKindRefId')
    SQLUpdate.Strings = (
      'UPDATE ServiceKindRef'
      'SET'
      '  ServiceKindName = :ServiceKindName'
      'WHERE'
      '  ServiceKindRefId = :Old_ServiceKindRefId')
    SQLLock.Strings = (
      'SELECT * FROM ServiceKindRef'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ServiceKindRefId = :Old_ServiceKindRefId')
    SQLRefresh.Strings = (
      'SELECT ServiceKindName FROM ServiceKindRef'
      'WHERE'
      '  ServiceKindRefId = :ServiceKindRefId')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM ServiceKindRef'
      ')')
    Connection = dm.dbConn
    SQL.Strings = (
      'select * from ServiceKindRef'
      'order by ServiceKindRefId')
    AfterOpen = qryServicesAfterOpen
    Left = 392
    Top = 98
  end
  object dsTariffServ: TUniDataSource
    DataSet = qryTariffServ
    Left = 448
    Top = 368
  end
  object qryTariffServ: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO TariffServs'
      '  (ServId, ServTitle, ServiceKindId, VatID)'
      'VALUES'
      '  (:ServId, :ServTitle, :ServiceKindId, :VatID)')
    SQLDelete.Strings = (
      'DELETE FROM TariffServs'
      'WHERE'
      '  ServId = :Old_ServId')
    SQLUpdate.Strings = (
      'UPDATE TariffServs'
      'SET'
      
        '  ServId = :ServId, ServTitle = :ServTitle, ServiceKindId = :Ser' +
        'viceKindId, VatID = :VatID'
      'WHERE'
      '  ServId = :Old_ServId')
    SQLLock.Strings = (
      'SELECT * FROM TariffServs'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ServId = :Old_ServId')
    SQLRefresh.Strings = (
      'SELECT ServId, ServTitle, ServiceKindId, VatID FROM TariffServs'
      'WHERE'
      '  ServId = :ServId')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM TariffServs'
      ')')
    Connection = dm.dbConn
    SQL.Strings = (
      'select ts.*, vr.* from TariffServs ts, VatsRef vr'
      'where vr.VatId = ts.VatId'
      'order by ts.ServId')
    MasterSource = dsServices
    MasterFields = 'ServiceKindRefId'
    DetailFields = 'ServiceKindId'
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    AfterOpen = qryTariffServAfterOpen
    Left = 368
    Top = 368
    ParamData = <
      item
        DataType = ftString
        Name = 'ServiceKindRefId'
        Value = nil
      end>
  end
  object qryTariffVal: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO TariffServsVal'
      '  (ServId, DateFrom, Value)'
      'VALUES'
      '  (:ServId, :DateFrom, :Value)')
    SQLDelete.Strings = (
      'DELETE FROM TariffServsVal'
      'WHERE'
      '  ServId = :Old_ServId AND DateFrom = :Old_DateFrom')
    SQLUpdate.Strings = (
      'UPDATE TariffServsVal'
      'SET'
      '  ServId = :ServId, DateFrom = :DateFrom, Value = :Value'
      'WHERE'
      '  ServId = :Old_ServId AND DateFrom = :Old_DateFrom')
    SQLLock.Strings = (
      'SELECT * FROM TariffServsVal'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ServId = :Old_ServId AND DateFrom = :Old_DateFrom')
    SQLRefresh.Strings = (
      'SELECT ServId, DateFrom, Value FROM TariffServsVal'
      'WHERE'
      '  ServId = :ServId AND DateFrom = :DateFrom')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM TariffServsVal'
      ')')
    Connection = dm.dbConn
    SQL.Strings = (
      'select &Limit * from TariffServsVal'
      'order by DateFrom Desc')
    MasterSource = dsTariffServ
    MasterFields = 'ServId'
    DetailFields = 'ServId'
    AfterOpen = qryTariffValAfterOpen
    Left = 312
    Top = 616
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ServId'
        Value = nil
      end>
    MacroData = <
      item
        Name = 'Limit'
      end>
  end
  object dsTariffVal: TUniDataSource
    DataSet = qryTariffVal
    Left = 376
    Top = 616
  end
end
