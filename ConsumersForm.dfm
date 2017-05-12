inherited fConsumers: TfConsumers
  Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1077#1081
  ClientHeight = 687
  ClientWidth = 812
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  ExplicitWidth = 828
  ExplicitHeight = 745
  PixelsPerInch = 96
  TextHeight = 14
  inherited sbMain: TSpTBXStatusBar
    Top = 662
    Width = 812
    ExplicitTop = 677
    ExplicitWidth = 812
    inherited SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
      CustomWidth = 619
    end
  end
  inherited dckTop: TSpTBXDock
    Width = 812
    ExplicitWidth = 812
    inherited tbrMain: TSpTBXToolbar
      Left = 432
      ExplicitLeft = 432
    end
    object tbrConsumers: TSpTBXToolbar
      Left = 0
      Top = 0
      ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
      DockPos = -6
      Images = ilMainLarge
      ShowCaption = False
      TabOrder = 1
      Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074' "'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081'"'
      Customizable = False
      object tbiAddConsumer: TSpTBXItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        ImageIndex = 4
        OnClick = actAddConsumerExecute
      end
      object tbiEditConsumer: TSpTBXItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
        ImageIndex = 3
        Images = ilMainLarge
        OnClick = actEditConsumerExecute
      end
      object tbiDeleteConsumer: TSpTBXItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        ImageIndex = 2
        Images = ilMainLarge
      end
      object SpTBXSeparatorItem5: TSpTBXSeparatorItem
      end
      object lblFilterType: TSpTBXLabelItem
        Caption = #1054#1090#1073#1086#1088': '
      end
      object tbcTypeConsumer: TTBControlItem
        Control = cbTypeConsumer
      end
      object SpTBXSeparatorItem4: TSpTBXSeparatorItem
      end
      object tbsPrint: TSpTBXSubmenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        Hint = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1086#1074
        ImageIndex = 6
        DropdownCombo = True
      end
      object SpTBXSeparatorItem6: TSpTBXSeparatorItem
      end
      object tbiFilterExt: TSpTBXItem
        Caption = #1060#1080#1083#1100#1090#1088
        Hint = #1042#1082#1083'./'#1042#1099#1082#1083' '#1089#1090#1088#1086#1082#1091' '#1088#1072#1089#1096#1080#1088#1077#1085#1085#1086#1075#1086' '#1092#1080#1083#1100#1090#1088#1072
        AutoCheck = True
        ImageIndex = 7
        OnClick = actFilterConsumerExecute
      end
      object cbTypeConsumer: TComboBox
        Left = 174
        Top = 8
        Width = 145
        Height = 22
        ItemIndex = 0
        TabOrder = 0
        Text = '('#1042#1089#1077')'
        Items.Strings = (
          '('#1042#1089#1077')'
          #1041#1102#1076#1078#1077#1090#1085#1099#1077
          #1061#1086#1079#1088#1072#1089#1095#1077#1090#1085#1099#1077
          #1046#1057#1050
          #1046#1057#1050' ('#1041#1043#1057#1061#1040')')
      end
    end
  end
  object pnlView: TPanel [2]
    Left = 0
    Top = 42
    Width = 812
    Height = 620
    Align = alClient
    TabOrder = 2
    object pnlOrg: TPanel
      Left = 1
      Top = 1
      Width = 810
      Height = 263
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object grdConsumers: TDBGridEh
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 804
        Height = 257
        Align = alClient
        AutoFitColWidths = True
        ColumnDefValues.Title.Alignment = taCenter
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataSource = dsOrgs
        DynProps = <>
        EvenRowColor = 16776176
        GridLineParams.ColorScheme = glcsFlatEh
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
        PopupMenu = pmConsumers
        SortLocal = True
        STFilter.Local = True
        TabOrder = 0
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'kodorg'
            Footers = <>
            Title.Caption = #1050#1086#1076
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'nazv'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
            Width = 450
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'adres'
            Footers = <>
            Title.Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
            Width = 300
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object splMain: TRxSplitter
      Left = 1
      Top = 264
      Width = 810
      Height = 4
      ControlFirst = pnlOrg
      ControlSecond = pnlObjects
      Align = alTop
    end
    object pnlObjects: TPanel
      Left = 1
      Top = 268
      Width = 810
      Height = 351
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object dckObject: TSpTBXDock
        Left = 0
        Top = 0
        Width = 810
        Height = 42
        object tbrObjects: TSpTBXToolbar
          Left = 0
          Top = 0
          ChevronHint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086'|'
          Images = ilMainLarge
          ShowCaption = False
          TabOrder = 0
          Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074' "'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1086#1074'"'
          Customizable = False
          DisplayMode = tbdmImageOnly
          object tbiAddObject: TSpTBXItem
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
            Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
            ImageIndex = 4
            Images = ilMainLarge
          end
          object tbiEditObject: TSpTBXItem
            Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
            Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
            ImageIndex = 3
            Images = ilMainLarge
          end
          object tbiDeleteObject: TSpTBXItem
            Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
            Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
            ImageIndex = 2
            Images = ilMainLarge
          end
          object SpTBXSeparatorItem1: TSpTBXSeparatorItem
          end
          object tbiHistoryAttrs: TSpTBXItem
            Caption = #1048#1089#1090#1086#1088#1080#1103
            Hint = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1072#1090#1088#1080#1073#1091#1090#1086#1074
            ImageIndex = 5
            Images = ilMainLarge
          end
          object SpTBXSeparatorItem7: TSpTBXSeparatorItem
          end
          object tbiFilterExtObject: TSpTBXItem
            Caption = #1060#1080#1083#1100#1090#1088
            Hint = #1042#1082#1083'./'#1042#1099#1082#1083' '#1089#1090#1088#1086#1082#1091' '#1088#1072#1089#1096#1080#1088#1077#1085#1085#1086#1075#1086' '#1092#1080#1083#1100#1090#1088#1072
            AutoCheck = True
            ImageIndex = 7
            OnClick = actFilterObjectExecute
          end
        end
      end
      object grdObjects: TDBGridEh
        AlignWithMargins = True
        Left = 3
        Top = 45
        Width = 804
        Height = 303
        Align = alClient
        AutoFitColWidths = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataSource = dsObjects
        DynProps = <>
        EvenRowColor = clMoneyGreen
        GridLineParams.ColorScheme = glcsFlatEh
        PopupMenu = pmObjects
        TabOrder = 1
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'kodobk'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'nazv'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1103
            Width = 450
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'q'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Q'#1086#1090'.'
            Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1072#1103' '#1085#1072#1075#1088#1091#1079#1082#1072' '#1085#1072' '#1086#1090#1086#1087#1083#1077#1085#1080#1077' ('#1082#1082#1072#1083'/'#1084'2)'
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'qv'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Q'#1093'.'#1074'.'
            Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1099#1081' '#1088#1072#1089#1093#1086#1076' '#1085#1072' '#1074#1086#1076#1086#1089#1085#1072#1073#1078#1077#1085#1080#1077
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'qk'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Q'#1082#1072#1085'.'
            Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1099#1081' '#1088#1072#1089#1093#1086#1076' '#1085#1072' '#1074#1086#1076#1086#1086#1090#1074#1077#1076#1077#1085#1080#1077
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'qg'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'Q'#1084'.'
            Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1099#1081' '#1086#1073#1098#1077#1084' '#1058#1041#1054
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited MainMenu: TMainMenu
    inherited miActions: TMenuItem
      object miConsumers: TMenuItem [0]
        Caption = #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083#1080
        object miAddConsumer: TMenuItem
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        end
        object miEditConsumer: TMenuItem
          Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
        end
        object miDeleteConsumer: TMenuItem
          Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        end
        object miN7: TMenuItem
          Caption = '-'
        end
        object miPrint: TMenuItem
          Caption = #1055#1077#1095#1072#1090#1100
        end
        object miN5: TMenuItem
          Caption = '-'
        end
        object miFilterConsumer: TMenuItem
          AutoCheck = True
          Caption = #1060#1080#1083#1100#1090#1088
          OnClick = actFilterConsumerExecute
        end
      end
      object miObjects: TMenuItem [1]
        Caption = #1054#1073#1098#1077#1082#1090#1099
        object miAddObject: TMenuItem
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        end
        object miEditObject: TMenuItem
          Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
        end
        object miDeleteObject: TMenuItem
          Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        end
        object miN13: TMenuItem
          Caption = '-'
        end
        object miHistoryAttrs: TMenuItem
          Caption = #1048#1089#1090#1086#1088#1080#1103
        end
        object miN15: TMenuItem
          Caption = '-'
        end
        object miFilterObject: TMenuItem
          AutoCheck = True
          Caption = #1060#1080#1083#1100#1090#1088
          OnClick = actFilterObjectExecute
        end
      end
      object miN1: TMenuItem [2]
        Caption = '-'
      end
    end
  end
  inherited MainActionList: TActionList
    object actAddConsumer: TAction
      Category = 'Consumers'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1103
      OnExecute = actAddConsumerExecute
    end
    object actFilterConsumer: TAction
      Category = 'Consumers'
      Caption = 'actFilterConsumer'
      OnExecute = actFilterConsumerExecute
    end
    object actEditConsumer: TAction
      Category = 'Consumers'
      Caption = 'actEditConsumer'
      OnExecute = actEditConsumerExecute
    end
    object actDelConsumer: TAction
      Category = 'Consumers'
      Caption = 'actDelConsumer'
    end
    object actAddObject: TAction
      Category = 'Objects'
      Caption = 'actAddObject'
    end
    object actEditObject: TAction
      Category = 'Objects'
      Caption = 'actEditObject'
    end
    object actDelObject: TAction
      Category = 'Objects'
      Caption = 'actDelObject'
    end
    object actHistory: TAction
      Category = 'Objects'
      Caption = 'actHistory'
    end
    object actFilterObject: TAction
      Category = 'Objects'
      Caption = 'actFilterObject'
      OnExecute = actFilterObjectExecute
    end
  end
  inherited ilMainLarge: TcxImageList
    FormatVersion = 1
  end
  inherited ilMainSmall: TcxImageList
    FormatVersion = 1
  end
  object qryOrgs: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO org'
      
        '  (nazv, adres, bank, rschet, unn, tiporg, datadog, ndog, [_min]' +
        ', tipbud, kodbank, data_per)'
      'VALUES'
      
        '  (:nazv, :adres, :bank, :rschet, :unn, :tiporg, :datadog, :ndog' +
        ', :[_min], :tipbud, :kodbank, :data_per)'
      'SET :kodorg = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM org'
      'WHERE'
      '  kodorg = :Old_kodorg')
    SQLUpdate.Strings = (
      'UPDATE org'
      'SET'
      
        '  nazv = :nazv, adres = :adres, bank = :bank, rschet = :rschet, ' +
        'unn = :unn, tiporg = :tiporg, datadog = :datadog, ndog = :ndog, ' +
        '[_min] = :[_min], tipbud = :tipbud, kodbank = :kodbank, data_per' +
        ' = :data_per'
      'WHERE'
      '  kodorg = :Old_kodorg')
    SQLLock.Strings = (
      'SELECT * FROM org'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  kodorg = :Old_kodorg')
    SQLRefresh.Strings = (
      
        'SELECT nazv, adres, bank, rschet, unn, tiporg, datadog, ndog, [_' +
        'min], tipbud, kodbank, data_per FROM org'
      'WHERE'
      '  kodorg = :kodorg')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM org'
      ')')
    Connection = dm.dbConn
    SQL.Strings = (
      'select * from org'
      'order by kodorg')
    Left = 336
    Top = 224
  end
  object dsOrgs: TUniDataSource
    DataSet = qryOrgs
    Left = 392
    Top = 224
  end
  object qryObjects: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO obekt'
      
        '  (kodorg, nazv, ngvs, kodkot, kodtt, nds, ecnal, nalprib, nalpr' +
        'ibgv, kodpr, prin, q, t, prj, prjl, spl, spll, podkl, v, rasch, ' +
        'kodtv, podklv, qv, qk, podklgv, data_per, kodtg, podklg, qg, Loc' +
        'alityId)'
      'VALUES'
      
        '  (:kodorg, :nazv, :ngvs, :kodkot, :kodtt, :nds, :ecnal, :nalpri' +
        'b, :nalpribgv, :kodpr, :prin, :q, :t, :prj, :prjl, :spl, :spll, ' +
        ':podkl, :v, :rasch, :kodtv, :podklv, :qv, :qk, :podklgv, :data_p' +
        'er, :kodtg, :podklg, :qg, :LocalityId)'
      'SET :kodobk = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM obekt'
      'WHERE'
      '  kodobk = :Old_kodobk')
    SQLUpdate.Strings = (
      'UPDATE obekt'
      'SET'
      
        '  kodorg = :kodorg, nazv = :nazv, ngvs = :ngvs, kodkot = :kodkot' +
        ', kodtt = :kodtt, nds = :nds, ecnal = :ecnal, nalprib = :nalprib' +
        ', nalpribgv = :nalpribgv, kodpr = :kodpr, prin = :prin, q = :q, ' +
        't = :t, prj = :prj, prjl = :prjl, spl = :spl, spll = :spll, podk' +
        'l = :podkl, v = :v, rasch = :rasch, kodtv = :kodtv, podklv = :po' +
        'dklv, qv = :qv, qk = :qk, podklgv = :podklgv, data_per = :data_p' +
        'er, kodtg = :kodtg, podklg = :podklg, qg = :qg, LocalityId = :Lo' +
        'calityId'
      'WHERE'
      '  kodobk = :Old_kodobk')
    SQLLock.Strings = (
      'SELECT * FROM obekt'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  kodobk = :Old_kodobk')
    SQLRefresh.Strings = (
      
        'SELECT kodorg, nazv, ngvs, kodkot, kodtt, nds, ecnal, nalprib, n' +
        'alpribgv, kodpr, prin, q, t, prj, prjl, spl, spll, podkl, v, ras' +
        'ch, kodtv, podklv, qv, qk, podklgv, data_per, kodtg, podklg, qg,' +
        ' LocalityId FROM obekt'
      'WHERE'
      '  kodobk = :kodobk')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM obekt'
      ')')
    Connection = dm.dbConn
    SQL.Strings = (
      'select * from obekt'
      'order by kodobk')
    MasterSource = dsOrgs
    MasterFields = 'kodorg'
    DetailFields = 'kodorg'
    Left = 336
    Top = 360
    ParamData = <
      item
        DataType = ftInteger
        Name = 'kodorg'
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsObjects: TUniDataSource
    DataSet = qryObjects
    Left = 392
    Top = 360
  end
  object pmObjects: TSpTBXPopupMenu
    Left = 305
    Top = 446
  end
  object pmConsumers: TSpTBXPopupMenu
    Left = 409
    Top = 446
  end
end
