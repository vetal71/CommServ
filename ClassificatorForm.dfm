inherited fClassificator: TfClassificator
  Caption = 'fClassificator'
  ClientHeight = 597
  ClientWidth = 828
  ExplicitWidth = 844
  ExplicitHeight = 655
  PixelsPerInch = 96
  TextHeight = 14
  inherited sbMain: TSpTBXStatusBar
    Top = 572
    Width = 828
    inherited SpTBXRightAlignSpacerItem1: TSpTBXRightAlignSpacerItem
      CustomWidth = 635
    end
  end
  inherited dckTop: TSpTBXDock
    Width = 828
    Height = 26
    ExplicitWidth = 828
    ExplicitHeight = 26
    inherited tbrMain: TSpTBXToolbar
      Left = 33
      Images = ilMainSmall
      ExplicitLeft = 33
      ExplicitWidth = 33
      ExplicitHeight = 26
    end
    object tbr1: TSpTBXToolbar
      Left = 0
      Top = 0
      Images = ilMainSmall
      TabOrder = 1
      Caption = 'tbr1'
    end
  end
  object pnlLeft: TPanel [2]
    Left = 0
    Top = 26
    Width = 353
    Height = 546
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object tvDict: TTreeView
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 347
      Height = 540
      Align = alClient
      Indent = 19
      TabOrder = 0
      Items.NodeData = {
        0301000000380000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        0000000000010D1A043B043004410441043804440438043A04300442043E0440
        04}
      ExplicitLeft = 32
      ExplicitTop = 280
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
  end
  object pnlRight: TPanel [3]
    Left = 356
    Top = 26
    Width = 472
    Height = 546
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = 544
    ExplicitTop = 320
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  object spl1: TRxSplitter [4]
    Left = 353
    Top = 26
    Width = 3
    Height = 546
    ControlFirst = pnlLeft
    ControlSecond = pnlRight
    Align = alLeft
    BevelOuter = bvLowered
    ExplicitLeft = 249
  end
  inherited tmMainTimer: TTimer
    Left = 408
  end
  inherited MainActionList: TActionList
    Left = 336
    Top = 223
  end
  inherited ilMainLarge: TcxImageList
    FormatVersion = 1
    DesignInfo = 11010528
  end
  inherited ilMainSmall: TcxImageList
    FormatVersion = 1
    DesignInfo = 11010592
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000000001C0000
          0054000000540000005400000054000000540000005400000054000000540000
          0054000000370000000000000000000000000000000000000000000000580000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000A80000000000000000000000000000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          00AC000000A80000000000000000000000000000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          00AC000000A80000000000000000000000000000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          0073000000700000000A0000000E000000000000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000A6000000C70000000E0000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000002B000000EA000000C70000000E00000000000000580000
          00FF00000000000000000000000000000071000000A8000000A8000000A80000
          00A8000000A8000000A8000000CC000000FF000000C70000000E000000580000
          00FF00000000000000000000000000000074000000AC000000AC000000AC0000
          00AC000000AC000000AC000000CD000000FF000000C70000000E000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000028000000E7000000C80000000F00000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000A7000000C90000000F0000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          00700000006E0000000B0000000F000000000000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          00AC000000A80000000000000000000000000000000000000000000000580000
          00FF000000000000000000000000000000000000000000000000000000000000
          00AC000000A80000000000000000000000000000000000000000000000580000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000A800000000000000000000000000000000000000000000001E0000
          0058000000580000005800000058000000580000005800000058000000580000
          0058000000390000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000060626169A2A6
          A3B1BBBFBCCCE2E7E3F6E8EDE9FFC5C9C5FFEAEFEBFFDCE1DDF0BBBFBCCCA0A3
          A0AE5E605E660000000000000000000000000000000000000000909391F86264
          62FF4F514FFF303130FF292A29FF292A29FF292A29FF343634FF4F514FFF6467
          65FF8D908DF200000000000000000000000000000000000000002A2B2AFD2A2B
          2AFF2B2C2BFF2B2C2BFF2B2C2BFF2B2C2BFF2B2C2BFF2B2C2BFF2B2C2BFF292A
          29FF2D2E2DFA00000000000000000000000000000000000000002E2F2EEB292A
          29FF2D2E2DFF2C2D2CFF2B2C2BFF2B2B2BFF2B2C2BFF2C2D2CFF2D2E2DFF2929
          29FF333433DB03030303B3B7B4C3A5A9A6B4797C7A843D3E3D42181918922526
          25FF2B2C2BFF282928FF242524FF232423FF252625FF292A29FF2B2C2BFF2425
          24FF1313137947484750565857FF656765FF878A88FFAAAEABF2020202181E1E
          1EEB232423FF232323F512121290262626AA181818BA232423FB242424FF1E1F
          1ED9171717239FA2A0EE2F302FFF313231FF2F302FFF303130FB000000000404
          042D1B1B1BE04042416FDCE1DDF0C6CAC7FFDCE1DDF0383938751C1D1CE11F20
          1F39B2B5B3D6414241FF333433FF343534FF2F302FFF373737E3000000000000
          00001111111DA9ABA9F7404140FF373837FF404140FFA9ACA9F00B0B0B237173
          7197383A38ED2B2C2BFF313231FF333433FF2C2C2CFF1818188A000000000000
          00003B3C3B4F3B3B3BFF393A39FF393A39FF393A39FF404240FF272827321111
          1187151615991B1B1BBD282928FF2A2B2AFF232524E402020212000000000000
          00001B1B1B56313231FF3A3B3AFF3C3D3CFF3A3B3AFF303130FF0E0E0E32878A
          8793EAEFEBFFB3B7B4C32526257B202020EA0505052D00000000000000000000
          00000303031B2A2A2AF9333433FF363736FF323332FF2C2D2CF21C1D1C267D7F
          7EFA3D3E3DFF646664FFB2B6B3E1070707210000000000000000000000000000
          0000000000000B0B0B5D222322F6262726FF232323F117171755A6AAA7CD4546
          45FF414241FF404140FF505250FF2728272D0000000000000000000000000000
          000000000000000000000101010C06060633010101091F201F315E5F5EFE4142
          41FF434443FF414241FF363736FF121212370000000000000000000000000000
          00000000000000000000000000000000000000000000040404212F302FFD3A3B
          3AFF3D3E3DFF393A39FF2D2F2DFB0202020F0000000000000000000000000000
          00000000000000000000000000000000000000000000000000001111117E292A
          29FF2D2D2DFF292A29FC0E0E0E66000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000505
          052A0D0D0D660404042100000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000001900000086000000D2000000F8000000F80000
          00D1000000850000001800000000000000000000000000000000000000000000
          00000000000000000059000000EC00000091000000350000000A0000000A0000
          003600000093000000EC00000056000000000000000000000000000000000000
          000000000059000000E30000002F000000000000000000000000000000000000
          00000000000000000031000000E4000000560000000000000000000000000000
          001B000000EC0000002E00000000000000000000000000000000000000000000
          0000000000000000000000000031000000EC0000001800000000000000000000
          0088000000900000000000000000000000080000003100000000000000000000
          0032000000080000000000000000000000930000008500000000000000000000
          00D400000034000000000000000000000035000000EA0000003E000000400000
          00EA00000032000000000000000000000036000000D100000000000000000000
          00F90000000800000000000000000000000000000043000000EB000000EA0000
          00400000000000000000000000000000000A000000F800000000000000000000
          00F90000000800000000000000000000000000000042000000EC000000EB0000
          003E0000000000000000000000000000000A000000F800000000000000000000
          00D500000033000000000000000000000034000000EB00000042000000430000
          00EA00000031000000000000000000000035000000D200000000000000000000
          00890000008E00000000000000000000000A0000003400000000000000000000
          0035000000080000000000000000000000910000008600000000000000000000
          001C000000EC0000002C00000000000000000000000000000000000000000000
          000000000000000000000000002F000000EC0000001900000000000000000000
          00000000005C000000E20000002C000000000000000000000000000000000000
          0000000000000000002E000000E3000000590000000000000000000000000000
          0000000000000000005C000000EC0000008E0000003300000008000000080000
          003400000090000000EC00000059000000000000000000000000000000000000
          000000000000000000000000001C00000089000000D5000000F9000000F90000
          00D4000000880000001B00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000FF000000FF00000080000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000FF0000008000000000000000800000008000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000800000000000000080000000FF000000FF00000080000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000080000000FF000000FF000000FF000000FF000000800000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000080000000FF000000FF000000FF000000FF000000FF0000
          0080000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000080000000FF000000FF000000FF000000FF0000
          00FF000000800000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000080000000FF000000FF000000FF0000
          00FF000000FF0000008000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000080000000FF000000FF0000
          00FF000000FF000000FF00000080000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000080000000FF0000
          00FF000000FF000000FF000000FF000000800000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000800000
          00FF000000FF000000FF000000FF000000FF0000008000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0080000000FF000000FF000000FF000000FF000000FF00000080000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000080000000FF000000FF000000FF000000FF00000080000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000080000000FF000000FF0000008000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000080000000800000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000001B000000650000008C0000008B0000
          0063000000190000000000000000000000000000000000000000000000000000
          000000000000000000080000008D272727FA838383FFB0B0B0FFAFAFAFFF8181
          81FF252525F90000008800000007000000000000000000000000000000000000
          000000000008030303BF898989FFFCFCFCFFFFFFFFFFDDDDDDFFDCDCDCFFFFFF
          FFFFFBFBFBFF838383FF030303BA000000070000000000000000000000000000
          00000000008E8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFA5A5A5FFFFFF
          FFFFFFFFFFFFFFFFFFFF888888FF000000870000000000000000000000000000
          001B323232FBFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFA5A5A5FFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFDFDFF303030F90000001600000000000000000000
          0067969696FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFA5A5A5FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF909090FF0000005F00000000000000000000
          008CC5C5C5FFDFDFDFFFB9B9B9FFB9B9B9FFB9B9B9FF787878FF787878FFB9B9
          B9FFB9B9B9FFB9B9B9FFE0E0E0FFC0C0C0FF0000008700000000000000000000
          008CCBCBCBFFCDCDCDFF939393FF939393FF939393FF606060FF5F5F5FFF9393
          93FF939393FF939393FFCECECEFFC6C6C6FF0000008700000000000000000000
          0067A2A2A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFA5A5A5FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF9C9C9CFF0000006000000000000000000000
          001B474747FCFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFA5A5A5FFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFEFEFF404040F90000001700000000000000000000
          00000101018DB1B1B1FFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFA5A5A5FFFFFF
          FFFFFFFFFFFFFFFFFFFFABABABFF010101860000000000000000000000000000
          0000000000080E0E0EC0B6B6B6FFFEFEFEFFFFFFFFFFCCCCCCFFCBCBCBFFFFFF
          FFFFFEFEFEFFB1B1B1FF0C0C0CBB000000060000000000000000000000000000
          000000000000000000080202028D565656FBB1B1B1FFDDDDDDFFDCDCDCFFAFAF
          AFFF4F4F4FFA0101018700000006000000000000000000000000000000000000
          000000000000000000000000000000000019000000630000008A000000890000
          0061000000170000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000002C00000094000000FB000000B7000000B90000
          00FF000000910000002900000000000000000000000000000000000000000000
          0000000000070000009B0000008C000000190000000000000000000000000000
          00000000001C0000009100000095000000060000000000000000000000000000
          0008000000D30000003700000000000000000000000000000000000000000000
          000000000000000000000000003B000000CD0000000600000000000000000000
          009E000000360000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000003B00000095000000000000002F0000
          0088000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000091000000290000009A0000
          0017000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000001C00000091000000F10000
          0000000000000000000000000000000000000000000000000032000000980000
          00980000009800000098000000980000004300000000000000FF000000AE0000
          0000000000000000000000000000000000000000000000000054000000590000
          000C0000000C0000000C0000000C0000000600000000000000B9000000AD0000
          0000000000000000000000000000000000000000000000000054000000500000
          00000000000000000000000000000000000000000000000000B7000000EE0000
          0000000000000000000000000000000000000000000000000054000000500000
          00000000000000000000000000000000000000000000000000FB0000009D0000
          0015000000000000000000000000000000000000000000000054000000500000
          0000000000000000000000000000000000000000001900000094000000320000
          0084000000000000000000000000000000000000000000000054000000500000
          0000000000000000000000000000000000000000008C0000002C000000000000
          00A400000032000000000000000000000000000000000000000F0000000E0000
          0000000000000000000000000000000000370000009B00000000000000000000
          0009000000DA0000003200000000000000000000000000000000000000000000
          0000000000000000000000000036000000D30000000700000000000000000000
          000000000009000000A400000084000000150000000000000000000000000000
          000000000017000000880000009E000000080000000000000000000000000000
          00000000000000000000000000320000009D000000EE000000AD000000AE0000
          00F10000009A0000002F00000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000094000000AC000000AC000000AC000000AC000000AC0000
          00AC000000AC000000AC0000008F000000000000000000000000000000000000
          000000000000000000AC00000000000000000000000000000000000000000000
          00000000000000000000000000A8000000000000000000000000000000000000
          000000000000000000AC0000000000000074000000AC000000AC000000AC0000
          00AC0000007100000000000000A8000000000000000000000000000000000000
          000000000000000000AC00000000000000000000000000000000000000000000
          00000000000000000000000000A8000000000000000000000000000000E90000
          00FF000000FF000000FF0000000000000074000000AC000000AC000000AC0000
          00AC0000007100000000000000FF000000FF000000FF000000E6000000FF0000
          008F00000058000000C800000000000000000000000000000000000000000000
          00000000000000000000000000C60000005800000091000000FF000000FF0000
          005400000000000000AC0000000000000074000000AC000000AC000000AC0000
          00AC0000007100000000000000A80000000000000058000000FF000000FF0000
          005400000000000000AC00000000000000000000000000000000000000000000
          00000000000000000000000000A80000000000000058000000FF000000FF0000
          005400000058000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF0000005400000058000000FF000000FF0000
          00540000001E0000005800000058000000580000005800000058000000580000
          00580000005800000058000000580000001C00000058000000FF000000FF0000
          00540000003B000000080000003B000000080000000000000000000000000000
          00000000000000000000000000000000000000000058000000FF000000FF0000
          0054000000E40000003B000000E40000003B0000000000000000000000000000
          00000000000000000000000000000000000000000058000000FF000000FF0000
          008C000000540000005400000054000000540000005400000054000000540000
          0054000000540000005400000054000000540000008F000000FF000000EB0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000E9000000000000
          000000000000000000AC00000000000000000000000000000000000000000000
          00000000000000000000000000A8000000000000000000000000000000000000
          00000000000000000096000000A8000000A8000000A8000000A8000000A80000
          00A8000000A8000000A800000092000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000710000
          0087000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000073000000FF0000
          00B4000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000006A000000FF000000FF0000
          00B4000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000B8000000FF000000FF0000
          00B4000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000B8000000FF000000FF0000
          00B4000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000B8000000FF000000FF0000
          00B4000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000B8000000FF000000FF0000
          00B4000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000012000000DE000000FF000000FF0000
          00DB000000110000000000000000000000000000000000000000000000000000
          0000000000000000000000000012000000CE000000FF000000FF000000FF0000
          00FF000000CC0000001100000000000000000000000000000000000000000000
          00000000000000000012000000CE000000FF000000FF000000FF000000FF0000
          00FF000000FF000000CC00000011000000000000000000000000000000000000
          000000000012000000CE000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000CC000000110000000000000000000000000000
          0011000000CE000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000CC0000000F00000000000000000000
          0027000000B7000000B8000000B8000000B8000000B8000000B8000000B80000
          00B8000000B8000000B8000000B8000000B70000002400000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000F0F0DC81313
          12FF131312FF131312FF131312FF131312FF131312FF131312FF131312FF1313
          12FF131312FF131312FF131312FF131312FF0F0F0EC500000000131312FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          000000000000000000000808076A050505400000000000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          000000000000000000000808086F0C0C0B9B0000000000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          000000000000000000000202021A121211EC0101011000000000000000000000
          000000000000000000000000000000000000131312FF00000000131312FF0000
          00000000000000000000000000000B0B0B970B0B0A9100000000000000000000
          0000000000000000000000000000000000000808076500000000131312FF0000
          000000000000000000000000000001010111111110DF06060656000000000000
          0000000000000000000004040437000000060000000000000000131312FF0000
          0000000000000000000000000000000000000303032B0F0F0EE50808076A0000
          000000000000000000000B0B0B9A0C0C0CB100000005000000000F0F0DC91313
          12FF131312FF131312FF131312FF111110E200000000020202210D0D0DCA0D0D
          0DBE0505054400000002000000040D0D0BAB0D0D0CAD00000004000000000000
          0000000000000000000000000000000000000000000000000000000000030707
          075F0E0E0ECB121211EC0D0D0DBD0D0D0CAE131312FC0C0C0CA6000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000020202170505054409090878131312FA0707065A000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000003030222111110DF0707075E00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000D0D0DB4070707630000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000C0000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
          0000000000B6000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000F8000000600000004000000040000000000000
          000000000056000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000F800000048000000000000000000000000000000000000
          0000000000000000003D0000007C000000800000008000000080000000800000
          0080000000800000004000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end
