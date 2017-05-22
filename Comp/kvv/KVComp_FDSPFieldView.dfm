object FieldViewDialog: TFieldViewDialog
  Left = 473
  Top = 124
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1086#1083#1077#1081
  ClientHeight = 225
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 482
    Height = 181
    Caption = #1055#1086#1083#1103' '#1085#1072#1073#1086#1088#1072' '#1076#1072#1085#1085#1099#1093
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object Label1: TLabel
      Left = 212
      Top = 19
      Width = 53
      Height = 13
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
    end
    object Label2: TLabel
      Left = 215
      Top = 51
      Width = 67
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072' '#1087#1086#1083#1103
    end
    object Label3: TLabel
      Left = 215
      Top = 83
      Width = 119
      Height = 13
      Caption = #1052#1072#1089#1082#1072' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103
    end
    object lbFields: TListBox
      Left = 8
      Top = 16
      Width = 198
      Height = 153
      ItemHeight = 13
      TabOrder = 0
      OnClick = lbFieldsClick
    end
    object edLabel: TEdit
      Left = 286
      Top = 16
      Width = 185
      Height = 21
      TabOrder = 1
      Text = 'edLabel'
      OnChange = edLabelChange
    end
    object edWidth: TEdit
      Left = 342
      Top = 48
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '1'
      OnExit = edWidthExit
    end
    object udWidth: TUpDown
      Left = 383
      Top = 48
      Width = 15
      Height = 21
      Associate = edWidth
      Min = 1
      Max = 120
      Position = 1
      TabOrder = 3
      OnClick = udWidthClick
    end
    object edMask: TEdit
      Left = 342
      Top = 80
      Width = 129
      Height = 21
      TabOrder = 4
      Text = 'edMask'
      OnChange = edMaskChange
    end
    object cbVisible: TCheckBox
      Left = 215
      Top = 112
      Width = 97
      Height = 17
      Alignment = taLeftJustify
      Caption = #1042#1080#1076#1080#1084#1086#1077' '#1087#1086#1083#1077
      TabOrder = 5
      OnClick = cbVisibleClick
    end
  end
  object btnClose: TButton
    Left = 415
    Top = 192
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object btnSave: TButton
    Left = 335
    Top = 192
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object cbCommonSetup: TCheckBox
    Left = 8
    Top = 192
    Width = 145
    Height = 17
    Caption = #1054#1073#1097#1072#1103' '#1085#1072#1089#1090#1088#1086#1081#1082#1072
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 3
  end
  object FormStorage1: TFormStorage
    StoredValues = <>
    Left = 216
    Top = 148
  end
end
