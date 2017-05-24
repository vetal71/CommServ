inherited fTariffValEditor: TfTariffValEditor
  Caption = ''
  ClientHeight = 152
  ClientWidth = 444
  Constraints.MinHeight = 180
  Constraints.MinWidth = 450
  ExplicitWidth = 450
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlButton: TPanel
    Top = 117
    Width = 444
    inherited btnCancel: TButton
      Left = 341
    end
    inherited btnOK: TButton
      Left = 235
    end
  end
  inherited pnlMain: TPanel
    Width = 438
    Height = 111
    object lblDateFrom: TLabel
      Left = 16
      Top = 51
      Width = 73
      Height = 14
      Caption = #1044#1077#1081#1089#1090#1074#1091#1077#1090' '#1089':'
    end
    object lblTariffVal: TLabel
      Left = 16
      Top = 79
      Width = 104
      Height = 14
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1090#1072#1088#1080#1092#1072':'
    end
    object bvl1: TBevel
      Left = 5
      Top = 39
      Width = 428
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 572
    end
    object dDateFrom: TDateEdit
      Left = 168
      Top = 48
      Width = 250
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      NumGlyphs = 2
      TabOrder = 0
      ExplicitWidth = 272
    end
    object edtTariffVal: TCurrencyEdit
      Left = 168
      Top = 76
      Width = 250
      Height = 22
      DecimalPlaces = 4
      DisplayFormat = ',0.0000 '#1088#39'.'#39
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 272
    end
    object edtTariffName: TEdit
      Left = 5
      Top = 9
      Width = 428
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
      TabOrder = 2
      Text = 'edtTariffName'
    end
  end
end
