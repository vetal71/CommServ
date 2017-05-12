inherited fConsumerEditor: TfConsumerEditor
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1077#1081
  ClientHeight = 372
  ClientWidth = 694
  Constraints.MinHeight = 400
  Constraints.MinWidth = 700
  ShowHint = True
  ExplicitWidth = 700
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlButton: TPanel
    Top = 337
    Width = 694
    ExplicitTop = 337
    ExplicitWidth = 694
    DesignSize = (
      694
      35)
    inherited btnCancel: TButton
      Left = 591
      ExplicitLeft = 591
    end
    inherited btnOK: TButton
      Left = 485
      ExplicitLeft = 485
    end
  end
  inherited pnlMain: TPanel
    Width = 688
    Height = 331
    ExplicitWidth = 688
    ExplicitHeight = 331
    object scbMain: TScrollBox
      Left = 1
      Top = 1
      Width = 686
      Height = 329
      VertScrollBar.Style = ssFlat
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 0
      DesignSize = (
        686
        329)
      object lblOrgName: TLabel
        Left = 5
        Top = 3
        Width = 181
        Height = 14
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl1: TBevel
        Left = 4
        Top = 47
        Width = 677
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblAddress: TLabel
        Left = 5
        Top = 56
        Width = 120
        Height = 14
        Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089':'
      end
      object lblTipOrg: TLabel
        Left = 5
        Top = 83
        Width = 105
        Height = 14
        Caption = #1058#1080#1087' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1103':'
      end
      object lblRekv: TLabel
        Left = 5
        Top = 112
        Width = 144
        Height = 14
        Caption = #1055#1083#1072#1090#1077#1078#1085#1099#1077' '#1088#1077#1082#1074#1080#1079#1080#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl2: TBevel
        Left = 4
        Top = 128
        Width = 677
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblDogovor: TLabel
        Left = 5
        Top = 224
        Width = 55
        Height = 14
        Caption = #1044#1086#1075#1086#1074#1086#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl3: TBevel
        Left = 1
        Top = 240
        Width = 680
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblMFO: TLabel
        Left = 5
        Top = 166
        Width = 61
        Height = 14
        Caption = #1050#1086#1076' '#1073#1072#1085#1082#1072':'
      end
      object lbl1: TLabel
        Left = 5
        Top = 137
        Width = 95
        Height = 14
        Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090':'
        FocusControl = edtAccount
      end
      object lbl2: TLabel
        Left = 5
        Top = 193
        Width = 27
        Height = 14
        Caption = #1059#1053#1055':'
        FocusControl = edtUnn
      end
      object lbl3: TLabel
        Left = 59
        Top = 256
        Width = 65
        Height = 14
        Caption = #1044#1086#1075#1086#1074#1086#1088' '#8470
      end
      object lbl4: TLabel
        Left = 359
        Top = 84
        Width = 127
        Height = 14
        Caption = #1058#1080#1087' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103':'
      end
      object lblOt: TLabel
        Left = 225
        Top = 256
        Width = 13
        Height = 14
        Caption = #1086#1090
      end
      object cbMFO: TDBLookupComboBox
        Left = 130
        Top = 162
        Width = 89
        Height = 22
        Hint = #1042#1099#1073#1086#1088' '#1073#1072#1085#1082#1072
        DataField = 'kodbank'
        DataSource = fConsumers.dsOrgs
        KeyField = 'kod_bank'
        ListField = 'kod_bank;nazv_bank'
        ListSource = dsBanks
        TabOrder = 5
      end
      object edtNazv: TRxDBComboEdit
        Left = 5
        Top = 20
        Width = 676
        Height = 22
        DataField = 'nazv'
        DataSource = fConsumers.dsOrgs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ButtonWidth = 0
        Anchors = [akLeft, akTop, akRight]
        NumGlyphs = 1
        ParentFont = False
        TabOrder = 0
      end
      object edtAddress: TRxDBComboEdit
        Left = 130
        Top = 53
        Width = 551
        Height = 22
        DataField = 'adres'
        DataSource = fConsumers.dsOrgs
        ButtonWidth = 0
        Anchors = [akLeft, akTop, akRight]
        NumGlyphs = 1
        TabOrder = 1
      end
      object edtAccount: TRxDBComboEdit
        Left = 130
        Top = 134
        Width = 551
        Height = 22
        DataField = 'rschet'
        DataSource = fConsumers.dsOrgs
        ButtonWidth = 0
        Anchors = [akLeft, akTop, akRight]
        NumGlyphs = 1
        TabOrder = 4
      end
      object edtBankName: TRxDBComboEdit
        Left = 222
        Top = 162
        Width = 459
        Height = 22
        Color = clBtnFace
        DataField = 'bank'
        DataSource = fConsumers.dsOrgs
        Enabled = False
        ButtonWidth = 0
        Anchors = [akLeft, akTop, akRight]
        NumGlyphs = 1
        ReadOnly = True
        TabOrder = 6
      end
      object edtUnn: TRxDBComboEdit
        Left = 130
        Top = 190
        Width = 223
        Height = 22
        DataField = 'unn'
        DataSource = fConsumers.dsOrgs
        ButtonWidth = 0
        NumGlyphs = 1
        TabOrder = 7
      end
      object edtDogNum: TRxDBComboEdit
        Left = 130
        Top = 253
        Width = 89
        Height = 22
        DataField = 'ndog'
        DataSource = fConsumers.dsOrgs
        ButtonWidth = 0
        NumGlyphs = 1
        TabOrder = 8
      end
      object edtDataDog: TDBDateEdit
        Left = 244
        Top = 253
        Width = 121
        Height = 22
        DataField = 'datadog'
        DataSource = fConsumers.dsOrgs
        DefaultToday = True
        DialogTitle = #1042#1099#1073#1086#1088' '#1076#1072#1090#1099
        NumGlyphs = 2
        TabOrder = 9
      end
      object cbTipOrg: TComboBox
        Left = 130
        Top = 80
        Width = 223
        Height = 22
        TabOrder = 2
        Text = 'cbTipOrg'
        Items.Strings = (
          #1041#1102#1076#1078#1077#1090#1085#1072#1103
          #1061#1086#1079#1088#1072#1089#1095#1077#1090#1085#1072#1103
          #1046#1057#1050
          #1046#1057#1050' ('#1041#1043#1057#1061#1040')')
      end
      object cbMin: TComboBox
        Left = 492
        Top = 81
        Width = 189
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        Text = 'cbMin'
        Items.Strings = (
          #1052#1077#1089#1090#1085#1099#1081' '#1041#1102#1076#1078#1077#1090
          #1054#1073#1083#1072#1089#1090#1085#1086#1081' '#1041#1102#1076#1078#1077#1090
          #1056#1077#1089#1087#1091#1073#1083#1080#1082#1072#1085#1089#1082#1080#1081' '#1041#1102#1076#1078#1077#1090
          #1055#1088#1086#1095#1077#1077)
      end
    end
  end
  object qryBanks: TUniQuery
    Connection = dm.dbConn
    SQL.Strings = (
      'select * from bank')
    Left = 404
    Top = 196
  end
  object dsBanks: TUniDataSource
    DataSet = qryBanks
    Left = 458
    Top = 196
  end
end
