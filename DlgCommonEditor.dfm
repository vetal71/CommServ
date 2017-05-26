inherited fCommonEditor: TfCommonEditor
  Caption = 'fCommonEditor'
  ClientWidth = 544
  Constraints.MinWidth = 550
  ExplicitWidth = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlButton: TPanel
    Width = 544
    inherited btnCancel: TButton
      Left = 441
    end
    inherited btnOK: TButton
      Left = 335
    end
  end
  inherited pnlMain: TPanel
    Width = 538
    object lblTables: TLabel
      Left = 13
      Top = 14
      Width = 139
      Height = 14
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099':'
    end
    object lblCommonName: TLabel
      Left = 13
      Top = 42
      Width = 163
      Height = 14
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072':'
    end
    object cbTables: TComboBox
      Left = 182
      Top = 11
      Width = 345
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'cbTables'
      ExplicitWidth = 519
    end
    object edtCommonName: TEdit
      Left = 182
      Top = 39
      Width = 345
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      ExplicitWidth = 519
    end
  end
end
