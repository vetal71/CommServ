inherited FDlgCommon: TFDlgCommon
  ClientHeight = 538
  ClientWidth = 591
  ExplicitWidth = 597
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlButton: TPanel
    Top = 503
    Width = 591
    inherited btnCancel: TButton
      Left = 488
    end
    inherited btnOK: TButton
      Left = 382
    end
  end
  inherited pnlMain: TPanel
    Width = 585
    Height = 497
    object grdCommon: TDBGridEh
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 577
      Height = 489
      Align = alClient
      AutoFitColWidths = True
      DataSource = dsCommon
      DynProps = <>
      OddRowColor = clSilver
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghIncSearch, dghPreferIncSearch, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SortLocal = True
      TabOrder = 0
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'CODE'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076
          Width = 80
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 300
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object qryCommon: TUniQuery
    Left = 288
    Top = 272
  end
  object dsCommon: TUniDataSource
    DataSet = qryCommon
    Left = 360
    Top = 272
  end
end
