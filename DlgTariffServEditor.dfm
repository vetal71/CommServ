inherited fTariffServEditor: TfTariffServEditor
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlMain: TPanel
    object lblTariffName: TLabel
      Left = 10
      Top = 47
      Width = 146
      Height = 14
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1072#1088#1080#1092#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object bvl1: TBevel
      Left = 5
      Top = 39
      Width = 479
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object lblVAT: TLabel
      Left = 10
      Top = 99
      Width = 96
      Height = 14
      Caption = #1059#1095#1077#1090' '#1053#1044#1057' '#1074' '#1094#1077#1085#1077
    end
    object edtTariffName: TEdit
      Left = 10
      Top = 65
      Width = 468
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
    end
    object edtServiceName: TEdit
      Left = 10
      Top = 11
      Width = 468
      Height = 22
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Text = 'edtServiceName'
    end
    object cbVAT: TQueryComboBox
      Left = 120
      Top = 96
      Width = 358
      Height = 22
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Complete = True
      MinLengthComplete = 0
      Connection = dm.dbConn
      SQL.Strings = (
        'select VatID as Code, VatName as Name from VatsRef'
        'order by VatID')
    end
  end
end
