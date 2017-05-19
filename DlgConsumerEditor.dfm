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
        Left = 3
        Top = 225
        Width = 62
        Height = 14
        Caption = #1044#1086#1075#1086#1074#1086#1088#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl3: TBevel
        Left = 4
        Top = 240
        Width = 677
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
      object edtNazv: TEdit
        Left = 5
        Top = 20
        Width = 676
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 0
        Text = 'edtNazv'
      end
      object edtAddress: TEdit
        Left = 130
        Top = 53
        Width = 551
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'edtAddress'
      end
      object edtAccount: TEdit
        Left = 130
        Top = 134
        Width = 551
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        Text = 'edtAccount'
      end
      object edtUnn: TEdit
        Left = 130
        Top = 190
        Width = 223
        Height = 22
        TabOrder = 4
        Text = 'edtUnn'
      end
      object edtDogNum: TEdit
        Left = 130
        Top = 253
        Width = 89
        Height = 22
        TabOrder = 5
        Text = 'edtDogNum'
      end
      object dDataDog: TDateEdit
        Left = 244
        Top = 253
        Width = 121
        Height = 22
        DefaultToday = True
        DialogTitle = #1042#1099#1073#1086#1088' '#1076#1072#1090#1099
        GlyphKind = gkCustom
        Glyph.Data = {
          76050000424D760500000000000036000000280000001C0000000C0000000100
          2000000000004005000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF008080800080808000808080008080800080808000808080008080
          800080808000808080008080800080808000FF00FF00FF00FF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FF00FF00FF00FF000000000000000000800000000000
          0000800000008000000000000000800000000000000000000000800000008080
          8000FF00FF008080800080808000808080008080800080808000808080008080
          80008080800080808000808080008080800080808000FFFFFF00FF00FF00FF00
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF008000000080808000FF00FF0080808000FFFFFF00FF00
          FF00FFFFFF00FFFFFF00FFFFFF00FF00FF00FFFFFF00FFFFFF00FFFFFF00FF00
          FF0080808000FFFFFF00FF00FF00FF00FF00FFFFFF0000000000000000000000
          0000FFFFFF00000000000000000000000000C0C0C000FFFFFF00800000008080
          8000FF00FF0080808000FFFFFF00808080008080800080808000FF00FF008080
          80008080800080808000FF00FF00FFFFFF0080808000FFFFFF00FF00FF00FF00
          FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C0C0C000FFFFFF00C0C0
          C00000000000FFFFFF008000000080808000FF00FF0080808000FFFFFF00FF00
          FF0080808000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF0080808000FFFF
          FF0080808000FFFFFF00FF00FF00FF00FF00FFFFFF00FFFFFF0000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00800000008080
          8000FF00FF0080808000FFFFFF00FF00FF0080808000FFFFFF00FF00FF00FF00
          FF00FFFFFF00FFFFFF0080808000FF00FF0080808000FFFFFF00FF00FF00FF00
          FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
          0000C0C0C000FFFFFF008000000080808000FF00FF0080808000FFFFFF00FF00
          FF0080808000FFFFFF00FF00FF00808080008080800080808000FF00FF00FF00
          FF0080808000FFFFFF00FF00FF00FF00FF00FFFFFF000000000000000000FFFF
          FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000008080
          8000FF00FF0080808000FFFFFF008080800080808000FFFFFF00FF00FF008080
          8000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF00FF00FF00FF00
          FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
          000000000000FFFFFF008000000080808000FF00FF0080808000FFFFFF00FF00
          FF0080808000FF00FF00FF00FF0080808000808080008080800080808000FF00
          FF0080808000FFFFFF00FF00FF00FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000008080
          8000FF00FF0080808000FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0080808000FFFFFF00FF00FF00FF00
          FF00FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000FFFFFF008000000080808000FF00FF0080808000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0080808000FFFFFF00FF00FF00FF00FF000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF008080800080808000808080008080800080808000808080008080
          80008080800080808000808080008080800080808000FF00FF00}
        NumGlyphs = 2
        TabOrder = 6
        Text = '18/05/2017'
      end
      object cbBudgetKind: TQueryComboBox
        Left = 492
        Top = 81
        Width = 189
        Height = 22
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        Complete = True
        MinLengthComplete = 0
        Connection = dm.dbConn
        SQL.Strings = (
          'select BudgetKindRefId, BudgetKindName '
          'from BudgetKindRef '
          'order by BudgetKindRefId')
      end
      object cbConsumerKind: TQueryComboBox
        Left = 130
        Top = 80
        Width = 223
        Height = 22
        Style = csDropDownList
        TabOrder = 7
        Complete = True
        MinLengthComplete = 0
        Connection = dm.dbConn
        SQL.Strings = (
          'select ConsumerKindRefId, ConsumerKindName '
          'from ConsumersKindRef '
          'order by ConsumerKindRefId')
      end
      object ceBank: TComboEditDict
        Left = 130
        Top = 162
        Width = 70
        Height = 22
        Hint = #1050#1086#1076' '#1073#1072#1085#1082#1072
        FormCaption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1086#1090#1088#1077#1073#1080#1090#1077#1083#1077#1081
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        Text = ''
        Connection = dm.dbConn
        SQLs.Strings = (
          'select BankId as Code, BankName as Name from Banks')
      end
      object edtBankName: TEditDict
        Left = 206
        Top = 162
        Width = 475
        Height = 22
        Hint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1073#1072#1085#1082#1072
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 2000
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        Text = '?'
        DictSource = ceBank
      end
    end
  end
end
