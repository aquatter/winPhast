object Form1: TForm1
  Left = 183
  Top = 100
  Caption = 'winPhast'
  ClientHeight = 661
  ClientWidth = 1344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 451
    Width = 1344
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Color = clBlack
    ParentColor = False
    Visible = False
    ExplicitLeft = -160
    ExplicitTop = 312
  end
  object Splitter1: TSplitter
    Left = 250
    Top = 72
    Height = 379
    Color = clBlack
    ParentColor = False
    ExplicitLeft = 776
    ExplicitTop = 368
    ExplicitHeight = 100
  end
  object ControlBar1: TControlBar
    Left = 976
    Top = 359
    Width = 857
    Height = 65
    BevelEdges = [beBottom]
    TabOrder = 0
    Visible = False
    DesignSize = (
      857
      63)
    object ToolBar6: TToolBar
      Left = 11
      Top = 2
      Width = 215
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar6'
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object ToolButton18: TToolButton
        Left = 0
        Top = 0
        Hint = 'Open Image'
        AutoSize = True
        Caption = 'Open_Image'
        ImageIndex = 3
        OnClick = ToolButton18Click
      end
      object ToolButton19: TToolButton
        Left = 31
        Top = 0
        Hint = 'Exit'
        AutoSize = True
        Caption = 'Exit'
        ImageIndex = 2
        OnClick = ToolButton19Click
      end
      object ToolButton1: TToolButton
        Left = 62
        Top = 0
        Width = 19
        Caption = 'ToolButton1'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
    object ToolBar8: TToolBar
      Left = 239
      Top = 2
      Width = 71
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar8'
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ImageList1
      TabOrder = 1
      Transparent = True
      object ToolButton23: TToolButton
        Left = 0
        Top = 0
        Hint = 'Zoom +'
        Caption = 'Zoom+'
        ImageIndex = 1
        Style = tbsCheck
        OnClick = ToolButton23Click
      end
      object ToolButton24: TToolButton
        Left = 31
        Top = 0
        Hint = 'Zoom -'
        Caption = 'Zoom-'
        ImageIndex = 0
        OnClick = ToolButton24Click
      end
    end
    object ToolBar9: TToolBar
      Left = 323
      Top = 2
      Width = 102
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar9'
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ImageList1
      TabOrder = 2
      object ToolButton27: TToolButton
        Left = 0
        Top = 0
        Caption = 'ToolButton27'
        ImageIndex = 11
        OnClick = ToolButton27Click
      end
      object ToolButton29: TToolButton
        Left = 31
        Top = 0
        Caption = 'ToolButton29'
        ImageIndex = 10
        Style = tbsCheck
        OnClick = ToolButton29Click
      end
      object ToolButton30: TToolButton
        Left = 62
        Top = 0
        Caption = 'ToolButton30'
        ImageIndex = 9
        Style = tbsCheck
        OnClick = ToolButton30Click
      end
    end
    object PageControl1: TPageControl
      Left = 438
      Top = 2
      Width = 360
      Height = 74
      ActivePage = TabSheet1
      Align = alClient
      MultiLine = True
      Style = tsFlatButtons
      TabOrder = 3
      object TabSheet1: TTabSheet
        Caption = 'Measure'
        object ToolBar1: TToolBar
          Left = 0
          Top = 0
          Width = 352
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 31
          Caption = 'ToolBar1'
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = ImageList1
          TabOrder = 0
          object ToolButton3: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButton3'
            ImageIndex = 0
            OnClick = ToolButton3Click
          end
          object ToolButton4: TToolButton
            Left = 31
            Top = 0
            Caption = 'ToolButton4'
            ImageIndex = 1
            OnClick = ToolButton4Click
          end
          object ToolButton5: TToolButton
            Left = 62
            Top = 0
            Caption = 'ToolButton5'
            ImageIndex = 2
            OnClick = ToolButton5Click
          end
          object ToolButton10: TToolButton
            Left = 93
            Top = 0
            Caption = 'ToolButton10'
            ImageIndex = 3
            OnClick = ToolButton10Click
          end
          object ToolButton11: TToolButton
            Left = 124
            Top = 0
            Caption = 'ToolButton11'
            ImageIndex = 4
            OnClick = ToolButton11Click
          end
          object ToolButton12: TToolButton
            Left = 155
            Top = 0
            Caption = 'ToolButton12'
            ImageIndex = 5
            OnClick = ToolButton12Click
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Calibration'
        ImageIndex = 1
        object ToolBar7: TToolBar
          Left = 0
          Top = 0
          Width = 352
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 31
          Caption = 'ToolBar7'
          Images = ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object ToolButton20: TToolButton
            Left = 0
            Top = 0
            Hint = 'Draw Lines'
            Caption = 'Draw_Lines'
            ImageIndex = 8
            Style = tbsCheck
            OnClick = ToolButton20Click
          end
          object ToolButton21: TToolButton
            Left = 31
            Top = 0
            Hint = 'OK'
            Caption = 'Ok'
            ImageIndex = 7
            OnClick = ToolButton21Click
          end
          object ToolButton22: TToolButton
            Left = 62
            Top = 0
            Hint = 'Decline'
            Caption = 'Cancel'
            ImageIndex = 10
            Style = tbsCheck
            OnClick = ToolButton22Click
          end
          object ToolButton26: TToolButton
            Left = 93
            Top = 0
            Caption = 'ToolButton26'
            ImageIndex = 5
            Style = tbsCheck
            OnClick = ToolButton26Click
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Dynamic'
        ImageIndex = 2
      end
      object TabSheet4: TTabSheet
        Caption = 'Fft'
        ImageIndex = 3
      end
      object TabSheet5: TTabSheet
        Caption = 'Histogram'
        ImageIndex = 4
        object ToolBar3: TToolBar
          Left = 0
          Top = 0
          Width = 352
          Height = 33
          ButtonHeight = 30
          ButtonWidth = 34
          Caption = 'ToolBar3'
          Images = ImageList1
          TabOrder = 0
          object ToolButton6: TToolButton
            Left = 0
            Top = 0
            Caption = 'Change Hist'
            ImageIndex = 12
            Style = tbsCheck
            OnClick = ToolButton6Click
          end
          object ToolButton7: TToolButton
            Left = 34
            Top = 0
            Caption = 'View Graph'
            ImageIndex = 4
            Style = tbsCheck
            OnClick = ToolButton7Click
          end
          object ToolButton8: TToolButton
            Left = 68
            Top = 0
            Caption = 'Change Graph'
            ImageIndex = 14
            Style = tbsCheck
            OnClick = ToolButton8Click
          end
          object ToolButton9: TToolButton
            Left = 102
            Top = 0
            Caption = 'ToolButton9'
            ImageIndex = 13
            Style = tbsCheck
            OnClick = ToolButton9Click
          end
          object ToolButton2: TToolButton
            Left = 136
            Top = 0
            Caption = 'ToolButton2'
            ImageIndex = 15
            OnClick = ToolButton2Click
          end
        end
      end
    end
    object ComboBox1: TComboBox
      Left = 239
      Top = 80
      Width = 120
      Height = 21
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      Style = csDropDownList
      Anchors = []
      ItemIndex = 0
      TabOrder = 4
      Text = 'Image'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Image'
        'FFT_amp'
        'Phase'
        'Amplitude'
        'Unwrap Phase')
    end
  end
  object ToolBar2: TToolBar
    Left = 0
    Top = 0
    Width = 1344
    Height = 34
    AutoSize = True
    ButtonHeight = 30
    ButtonWidth = 34
    Caption = 'ToolBar2'
    DisabledImages = ImageList2
    EdgeBorders = [ebTop, ebBottom]
    Images = ImageList1
    TabOrder = 1
    Visible = False
    object ToolButton13: TToolButton
      Left = 0
      Top = 0
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1080#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084#1099' [Ctrl + O]'
      Caption = 'ToolButton13'
      ImageIndex = 10
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton3Click
    end
    object ToolButton14: TToolButton
      Left = 34
      Top = 0
      Hint = #1047#1072#1093#1074#1072#1090' '#1080#1085#1090#1077#1088#1092#1077#1088#1077#1085#1094#1080#1086#1085#1085#1099#1093' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081' [Ctrl + M]'
      Caption = #1047#1072#1093#1074#1072#1090' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = Action2Execute
    end
    object ToolButton25: TToolButton
      Left = 68
      Top = 0
      Width = 15
      Caption = 'ToolButton25'
      ImageIndex = 5
      Style = tbsSeparator
      Visible = False
    end
    object ToolButton15: TToolButton
      Left = 83
      Top = 0
      Hint = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1086#1073#1083#1072#1089#1090#1100
      Caption = 'ToolButton15'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      Visible = False
      OnClick = ToolButton23Click
    end
    object ToolButton16: TToolButton
      Left = 117
      Top = 0
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
      Caption = 'ToolButton16'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = ToolButton24Click
    end
    object ToolButton28: TToolButton
      Left = 151
      Top = 0
      Width = 15
      Caption = 'ToolButton28'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton17: TToolButton
      Left = 166
      Top = 0
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1089#1095#1077#1090
      Caption = 'ToolButton17'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = ToolButton17Click
    end
    object ToolButton33: TToolButton
      Left = 200
      Top = 0
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Caption = 'ToolButton33'
      ImageIndex = 11
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton33Click
    end
    object ToolButton31: TToolButton
      Left = 234
      Top = 0
      Width = 15
      Caption = 'ToolButton31'
      ImageIndex = 19
      Style = tbsSeparator
    end
    object ToolButton44: TToolButton
      Left = 249
      Top = 0
      Hint = #1056#1072#1089#1095#1077#1090' Rz, Ra, Rmax'
      Caption = 'ToolButton44'
      ImageIndex = 13
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton44Click
    end
    object ToolButton43: TToolButton
      Left = 283
      Top = 0
      Hint = #1056#1072#1089#1095#1077#1090' '#1088#1072#1079#1085#1086#1089#1090#1080' '#1074#1099#1089#1086#1090' '#1074' '#1076#1074#1091#1093' '#1090#1086#1095#1082#1072#1093
      Caption = 'ToolButton43'
      ImageIndex = 14
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton43Click
    end
    object ToolButton45: TToolButton
      Left = 317
      Top = 0
      Width = 13
      Caption = 'ToolButton45'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton34: TToolButton
      Left = 330
      Top = 0
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1080' '#1089#1077#1095#1077#1085#1080#1081
      Caption = 'ToolButton34'
      ImageIndex = 9
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton26Click
    end
    object ToolButton35: TToolButton
      Left = 364
      Top = 0
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1096#1082#1072#1083#1091' '#1087#1089#1077#1074#1076#1086#1094#1074#1077#1090#1086#1074
      Caption = 'ToolButton35'
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton35Click
    end
    object ToolButton36: TToolButton
      Left = 398
      Top = 0
      Width = 15
      Caption = 'ToolButton36'
      ImageIndex = 17
      Style = tbsSeparator
    end
    object ToolButton37: TToolButton
      Left = 413
      Top = 0
      Hint = #1052#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1090#1100' '#1075#1080#1089#1090#1086#1075#1088#1072#1084#1084#1091' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
      Caption = 'ToolButton37'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton8Click
    end
    object ToolButton39: TToolButton
      Left = 447
      Top = 0
      Hint = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1080#1089#1093#1086#1076#1085#1086#1081' '#1075#1080#1089#1090#1086#1075#1088#1072#1084#1084#1077
      Caption = 'ToolButton39'
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton2Click
    end
    object ToolButton38: TToolButton
      Left = 481
      Top = 0
      Width = 15
      Caption = 'ToolButton38'
      ImageIndex = 18
      Style = tbsSeparator
      Visible = False
    end
    object ToolButton40: TToolButton
      Left = 496
      Top = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1077#1090' MSWord [Ctrl+ R]'
      Caption = 'ToolButton40'
      ImageIndex = 12
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton40Click
    end
    object ToolButton42: TToolButton
      Left = 530
      Top = 0
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1074' '#1072#1082#1089#1086#1085#1086#1084#1077#1090#1088#1080#1080
      Caption = 'ToolButton42'
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = ToolButton42Click
    end
    object ToolButton41: TToolButton
      Left = 564
      Top = 0
      Width = 15
      Caption = 'ToolButton41'
      ImageIndex = 27
      Style = tbsSeparator
    end
    object ToolButton32: TToolButton
      Left = 579
      Top = 0
      Hint = #1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' [Ctrl + Q]'
      Caption = 'ToolButton32'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton19Click
    end
    object Label1: TLabel
      Left = 613
      Top = 0
      Width = 3
      Height = 30
    end
  end
  object ToolBar4: TToolBar
    Left = 0
    Top = 34
    Width = 1344
    Height = 38
    ButtonHeight = 38
    ButtonWidth = 125
    Caption = 'ToolBar4'
    DisabledImages = ImageList5
    DrawingStyle = dsGradient
    Images = ImageList3
    List = True
    ShowCaptions = True
    TabOrder = 2
    object ToolButton46: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1077#1082#1090
      ImageIndex = 0
      OnClick = N117Click
    end
    object ToolButton47: TToolButton
      Left = 129
      Top = 0
      AutoSize = True
      Caption = #1048#1079#1084#1077#1088#1077#1085#1080#1077
      ImageIndex = 1
      OnClick = Action2Execute
    end
    object ToolButton48: TToolButton
      Left = 234
      Top = 0
      AutoSize = True
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 2
      OnClick = ToolButton33Click
    end
    object ToolButton49: TToolButton
      Left = 336
      Top = 0
      AutoSize = True
      Caption = #1056#1072#1089#1095#1077#1090
      ImageIndex = 3
      Visible = False
      OnClick = ToolButton49Click
    end
    object ToolButton50: TToolButton
      Left = 418
      Top = 0
      AutoSize = True
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1077#1090
      ImageIndex = 4
      Visible = False
      OnClick = ToolButton40Click
    end
    object ToolButton51: TToolButton
      Left = 537
      Top = 0
      AutoSize = True
      Caption = #1042#1099#1093#1086#1076
      ImageIndex = 5
      OnClick = ToolButton19Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 454
    Width = 1344
    Height = 188
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object Splitter3: TSplitter
      Left = 625
      Top = 0
      Height = 188
      Color = clBlack
      ParentColor = False
      ExplicitLeft = 369
      ExplicitTop = 14
      ExplicitHeight = 100
    end
    object Chart3: TChart
      Left = 628
      Top = 0
      Width = 716
      Height = 188
      BackImage.Mode = pbmCustom
      BackImage.Data = {
        09544D65746166696C654C040000010000006C00000002000000050000001700
        00002B000000000000000000000077020000B004000020454D46000001004804
        0000110000000200000000000000000000000000000000050000000400004001
        00000001000000000000000000000000000000E2040000E80300460000002C00
        000020000000454D462B014001001C000000100000000210C0DB010000006000
        00006000000046000000E0000000D4000000454D462B30400200100000000400
        00000000803F1F4004000C000000000000001E4005000C000000000000001D40
        00001400000008000000AEFFFFFF0A0400002A40000024000000180000000000
        C04200000000000000000000C042808828C14D45F34008400006300000002400
        00000210C0DB00C7B13E00000000010000000000000005000000410052004900
        41004C0000003640008040000000340000009B9BFFFF01000000010000000100
        00005800005B003E001F9A3E0000803F00000000000000000000803F00000000
        0000000000002100000008000000620000000C00000001000000120000000C00
        000001000000180000000C000000FF9B9B00160000000C000000180000005200
        00007001000001000000DFFFFFFF000000000000000000000000BC0200000000
        00CC0700040041007200690061006C0000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000190210E6190210880E0418147B03D01A8303400000007801
        19026C007B030004000000000000F94DD43B00040000000000002C0800000000
        0000244412000471147890830E0400040000360000007400000090870E040000
        190248810E0408880E0448441200360A917CFF00000008880E04000019024881
        0E040000190200001902780119021C451200182D4454FB2109405DEA18782000
        00003C451200100000000000E400CE53D53B48810E04100000007F0300002845
        1200630A197800001978080000000000000020461200970A19787F1700000A00
        0000E8037B0380A9E63BB20C21770455750374040000D81A8303C00600001800
        00008C0400006476000800000000250000000C00000001000000540000005400
        00000200000005000000170000002A000000010000000000C8410000C8410200
        000024000000010000004C000000000000000000000000000000FFFFFFFFFFFF
        FFFF500000005800000000000000250000000C0000000D000080460000001C00
        000010000000454D462B2B4000000C000000000000004C000000640000000200
        000007000000170000002B000000020000000700000016000000250000002900
        AA0000000000000000000000803F00000000000000000000803F000000000000
        0000000000000000000000000000000000000000000000000000220000000C00
        0000FFFFFFFF460000001C00000010000000454D462B024000000C0000000000
        00000E00000014000000000000001000000014000000}
      BackImageMode = pbmCustom
      BackImageTransp = True
      Legend.Font.Shadow.Visible = False
      Legend.Title.Font.Shadow.Visible = False
      Legend.Title.Shadow.Visible = False
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      ClipPoints = False
      Shadow.Visible = False
      View3D = False
      View3DOptions.Orthogonal = False
      View3DOptions.ZoomText = False
      View3DWalls = False
      Zoom.Brush.Style = bsDiagCross
      Zoom.Pen.Color = clBlack
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Series1: TLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = clBlack
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TPointSeries
        Marks.Arrow.Color = clBlack
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Callout.ArrowHead = ahLine
        Marks.Callout.Distance = 7
        Marks.Shadow.Color = 8487297
        Marks.Shadow.Visible = False
        Marks.Symbol.Shadow.Visible = False
        Marks.Visible = True
        ClickableLine = False
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 625
      Height = 188
      BackImage.Mode = pbmCustom
      BackImage.Data = {
        09544D65746166696C654C040000010000006C00000002000000050000001800
        00002B000000000000000000000077020000B004000020454D46000001004804
        0000110000000200000000000000000000000000000000050000000400004001
        00000001000000000000000000000000000000E2040000E80300460000002C00
        000020000000454D462B014001001C000000100000000210C0DB010000006000
        00006000000046000000E0000000D4000000454D462B30400200100000000400
        00000000803F1F4004000C000000000000001E4005000C000000000000001D40
        00001400000008000000AEFFFFFF0A0400002A40000024000000180000000000
        C04200000000000000000000C042808828C14D45F34008400006300000002400
        00000210C0DB00C7B13E00000000010000000000000005000000410052004900
        41004C0000003640008040000000340000009B9BFFFF01000000010000000100
        00005900005B003E001F9A3E0000803F00000000000000000000803F00000000
        0000000000002100000008000000620000000C00000001000000120000000C00
        000001000000180000000C000000FF9B9B00160000000C000000180000005200
        00007001000001000000DFFFFFFF000000000000000000000000BC0200000000
        00CC0700040041007200690061006C0000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000001902E84312009821830300001902D01A8303A60400000444
        12001624917C00001902D01A8303D01A83030000190200007403000074030000
        E4014C441200C325917CA6040000D01A83100000000000001902D01A83030000
        000000000000004083034844120000007403000000000000000000000000A600
        000000000000000000001C451200BA09917C182D4454FB2109405DEA18782000
        00003C451200100000000000E400CE53D53BD01A8303100000007F0300002845
        1200630A197800001978080000000000000020461200970A19787F1700000A00
        0000E8037B0380A9E63B7D0D2117045575037404000000000000C00600001800
        00008C0400006476000800000000250000000C00000001000000540000005400
        00000200000005000000180000002A000000010000000000C8410000C8410200
        000024000000010000004C000000000000000000000000000000FFFFFFFFFFFF
        FFFF500000005900000000000000250000000C0000000D000080460000001C00
        000010000000454D462B2B4000000C000000000000004C000000640000000200
        000007000000170000002B000000020000000700000016000000250000002900
        AA0000000000000000000000803F00000000000000000000803F000000000000
        0000000000000000000000000000000000000000000000000000220000000C00
        0000FFFFFFFF460000001C00000010000000454D462B024000000C0000000000
        00000E00000014000000000000001000000014000000}
      BackImageMode = pbmCustom
      BackImageTransp = True
      Legend.Font.Shadow.Visible = False
      Legend.Title.Font.Shadow.Visible = False
      Legend.Title.Shadow.Visible = False
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      ClipPoints = False
      Shadow.Visible = False
      View3D = False
      View3DOptions.Orthogonal = False
      View3DOptions.ZoomText = False
      View3DWalls = False
      Zoom.Brush.Style = bsDiagCross
      Zoom.Pen.Color = clBlack
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object LineSeries1: TLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = clBlack
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object PointSeries1: TPointSeries
        Marks.Arrow.Color = clBlack
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Callout.ArrowHead = ahLine
        Marks.Callout.Distance = 7
        Marks.Shadow.Color = 8487297
        Marks.Shadow.Visible = False
        Marks.Symbol.Shadow.Visible = False
        Marks.Visible = True
        ClickableLine = False
        Pointer.InflateMargins = True
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 642
    Width = 1344
    Height = 19
    Panels = <>
  end
  object Panel2: TPanel
    Left = 0
    Top = 72
    Width = 250
    Height = 379
    Align = alLeft
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 5
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 15
      Height = 379
      Cursor = crHandPoint
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100
      Align = alLeft
      BevelOuter = bvNone
      Caption = '<<'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Panel3Click
    end
  end
  object ImageList1: TImageList
    Height = 24
    ShareImages = True
    Width = 24
    Left = 409
    Top = 221
    Bitmap = {
      494C01010F002400240018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000006000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F8F8F0098989800A6A6A600ADADAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006C6C6C00B8B8B800B4B4B400D0D0D000BDBDBD00ACAC
      AC00959595008C8C8C0091919100A0A0A000AFAFAF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A70060606000D1D1D100B2B2B200EAEAEA00E9E9E900F1F1
      F100F6F6F600F5F5F500EEEEEE00DFDFDF00CACACA00B5B5B5009B9B9B008E8E
      8E009D9D9D000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E0062626200D0D0D000A7A7A700E5E5E500E0E0E000E4E4
      E300E9E8E700EFEDEC00F7F5F400F9F8F700FAFAFA00FAFAFA00FBFBFB00FBFB
      FB00C9C9C9000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000190000001900
      0000190000001900000019000000190000001900000019000000190000001900
      0000190000001900000019000000190000001900000019000000190000001900
      0000190000001900000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A1A1A1005C5C5C00D4D4D400A2A2A200E5E5E500E1E0E000E9E4
      E100E3DDD800C2CBD00096B9CD00A3999700F5F2F100ECECEC00EBEBEB00ECEC
      EC00D7D7D700B4B4B400000000000000000000000000000000009B0000009B00
      00009B0000009B0000009B0000009B0000009B0000009B0000009B0000009B00
      00009B0000009B0000009B0000009B0000009B0000009B0000009B0000009B00
      00009B0000009B00000000000000000000000000000000000000320000003200
      0000320000003200000032000000320000003200000032000000320000003200
      0000320000003200000032000000320000003200000032000000320000003200
      0000320000003200000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A6A6A60058585800D6D6D600A0A0A000E9E8E700D9D3CF007F89
      8E000178BE00068BE40054BAF5003477A100F5F0EC00E8E8E800E7E7E700E8E8
      E800E1E1E100ABABAB00000000000000000000000000000000009B0000009B00
      00009B0000009B0000009B0000009B0000009B0000009B0000009B0000009B00
      00009B0000009B0000009B0000009B0000009B0000009B0000009B0000009B00
      00009B0000009B00000000000000000000000000000000000000490000004900
      0000490000004900000049000000490000004900000049000000490000004900
      0000490000004900000049000000490000004900000049000000490000004900
      0000490000004900000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9A9A90053535300DADADA00A2A1A000D6CFCC004F636F00006D
      B500138DF10059BEFF00ABE7FF004AA1D900F3EBE600E3E3E300E3E3E300E3E3
      E300E5E5E500A5A5A50000000000000000000000000000000000BA000000BA00
      0000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA00
      0000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA00
      0000BA000000BA000000000000000000000000000000000000005F0000005F00
      00005F0000005F0000005F0000005F0000005F0000005F0000005F0000005F00
      00005F0000005F0000005F0000005F0000005F0000005F0000005F0000005F00
      00005F0000005F00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052525200DEDDDC0096908C00596B7500006EB5000E8D
      EC004FB3FF0070D6FF0061D6F7006BACD700E8E2DE00DFDFDF00DEDEDE00DDDD
      DD00E6E6E6009F9F9F0000000000000000000000000000000000BA000000BA00
      0000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA00
      0000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA00
      0000BA000000BA00000000000000000000000000000000000000740000007400
      0000740000007400000074000000740000007400000074000000740000007400
      0000740000007400000074000000740000007400000074000000740000007400
      0000740000007400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000053535300D7D1CE00445058000075BB00098CE60044A9
      FF0072D6FF007CE6FE000E8ED900D9D9D800DFDCDA00DBDBDB00DADADA00DADA
      DA00E1E1E100A0A0A00000000000000000000000000000000000BA000000BA00
      0000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA00
      0000BA000000BA000000BA000000BA000000BA000000BA000000BA000000BA00
      0000BA000000BA00000000000000000000000000000000000000870000008700
      0000870000008700000087000000870000008700000087000000870000008700
      0000870000008700000087000000870000008700000087000000870000008700
      0000870000008700000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000524F4D00757A7E000074BB00058BE2003BA1FF0073D8
      FF007DE4FF00149BDF00B1C5D400DED8D500D7D6D600D6D6D600D6D6D600D5D5
      D500DCDCDC00A8A8A80000000000000000000000000000000000D9000000D900
      0000D9000000D9000000D900000000FFFF00D9000000D9000000D9000000D900
      000000FFFF00D900000000FFFF0000FFFF0000FFFF0000FFFF00D9000000D900
      0000D9000000D900000000000000000000000000000000000000990000009900
      0000990000009900000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF009900000000FFFF0000FFFF0000FFFF0000FFFF0099000000990000009900
      0000990000009900000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000333436000578BD00008ADE00339AFF0071D5FF0077DB
      FF0037B7E90073ACD200DCD4CF00D3D2D100D1D1D100D1D1D100D1D1D100D1D1
      D100D5D5D500B2B2B20000000000000000000000000000000000D9000000D900
      0000D9000000D9000000D900000048FFC200D9000000D9000000D900000048FF
      C200D9000000D900000048FFC200D9000000D9000000D9000000D9000000D900
      0000D9000000D900000000000000000000000000000000000000A9000000A900
      0000A9000000A900000043FFBC00A9000000A9000000A9000000A900000043FF
      BC00A900000043FFBC00A9000000A9000000A9000000A9000000A9000000A900
      0000A9000000A900000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006F6F6F0036627D00118DD9002596FF006DD2FF0070D4FF0062D7
      F3002F95D500E1D8D400D8D5D400D3D3D300D3D3D300D1D1D100D3D3D300D3D3
      D300D7D7D700C1C1C100B7B7B700000000000000000000000000D9000000D900
      0000D9000000D9000000D900000090FFB500D9000000D900000090FFB500D900
      0000D9000000D9000000D900000090FFB500D9000000D9000000D9000000D900
      0000D9000000D900000000000000000000000000000000000000B8000000B800
      0000B8000000B8000000B80000007CFF8300B8000000B80000007CFF8300B800
      0000B8000000B80000007CFF8300B8000000B8000000B8000000B8000000B800
      0000B8000000B800000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007979790081807B00A9A29B009D9A9A0069C2F3006BD5FF007DEBFD000688
      D700DAD7D700DEDAD700D7D7D700D6D6D600D6D6D600D6D6D600D6D6D600D7D7
      D700DADADA00D2D2D200B3B3B300000000000000000000000000D9000000D900
      0000D9000000D9000000D9000000B5FF9000B5FF9000B5FF9000B5FF9000D900
      0000D9000000D9000000D9000000D9000000B5FF9000D9000000D9000000D900
      0000D9000000D900000000000000000000000000000000000000C6000000C600
      0000C6000000C6000000C6000000ABFF5400C6000000C6000000ABFF5400C600
      0000C6000000C6000000C6000000ABFF5400C6000000C6000000C6000000C600
      0000C6000000C600000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008383
      830075759B006C6CB300ABAB9C00ABA69F009B97940085D7E6000091DF00BDD3
      E300EFE9E500E0DFDF00D9D9D900DADADA00D9D9D900D8D8D800D8D8D800D7D7
      D700DBDBDB00E1E1E100AAAAAA00000000000000000000000000F0000000F000
      0000F0000000F0000000F0000000DAFF9000F0000000F0000000F0000000DAFF
      9000F0000000F0000000F0000000F0000000F0000000DAFF9000F0000000F000
      0000F0000000F000000000000000000000000000000000000000D2000000D200
      0000D2000000D2000000D2000000D0FF2F00D2000000D2000000D0FF2F00D200
      0000D2000000D2000000D2000000D2000000D0FF2F00D2000000D2000000D200
      0000D2000000D200000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005353
      59007575FA000000D1003838B500ABAB9F00E3DCD7009E9A970088B3CD00F6EE
      EA00E9E8E700E7E7E700E5E5E500DEDEDE00DDDDDD00DCDCDC00F7F7F700FBFB
      FB00FFFFFF00EAEAEA00B0B0B000000000000000000000000000F0000000F000
      0000F0000000F0000000F0000000FFFF6C00F0000000F0000000F0000000FFFF
      6C00F0000000F0000000FFFF6C00FFFF6C00FFFF6C00FFFF6C00F0000000F000
      0000F0000000F000000000000000000000000000000000000000DC000000DC00
      0000DC000000DC000000DC000000DC000000EAFF1500EAFF1500DC000000DC00
      0000DC000000EAFF1500EAFF1500EAFF1500EAFF1500DC000000DC000000DC00
      0000DC000000DC00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006161
      6100C9C9EE003939E2001C1EDB00595BC800A5A59B00A3A19B00EEECEB00EEEC
      EB00E9E9E900E9E9E900E8E8E800E7E7E700DFDFDF00DEDEDE00F1F1F100EBEB
      EB00D7D6D700ACADAC00BABABA00000000000000000000000000F0000000F000
      0000F0000000F0000000F0000000FFFF6C00F0000000F0000000F0000000FFFF
      6C00F0000000F0000000F0000000F0000000F0000000F0000000F0000000F000
      0000F0000000F000000000000000000000000000000000000000E5000000E500
      0000E5000000E5000000E5000000E5000000FAFF0500FAFF0500E5000000E500
      0000E5000000E5000000E5000000E5000000E5000000E5000000E5000000E500
      0000E5000000E500000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A3A3
      A30064646100D1D1D7004D4DEB000607DF002626C100D5D5CE00F3F3F300ECEC
      EC00EBEBEB00EBEBEB00EAEAEA00EAEAEA00E7E7E700E2E2E200EBEBEB00E9E9
      E900CDCDCD00A2A2A20000000000000000000000000000000000F0000000F000
      0000F0000000F0000000F0000000FFFF6C00FFFF6C00FFFF6C00FFFF6C00F000
      0000F0000000F0000000F0000000F0000000F0000000F0000000F0000000F000
      0000F0000000F000000000000000000000000000000000000000ED000000ED00
      0000ED000000ED000000ED000000ED000000FFFF0000FFFF0000ED000000ED00
      0000ED000000ED000000ED000000ED000000ED000000ED000000ED000000ED00
      0000ED000000ED00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009797970053534C008D8DAB00A5A5B000CBCBC500F4F4F400EEEE
      EE00EEEEEE00EDEDED00EDEDED00ECECEC00EDEDED00E6E6E600EBEBEB00ECEC
      EC00AFAFAF00B6B6B60000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000F4000000F400
      0000F4000000F4000000F4000000F4000000F4000000F4000000F4000000F400
      0000F4000000F4000000F4000000F4000000F4000000F4000000F4000000F400
      0000F4000000F400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000076767600AAAAA700B8B8B600BFBFBE00F7F7F700F0F0
      F000F0F0F000EFEFEF00EFEFEF00F0F0F000F1F1F100EEEEEE00F4F4F400E1E1
      E100A6A6A6000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000F9000000F900
      0000F9000000F9000000F9000000F9000000F9000000F9000000F9000000F900
      0000F9000000F9000000F9000000F9000000F9000000F9000000F9000000F900
      0000F9000000F900000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007C7C7C009D9D9D00BBBBBB00B5B5B500FCFCFC00F5F5
      F500F7F7F700F9F9F900FBFBFB00F9F9F900F1F1F100DEDEDE00C8C8C800B2B2
      B200000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000FC000000FC00
      0000FC000000FC000000FC000000FC000000FC000000FC000000FC000000FC00
      0000FC000000FC000000FC000000FC000000FC000000FC000000FC000000FC00
      0000FC000000FC00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800098989800C2C2C200B1B1B100FCFCFC00E7E7
      E700D2D2D200BCBCBC00B0B0B000A4A4A40097979700878787008C8C8C000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000FE000000FE00
      0000FE000000FE000000FE000000FE000000FE000000FE000000FE000000FE00
      0000FE000000FE000000FE000000FE000000FE000000FE000000FE000000FE00
      0000FE000000FE00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008E8E8E0087878700E3E3E300A6A6A600A4A4A4009595
      9500868686008686860098989800ADADAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C008F8F8F009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006A320F009352
      0D00813A0E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CD652000FFCB0E00FFF4
      0500FFC60D006E300F000000000000000000E2810C00CC710A004D1406000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C0000000000000000000C0C0C0000000000000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C0000000000000000000000000000000000000000000257E9C00257C
      9900247894002877910000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B9601D00FFE00700FFE7
      0000FFDB0100E286110057111000AD560E00FFE40300FFF50100EFA007005118
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C0000000000000000000C0C0C0000000000000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C000000000000000000000000000000000000000000033ACD60059BA
      DB0032A1C6002F92B700218BAD002281A1002878940029779200297892002978
      9300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000062321900000000000000000000000000A45E1C00FFD50800FF9D
      0000FF8D0000FC970300F7B80C00FBD30500FFEE0000FFCC0000FFB30100E47D
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000FF000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000000000000008BC6005CBEE000B4EA
      FF006AD6FE005ED0F90052CAF1004CBCE4003FAAD0002A9EC6001A8EB400257E
      9C00287A96002679950026779300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AE692800FFC91E00B0721F0058281A00B9741C00FBCE0E00FFD50000FF93
      0000FF8F0000FF990000FFDF0000FFE80000FFD60000FF9B0000FF910000F679
      0A006A1E0A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000C0C0C0000000000000000000C0C0C0000000000000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000FF000000BF00
      4000C0C0C0000000000000000000000000000000000015A3D7006BC9F000A9E5
      F90085E2FF0079DFFF007BE0FF0079DFFF0074DDFE006EDAFC0066D4F7005AC7
      EB0041B8DF002EA6D0002C94B6002C87A6002481A000257B9800000000000000
      000000000000000000000000000000000000000000000000000000000000945B
      2700FDC31800FFDF0000FFCE0B00FEBA1800FFD60700FFE00000FFC20000FF93
      0000FF940000FF930000FF9A0000FF9F0000FF9A0000FF930000FD940200E885
      0A00D9780C004715080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC0033000000000000000000C0C0C0000000000000000000FF00
      00000000000000000000C0C0C0000000000000000000C0C0C000FF0000000000
      00007F0080003F00C00000000000000000000000000027ADDE0060C7F0009CDA
      EF009BEAFF007CE3FF007FE4FF007FE4FF007FE4FF007FE4FF007FE5FF007EE4
      FF007DE4FF007CE3FE0073DEFA0061D1F30049C3E800269ABF00247793000000
      000000000000000000000000000000000000000000000000000000000000CF89
      2B00FFCD0400FFAF0000FF9B0000FFBB0000FFC30000FFAE0000FF980000FF93
      0000FF950000FF950000FF920000FF900000FF910000FF930000FF970000FEC2
      0000FFCF0200E57E0A0040130600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000CC003300C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FF00
      0000CC003300C0C0C000C0C0C000C0C0C000C0C0C00080007F00C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000028AEDD0052C3F00086D2
      EC00B1F3FD0085ECFF0083ECFF0084ECFF0084ECFF0084ECFF0084ECFF0084EC
      FF0084ECFF0084ECFF0084ECFF0085EDFF007EE7FF0048C3EB002587A6000000
      000000000000000000000000000000000000000000000000000000000000A469
      2E00FFAE1200FF990000FF950000FF990000FF9D0000FF950000FF970000FFA0
      0800FFA21400F6A62000F4AA2400FAA81C00FF9D0A00FF960000FF980000FFA3
      0000FFB30000FFAA0400883A0A00000000000000000000000000808080000000
      0000000000008080800000000000000000008080800000000000000000008080
      8000000000000000000080808000000000000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000CC0033000000000000000000C0C0C0000000000000000000FF00
      00000000000099006600C0C0C000000000000000000080007F00000000000000
      0000C0C0C000000000000000000000000000000000002BAEDD0063C8F6005BC1
      E900BEEFF70094F4FF008CF2FF008DF3FF008DF3FF008DF3FF008DF3FF008DF3
      FF008DF3FF008DF3FF008DF3FF008DF3FF0080E8FF0080E5FD0032A6C6002275
      9300000000000000000000000000000000000000000000000000000000000000
      0000E28E2C00FFA40100FFA10000FFA00000FF9E0000FFA60200FFA92000D59A
      3B00D09E50000000000000000000C7A75F00EEBC5A00FFAA2200FF9D0000FF9E
      0000FFA30000FFAB04009A490B00000000000000000000000000808080000000
      0000000000008080800000000000000000008080800000000000000000008080
      8000000000000000000080808000000000000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000C0C0C0009900660000000000C0C0C0000000000000000000FF00
      0000000000000000000065009A00000000000000000080007F00000000000000
      0000C0C0C000000000000000000000000000000000002DAEDC0071CFFA003FB8
      EB00B7E7F600A6F9FF0092F8FF0094F8FF0093F8FF0093F8FF0093F8FF0093F8
      FF0093F8FF0093F8FF0093F8FF0093F8FF0085ECFF0098EDFF006AD2E7002682
      9F00000000000000000000000000000000000000000000000000000000007D56
      3100ED8F2300FF9C0000FFA80000FFA70000FFAC0A00EAA13500996C3B000000
      00000000000000000000000000000000000000000000FDDA6600FFAD1E00FFA5
      0000FEA20500D570120000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C00099006600C0C0C000C0C0C000C0C0C00080007F00C0C0
      C000C0C0C000C0C0C000C0C0C0003200CD000000FF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000000000000000000000000002AADDC0071D0FC004CC0
      F7008CD5F200C0FBFD0099FEFF0099FDFF0099FDFF0099FDFF009AFDFF009AFD
      FF009AFDFF009AFDFF009AFDFF009AFDFF0089F0FF00A2EEFF00B4F6FA0032A0
      C2002778940000000000000000000000000000000000D18E3D00F0912300F98D
      1B00FF820400FF980000FFB00000FFB30800D58D2E0000000000000000000000
      000000000000000000000000000000000000ACA13800FFF46900FFC34700FFB0
      0200E07C120000000000000000000000000000000000000000000C0000003C00
      000079000000B5000000EF030000FE3E0000FF8F0000FDDF0100D9FD24009DFF
      60005FFF9E0023FDDA0001E6FD0000AAFF00006DFF000031FF000F12FF005D5D
      FF00AEAEFF00F5F5FF0000000000000000000000000000000000000000000000
      000000000000C0C0C0009900660000000000C0C0C0000000000080007F00C0C0
      C0000000000000000000C0C0C000000000000000FF00C0C0C000000000000000
      0000C0C0C000000000000000000000000000000000002CAEDB0079D4FC0061CD
      FD005FC4ED00C8F1F900C4FFFF00BAFFFF00B4FFFF00AFFFFF00A9FFFF00A7FF
      FF00A8FFFF00A8FFFF00A8FFFF00A9FFFF0093F0FF00A6EDFF00D0FEFF007DC9
      E000267E9C0000000000000000000000000000000000EA923500FF710000FF6F
      0000FF7E0000FFAF0000FFBA0200EF9E24000000000000000000000000000000
      000000000000000000000000000000000000CAC14800FFF66300FFCC5100FFB4
      0900FD8F070095411300000000000000000000000000000000000C0000003C00
      000079000000B5000000EF030000FE3E0000FF8F0000FDDF0100D9FD24009DFF
      60005FFF9E0023FDDA0001E6FD0000AAFF00006DFF000031FF000F12FF005D5D
      FF00AEAEFF00F5F5FF0000000000000000000000000000000000000000000000
      000000000000C0C0C0000000000065009A00C0C0C0000000000080007F00C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C0000000000000000000000000000000000030AFDC0083DAFB006DD7
      FE005ACBF5006FCCED0099DAEF00A3DEEF00ADE5F200C6F3FB00D6FBFE00C8FF
      FF00BDFFFF00BDFFFF00BDFFFF00BEFFFF00A3F1FF00B0EEFF00E4FFFF00BEEE
      F7003C99BA0027759000000000000000000000000000EB8C3200FF940000FFA9
      0000FFB10000FFBE0000FFBC1000814D1F000000000000000000000000000000
      000000000000000000000000000000000000FBE85800FBE25D00FCC54A00FFB7
      0600FFBB0000F3881500000000000000000000000000000000000C0000003C00
      000079000000B5000000EF030000FE3E0000FF8F0000FDDF0100D9FD24009DFF
      60005FFF9E0023FDDA0001E6FD0000AAFF00006DFF000031FF000F12FF005D5D
      FF00AEAEFF00F5F5FF000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C00065009A00C0C0C000C0C0C00080007F00C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000000000000000000000000002EAFDC0085DFFC0079E1
      FF007AE1FF006BD9FA0067D7F70071D8F6006DD5F3006ED1F30081D3F000CFF1
      F800E0FFFF00D8FFFF00D8FFFF00D7FFFF00B4F0FF00BAECFF00F1FFFF00E9FC
      FE007EC8DE00217F9F00000000000000000000000000EB993B00FFBC0000FFCA
      0000FFC30000FFC80000EDA41700000000000000000000000000000000000000
      0000000000000000000000000000E9C64B00F9D14E00F2C55900FCBE2F00FFC5
      0000FFBE0D009B521600000000000000000000000000000000000C0000003C00
      000079000000B5000000EF030000FE3E0000FF8F0000FDDF0100D9FD24009DFF
      60005FFF9E0023FDDA0001E6FD0000AAFF00006DFF000031FF000F12FF005D5D
      FF00AEAEFF00F5F5FF0000000000000000000000000000000000000000000000
      000000000000C0C0C0000000000065009A00C0C0C0000000000080007F00C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C000000000000000000000000000000000002FB6DC008BEFFC0084ED
      FF0086EEFF0086EEFF0086EFFF0086EEFF0083EDFE0080EBFD0077E7FA0079DA
      EF00B5E5F300C6EAF500C9ECF500D5F3F900CAF0FD00DBF4FF00FFFFFF00FFFF
      FF00D1F1F900489BB600257692000000000000000000D99E4600F8BC2200FAC0
      1C00FEC50400FFCE0000E89E1900000000000000000000000000000000000000
      0000000000005A441A00E7B34500F5BD4700E7B04700F3B94900FFC41100CD7D
      1800B35C200000000000000000000000000000000000000000000C0000003C00
      000079000000B5000000EF030000FE3E0000FF8F0000FDDF0100D9FD24009DFF
      60005FFF9E0023FDDA0001E6FD0000AAFF00006DFF000031FF000F12FF005D5D
      FF00AEAEFF00F5F5FF0000000000000000000000000000000000000000000000
      000000000000C0C0C00000000000000000003200CD000000000080007F00C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C0000000000000000000000000000000000034B6DC0099F5FC008FFB
      FF0090FBFF0090FBFF0090FBFF0090FBFF0090FBFF0090FBFF0090FBFF0084F2
      FB006CDFF2007EE2F20084E4F1008BE3F30082D8EE0073C8E50070C5E30072C6
      E30072C8E4003B9EBE0025799500000000000000000000000000CE975400F98D
      3800FFA50300FFD50000F5A81300CD813A007958220047311300000000006E4D
      1D00B07C2F00EFAA4100E5A23B00DC983E00E8A34900FFC81E00CA8416000000
      00000000000000000000000000000000000000000000000000000C0000003C00
      000079000000B5000000EF030000FE3E0000FF8F0000FDDF0100D9FD24009DFF
      60005FFF9E0023FDDA0001E6FD0000AAFF00006DFF000031FF000F12FF005D5D
      FF00AEAEFF00F5F5FF000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C0003200CD000000FF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000038B8DC00A4FAFC0099FE
      FF009AFEFF009AFEFF009AFEFF009AFEFF00A3FEFF00A6FFFF00A4FFFF00A1FF
      FF009CFFFF009AFFFF0098FFFF0093FAFD0058D5EB000094CB00000000000000
      0000000000000000000000000000000000000000000000000000DC9D4A00FF65
      0A00FF8C0000FFDD0000F8C50400E3812A00E78D3C00E2913700E3923700EB98
      3900E5933700D6843400D3803B00E6993B00FBCA1800FFDA0600B36C22000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      000000000000C0C0C00000000000000000003200CD000000FF0000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C0000000000000000000000000000000000029A6D40086E2F1009CFF
      FF009AFFFF009BFFFF0099FFFF00B1FDFE00B0EAF60084D9ED0079DAED0074DC
      EE00A5F6FC00B4FEFF00B6FFFF00B2FFFF006CDBED000095CB00000000000000
      0000000000000000000000000000000000000000000000000000C28E4800FF96
      1100FFC60000FFDD0000FFE10000F4BD0800DA772400D46E2F00D26F3000CE6D
      2F00CF6F3100DA7F3400F0AD2600FFCA1600FFD30A00FFD11500B36B26000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000008080800000000000000000008080800000000000000000008080
      8000000000000000000080808000000000000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000C0C0C0000000000000000000C0C0C0000000FF0000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C000000000000000000000000000000000000000000045BADD00C5FA
      FC00B3FAFC00A9FAFC00AAFAFC00BBEDF80042B3DB00008FC7000098CC00039A
      CE0048B8DE0059C1E2005BC4E20054C4E20030B4DA0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5D1
      2E00FFE90A00F3C82800FACA1C00FFE10000FCD60300F2B80B00ECAC1300EEAD
      1600F3BA1500FBD60900F3C51900CA813200C6793400AB692A00000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000008080800000000000000000008080800000000000000000008080
      8000000000000000000080808000000000000000000080808000000000000000
      000080808000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000FF00C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000000000000000000001EA6D30055BC
      DE004BBCDE0044BCDE0045BCDE0040B4DB00069CCF0000000000000000000000
      000000000000008BC6000089C6000089C6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B48E
      4900D1A6480000000000DB863C00FFB60200FFED0000FFED0B00F8D71E00FAD6
      1600FFF70000FFE619007F4B2C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C0000000000000000000C0C0C0000000000000000000C0C0
      C0000000000000000000C0C0C0000000000000000000C0C0C000000000000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CF924200FFD41900FFE41400CB973A0000000000DD9B
      4300F5C62A00D297370000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DFAB5200DBA04D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AAAAAA00767691007D7DB0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A3A09C00ACA49900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008B8A8A0089919100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000098989800303081000000DB001014DF006464A00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000606000006
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ACACAC00675E5400E28A0200F2AC3500E4992100C683
      1F00B68D5600B5ADA10000000000000000000000000000000000000000009898
      9700344D62000288D1003AD7FF00BF9F68000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A0A0
      A000585872000000DC003B50F100758DFF001C24E0005353A200000000000000
      00000000000000000000000000000000000000000000000000007A7A85005B5B
      AF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000B0B00006666000056
      5600000505000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ACACAC006A625400E0860200FEC96B00FFD77A00FFE29100FFEA
      B100FFEAB100E2AA4B00946B3000786947008468320094784200766957002147
      6A00037AC50022E3FF009CF5FF005B9DC6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006C6C
      6C00B8B8EB00B8B7F3000203CE00647EFA006181FF002530E6004444A6000000
      0000000000000000000000000000000000009595940030306E000000D4004C58
      F5006767A9000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000073534000BDDDB000BE1
      DF00086F71000C1F210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063636200EECE9C00E28A0200FFB43700E6951800FFD26E00FFDC
      8000C2AF760084683200986C1800D3BB8600E4E0D700E3DBCD00D3BB8600996F
      2200648C860089FDFF0088C2E300ADB9C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E00000000000000000000000000000000000000000000000000000000005A5A
      5A00D9D8F700F1F1FE009291E7000408CF005F7CFC005879FF003040ED003636
      AE000000000000000000000000008282820019197F000000D4005971F9004B71
      FF003F40D6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000070E0F000262720001E3FB0003DD
      FF000EC8F30005628A000C0D0F00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B9B9B00947C
      5600B6792100B4884500F9F1E500FBF6F100DC931A00D57D0000FFE7AF00B693
      57007A571700986C1800FBF4B900FDFCD700E4E0D700B9B5B000CDCFBD00FDFC
      D700AE7D2B006295A3008BADC400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D1D001D1D
      1D00000000000000000000000000000000000000000000000000000000009A9A
      9A0054545600E3E2FD00EEEEFE007270E0000912D7005A7EFF004E72FF00384B
      F3002A2AAF00ADADAD007A7A7A00141485000000D4005971F9003157FE005563
      EB007474C4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000407150006529C000B96F2000995
      F800029AFF000396F10000497000024B4D000000000000000000000000000000
      0000000000000C0B1F00050328000000000000000000000000005F5A5300F4B8
      5B00E7910C00F0961000DC7A0000D6861600DFB67D00D6830200C0AA84008468
      320093650F00DACA8D00F9F3CA00FDFCD700FFFFED00F5F5E100D9D3A800F9F3
      CA00F9F3CA009C75320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C2C2C002C2C2C002C2C2C002C2C2C002C2C2C002C2C2C002C2C2C002C2C
      2C00000000000000000000000000000000000000000000000000000000000000
      0000959594005A5A5D00E9E9FE00F1F1FE004D4BD900111FDF005879FF004169
      FF00435AFC001414AE000F0F84000000D4005470FC002953FF005E79FB002E2E
      C900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000010B3C000F2B8E00033FA700015F
      C9000870E6000B85F7000C8CEA0001435F000308060000000000000000000000
      00000006380000156300061C3E0000000000000000008991910089755700F3BD
      6800E6951800C3D47E009ED89800E4B54700F59E1D00DB810000643A0200AE8C
      4B00986C1800E3D4A800FDFCD700FDFCD700FFFFE000FFFFE000FBF4B900FDFC
      D700FFFFE000C6A65D00B2AB9D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B3B3B003B3B3B003B3B3B003B3B3B003B3B3B003B3B3B003B3B3B003B3B
      3B00000000000000000000000000000000000000000000000000000000000000
      0000000000008C8C8C0060606400EEEEFE00EEEEFE00312ED300172EE8005175
      FF00345DFF004C67FB000000D2004E6DFD002F59FF00496EFF002327D5009E9E
      C100000000000000000000000000000000000000000000000000000000000000
      00000606030030322700292D2D00191520000F0F5900071A7600102B91000F3B
      9E00054DB3000368D8000A8FFB00028FE100034A690006070C0000000000060D
      200006238500001D77000000000000000000000000009393930076695700F3BD
      6800DE870800B9D4820053FFFF004AFBFF003DFFFF005FB59C0078694700B68D
      5600A3792700DACA8D00E7DDB300D4CDA100D9D3A800D4CDA100C7B88B00C7BD
      9700D9D3A800F2D28B00A3906B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000828282006E6E7600EEEEFE00E7E6FC001614CD002443
      F1005175FF002754FF006989FF003961FF002552FF004859ED005756C5000000
      000000000000000000000000000000000000000000000000000000000000080D
      040048522900898E5A0093A25600737741001D2C40000F116100041A74000D2A
      8A000B3CA200085EC5000777ED000A9CFF00079EE9000C63A6000B408A000230
      B4001027A700010240000000000000000000000000009393930076695700F5C1
      7300E0860200CBCC6D0053FFFF007FFEFF007FFEFF0032A8B0007D897100C2A2
      6B00986C1800C2A46100C5B07900C7B88B00C9BF9800CAC09900CAC09900C7B8
      8B00BBA57900D7AF5E00A1875600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000595959005959590059595900595959005959590059595900595959005959
      5900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007A7A7A0082828D00FBFBFF00D9D8F7000000
      C9001E45FA000F3EFF002552FF00093AFF004E72FF001313C700000000000000
      000000000000000000000000000000000000000000000A09010020231A007070
      46009EA85C0098A3660099976600989864006E6E4F001C1D3A00001560000B19
      8000112E9200034EB8000076DC000F9BFF0005A8FF000394FF000B60F0000332
      CC0001248600080A250000000000000000000000000098989700695E4E00F5C1
      7300DB810000DCC45D0053FFFF0089FDFF007FFEFF0046AFB3006A807000D0B6
      8A0093650F00D7BB8C00DDC79F00DAC8A300D9CBA900D9CBA900D9CBA900DAC8
      A300DDC79F00EECE9C00A48C6000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000686868006868680068686800686868006868680068686800686868006868
      6800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006A6A6A0070709D00110FBA000E0C
      CE003D63FE003961FF003961FF003961FF003961FF000F14CF007C7C99000000
      00000000000000000000000000000000000000000000464423008A975100BCCC
      6800A6BE66009DB2660098A466009998660091985A005A5F49000E1942000917
      68000B2480001637AD000370DA00029AFF0009A6FF000B87FC000550D0000C30
      B30005126B00000000000000000000000000000000009B9B9B00635A4D00FBCB
      8200D57D0000EBBE4D003DFFFF006DFCFF0074FFFF0065D0D4004A686600EAD4
      B500986C1800D0B68A00DDC79F00E2CDAC00E2CFB300ECD8BA00E6D8BD00E2CD
      AC00E9CFAA00D7BB8C00B1A58D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000777777007777770077777700777777007777770077777700777777007777
      7700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AAAAAA0049495A000303AA001416D5004E72
      FF004169FF004066FF004066FF004066FF004169FF004B71FF00222BE3006D6D
      960000000000000000000000000000000000000000001D1D18004E4E34008391
      4800A8B15F00AFBA66009CA76700999A6200868D6900555B5800282838000A0D
      550009197800072B92000867D2000B8FFF0001A7FF000482F900103BCE00002D
      9E0006102D0000000000000000000000000000000000A3A09C005C564C00FBCB
      8200D57D0000F7B8400046FFFF0089FDFF0083FEFF0083F6FE0032717600CAC4
      B400D0B68A00996F2200E2CDAC00EFDEC300FAECD700F9F4EB00F9F4EB00F1E6
      D900F5E5CD00A3813F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000878787008787870087878700878787008787870087878700878787008787
      8700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A6A6A60046465C000202B1001D1DDC006384FF004E72
      FF005175FF006384FF008AA3FF008AA3FF006181FF005175FF005A7EFF003841
      EB00606098000000000000000000000000000000000000000000000001000A0C
      070034341F0066673E00818C550089925A00504F51001A1A3300292937001919
      4D00090B6F00142A89000364C5000298FF0008A9FF000C79E3000339C8000019
      86000000000000000000000000000000000000000000A3A3A3005C564C00FBCB
      8200D57D0000FFB53A004AFBFF0092FAFF0092FAFF0092FAFF0076D1D900446C
      6F00EFE9E200C2A26B009C722200E6D6BC00FFFCF500FFFFFF00FFFFFF00F9F1
      E500AA884500B8AE9A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000969696009696960096969600969696009696960096969600969696009696
      9600000000000000000000000000000000000000000000000000000000000000
      000000000000A0A0A0003C3C61000101BB002122DD007493FF005A7EFF006989
      FF007C98FF00ADC0FF00363CDC00454BDF00ADC0FF008099FF006989FF006989
      FF005360F3004C4C990000000000000000000000000000000000000000000000
      000000000000050502001C1C12003A3A390039393B002B2B300023232F003231
      3700050E50000A2886000552C3000F9EFF0005ADFF000369E2000F32BD000024
      82000000000000000000000000000000000000000000A3A3A30055514C00FDD0
      8700D57D0000FFB841004AFBFF00A3F9FF009BFAFF009BFAFF009BFAFF007ED0
      D700507F8700BEC9CD00D8C2A000A56F1800AE7D2B00C5995D00B58C4A009F75
      2900ACA89E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      00009A9A9A00323262000000BD002225DC0087A1FF006484FF007893FF008EA4
      FF00B0C2FF009DA7F6001614CD004E4DDA006B71E700BDCDFF0092A8FF007893
      FF007595FF00717FFC003E3D9E00000000000000000000000000000000000000
      00000000000000000000000000000B0B06005858290075753500535336004C4C
      3C001E20420001166F00104BB30003AFFF0009BBFF000C57E20005259F00050B
      52000000000000000000000000000000000000000000ACACAC00504E4C00FDD0
      8700D57D0000FFBC480049F1FB00ABF9FF00A3F9FF00A3F9FF00A3F9FF00A3F9
      FF00A3F3FE0089D0DE0061AEC2005CA6BB00529CAA0045A1B00041B7D700E088
      1800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400000000000000000000000000000000000000000000000000000000009595
      94002C2C66000000BD002225DC0096ACFF006989FF007D96FF0094A9FF00ADC0
      FF00DEE8FF000607D300C2C1F200F4F4FF002725D1009BA1F100C2D0FF0099AD
      FF007994FF008FABFF005E68F2009090BF000000000000000000000000000000
      0000000000000000000000000000000000001111080040401E004C4C20006B6B
      480046453D0009085F000F43AC000FB2F40003B2FE000248DE00022A8D000000
      00000000000000000000000000000000000000000000000000004E4D4C00FDD0
      8800D6830200FFBD520045E9F200B4F4FF00ABF4FF00ABF4FF00ABF4FF00ABF4
      FF00ABF4FF00ABF9FF00B4F4FF007CE6FF007CE6FF0023CCFF0023CCFF00E689
      0900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
      C300000000000000000000000000000000000000000000000000909090003030
      85000000C700292EDF00A6BBFF007493FF007994FF0094A9FF00ABBCFF00DEE8
      FF006A6EEE0036368D0060605A00EEEEFE00E3E2FD001614CD00BBC1F800C0CE
      FF0099ADFF009EB4FF002E2EC900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000090909004B4B
      2D0076763400191B4C000440A10003C7F60000B4F2000F40BD000A1251000000
      00000000000000000000000000000000000000000000000000004E4D4C00FBCB
      8200D6830200FFC2570046E3E900BFF7FF00B4F4FF00B4F4FF00B4F4FF00B4F4
      FF00B4F4FF00B4F4FF00B6EDFF00A0ECFF008AE5FE0095DEFF002CCDFF00DC93
      1A00C0B8AB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
      D20000000000000000000000000000000000000000000000000062626100C0C0
      E7003030E4003E43DF00A7BCFF00849FFF008EA4FF00A6B8FE00CCD9FF00CBD1
      FA001212D00000000000848484006B6B7200F1F1FE00D5D5F9000E0CCE00CDD5
      FD00BFD1FF005860E2009695C200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000E0E
      0B005D5D2800464439000B3381000BC9EC000E99F2000021A10005084E000000
      000000000000000000000000000000000000000000000000000053535300F6C7
      8300D6830200FFC35B003ADCE60089F5FF0089F5FF0092FAFF0096EEFF009CF5
      FF00A3F3FE00A3F3FE00B4F4FF00B4F4FF0092E5FF0092E5FF0082E6FF00CAA3
      4300C0B09A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E1E1E100E1E1E100E1E1E100E1E1E100E1E1E100E1E1E100E1E1E100E1E1
      E100000000000000000000000000000000000000000000000000A8A8A8006161
      6000C1C0C4004C4BE6002829D800A6B8FE00A4B8FF00B9C8FF00ECF4FF001F1F
      D1008383C50000000000000000007A7A7A007D7D8700F4F4FF00C1C0F4001818
      D000C8D3FE003636C70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002323130069563100182A730004B7E6000485E800001C8700000000000000
      000000000000000000000000000000000000000000000000000053535300F6C8
      8200DB8B0A00FEC96B00F6D07300EFCB6C00E3C56500E3C56500DAC36300D3C0
      6300CDBF6500C4BC6A00C4BC6A00BDBD7500BABE7E00B9BF8700B4C49D00E4B6
      5300C1A680000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000000000000000000000000000000000000000000000000000000000000000
      00006F6F6F00A4A4A3007A79F1001B1AD600B3BFFB00E3EEFF008186EA003636
      C50000000000000000000000000000000000737373009797A400FCFCFE00BDBC
      FE001010D800A8A8C20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000707070037352300384653000193D5000E5FB60000155E00000000000000
      000000000000000000000000000000000000000000000000000063636200E2CF
      B300F3AC3D00EC910100EE940900EE940900EE940900F0961000F0961000F39B
      1300F39B1300F59E1D00F59E1D00F9A31E00FAA72400FAA72400FAA72400F2A6
      2900C9A266000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000007C7C7C0084847F00A1A1F9000F0FD500B2B8F6000707C900A9A9
      C10000000000000000000000000000000000000000009F9F9F00909090008F8F
      8D00A5A5AB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000F0F09003E403700124198000617790000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009B9B
      9B008B8A8A008B8A8A008B8A8A008B8A8A008B8A8A008B8A8A008B8A8A008B8A
      8A008B8A8A008B8A8A008B8A8A008B8A8A008B8A8A008B8A8A008B8A8A009898
      9700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008A8A8A0071716B00ACACE0000606DB006767C8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000E0D0C000D19290000050D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00A2A2A300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000889088006484
      6400528352005E8E5E007F9B7F00ABB1AB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A6A6
      A60073828E009695900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ACAC
      AC007E8890009E9B970000000000000000000000000000000000000000000000
      000000000000000000009F9F9F0054546F001010D0004D4DB600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A0A0A0004D734D000CA00C0015C1150052E3
      520075F4750075F475005CE65C0026BE26002D9F2D0096B59600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E7E7E001E52
      79001FBAF60056C6E100F0B75A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000085858500234C
      6C0022BBF5005FBDD100E5AD5300000000000000000000000000000000000000
      00000000000000000000656564000C0BC8004F57EB00999FF6001B1BCC006D6D
      B600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007E7E7E00198A190014BC140079F3790094FE940085F8
      850075F4750075F475007FF77F0094FE940094FE940039C839004F984F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000696969000B568F000095
      DB0004D4FF0036E7FF006DB1C200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000707070000E4A79000095
      DA0004D9FF003CE9FF0074A9AF00000000000000000000000000000000000000
      0000000000008A8A8A00333386000000D800B3C2FF00AABCFF00CCD5FF006C6D
      E6004040BF0000000000000000000000000084848400343487005252C5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000078787800118F110020C4200085F6850071ED710045DD450051E5
      510051E551004FE34F004FE34F0055E8550060ED600083FB83006BE76B00339C
      3300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008D8A87008B775D00A17B
      4900A57C4600A4835700B09D8500A9A9A90076767600105185000D89CC0041EA
      FF0004D4FF00C0F9FF0098D8F700A1B3C0000000000000000000000000000000
      00000000000000000000000000000000000000000000918F8D00887964009C7A
      4C00A17B4900A2835B00A89B8800000000007B7B7B0014436F000C86C7003CE9
      FF0003D1FF00C0F9FF0091D7F600A4B4BF000000000000000000000000000000
      00000000000058585A009A9AF0001817D300060BD2006775F200B8C6FF00C3CF
      FF009EA1F3003A3AC70000000000656566000A0AA0000D0DDA00868EF4005454
      C000000000000000000000000000000000000000000000000000000000000000
      0000898989001E7A1E000EB70E0079EF790059E1590042DD420000A4000012B9
      120032D532003AD83A003AD83A003DDA3D0042DD42004BE34B0067EE670071ED
      710040A040000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007A777400B9853F00F0A84400FACC8900FFED
      D400FEF5E500FFF0DA00FCD59F00E8A64C007E71500089C2E8004AC0E40071FC
      FF00A4F6FF00CAF2FD00619DC100000000000000000000000000000000000000
      00000000000000000000000000007E7C7900AF7F4100F0A64100F8CA8200FFEA
      CA00FFF5E300FFEDD100FCD29900E4A2490074684B0081BCE6004DC7EB006EFC
      FF00A7F6FF00C4F0FD00639EC100000000000000000000000000000000000000
      00009090900074748C00FFFFFF00ECECFF00D5D4F6003E3DD600252BDC00B6C4
      FF00B2C0FF008386F6003B3B7C00111186000000D200A2ADFE00ABBEFF005E6C
      EE006F6FBD00000000000000000000000000000000000000000000000000A7A7
      A700455A450000AA000059E1590059E1590031D231002DD02D001DC71D006BC9
      6B0032BA32000ABE0A0020CC200024CC24002DD02D0035D435003DDA3D005CE6
      5C0051D9510075A5750000000000000000000000000000000000000000000000
      000000000000A6A6A6006A605300E59A3900F6CD7C00FFFEDA00FFFFF200FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FFFFF200FDDD9A00E2922D00D5A96E0057D2
      F400E2FFFF00489AC90000000000000000000000000000000000000000000000
      000000000000ACACAC0068615900DD963900F4C57100FFFDDA00FFFEF200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEF200FBDA9400DE912C00CBA9760058D4
      F600E5FFFF004899C90000000000000000000000000000000000000000000000
      0000000000007E7E7E006E6E7300ADADBE00FEFEFE00FFFFFF006261DE003C46
      E400A2B3FF00A9BBFF003336E000444BE900ACBAFF00A3B6FF00A2B5FF001A1E
      D5009696B9000000000000000000000000000000000000000000000000006E6E
      6E001EA11E000EB30E0066E2660029D0290021CA21001DC71D0012C5120000AE
      0000FFFEFF0097DA970000AA000002BD020010C110001BC81B0024CC240031D2
      310060E5600022B0220000000000000000000000000000000000000000000000
      0000A9A9A900635B5200E59A3900F8D88D00FFFFD400FFFECA00FFFEDA00FFFF
      F200FEFEFE00FEFEFE00FFFEF500FFFFE600FFFFD400FEF2B400EDA24600BCA5
      6D0041A4DE000000000000000000000000000000000000000000000000000000
      000000000000625E5800E2993900F7D08300FFFFD300FFFECB00FFFDDA00FFFE
      ED00FFFEF500FFFEF500FFFEED00FFFEE000FFFFD300FDEEB300EEA34700B1A3
      740044A6DF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008585850065656500ECECFD00DBDBFB000C0B
      CD00879AFD006E87FF009FB1FF009AAEFF00889FFF009FB2FF00252CDB006C6C
      BD00000000000000000000000000000000000000000000000000A0A0A000485E
      480007AE07002EC62E004AD64A0015C415000EC00E0008BB080001B9010000B6
      00003BBC3B00FFFEFF00F6FBF6002FB72F0000AE000000B600000ABE0A0015C4
      150029D0290052DC520068A86800000000000000000000000000000000000000
      000061616000DD993D00F0BB6B00FFFECA00FFFECA00FFFCC500FFFECA00F4DD
      A500DB8B0F00DE992900E09E3100FFFFD400FFFCC500FFFECA00FCECAA00D3A0
      5C00AFB0B0000000000000000000000000000000000000000000000000000000
      000067676700D6943E00EEB65F00FFFECB00FFFECB00FFFBC400FFFECB00FFFE
      E000FFFEF500FFFEED00FFFDDA00FFFECB00FFFBC400FFFECB00FEEBA500D19F
      5C00ACACAC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F0068687100BEBEF8005957
      DB004453E9005173FF005C7CFF0095AAFF007286FC000D11D8006867B9000000
      000000000000000000000000000000000000000000000000000078787800519E
      510000A400003DD03D0025C5250006BA060000B6000001B9010008BB08000ABE
      0A0000B10000BCE6BC00FFFEFF00FFFEFF00A1DDA10000AA000000B6000001B9
      01000ABE0A0044D6440021A82100000000000000000000000000000000007E7E
      7E00AE844D00E59A3900FFF6B900FFFCC500FFFABF00FFFCC500FFFECA00F5E0
      9A00EECC9B00FEFEFE00E1A14100FFFECA00FFFCC500FFFCC500FFFCC500F2C4
      7200C5B49D000000000000000000000000000000000000000000000000008585
      85009C7A4C00E99C3900FFF1AD00FFFBC400FFFBC400FFFECB00FFFECB00FFFF
      D300FFFEED00FFFEED00FFFFD300FFFECB00FFFECB00FFFBC400FFFBC400F0C0
      6E00C1B29F000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717172001A1A86008A89E5007674
      E100252AD9003E67FF00587BFF00191DD5000707B60076759F00000000000000
      00000000000000000000000000000000000000000000000000005F5F5F005EC6
      5E00009E00003CCD3C000EBD0E0001B9010008BB08000EC00E0015C115001AC6
      1A0015C4150007AE0700FFFEFF00FFFEFF00FFFEFF00FAFDFA003FBD3F0000B1
      000001B9010015C4150021BD2100ABBAAB000000000000000000A6A6A6005955
      5000F1B15600E9B05800FFF6B900FFF6B900FFFCC500FFFECA00FFFFD400FCEC
      AA00E8B97300FEFEFE00E2AA5300FFFCC500FFFFD400FFFECA00FFFABF00FFF0
      AC00D3A05C000000000000000000000000000000000000000000ACACAC005655
      5300F1B35F00E6A84B00FFF5B800FFF5B800FFF8BE00FFFBC400EBBF6100EBC0
      6100EBC05E00EBC05E00EBC05E00EBC06100EBC06100FFF8BE00FFF8BE00FEEB
      A500CB9C5D000000000000000000000000000000000000000000000000000000
      00000000000000000000A0A0A0004D4D60000303C0000002E1000706C6004C49
      D000161AD300305EFF00204EFF002934E0000000CF000205D5001C1CC7008484
      BA000000000000000000000000000000000000000000000000005252520075D7
      7500009E000033C833000EBD0E000ABE0A0010C1100015C415001BC81B0021CA
      210029D029000EC00E008DD68D00FFFEFF00FFFEFF00FFFEFF00FFFEFF008DD6
      8D0000AE000002BD020026C2260089B18900000000000000000083838300967E
      5F00E9A54500F3C97700FCECAA00FFF6B900F3D38400E5AE4400E5AE4200E3A4
      3200E3A84D00FEFEFE00E8B97300E19E2600E3A43200E3A43200FEF2B400FFEB
      A300E2AA530000000000000000000000000000000000000000008C8C8C008471
      5800EEAB5300EEBE6800FEEEAC00FEEEAC00FFF5B800FFF5B800DA8E1D00F6E5
      CE00F5E0C300F5E0C300F4E0C500F5E3CC00E6B77500FBE29500FEF3B400FEE6
      9E00E0A550000000000000000000000000000000000000000000000000000000
      00000000000000000000535362002929CF00060CDB002456FF001D3FF4000606
      CA002428D700496FFF002250FF00335DFF002253FF002456FF002756FF001120
      DE008C8CBA0000000000000000000000000000000000000000004E4F4E008BE1
      8B00009B00002EC62E0020C4200020C4200037CF370048D3480050D6500056D8
      56005DDE5D0012B91200EAF7EA00FFFEFF00FFFEFF00FFFEFF0093D8930013B5
      13003DD03D0025C525002EC62E0073AF7300000000000000000069696900D2AF
      7E00E09A3C00F7CA7500F6D18100FFEBA400E3A43200F0D0A500F9ECDA00F9EC
      DA00FCF8F100FEFEFE00FEFEFE00FBF6EE00FEFEFE00E8B97300FCE29300F6CD
      7C00EAAD5000C4B7A5000000000000000000000000000000000070707000C5A5
      7B00E4A24900F0BE6600F8D28100FEE69E00FFF1AD00FFF5B800DA8E1D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F5E0C300F3CF7500FEEBA500F5CC
      7800ECB04F00C1B6A60000000000000000000000000000000000000000000000
      000000000000808080007676AB00CECEFF001C1AD2005C78FA006588FF006184
      FF005F7FFE006081FF006281FF006A8AFF005B74F7004E5DEB007290FF00374E
      ED008484B9000000000000000000000000000000000000000000545354008FDF
      8F00009E00004ACE4A0065D965004ED64E0056D856005BD95B0061DD610066E2
      660061DD610028B52800FFFEFF00FFFEFF00FFFEFF0045BE450031C7310061DD
      61005DDA5D0055D655005DD45D006CAE6C0000000000000000005C5C5C00F0C9
      9600DE973900F2BC5D00EBB55B00FCDC8F00E9AE4000F7E7D000FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00EFD1A600F9D07300EFBA
      5B00EDA94600C7B294000000000000000000000000000000000062626200DCB7
      8600E19E4400EEB65700EBB65C00F8D28100FEE69E00FFF1AD00DA8E1900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF3EB00EEBC5700FEE39900F0B9
      5B00EDAC4600C3B1990000000000000000000000000000000000000000000000
      0000000000009F9F9F0057575700E3E3F400D2D1FD001A17D1007481EF00A8BD
      FF00AEC1FF00AFC2FF00B4C7FF00A5B7FF000E0DCF00A7A4EE003E3DDA000A0A
      CE000000000000000000000000000000000000000000000000005F5F5F0098D2
      980020AF200025BB25007EE07E0056D8560061DD610068DF68006CE16C0078E6
      780031C73100C2E9C200FFFEFF00DFF3DF0014B0140061DD610078E6780074E5
      74006AE06A0068DF68005DD45D007AB17A0000000000000000005A5A5A00F0D0
      A500E09E4600EFAF4900E8A94A00F5C87200EBB34A00DE9A3400E1A64900DF9D
      3600E1A64900FEFEFE00FBF1E200D7820000DB8E1600DC8F1400F7D18700F1C5
      8100F1B15600C6AF90000000000000000000000000000000000062626200DBBB
      9000E5A65200ECAB4400E8AB4A00F0BE6600FEE39900FFF1BA00D6820000E2A6
      4D00DE982E00DB932100DA8E1900DA8D1300DA8D1300EFBB6100FFE4A800F0C5
      8100F2B45700C5B1970000000000000000000000000000000000000000000000
      00000000000000000000999999005D5D5D00E7E7E100FFFFFF004E4CE2000A09
      D1003B3EDB005861E7003B42DE000809D10042418B00FAFAF500C8C8D1007575
      B400000000000000000000000000000000000000000000000000787878007896
      780074D27400009E000089E6890070E070006CE16C0074E574007CE77C0085EE
      850014B01400FFFEFF00A1DDA10015B4150085EE85008DEE8D0087EB870081E9
      810078E6780086E486003FC63F0096B59600000000000000000065656500D7C3
      AB00E8AF6300E9A54500F1C58100F2CC9100FADA9E00F7D18700FBDC9D00FFE8
      B100DB8C1100FEFEFE00FCF8F100E7AB4400FFF4C900FFEBB600FBD9A000F0C9
      9600F1C17A00C5B49D00000000000000000000000000000000006B6B6B00C3B1
      9900EEBD7C00E5A03C00F5C88000F0C98C00FBDB9F00FFE9B500FADC9D00FBDF
      A100FDE7AF00FFEDB800FFEEC000FFF1C500FFEEBF00FEE6B100F9D69D00F1CB
      9500F1BF7600C3B4A10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800073737200B5B5B800C1C1
      E0008281E400110ECC000607CF002C31DF000404C60068689000000000000000
      00000000000000000000000000000000000000000000000000009A9A9A005156
      5100C3F5C300009E000052D0520092E9920078E6780081E981008DEE8D0062DA
      620093D893005EC65E0039C839009FF89F009DF59D009AF49A0097F2970092EE
      92008AEC8A00A2F2A20013A8130000000000000000000000000076767600978B
      7B00F7CD9500DF973500F8CF9300EEC89100F4D19B00FEDFA700FFE4B200FFF0
      C200DC8F1200FEFEFE00FEFEFE00E39D2D00FFE9B900FBDCA400F3D1A000F4D2
      A500E5AD6200C0B9B1000000000000000000000000000000000080808000837B
      6E00FEDBAD00DC933100F8CF8D00F0CA9300F6D19900FDDEA500FFE3B000FFE9
      B500FFE8B800FFE6B500FFE6B500FEE6B100FFE2AD00FCD9A600F1CFA100F6D4
      A300E5AC5F000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B001A1A
      B2000D0BCD000005D5003D65FF005376FF002B59FF00090ED800000000000000
      0000000000000000000000000000000000000000000000000000000000006767
      6700A4C0A40072D17200009E000096EB960098EC980089EB89009DF59D000AAD
      0A0015AE150070E07000ACFCAC00ACFCAC00A9FAA900A6F9A600A2F5A2009CF1
      9C00A2F2A20089E689003DA83D00000000000000000000000000999999005252
      5200FEF6DF00DE973900F1B96700F5D3A200EECFA100F4D2A500F9D8A700FFE9
      B900DC911800F3DCB600EEC89100DC8F1400FDE5BD00F5D7AE00F2D9B500F8DA
      B100D79F53000000000000000000000000000000000000000000A0A0A1004E4D
      4D00FEF0D600E19E4400ECAE5600F5D4A400F1D1A300F6D4A300FAD9A600FFE2
      AB00FFE6B500FFEBC500FFECCA00FEE6BF00FBE0B300F4D6AF00F3D9B500F9DC
      B000D6A157000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4A4A4004C4C57005757
      EF001C19D0000022F3000036FF000739FF00083BFF000B2DF1007979B8000000
      0000000000000000000000000000000000000000000000000000000000009E9E
      9E0054535400E1FBE1001DB01D0015B41500AFF5AF00A2F5A20092EE920004AA
      04009AF39A00B4FEB400B4FEB400B4FEB400B4FEB400B1FDB100ADF9AD00ADF9
      AD00BEFEBE0015AE1500A1BBA100000000000000000000000000000000006565
      6500BEB4A800F4CA9100DE952F00FAD19700F4DAB400F2D8B300F4D9B300F9E3
      C200EDC28100E9B86D00EECC9B00F6E2C900F9ECDA00F5E0C100FAE6CB00EDBF
      7F00CAB291000000000000000000000000000000000000000000000000006F6F
      6F00A89F9600FDDEB400DE912C00F8CA8900F6DAB400F2D8B300F4D9B300F3DC
      BB00FDEDD600FDF4EA00FDF7ED00FDF4EA00F7EAD700F4E0C500FAE8CC00EABA
      7800C8B397000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C004F4F5A009393
      FC002522D1002C4DF600466DFF004C6FFF005B7FFF004E66F4006A6ABA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000089898900696C6900E2FEE20000A400002BBE2B00BAF9BA00BAF9BA00ADF9
      AD00B4FEB400B4FEB400B8FEB800B8FEB800B8FEB800B8FEB800BEFEBE00CFFF
      CF0049CB49005AB05A0000000000000000000000000000000000000000009E9E
      9E0052525200F7EEE200ECAE5C00E39C3900FCE0B300F7E4C900F6E1C700F7E8
      D300FDF9F400FEFEFE00FEFCFA00FEFCFA00FAF4E700F9ECDA00F8DAB100D8A0
      570000000000000000000000000000000000000000000000000000000000A5A5
      A50056565600ECE4DA00F0BE7A00E0963000FAD9A600F8E5C800F4E0C500F6E5
      CE00FBF4EC00FDF9F500FDF9F500FDF9F500FCF3E900FCEFDD00F4D6AA00D5A1
      5B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052525200B9B9
      FD006867E3002F38DF0099B1FF009DB4FF00B0C4FF004147DE008E8EB8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000086868600716E7100E9FCE90012AD12000AAD0A00A4F3A400D1FF
      D100CAFFCA00C5FFC500C2FEC200C2FEC200CAFFCA00D5FFD500D5FFD50043CB
      43003DA83D000000000000000000000000000000000000000000000000000000
      0000959595005A5A5A00F7EEE200EDAE5800E49A3600FAD9A800FEEFDD00FBF1
      E200FCF8F100FDF9F400FDF9F400FDF9F400FFFEF500F5D6A800DB9D4900C2BC
      B400000000000000000000000000000000000000000000000000000000000000
      00009C9C9C0057575800E8E3DD00F4BE7400E1962F00F6CD9200FEF0DB00FDF2
      E100FDF7ED00FEF9F200FEF9F200FFFBF800FFFEF200F7D3A000DA9F4D000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E7E7E008080
      8900F2F2FE001C1BDB00656BEC00B8C0FF00696DEA003736C700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009A9A9A0061616100C7C6C7006CD46C0000A4000030C3
      30009CF19C00CFFFCF00DBFFDB00D5FFD500BEFEBE006AE06A0007B307005695
      5600000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E005E5F6100B5B5B500FBCA8A00E89C3400EEAD5400F8D9
      AD00FFF0DE00FFF7EB00FEF5E500FBDDB500F2B15A00C2925100BAB6B0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A50067676700A1A3A500FCD9A600EBA03A00ECA54500F7CE
      9500FDEAD000FDF2E100FDEDD600FAD7A800F1AE5400C0935700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008888
      8800777774009898A0004D4CBC002222B1005A5A9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000096959600747074007D877D0045A1
      45000BAA0B0000AE000000B1000000AE00000CA80C00418E41009DA39D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000929292006B6D6F008E877C00CFA26400EDA9
      4600F2A43C00F1A43A00EBA13E00C2925100988F830000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009A9A9A00707174007E7C7900BD9B6B00E7A5
      4F00F0A64100F2A43D00E19D4000B28A530099938B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A7A7
      A700969596008D8C8D008F908F009E9E9E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009E9E9E008F8F
      91008C8D8D0095959500ACACAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5009A9A
      9A0095969700A0A0A10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000600000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF00FE1FFFFFFFFFFFFFFF000000FC007FFF
      FFFFFFFFFF000000F80007C00003C00003000000F80007C00003C00003000000
      F80003C00003C00003000000F80003C00003C00003000000F80003C00003C000
      03000000FC0003C00003C00003000000FC0003C00003C00003000000FC0003C0
      0003C00003000000FC0003C00003C00003000000F80001C00003C00003000000
      F00001C00003C00003000000E00001C00003C00003000000E00001C00003C000
      03000000E00001C00003C00003000000E00003C00003C00003000000F80003C0
      0003C00003000000FC0007C00003C00003000000FC000FC00003C00003000000
      FC001FC00003C00003000000FC00FFC00003C00003000000FE3FFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6
      DB6FFFFFFFFFC7FFFFFFFFC00003FFFFFFFF831FC7447FDB6DB7C3FFFFFF800F
      F7777F9B6DB7C00FFFFB800FE4667FC000038001FFF00007F65DFFD36D878000
      3FE00003C7667F9B6D9380001FE00001FFFFFFC0000380001FE00001DB6DB7DB
      69B780000FF00601DB6DB7996DB780000FE01F83C00003C00003800007807F07
      C00003D94D3780000780FF03C000039A4DB780000380FF03C00003C000038000
      0381FE03C00003DA4DB780000181F807C000039B4DB7800001C0201FC00003C0
      000380003FC0001FC00003DB2DB780003FC0001FDB6DB79B2DB7C0007FE0003F
      DB6DB7C00003C078FFE401FFFFFFFFDB6DB7FFFFFFFC23FFFFFFFFFFFFFFFFFF
      FFFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFF3FF9FF
      FFFFF07FFFFFCFFFFC03E0F0000FE03FCFFF87FFF80000FEF00FE01F07FF83FF
      F80000FC700FE00E07FF01FFC00001FAB00FE00007FF00F9C00003FEF00FF000
      0FFF0071800001FEF00FF8000FF00023800001FEF00FFC001FE00003800001FE
      F00FFE003F800003800001FEF00FFF001F800007800001FEF00FFE000F800007
      800003FEF00FFC0007C0000F800003FEF00FF80003F0000F800007FEF00FF000
      01FE000F80000FFEF00FE00000FF001FC0000FFEF00FC00001FFC01FC00007FE
      F00FC00401FFE01FC00007FAB00FC00603FFF03FC00007FC700FF00F03FFF03F
      C00007FEF00FF80F87FFF87FE0000FF0000FFC1FFFFFFC7FFFFFFFFFFFFFFF3F
      FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFFFFFE3FFFFE3FC3FFFFE
      003FFFFFC1FFFFC1FC0FFFFC001FFFFF81FFFF81F8071FF8000FFF8000FF8100
      F8020FF00007FE0001FE0001F00007E00003F80003F80003F80007E00003F000
      07F80007FE000FC00001F00007F00007FF001FC00001E00007E00007FF003FC0
      0000C00007C00007FC000FC00000C00007C00007FC0007C00000C00003C00003
      F80007C00000C00003C00003F8000FC00000C00003C00003FC000FC00000C000
      03C00003FF003FC00001C00003C00007FFC03FE00001C00007C00007FF801FE0
      0001E00007E00007FF801FF00003E0000FE0000FFFC01FF80007F0000FF0001F
      FFC03FFC000FF8001FF8003FFFE07FFF001FFE007FFE007FFFFFFFFFE0FFFFC1
      FFFFC3FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList4: TImageList
    Left = 483
    Top = 220
    Bitmap = {
      494C01011B002400240010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000007000000001002000000000000070
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD00678067002C8B2C002CA02C0036A03600599E5900A8B7
      A800000000000000000000000000000000000000000000000000A1A1A1008686
      8600A3A3A3008E8E8E00848484008585850095959500AAAAAA00000000000000
      000000000000000000000000000000000000AF613300AD5F3100AA5D2F00A85A
      2B00A4572700A05423009C4F1F00984C1C0093481800904414008B410F00873E
      0B00843A0800813705007E3402007C3300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000083848300149B140063ED63008EFF8E0086FF860087FF87008EFF8E005CDA
      5C0062A4620000000000000000000000000000000000000000006B6B6B00C4C4
      C400DFDFDF00EFEFEF00F6F6F600F9F9F900F5F5F500E6E6E600CCCCCC00A5A5
      A50095959500000000000000000000000000B8684100EBAE9400EBAD9200E9AB
      9000E6A98F00E4A78B00E0A48800DDA28500D89E8100D59B7E00D1997A00CE96
      7600CB947400C8917200C79070007E3502000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008686
      86000C9F0C0071F271005DEA5D0047E0470042DF420041E1410048E748005EEF
      5E0077F4770055A755000000000000000000000000000000000069696900C3C3
      C300D2D2D200DFDFDF00E2E2E200E8E8E800EDEDED00F1F1F100F5F5F500F7F7
      F700DADADA00000000000000000000000000BB6B4400ECB09600FCF6F500FBF4
      F200FAF3F100FAF1F000F9F0ED00F9EEEC00F8EEEA00F8ECE900F8EAE700F7EA
      E600F6E8E500F6E7E300C8917100813705000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A7002378
      230045DA45004BDF4B002ED22E0028CE280014BC1400609D60005EA15E001CBA
      1C0043E0430064E864007CAB7C000000000000000000000000006F6F6F00C4C4
      C400CBCBCB00DCDCDC00DEDEDE00E1E1E100E5E5E500E7E7E700E8E8E800E8E8
      E800DBDBDB00BBBBBB000000000000000000BE6E4800EDB29A00FCF7F500FCF6
      F400FBF5F300FBF2F100FAF1F000F9F0EE00F9EFED00F9EDEB00F8ECE900F7EA
      E800F7E9E600F7E8E500CA937300843A08000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006266620008B3
      080056DF56001CC91C000FC30F0006C0060000B50000CADACA00FFFFFF0000A2
      000015C9150035D835003EC03E0000000000000000000000000077777700C3C3
      C300C4C4C400D6D6D600D9D9D900DCDCDC00DFDFDF00E1E1E100E1E1E100E2E2
      E200DFDFDF00B7B7B7000000000000000000C3714B00EEB59D00FDF8F700A950
      25008D4E2800C0B8AB00FAF3F100FAF1F000A9502500573A1300B5AB9C00F8EC
      E900F8EAE800F7E9E700CD967600883E0B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ABABAB004A804A000BB7
      0B0034CD340000BB000000A400001989190004880400A1C6A100FFFFFF000986
      09000092000000AE00003BD53B0087B2870000000000000000007F7F7F00C2C2
      C200C0C0C000D4D4D400D4D4D400D7D7D700D9D9D900DBDBDB00DBDBDB00DBDB
      DB00DEDEDE00B4B4B4000000000000000000C7754F00EFB8A100FDFAF900C47A
      5D00DE7543008D4E2800ECE9E600F5F2EF00CD673E008D4E2800573A1300E9DF
      D900F8ECE900F7EBE800D19879008B410F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000949494005BAD5B0006B1
      06001AC11A0005BE050000A90000FFF6FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF001BA11B0011C411004BAC4B00000000000000000086868600C0C0
      C000BABABA00D8D8D800D1D1D100D1D1D100D2D2D200D5D5D500D5D5D500D5D5
      D500DADADA00B0B0B0000000000000000000CC7A5400F0BBA500FDFAFA00C983
      6800E2957700DE7543008D4E2800E3D6CD00DB7C5700DE7543008D4E2800998B
      7600F9EDEA00F8ECE900D39B7C008F4413000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008A8A8A0076C0760000AC
      000030CA300029CB290027BC2700C9D6C900F7F7F700F3F6F300FFFFFF00ECF1
      EC00EAECEA00379C37002BCD2B0034AE340000000000000000008D8D8D00B9B9
      B900B6B6B600DDDDDD00D5D5D500D5D5D500D2D2D200D2D2D200D1D1D100D2D2
      D200D9D9D900B1B1B1000000000000000000D17E5900F0BEA900FEFBFB00D38E
      7100B77E6400D19B8300DE7543008D4E2800C56D4900C9836800B6613900573A
      1300E9DFD900F8EEEB00D79D7F00934817000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009393930080B5800006AB
      060072DF720058DA580059D7590034AC34003AB73A003A953A00FFFFFF005FA5
      5F004CCC4C0054CF54006AE06A003CB13C00000000000000000093939300B4B4
      B400B2B2B200ECECEC00DFDFDF00D9D9D900D7D7D700D7D7D700D6D6D600D5D5
      D500DCDCDC00B7B7B7000000000000000000D6825D00F2C1AD00FEFCFC00D897
      7D00B77E6400E6BBAC00C9836800DE75430085452300E0AA9600D17446008D4E
      2800A08F7B00F9EFEC00DAA08300984C1B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA006E806E002DBB
      2D006BD96B0070E1700074E574007FEC7F008DF78D0047A44700FFFFFF009CC4
      9C0089F3890080EA800089EA890046AD4600000000000000000098989800B0B0
      B000AEAEAE00F0F0F000E7E7E700E7E7E700E0E0E000DBDBDB00DCDCDC00EDED
      ED00F7F7F700C5C5C5000000000000000000DB866200F2C4B100FEFEFD00DCA0
      8800B77E6400F5E4E000DCA08800E1AC980088482600E2CBC200DDB9AB00B661
      3900573A1300F5F0ED00DEA286009C5020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000061606100A2E6
      A20016B5160096EC960086EA86008EEE8E009CF99C0044A64400579E57003690
      360097F3970098F298008BE78B0082B4820000000000000000009E9E9E00A3A3
      A300ABABAB00F4F4F400EAEAEA00E9E9E900EAEAEA00E4E4E400DFDFDF00FAFA
      FA00DAD9DA00AAAAAA000000000000000000DF8A6700F4C7B500DF967B00E4A8
      9100E4A89100AD796400FFFFFF00D1866800914F2F00E2CBC200E1AC9800C781
      6800B6613900D49A8000E1A58900A05324000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A000838D
      83004DC84D0059D45900A8F5A800A0F4A000AAFBAA00B3FFB300BBFFBB00BAFF
      BA00B6FFB600BCFDBC0036B73600000000000000000000000000A4A4A4009D9D
      9D00A9A9A900F7F7F700EDEDED00ECECEC00ECECEC00ECECEC00E3E3E300F7F7
      F700BFBFBF00B7B7B7000000000000000000E48E6A00F4CAB800D8957E00D28C
      7200D28D7400C8745500DFBBAE00FEFBFA0099563800FCF8F700CA745300CB7A
      5C00CE795A00C66B4900E4A78C00A45727000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008A8A
      8A00A5ADA50039C239005FD85F00C4FFC400C1FFC100C0FFC000C1FFC100CAFF
      CA00D6FFD60054CD540092B99200000000000000000000000000A7A7A7009797
      9700A7A7A700FAFAFA00F1F1F100F2F2F200F3F3F300F6F6F600F5F5F500FFFF
      FF00A5A5A500000000000000000000000000E7916D00F5CCBB00FFFFFF00FFFF
      FF00FFFEFE00FEFEFE00FEFDFC00FEFCFB00FEFBFA00FDF9F900FCF8F700FCF7
      F600FCF5F400FBF4F300E6AA8E00A75A2C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009A9A9A00827D82006EC66E0021C2210089F08900C0FFC000C1FFC10090F4
      90002CB02C008DA78D0000000000000000000000000000000000ACACAC008888
      8800ACACAC00FFFFFF00FCFCFC00F2F2F200E2E2E200CACACA00A6A6A6008F8F
      8F0000000000000000000000000000000000EB937100F6CEBE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFE00FFFEFD00FEFDFC00FDFCFB00FEFAFA00FDFAF900FCF8
      F800FCF7F600FBF5F400E9AB9100AA5C2E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009F9F9F007B7D7B005378530036833600438343007C90
      7C00000000000000000000000000000000000000000000000000000000008585
      8500B6B6B60099999900828282008282820097979700ABABAB00000000000000
      000000000000000000000000000000000000ED967300F7CFC000F6CEBE00F5CC
      BC00F4CAB800F4C7B500F2C4B100F2C1AD00F0BEA900F0BBA500EFB8A100EDB5
      9D00ECB39A00ECB09600EBAE9400AD5F31000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADADAD000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ED967300ED967300EB947100E891
      6E00E48F6C00E18C6700DD886400D8846000D4805B00CF7C5700CA785200C574
      4F00C1704B00BD6E4700BA6B4400AF6133000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009EA3A6009BA5
      AC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ACACAC0067677F002C2D8A002C319C0036379D005A5A9900A8A8
      B800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000001212000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000959595003D8FC60039C7
      FE0031BAF50024A3E400248CC8003582B00053819F007494AA00919BA200A7AE
      B200000000000000000000000000000000000000000000000000000000000000
      00007E7E800013149B006474F3008EA4FF00879DFF0088A0FF008EA5FF005A68
      D9005F5F9F000000000000000000000000000000000000000000000000000000
      000000000000000000000455540006A7A6000441430000000000000000000000
      000000000000000000000000000000000000000000000000000018799C001879
      9C0018799C0018799C0018799C0018799C0018799C0018799C0018799C001879
      9C000000000000000000000000000000000000000000686766005CB9F6004CDC
      FC0071F5FA007BF4F10071F8FF0062F5FF004FEDFF003BE3FF002BD7FF0020C8
      FE001BB6F80022A0DB00459ACB00000000000000000000000000000000007F7F
      7F000B0CA2007483FF005D6EFF004857FA004453F9004655F9004D5EFC006073
      FF00788AFF005051A30000000000000000000000000000000000000000000000
      000000000000000000000472910007CFFF00079ED80007364F00000000000000
      000000000000000000000000000000000000000000001896C0001896C0001896
      C0001896C0001896C0001896C0001896C0001896C0001896C0001896C0001896
      C00018799C00000000000000000000000000000000006362620062BAF6002DCA
      F9003ADCD00034C34C0028C7570027C85B0031CA620057DD940052D5820067E2
      A90061DEAB0077EED1002DC0F500000000000000000000000000A3A3A3001D1D
      7B004D57F0004856FD002E38F7002831F600242CF600242CF6002831F600303B
      F7004353FD006574F9007575A900000000000000000000000000000000000000
      0000000000000305280008348B000662CB00077EED000679CA00013747000000
      00000000000003104B000515460000000000189AC6001B9CC7009CFFFF006BD7
      FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
      FF002899BF000C72A5000000000000000000000000006767670068BCF40039CB
      F70089DBD500FFAB5700FAB87300D8C07A0083BD670022AC47000EA135001DA7
      410021A7410027A3340026CAFC000000000000000000000000005B5B63000709
      B400585FFF001A22F6001013F7000508F8000001FA000000F9000101F900080A
      F900161BF900333FFF003E44CC00000000000000000000000000000000003E42
      2800585E48002E3140000A176D000B2D8F00084FB8000881F0000583C9000638
      5C0005206800061D80000000000000000000189AC600199AC60079E4F0009CFF
      FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BDF
      FF0042B2DE000C72A5000000000000000000000000006B6B6B006FBEF3002FC5
      F5007DE2DE00F5AA5300EDB76E00F6C58700FFCB9000FCCD94007DA25100076F
      0A0000660100005B00001ACCF1009DB5C40000000000A6A6A600464587001012
      C6002E33FC000000F3000000EE000F0FA0002727B0001717AD001110AF001010
      B3000000B9000304F8003B43FC007D7DAE0000000000293016005D65390094A1
      5C009BA2650083845700272E4800061971000C369D000571DC0009A3FF000884
      F300073DCA00041A76000000000000000000189AC60025A2CF003FB8D7009CFF
      FF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084E7
      FF0042BAEF000C72A5000000000000000000000000007171710071BBEC0023B9
      F2006CE4E800F5A84D00EBB97300F4D7AE00F2CB9200F6C58500FFC98B00FEC6
      8400EBB97200E8A74E005FDDE90085AEC800000000008B8B8B005655B1000C0D
      CE001414F8000508F3000A11F4006E6DBF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006E6FC5000105F8001111FC004343AF00000000003D3E27007E884800A3B1
      60009EAA66009296640050564D00111750000D2085000764CE0004A0FF000877
      F000062FA80003114A000000000000000000189AC60042B3E20020A0C900A5FF
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7
      FF0052BEE7005BBCCE000C72A5000000000000000000757575007ABDEB001AB0
      ED0062E7F200F4A34600E8AF6100EBB87000ECB97100EFC18200F4D1A300EEBC
      7600EBB46900F5AD5A0085D8C90064A7CF0000000000808080006F6FC2000303
      C500292CFA00262EF5003B45FA004C4CB600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009C9BD300373FF6002A2FFD002E2EBA0000000000000000000C0D08002D2E
      1B005A5E3A005D5F4E002828370021203F000B176E00075BC20006A2FF000869
      DF0004249B00000000000000000000000000189AC6006FD5FD00189AC60089F0
      F7009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF005AC7FF0096F9FB000C72A50000000000000000007979790079BBE60015A9
      EB0059EAFB00F19E3D00E5AA5900E7AD5E00E8B06400EBBB7600EFC89100E8B4
      6900F2D7B000FEDFC100B1D9B70042A3D900000000008A8A8A008484C0000708
      B2007077FF005860F900636EFD000B0A9F004E4CB8003C3BB2003332B0003232
      B1001E20A8005D68F4006970FF003939B9000000000000000000000000000000
      00000000000031311E005858300049483700161F5400094DB30008B0FE000757
      D500061D8100000000000000000000000000189AC60084D7FF00189AC6006BBF
      DA00FFFFFF00FFFFFF00F7FBFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084E7FF00FFFFFF000C72A50000000000000000007F7F7F007FBCE20010A4
      E80051ECFF00F1A44C00E9BB7C00E4A95600E5AA5700E5AA5800E5AA5600E4A5
      5000EEC18700F1B97700CCBE7A0027A6E30000000000A3A3A300787891001615
      AE00767DFA006D76FB007683FD007787FA008293FD00899CFF008FA4FF0090A4
      FF008B9DFF00818FFE008892FF003E3FB0000000000000000000000000000000
      000000000000000000001C1C0D004C4C2C00434141000846A00006B8F9000747
      BA0000000000000000000000000000000000189AC60084EBFF004FC1E200189A
      C600189AC600189AC600189AC600189AC600189AC600189AC600189AC600189A
      C600189AC600189AC6000C72A5000000000000000000828282007EB7DE000C9D
      E5005CF2FF00FBBF7F00F2BD7E00E89A3C00E99B3C00EA9B3D00E69D4000E29D
      4100DA9F4800D1A45300BEC48A0021B1EB0000000000000000005F5F5F008F8E
      DD00292DC900939EFF008593FC008F9FFC0097AAFE009EB2FF00A2B6FE00A1B5
      FE009CAEFD0097A7FF00919CFA007676B0000000000000000000000000000000
      000000000000000000000000000016160C00504B2900194C820008ACEF00042E
      9B0000000000000000000000000000000000189AC6009CF3FF008CF3FF008CF3
      FF008CF3FF008CF3FF008CF3FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00189AC600197A9D000000000000000000000000008888880083B6D7000B9A
      E2005EF3FF00B9C29600A5CDAB009BD9C00098E8DB0096F7EF0094FFFF0092FF
      FF0089FFFF0076FFFF0064F7FF002BB9F3000000000000000000979797009393
      9E002F2EB9007179EB00A5B2FF009EB0FE00A7BAFE00AFC4FE00B3CAFF00B3C9
      FF00B1C5FF00BBCBFF003A3EBF00000000000000000000000000000000000000
      0000000000000000000000000000000000002D281600304D6200077DCD000326
      850000000000000000000000000000000000189AC600FFFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF00FFFFFF00189AC600189AC600189AC600189AC600189A
      C600189AC600000000000000000000000000000000008B8B8B0080B1D4000D9B
      E40066FEFF0067F9FF0066F8FF0062EFFF0055DFFF003EC8FF002CB2F500259B
      DE002C85BF00437A9E00657C8C008F979D000000000000000000000000008080
      8000B1B0BD002220B6007582EA00C3D3FF00BFD3FF00BED4FF00C0D4FF00C8DB
      FF00D5E7FF005F68D3008A8AB700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000022292F000B255F000000
      0000000000000000000000000000000000000000000021A2CE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00189AC600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000959595008DACBF000F9C
      F2001A9DE700208CCE00357CAB005377900074828C0093979A00A9A9A9000000
      0000000000000000000000000000000000000000000000000000000000000000
      000091919100898988005554C0002A30C60099A9F500C7D9FF00C7D9FF009CAB
      F8002F34B4008484A30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000020301000000
      000000000000000000000000000000000000000000000000000021A2CE0021A2
      CE0021A2CE0021A2CE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A4A400A1A2
      A200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000999998007474790049487B002E2D88003D3D83007474
      8900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000072787D00287AAA00428FBB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000807A7300B57E2700BB8F4C00000000009A8E7C00B7B0
      A400000000000000000000000000000000000000000000000000777F77003A9A
      3A00469C46005EA15E009BB99B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006469
      6C00029CED0034E6FF0030E1FF003596CC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ACAAA7007C7C7C00DAA45100F4BC5300FEE69900B77F2500EEAD3A00EDBD
      60000000000000000000000000000000000000000000989898001F981F0094FF
      94006EF86E007CFC7C006FE969002C3064005B5ED700484CB5005053A6009C9A
      9900A7978200AEA8A1000000000000000000000000000000000002964A00029A
      4A0002AA5A000296460002923A000000000000000000020286000612A6000E22
      B60002028A000000000000000000000000000000000000000000000000006FA0
      C000089EED009AF6FF0043CBF2006EDFFC005697BF0000000000000000008B8B
      8B009A774000B2A48E0000000000000000000000000000000000000000007F7F
      7F00DE8B0C00DF992500E2931600FDDA8500FFDF8900FFDD8400FFE89B00FADC
      8D00A78E7000AFA9A0000000000000000000000000006867680031C031005FDF
      5F001ECA1E0026CF26006DF36300003A5D008A9AFF00637BFF0085A0FF009458
      2F00FFF19900FEF1B300BF9E6B00000000000000000002A2560002B2620002CA
      760002D6820002CA760002AE5600026A5600020696001632CA002256F6002662
      FE001E46E2000616A20002028A000000000000000000000000000000000090A6
      B40096D1F90018B7F10094EFFE003EDFFF0045C7F60081919F006A605E00CE7D
      0500FFB93900F29E1B0000000000000000000000000000000000A4A4A400B19F
      8200EF9F2000FFDE8300FFD77C00FFDA8300FFF0B100FFE09200FFCE6F00FFCE
      6600FCCD6B00FBC25700B9A88D000000000000000000616061003AC33A003CC8
      3C0000B8000000B9000035D52C00004946005C5EFF002730F8004D62FF006C43
      5000FFDD7100FFF4B000DBAB5900000000000000000002BE6E0002D27E0002CE
      7E0002CE7A0002D27E0002DA7A0002827A002246EA002A6AFE002662FE002256
      F6002256FA002256F6000A16AA00000000000000000000000000000000006362
      6200EEF9FD005CB5EC0046CEF9008CF8FF004CECFF0031A7E100C9760200FFBE
      4400FFAE2900FFD17500BFA377000000000000000000000000008F8F8F00C7C1
      B800EBAF5400F6BC5000FFCF6D00FFF9C100FFF5BA00FFE19100FFD16F00FFCD
      6800FFD37700FFCB6800C4AB87000000000000000000626062003DC43D004BCE
      4B003ED23E003DD33D0037D42F00006031003C35FF000000F300181FFF005237
      6F00FFCE5300FFDF8A00E8B86400000000000000000006CA7A0006D6860002CE
      7E0002CE7A0002CE760002D6760002928A002652F6002A66FE002662FE001A46
      EE00163EEA001A46F2000A26BA00000000000000000000000000000000000000
      000066686900F3FEFE00279FE5007EE6FE007DF9FF0052EBFF0056A1BA00FFB3
      2900FFE09300E09B270000000000000000000000000000000000000000005E50
      3C00DA830000FFC65B00FFDB8400FFFECA00F9DD9000DF962700E4A74900F6B9
      4A00FFE08C00FFCE6A00BA996A0000000000000000006664660043C6430085DE
      85007EE87E0083EA830087ED81000B7833003026F7000E15F500060DFF003828
      8E00FFC23B00FFCD6600F6C2650000000000000000001AD2920026DE9E0036E6
      B20056F2CE0026DE9E0002D6760002968E002252FA002A66FE003672FE002E62
      F600163EEA001232EA000A2EC600000000000000000000000000000000000000
      00000000000080838600E5F8FF000699E500A9F6FF0075F8FF0053DEFF0099BF
      BA00F9B64B00BEA88700000000000000000000000000A8A8A8009C784400F29F
      1800FFCA6100FFCB6400FFD37500FFF7BA00D8952800898B9100FFF8E700E09A
      2F00FFE28E00FFE08B00FABD4E00C0A06E00000000006969690045C6450085DE
      85008FF48F0097F6970093F68F0010872B005147F3005B66FB004E5AFF002D28
      AE00FFB42800FFBD4400FEC25900BFB29E00000000002EDEA6005EF6D6006AFE
      E2006EFEE6006AFEE2003EF6BA0002A2A2002A6AFE005A9AFE005692FE004A8A
      FE003E7EFE002A56F6000E3ED600000000000000000000000000000000000000
      00000000000088888800AAB0B700BCE5FF0002A6ED00C1FFFF0077FDFF001FAB
      E800BB8F5300000000000000000000000000000000008E8E8E00D7AD6D00E795
      0E00FAC76200FFCE6A00FFC96500FFE9A500E5A5370059595900E2A74D00D886
      0A00FFE7A100FFE9A000FDC15300C99F5D00000000006D6D6D0055CB55007DDB
      7D00A4FFA400B1FFB100A6FFA10013972400726BEF008291FF007F8EFF005356
      D200F9A41D00FFB53600FFBC4A00BFA88500000000000ACE820032E2AA004AEE
      C6004EF2CA003AEEC2003EDEA6008AAE76007682B2004E9AFA0062AAFE0062A2
      FE004E8EFE00226AEE000A52DE00000000000000000000000000000000000000
      000000000000000000005A5A5A00817C7E00668DA90020BEF800A0FEFF003A9B
      D7009A8680009C9694000000000000000000000000009E9E9E009E9A9400EAD7
      BE00E5A23A00F9CB6F00FFD37E00FFDA8D00FFDD8700C27B0C00BC6B0000EBB3
      4F00FFEEB200FFECAF00D89C390000000000000000007C7C7C00BDE6BD003DC3
      3D0066D8660066DA66005CD85500257E55006661DE008FA1FF0090A5FF005E68
      E700E49F3800FFBE5200FFC76700C5A36F00000000000000000002CA760006D6
      8E001EDE9E0062CE8A00DABE7600FEB66200FEA24600B68E7A006292DA003692
      FE000E6EF6000A5AE60000000000000000000000000000000000000000000000
      0000919191005C5654008A797400CEC3BD00E9D9D2004F98C6002C7CB000F0EF
      EF00E6E0D800B3A8A20000000000000000000000000000000000000000005658
      5B00F4C98900E7A94200FFDA8E00FFDF9800FFDB8E00FFDC8F00FFE09A00FFEA
      AC00FFF8C900FFE29D00E8B154000000000000000000000000007C7A7C00A0A6
      A000879B8700869385004E5258005F58D2005353CE009BB3FF00A1BCFF006E7E
      F700C88B3D00FFC15600FFBF5700CEA15D000000000000000000000000000000
      00008AA24E00FED29200FED28E00FEC27A00FEA24A00FEA64600EE9646005A6E
      8E00000000000000000000000000000000000000000000000000000000000000
      00006457540097858000E4E1DD00FAFBF90083716B00DDD2CD0099827800F8F4
      F100B7ADA800ADA09D009E94910000000000000000000000000000000000655B
      5200DE820000F5CE8100FFECB200FFDB9300FFE9AE00FFEDB700FFF0BD00FFF6
      CB00FFEBB000FFDF9B00FCD78C00C3B197000000000000000000000000000000
      0000000000000000000056565B007473D9003335BB00ADC8FF00B5D4FF007B8E
      FF00B1784000FFCC6C00FFC35D00D7A354000000000000000000000000000000
      0000DA8E3A00FEE6AE00FEDEA200FECE8A00FEA24A00FEA24A00FA9E4200CE7A
      0E00000000000000000000000000000000000000000000000000000000005850
      4F00816F6800EBE9E600F2F3F000DFD9D400544D4C00B9B3B000A2938F00DDDA
      D900A99D9800CAC1BE00998B8500000000000000000000000000AAAAAA009286
      7500F9B44900FFDE9700F2C36F00FADA9500FFE5A800FFDF9F00FFE3A500FFE2
      A400FFEAB200A67933009B8F7D00000000000000000000000000000000000000
      0000000000000000000077777700CFCFEA006D6DD7005357D2003A40BF003432
      AF00DE9E3900FFD58400FFC96D00E3AF5D000000000000000000000000000000
      0000DAA25200FEF6C200FEE6AE00FEDEA200FECA8200FEAA5600FA9E4200D28A
      2E0000000000000000000000000000000000000000000000000068676700AF9E
      9A00C0B6B200FFFFFF00D6D1CD0090827E0000000000807F7E00EBE7E5009788
      8300E7E4E3009F99970094939300000000000000000000000000000000008888
      8800ADA9A200B5833700A5947C00E9AA4A00F3D29100FFF5CB00F4D18A00F5D1
      8D00FFF5C700BEA98C0000000000000000000000000000000000000000000000
      0000000000000000000000000000A0A09F009E9E9D00A3A3A3005E5D5B00FED3
      8200E5A43B00FFDD9900FFD38100EDBC6B000000000000000000000000000000
      0000E2AA5E00FEF2BA00FEEEB600FEE6AE00FEE6AE00FEE6AA00FABA6E00DE96
      42000000000000000000000000000000000000000000000000008B8B8B00A5A4
      A300A7979200C3B9B4008E827E00000000000000000089898900A9A8A900E5DF
      DD00BAACA700AC9F9A0000000000000000000000000000000000000000000000
      00000000000000000000605B5300FFC66A00FACB7900FED89000CBAB7D00FED7
      9D00DFA03E00C0B39E0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000076767600FADB
      AC00F8C37300FFDB8C00FFDE8D00EAAA41000000000000000000000000000000
      0000DE9E4A00EAB26A00FADEA200FEF2BE00FEEEB600F6D28E00E6AE5E00E29E
      4E00000000000000000000000000000000000000000000000000000000008989
      89009B9B9B00958E8B0000000000000000000000000000000000000000009393
      93008D8D8D000000000000000000000000000000000000000000000000000000
      000000000000000000009A9A9A007F7E7C0096774800B18C5300ABABAB00A0A1
      A200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      85008A8A8B00997F57008F7F6900AFACA7000000000000000000000000000000
      00000000000000000000EEAE6200F6CE8A00F6C27E00EAAA5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A7005D7D5D00278E27002DA32D0032A13200509D5000A2B7
      A200000000000000000000000000000000000000000000000000000000000000
      00008E8E8E003587BA00759FBA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A4A4A400966B2D00EDAB4100CD964100B8945D00B8B1A600000000000000
      000000000000676970000C8ECC008CB19E000000000000000000000000000000
      0000797C790013A413006CF26C008EFF8E0084FE840084FE84008EFF8E0062DE
      6200569F56000000000000000000000000000000000000000000000000000000
      00005E7786003CADF30055E1FF002A99D40089ABC1000000000000000000868A
      8E00477C9E00A7B8C30000000000000000000000000000000000000000000000
      000000000000FFFFFF00C0C0C0008080800080808000C0C0C000FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000A9A9
      A90093784F00FCAC2E00FFC95C00FFEA9400F4E1A5009E752A009B793900B898
      5E0091733B0033718E0065FBFF007BB9DC000000000000000000000000007B7B
      7B000CA90C0075F3750051E3510021C4210041DE410043DE43004BE24B005DED
      5D0079F479004CA84C000000000000000000000000000000000000000000AAAA
      AA005F79880054B1F00038DBFD005CF3FF004BDAFE002883B6001A90D0003CD3
      FE006EF5FF0090B1C6000000000000000000000000000000000000000000FFFF
      FF00C0C0C000800000008000000080000000800000008000000080000000C0C0
      C000000000000000000000000000000000000000000000000000947E5B009468
      2600F9E1C100EEC28000E08C0D00E5C48D007E5B1900C5AD6600FFFFE500D7DB
      DD00DCDBC800DEBE7C0074999A00000000000000000000000000A0A0A0001A82
      1A004FDF4F0046DC46002ED22E001CB61C0050C5500011C411001FCB1F002ED2
      2E0041DE410066E966006FA96F00000000000000000000000000000000000000
      000056646C0071C0F60002BBF30058EDFF0046E8FF0076FAFF0073F9FF0063F1
      FF001ED8FF0085ADC60000000000000000000000000000000000FFFFFF008080
      8000800000008000000080000000800000008000000080000000800000008000
      0000C0C0C000000000000000000000000000000000006E6E6D00F8B75300FDB7
      4000DAA22900EB8E0E00D77D0000856A42009A701C00F2EEBF00FFFFE200FFFF
      EA00EFEDBE00FFFFE700B6934F000000000000000000000000005862580007B5
      070055DE550019C719000FC20F0000B80000A6DFA600C0E8C00000B0000000B9
      000013C3130031D431003FC43F00000000000000000000000000000000000000
      0000575C5F008ACFFE001AAFE90013D5FF005FECFF002DDBFF0034DDFF005DEB
      FF0011D4FF007EAAC70000000000000000000000000000000000C0C0C0008000
      00008000000080808000FFFFFF00FFFFFF00FFFFFF00C0C0C000800000008000
      000080000000FFFFFF0000000000000000000000000060616000F8BA5C00EDB6
      4A0044FFFF005DFFFF005CAB8D00A88A5900A87F2B00E1D6A500DAD3A800D8D3
      A800C8C39500D5CCA000DFC07700B7B2A90000000000A4A4A400468C460010B9
      10002CCA2C0000B8000003B9030003BC030003B40300FFFFFF00FFFFFF004BC3
      4B0000B2000000BB000039D339007AB07A000000000000000000000000000000
      0000605E5E002C9BE30044C4EE0044E5FF0014D3FF0046E3FF003FE1FF0010D2
      FF0045E6FF00589FCB00000000000000000000000000FFFFFF00800000008000
      000080000000FFFFFF00C0C0C0008000000080000000C0C0C000FFFFFF008000
      000080000000C0C0C00000000000000000000000000062626300F8BD6200F7A8
      2F004DFFFF0077FFFF0034A6AF00BDA984009E701B00D1B98300D1C39C00D0C6
      A300D1C5A200CFBF9900D5B37300B6AEA100000000008A8A8A0054B654000CB5
      0C0014C0140006BC060010C2100018C7180012C8120049C34900FFFFFF00FFFF
      FF00CFEDCF0006B206000FC10F0041AC4100000000000000000000000000A3A3
      A300235F8A0025B6F30064F2FF003CE0FF0019D3FF0064EEFF0082F6FF0014D3
      FF0042E4FF0047D7F7007CA8C4000000000000000000FFFFFF00800000008000
      0000C0C0C000C0C0C00080000000800000008000000080000000FFFFFF008000
      0000800000008080800000000000000000000000000068686800F6BE6900F9A0
      1F004EFDFF007DFFFF005BC6CC00AAA59100AB803600DCC19700E6D0AD00E9DA
      BB00E8DAC000E6D2B100CFAF7B0000000000000000008080800071C6710003AF
      03002CC92C002BCA2B0042D3420050D9500050DC500057C65700FFFFFF00FFFF
      FF0095DA95002EC52E002ECC2E002EAE2E00000000000000000000000000335B
      76000BA2F00056EFFF005AEBFF006DF0FF0057E9FF002FDCFF0066EEFF0031DC
      FF005CEBFF0045E8FF001CB8EE009EB4C10000000000FFFFFF00800000008000
      0000C0C0C000C0C0C00080000000C0C0C0008080800080000000C0C0C0008080
      800080000000808080000000000000000000000000006E6E6E00F4BE6E00F999
      12005EF7F6008DFEFF0085F9FF00507F8200E2CDB300AD843C00F4E1C900FFFF
      FE00FFFFFF00F0E4D100AD966A0000000000000000008B8B8B0082C1820007AD
      070072DF720059D8590063DE63006EE36E0043D14300ECF7EC00FFFFFF004DC4
      4D0057DA570066E066006ADF6A0039B3390000000000000000004F5F6A000594
      E60079FEFF006EF8FF003BE3FF0033DFFF0049E6FF0020D7FF0065EDFF0029DA
      FF0058EEFF006BF9FF0077FEFF0033A1DC0000000000FFFFFF00800000008000
      0000C0C0C000C0C0C00080000000C0C0C0008080800080000000FFFFFF008000
      0000800000008080800000000000000000000000000074747400EEBD7100F697
      110067F0EA009EFBFF009CFDFF008BE6F0006D9CA400C1BDAE00A87C3500C399
      5B00BB9C6300A7895700000000000000000000000000A4A4A400788F780019B3
      190076DE76006EE06E0075E5750083EC830047C34700E8F5E80039C3390084EF
      840089EF890080E9800089EA890040AE40000000000081818100ABDCFA0045B7
      FE001CA4EF0006A2EF0019B6F20044D1F70023D6FD0000CBFF0059EAFF0000CD
      FF0030C2F6002D91C7005D829A00A8ABAE0000000000FFFFFF00808080008000
      000080000000FFFFFF00C0C0C000C0C0C00080808000FFFFFF00C0C0C0008000
      000080000000C0C0C0000000000000000000000000007A7A7A00E9BB7400F596
      10006CEAE200AAF9FF00A7F8FF00A9F9FF00A8F7FF009CE8FA0061CCEB002FBF
      F1003CC3E900CCA16D00000000000000000000000000000000005E5E5E0093E2
      930023BB230096ED960089ED890075E375004BBE4B0059D45900A4FBA400A4F9
      A4009DF49D0099F299008EE98E0079B3790000000000000000009B9A9A008987
      860084838300898F940088A0B000A8D6F9000796E10011D6FF0067F0FF001FDA
      FF004794C3000000000000000000000000000000000000000000C0C0C0008000
      00008000000080000000C0C0C000C0C0C00080808000C0C0C000800000008000
      000080000000FFFFFF0000000000000000000000000080808000E6B87300F195
      120070E6E000B7FCFF00B6F8FF00B7F8FF00B8F6FF00BCF5FF00A5EEFF008FE5
      FF0046D0FF00D0984C0000000000000000000000000000000000999999008F9B
      8F0037BF370069DB6900ABF6AB004BCD4B0080E78000B6FFB600B7FFB700B4FE
      B400B2FCB200BBFCBB0038B83800000000000000000000000000000000000000
      0000000000000000000086868600AABAC6008BC8F30029C4F20080FDFF0042D3
      F70092B1C600000000000000000000000000000000000000000000000000C0C0
      C000800000008000000080000000C0C0C0008080800080000000800000008000
      0000C0C0C0000000000000000000000000000000000086868600E1B67500EE99
      19009DDAB0008DDFC9008CDCC90089DBCD008BDBD20091DAD90095DBE1008ED7
      E7008FDDFC00D197390000000000000000000000000000000000000000008383
      8300AEB9AE002ABC2A006EDE6E00C9FFC900C5FFC500C1FFC100C1FFC100CAFF
      CA00D6FFD60056CE560090B99000000000000000000000000000000000000000
      00000000000000000000000000005F5F5E00DBF2FE002C9FE4008AFFFF0031A5
      DD00000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000800000008000000080000000800000008000000080808000FFFF
      FF00000000000000000000000000000000000000000095959500B9A98F00E291
      1700E8992100EB981E00ED991D00EE9A1E00EF9A2000F09D2200F29E2400F2A2
      2600F2A83200DA99350000000000000000000000000000000000000000000000
      0000959595008683860062C4620024C324008CF18C00BFFFBF00C0FFC0008DF1
      8D002CB02C008CA68C0000000000000000000000000000000000000000000000
      0000000000000000000000000000A4A4A400767D8200CEF1FF002AADEB0058A0
      CD00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00C0C0C000C0C0C000C0C0C000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009D9D9D007A7C7A005278520036843600438443007C90
      7C00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093939300888889007D9AAC00B1BC
      C300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000081725B00B77D2100AE8F61000000
      0000000000000000000000000000000000000000000039383800393838003938
      3800393838000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A7A7A7004B677A007B8C7F00BFB3A2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A4A4A40044657D0076928800C7B59C000000000000000000000000000000
      00000000000000000000A9A9A90081623500F59A0E00EDA84A00EFBA6600D497
      3300AD997C0000000000000000000000000000000000C45C0000C77B47009A54
      2A00633B24003938380039383800393838000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009696
      96001B4B720000C4FF0048EDFF00A2A591000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009292
      92001856850000C3FF0044EEFF00A3A994000000000000000000000000000000
      0000000000009F9F9F0091652700F59D1500EEBA6D00ECC58400FFFFE000F6DA
      AB00F5C46E00CB8E2B00B0A493000000000000000000C45C0000DCA87800EBB7
      8800C77B47009A542A00633B2400393838003938380039383800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000918F8E009A794D00D8A25700E7B36F00D6A4640090795B002B53
      700037BDF00047F2FF00CAF9FE007CA9C4000000000000000000000000000000
      0000000000008E8C89009F7A4A00DCA65B00E9B77500DBA96500937958002A5C
      7C0037BCF00049F1FF00CDF9FE007BA8C5000000000000000000000000000000
      000099999900AA742000F5A01F00FADCA700F8DBA900F2D7A300FFFFE400FCEF
      C500F9E6BB00FDDCA100F7AC3300BE904C0000000000C45C0000E5B99600FFF0
      DB00FEE2C300FDDBB700F3BA8300CA8749009A542A0053362500393838000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073685A00EEAF5400FFFECA00FFFFFF00FFFFFF00FFFFFF00FFFFE500F3BE
      6C00B9A77B0099F6FF0069AAD000000000000000000000000000000000000000
      000075675600F1B45900FFFFCD00FFFFFF00FFFFFF00FFFFFF00FFFFE900F4C0
      6E00C1A6740096F5FF006AAAD000000000000000000000000000000000000000
      000079684B00EA910800F6D39400F0CC8E00FBE8C000F9ECC800FFFFE600FFF7
      D400FBE5B700F9E0B200FDDFAD00CD96430000000000C45C0000E5C0A900FEEA
      D400FEE2C300FDDBB700FDE7B900FFD18600FBAD5D0077381400393838000000
      0000000000000000000000000000000000000000000000000000000000006D66
      5E00EEAB4D00FFFFCD00FFFFCC00FFFEDC00FFFEF500FFFFEE00FFFFD900FFFF
      CE00F6C16B0090A09F0000000000000000000000000000000000000000006D64
      5900F1B15200FFFFCF00FFFFCC00FFFDDB00F1D49F00F4DAA900FFFFD900FFFF
      CF00F7C36F0095A39F0000000000000000000000000000000000000000009999
      9900B78B4600E28C0500FAECC100F5DAA500F4D5A400FEFEE500FFFFE800FFF8
      D300FFF1CA00F8D7A200F4C67C00C5A4740000000000C45C0000E6C9B700FFF0
      DB00CCD7CC000098CB00FDDBB700FFC25B00F2B77700633B2400333333000000
      000000000000000000000000000000000000000000000000000083838300D797
      4400FFE9A300FFFFCA00FFFFCB00FFFFD100FFFFED00FFFFE100FFFFD000FFFF
      D000FFFFC500D1A26300000000000000000000000000000000007C7C7C00DD9A
      4300FFEFAC00FFFFC900FFFEC800FFFCC500EABE7E00F3D8B300FAEDAA00FFFF
      CE00FFFEC400D9A7640000000000000000000000000000000000000000007979
      7900E3A03A00E1992500FCEFC600FBEDC500EDC58700FFFFED00FFFFEA00FFF9
      D500FFF2CD00F6D8A400EDAC4900C1B39E0000000000C45C0000FDDEC000D9E4
      DC000098CB000098CB00BABDA70091917500D597650081491A00333333003333
      330000000000000000000000000000000000000000000000000070655700F1AA
      4900FFF5B300FFF8BD00F9E6A100E09D3400E4AA4B00E4AA4A00E4AD5400E8B6
      5600FFFCC100EFC577000000000000000000000000000000000077695600F1AB
      4B00FFF7B600FFF7BC00F9E7A200F9E69D00E8B96E00FAF0E400EFCA6C00F6E1
      9600FFF7B800F0C97A0000000000000000000000000000000000000000005F5C
      5800F09E2100E7B25C00F6E2B000FFFEE700EDC68800FEFDE600FAF2D300FFFA
      D900FFF4CE00F3D29D00E2931E000000000000000000C45C0000FEE6D1000098
      CB00BCD7D900ABD1D4000098CB00A79C8100EBB78800F9CA9300CA8749009567
      3B0033333300333333000000000000000000000000009E9E9E00B0936F00ECA9
      4700F9D68600FFEEAA00FAE59A00F4DEC000FFFFFF00FFFFFF00FFFFFF00E9B7
      6200FFF0AB00F4C16500C4B29B00000000000000000099999900B9996F00EDAB
      4B00F9D78800F8D98800E7B97700F4DFBF00FBF0E200FFFFFF00F7E7D100F3DC
      C000F7D37C00F3C26800C6B39A00000000000000000000000000000000007765
      4B00E5900900F0CE9000F2D29700FEF1CD00DB8C1800FAEDC700FBF4D600FFFD
      DF00FFF6D100F3D5A100D68D20000000000000000000C45C0000F4EBE500F7F6
      EE00FEF1E300D9E4DC000098CB00FFEBCA00E4AC7200CA874900F9CA9300F9CA
      9300BD966A005B5C830033333300000000000000000093939300C2A47C00E9A2
      3F00ECB25200FBD88500FCE29600E8BC7C00F6E3C700F2D8B000F0D4A900E1A3
      3F00FFE39E00F0B45300C7AF8E0000000000000000008B8B8B00D5B28700E8A2
      3E00ECB35400F7D07500EBC38800F9EBD800F8EAD600FFFFFF00EFCE9C00EBC2
      8300F2C06200EEB25400C9AE8A000000000000000000000000009A9A9A00B78D
      4C00DF880200FBF2CA00F8D89F00CAA87400ECEAEB00F9DAAE00FBF1CE00FBF1
      CE00FFF5D000F2CF9500CB9548000000000000000000C45C0000FEF6F000FEF9
      F500FEF5EA00FEF1E3000098CB00F6ECDB00E5B9960066381A0033333300DCA8
      7800AC9E9C003059D1004C57B10000000000000000009B9B9B00AFA18D00EAA6
      4A00F3C27500F6D29600FFE8AF00F4CB7D00F7D48D00F9DC9900FCE2A500FFE3
      A800F8D8A200F5CA8E00C5B29800000000000000000094949400BFAE9900EAA3
      4200F2C37700F6D39600F2C47100F7D38900E1A13700FFFFFF00E8AF4C00FFE7
      AF00FAD8A000F5CC9100C7B2960000000000000000000000000079797900E5A7
      4400DE901800EDCA8900F8D8A1009E9589005E5E6000F5EFE700F9DAAD00FDF5
      D000FEEDC000E8961E00C5A679000000000000000000C45C0000FEFEFD00FEFE
      FD00FEF9F500FFF9EC00ABD1D400C9E2E200F4BD930053362500333333000000
      00000000000000000000000000000000000000000000000000006E6A6500F9C5
      7F00F2BB6E00F2CF9E00FADAA500FFE2AE00FFE8B700FFEABE00FFE5B600FCDC
      AA00F3D7AE00F0C38400C2BAB0000000000000000000ABABAB0078736C00F5BB
      7000F3C27900F1D0A000F9D9A600FFE8B800E5A74300FFFFFF00E6A84500FDE0
      B100F4D6AE00F0C48800C1B9AD00000000000000000000000000605C5A00F1A6
      3100E0972B00D8840800E0B57400000000000000000063636300FDF8EF00FEDD
      AE00FBDEA600B3915F00C3BAAB000000000000000000C45C0000FEFEFD00FEFE
      FD00FEFEFD00FEFEFD00D4EAEC00C9E2E200F3BA830053362500333333000000
      000000000000000000000000000000000000000000000000000071717100ECDA
      C500E9A13F00F7D5A300F4D9B700F5DBB500FCECD500FEF7EE00FCF4EA00F7E5
      CE00FAE6CA00D7A96A00000000000000000000000000000000006A6A6A00F2DD
      C100E9A23E00F8D7A900F2D9B600F7DEBA00EEC48400ECC38200F4DBB600F8E8
      D200FAE6CB00DAAA69000000000000000000000000000000000075644900EA95
      1300DF8E0B00E3A75100C7B3990000000000000000000000000075757500A4A2
      9F00B09F870000000000000000000000000000000000C45C0000C6733900D597
      6500D9B69B00E8CEC100F4EBE500FEFEFD00E5B996005A402900333333000000
      0000000000000000000000000000000000000000000000000000000000006465
      6600F9DFBA00EDA74500FDE3BC00F9EDD900FCF8F300FEFDFD00FFFFFE00FFF8
      EB00E8B57100C4BBB00000000000000000000000000000000000000000006667
      6800FBD7A800EFAA4C00FDE6C400FAEDDC00FDFCFB00FFFFFF00FFFFFF00FFFA
      EC00E8B77400C4BBAE000000000000000000000000009D9D9D00BA955A00F294
      0100A8885900D2B38A0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E4892E00D26C0900C45C
      0000C45C0000B8530100C05D1000C77B4700C67339005A483700333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006E707100C5B5A000F3AF5200FEC57800FFEAC200FFF0D000FFDAA400D09C
      5700B5AEA5000000000000000000000000000000000000000000000000000000
      00006C6E7000D0B99B00F4AE4E00FFCD8600FFEECD00FFF3D900FFE0AE00D49F
      5A00B5ACA100000000000000000000000000000000000000000077777700AD97
      7600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006565
      650065656500CA874900D8873600D4761800D26C0900715F4E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB008485860080776B00977E5E00917C620099938D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A6A6A6007E7E7E0084776500A28359009D825E00989086000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C8C8C00BE82
      2600AF8138009D7F5200A5937B00ABA39A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000777794009393B300000000000000000000000000000000000000
      0000000000000000000000000000000000006060600060606000606060006060
      6000606060006060600060606000606060006060600060606000606060006060
      6000606060006060600060606000606060000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000066615C00F5A4
      2700FFD26900FFC95B00FFE7B500FFD68D00F8C06800DCA14600BF8C3C00AA83
      4A009E8A6F00B0A4920000000000000000000000000000000000000000000000
      0000626269001718DF00888FF6004242BF000000000000000000000000000000
      000000000000000000000000000000000000CFCFCF0070707000707070007070
      7000707070007070700070707000707070007070700070707000707070007070
      700070707000707070007070700040404000000000000000000018799C001879
      9C0018799C0018799C0018799C0018799C0018799C0018799C0018799C001879
      9C0000000000000000000000000000000000000000000000000064615A00ED9F
      2600FFBF4B00FFB84000FFF7EA00FFF1D700FFF1D600FFF1D500FFF3D300FFF4
      CF00FFEBBB00FDD57D00C2B8A800000000000000000000000000000000009898
      98004040AB00232BE600A6B6FF00C7D1FF004C4DD600A3A3B2008D8D8D002323
      85003C3CD500000000000000000000000000FFFFFF00BFC6C900BFC6C900BFC6
      C900BFC6C900BFC6C900BFC6C900BFC6C900BFC6C900BFC6C900BFC6C900BFC6
      C900BFC6C900BFC6C9008080800040404000000000001896C0001896C0001896
      C0001896C0001896C0001896C0001896C0001896C0001896C0001896C0001896
      C00018799C0000000000000000000000000000000000000000005F5E5C00EFA2
      2B00FFB84000FFAF2B00FFFFFF00FFF4E400FFF3E200FFF2E000FFF3DF00FFF3
      E000FFF4E200FFD27300C4B19300000000000000000000000000000000006B6B
      6D00F8F8FD00D8D7FF005657E1007683F300BBC9FF003A3AB8001A1A7C004F54
      EE00BBCDFF003D3FCC000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D4008080800040404000189AC6001B9CC7009CFFFF006BD7
      FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
      FF002899BF000C72A500000000000000000000000000000000005F5E5D00F0A5
      2F00FFB33700FFA61700FFFFFF00FFFAF200FFF8F000FFFAF000FFF9F000FFF9
      F200FFFFFF00FFCA6000C8AA7A00000000000000000000000000000000000000
      00008585850084848300FEFEFE004E4DDF008C9FFF0099A9FF0096A3FF00A8BD
      FF006E7DF2007575BD000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400191A1A00191A1A00C8D0D400C8D0D400C8D0D400C8D0D400191A1A00191A
      1A00C8D0D400C8D0D4008080800040404000189AC600199AC60079E4F0009CFF
      FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BDF
      FF0042B2DE000C72A5000000000000000000000000000000000060606000F1A8
      3700FEAE2C00FF9D0500FFEFD500FFF2DC00FFF4E400FFF8ED00FFFAF100FFFB
      F600FFFFFF00FFC25500CFA56200000000000000000000000000000000000000
      0000000000009C9C9C0071707900A09EEF00424FE7004D71FF008399FF00424F
      E8006868B800000000000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400AFB6B90000000000191A1A00C8D0D400C8D0D400191A1A0000000000AFB6
      B900C8D0D400C8D0D4008080800040404000189AC60025A2CF003FB8D7009CFF
      FF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084E7
      FF0042BAEF000C72A5000000000000000000000000000000000062626200F2AA
      3D00FDAE3100FF930000FF990000FFA00800FFA61900FFAC2300FFAE2800FFAE
      2600FFAB2200FFAB1E00D6A14B00000000000000000000000000000000000000
      00000000000058586B000808BC006A67DC002D32DA001F4FFF002128D6001E1E
      AA007575B300000000000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400C8D0D400AFB6B90000000000191A1A00191A1A0000000000AFB6B900C8D0
      D400C8D0D400C8D0D4008080800040404000189AC60042B3E20020A0C900A5FF
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7
      FF0052BEE7005BBCCE000C72A50000000000000000000000000062636500F0AC
      4000FAB84600FFAF3300FFB64300FFB64600FFB84B00FFB94E00FFBC5300FFBE
      5700FFBE5700FFB74500DEA13D00000000000000000000000000000000000000
      00005B5B6F001010DA001B47FF001426E0002832DD002756FF00335DFF002354
      FF002A55FF004547C5000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400AFB6B9000000000000000000AFB6B900C8D0D400C8D0
      D400C8D0D400C8D0D4008080800040404000189AC6006FD5FD00189AC60089F0
      F7009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF005AC7FF0096F9FB000C72A50000000000000000000000000067676800F1AE
      4600F8C76D00FFC76A00F0AB5000E49C4B00FFE4B300FFE0B000FFE3B400F9D3
      9E00FFE5BC00FFC97300EAAE4C00000000000000000000000000000000000000
      000071717F00C7C5FF004450E90085A1FF008DA9FF0092ADFF0088A0FF00393C
      DC005965EE004445C5000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400191A1A000000000000000000191A1A00C8D0D400C8D0
      D400C8D0D400C8D0D4008080800040404000189AC60084D7FF00189AC6006BBF
      DA00FFFFFF00FFFFFF00F7FBFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084E7FF00FFFFFF000C72A5000000000000000000000000006B6B6B00F1AF
      4A00F7C66C00FFCE7500E99A3900CE6C0E00FFF3CE00FFE9BE00F4CD9600C149
      0000EEC08600FFDA9400F4BD5F00000000000000000000000000000000000000
      0000949494008C8C8800E2E0FD004C4CE6005256E400555CE3001314D000A29E
      AF00AAA8B1009D9CBC000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400C8D0D400191A1A0000000000AFB6B900AFB6B90000000000191A1A00C8D0
      D400C8D0D400C8D0D4008080800040404000189AC60084EBFF004FC1E200189A
      C600189AC600189AC600189AC600189AC600189AC600189AC600189AC600189A
      C600189AC600189AC6000C72A50000000000000000000000000070707000EFB1
      5000F5C46C00FFD68500EFAD5200CB660400FFFFFB00FFFAE600FBEACA00C34E
      0000E6B16E00FFF0BC00EEB85800000000000000000000000000000000000000
      0000000000000000000087878600616170004744DC000D17DA005067FA001019
      CA0000000000000000000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400191A1A0000000000AFB6B900C8D0D400C8D0D400AFB6B90000000000191A
      1A00C8D0D400C8D0D4008080800040404000189AC6009CF3FF008CF3FF008CF3
      FF008CF3FF008CF3FF008CF3FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00189AC600197A9D000000000000000000000000000000000074747400EDB0
      5300F2C26700FFDC9300F3BB6600C65B0000FFFFFD00FFFDEE00FFFAE900C655
      0000E3A66700FFFFE500D09D5000000000000000000000000000000000000000
      000000000000000000009E9E9E0049499D001A18D8000031FF001043FF001040
      FF007272BA00000000000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400AFB6B900AFB6B900C8D0D400C8D0D400C8D0D400C8D0D400AFB6B900AFB6
      B900C8D0D400C8D0D4008080800040404000189AC600FFFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF00FFFFFF00189AC600189AC600189AC600189AC600189A
      C600189AC60000000000000000000000000000000000000000007C7C7C00E9B1
      5900F1BF6400FFE5A500F8CB8200C95F0000FFFFFF00FFFFF400FFFDDC00FFE1
      A300F8C67000D29C4300C3BAAB00000000000000000000000000000000000000
      000000000000000000009A9A9A007A7AA8004A48E5005D7CFF007F9EFF00829B
      FF007070BB00000000000000000000000000FFFFFF00C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
      D400C8D0D400C8D0D40080808000404040000000000021A2CE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00189AC600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00EEB7
      6300F6BA4F00FFDA8500FCBE5100E5951A00CD8F2B00A67936008F7C61009993
      8C00ABAAAA000000000000000000000000000000000000000000000000000000
      000000000000000000000000000066666600D3D2FC003D3FEE009FA6FF004244
      DA0000000000000000000000000000000000FFFFFF00F8F9F900F8F9F900F8F9
      F900F8F9F900F8F9F900F8F9F900F8F9F900F8F9F900F8F9F900F8F9F900F8F9
      F900F8F9F900F8F9F900EFEFEF0040404000000000000000000021A2CE0021A2
      CE0021A2CE0021A2CE0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009F9F9F009286
      7600A17C4400948670009C999500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000929290007C7C800079798C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000032343500323435003234
      3500323435003234350032343500323435003234350032343500323435003234
      3500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000070
      7000007070000070700000707000007070000070700000707000007070000070
      7000191A1A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DFDFDF000010
      1000008080000080800000808000008080000080800000808000008080000080
      800000707000191A1A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001FFFFF00DFDF
      DF00001010000080800000808000008080000080800000808000008080000080
      80000080800000707000191A1A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DFFFFF001FFF
      FF00DFDFDF000010100000808000008080000080800000808000008080000080
      8000008080000080800000707000191A1A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001FFFFF00DFFF
      FF001FFFFF00DFDFDF0000101000001010000010100000101000001010000010
      1000001010000010100000101000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DFFFFF001FFF
      FF00DFFFFF001FFFFF00DFDFDF0000DFDF00DFDFDF0000DFDF00DFDFDF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001FFFFF00DFFF
      FF001FFFFF00DFFFFF001FFFFF00DFFFFF001FFFFF00DFFFFF001FFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DFFFFF001FFF
      FF00DFFFFF001F1F1F00001F1F001F1F1F00001F1F001F1F1F00001F1F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F1F1F00001F
      1F001F1F1F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000700000000100010000000000800300000000000000000000
      000000000000000000000000FFFFFF00F80FC03F00000000F007C00700000000
      E003C00700000000C001C00300000000C001C003000000008000C00300000000
      8000C003000000008000C003000000008000C003000000008000C00300000000
      C000C00300000000C001C00300000000E001C00700000000F003C00F00000000
      FC0FE03F00000000FFFFF7FF00000000FFFFFFFFCFFFF80FFEFFFFFF800FF007
      FC7FC00F8001E003FC3F80078001C001F81900038001C001E003000380008000
      80030003800080008003000180008000C007000180008000F807000180008000
      FC0F00018000C000FE0F00038000C001FF0F00078000E001FF9F81FF801FF003
      FFDFC3FFCFFFFC0FFFFFFFFFFFFFFFFFF1FFFC4FC1FFFFFFE0FFF00F8003C187
      E063E00380018001E003C00180018001E001C00180018001F003E00180018001
      F803800080008001F807800080008001FC0380018000C003F003E001C000F00F
      F001E000FC00F00FE001C001FC00F00FC081E003FE00F00FC183FC03FFC0F00F
      E3E7FC0FFFE0FC3FFFFFFFFFFFFFFFFFFFFFFFFFF80FF1FFFFFFF038F007F063
      F81FE000E003E003E00FC001C001F003C0078001C001F003C00380008000F003
      800380008000E001800380018000E000800380018000C0008003800380008000
      80038003C000C007C0038003C001FC07E0078003E001FE0FF00F8003F003FE0F
      F83FFFFFFC0FFF0FFFFFFFFFFFFFFFFFFF1F87FFFFF0FFF0FC0780FFFFE0FFE0
      F801803FF800F800F000801FF001F001F000801FE003E003E000801FC003C003
      E000800FC003C003E001800380018001E001800180018001C001800180018001
      C001801FC0018001C181801FC003C003C1C7801FE003E00383FF801FF007F007
      CFFFE03FF81FF81FFFFFFFFFFFFFFFFFFFFFFFFFC0FFF9FF0000FFFFC003F0FF
      0000C00FC001E00700008007C001E00300000003C001F00300000003C001F807
      00000003C001F80700000001C001F00300000001C001F00300000001C001F003
      00000001C001FC0F00000003C001FC0700000007C001FC07000081FFC007FE0F
      0000C3FFC1FFFF1FFFFFFFFFFFFFFFFFF99FF99FF99FFFFFF99FF99FF99FFFFF
      F99FF99FF99F800FF00FF00FF00F8007E007E007E00780038001800180018001
      8001800180018000000000000000800000001C381C38800F00001E781E78800F
      00001E781E78800F00000E700E70C7FF800180018001FFFFC003C003C003FFFF
      E007E007E007FFFFF81FF81FF81FFFFF00000000000000000000000000000000
      000000000000}
  end
  object OpenDialog1: TOpenDialog
    Left = 546
    Top = 220
  end
  object MainMenu1: TMainMenu
    Images = ImageList4
    Left = 611
    Top = 218
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N117: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1077#1082#1090
        OnClick = N117Click
      end
      object N99: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
        ImageIndex = 5
        ShortCut = 16463
        OnClick = ToolButton3Click
      end
      object N4: TMenuItem
        Caption = #1047#1072#1093#1074#1072#1090' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081
        ImageIndex = 13
        ShortCut = 16461
        Visible = False
        OnClick = Action2Execute
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object test1: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1088#1086#1077#1082#1090
        ShortCut = 16467
        OnClick = test1Click
      end
      object N120: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1073#1083#1072#1089#1090#1100
        OnClick = N120Click
      end
      object N95: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ImageIndex = 6
        Visible = False
        OnClick = N95Click
      end
      object N5: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
        ImageIndex = 6
        Visible = False
        object bmp1: TMenuItem
          Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' .bmp'
          ImageIndex = 22
          OnClick = bmp1Click
        end
        object Matlabfilem1: TMenuItem
          Caption = 'Matlab file .m'
          ImageIndex = 20
          OnClick = Matlabfilem1Click
        end
        object N40: TMenuItem
          Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083
          ImageIndex = 25
          OnClick = N40Click
        end
        object Binfile1: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' .bin'
          OnClick = Binfile1Click
        end
      end
      object N6: TMenuItem
        Caption = #1054#1090#1095#1077#1090
        ImageIndex = 26
        ShortCut = 16466
        Visible = False
        OnClick = ToolButton40Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        AutoLineReduction = maManual
        Caption = #1042#1099#1093#1086#1076
        ImageIndex = 7
        RadioItem = True
        ShortCut = 16465
        OnClick = ToolButton19Click
      end
      object RenameProject1: TMenuItem
        Caption = 'Rename Project'
        ShortCut = 113
        Visible = False
        OnClick = RenameProject1Click
      end
    end
    object N23: TMenuItem
      Caption = #1052#1072#1089#1082#1072
      object N24: TMenuItem
        Caption = #1055#1077#1088#1074#1072#1103
        object N100: TMenuItem
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          ImageIndex = 24
          object N102: TMenuItem
            Caption = #1069#1083#1083#1080#1087#1089
            OnClick = N102Click
          end
          object N103: TMenuItem
            Caption = #1055#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082
            OnClick = N103Click
          end
          object N104: TMenuItem
            Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1082#1086#1085#1090#1091#1088
            OnClick = N104Click
          end
        end
        object N101: TMenuItem
          Caption = #1054#1090#1085#1103#1090#1100
          ImageIndex = 23
          object N105: TMenuItem
            Caption = #1069#1083#1083#1080#1087#1089
            OnClick = N105Click
          end
          object N106: TMenuItem
            Caption = #1055#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082
            OnClick = N106Click
          end
          object N107: TMenuItem
            Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1082#1086#1085#1090#1091#1088
            OnClick = N107Click
          end
        end
        object N27: TMenuItem
          Caption = #1053#1086#1074#1072#1103
          ImageIndex = 25
          OnClick = N27Click
        end
        object N87: TMenuItem
          Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
          OnClick = N87Click
        end
        object N41: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          ImageIndex = 21
          Visible = False
          OnClick = N41Click
        end
        object N42: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          ImageIndex = 6
          Visible = False
          OnClick = N42Click
        end
      end
      object N25: TMenuItem
        Caption = #1042#1090#1086#1088#1072#1103
        Visible = False
        object N28: TMenuItem
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          ImageIndex = 24
          object N108: TMenuItem
            Caption = #1069#1083#1083#1080#1087#1089
            OnClick = N108Click
          end
          object N109: TMenuItem
            Caption = #1055#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082
            OnClick = N109Click
          end
          object N112: TMenuItem
            Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1082#1086#1085#1090#1091#1088
            OnClick = N112Click
          end
        end
        object N31: TMenuItem
          Caption = #1054#1090#1085#1103#1090#1100
          ImageIndex = 23
          object N113: TMenuItem
            Caption = #1069#1083#1083#1080#1087#1089
            OnClick = N113Click
          end
          object N114: TMenuItem
            Caption = #1055#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082
            OnClick = N114Click
          end
          object N92: TMenuItem
            Caption = #1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1082#1086#1085#1090#1091#1088
            OnClick = N92Click
          end
        end
        object N29: TMenuItem
          Caption = #1053#1086#1074#1072#1103
          ImageIndex = 25
          OnClick = N29Click
        end
        object N115: TMenuItem
          Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
          OnClick = N115Click
        end
        object N43: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          ImageIndex = 5
          Visible = False
          OnClick = N43Click
        end
        object N44: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          ImageIndex = 6
          Visible = False
          OnClick = N44Click
        end
        object N46: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100
          ImageIndex = 22
          Visible = False
          OnClick = N46Click
        end
      end
      object N26: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        ImageIndex = 24
        Visible = False
        OnClick = N26Click
      end
      object N30: TMenuItem
        Caption = #1054#1090#1085#1103#1090#1100
        ImageIndex = 23
        Visible = False
        OnClick = N30Click
      end
      object N93: TMenuItem
        Caption = #1054#1090#1085#1103#1090#1100' '#1055#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1082#1086#1085#1090#1091#1088
        Visible = False
        OnClick = N93Click
      end
      object N45: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100
        Visible = False
        OnClick = N45Click
      end
    end
    object N32: TMenuItem
      Caption = #1054#1076#1085#1086' '#1080#1079#1084#1077#1088#1077#1085#1080#1077
      Visible = False
      object N3: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        ImageIndex = 5
        ShortCut = 16463
        OnClick = ToolButton3Click
      end
      object N33: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090
        OnClick = N33Click
      end
      object N34: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090' '#1073#1072#1079#1099
        OnClick = N34Click
      end
      object N35: TMenuItem
        Caption = #1042#1099#1089#1086#1090#1072' '#1089#1090#1091#1087#1077#1085#1080
        Visible = False
        OnClick = N35Click
      end
    end
    object Cthbz1: TMenuItem
      Caption = #1057#1077#1088#1080#1103' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
      Visible = False
      object N36: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
        ImageIndex = 5
        OnClick = N36Click
      end
      object N38: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090
        OnClick = N38Click
      end
      object N37: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090' '#1073#1072#1079#1099
        OnClick = N37Click
      end
    end
    object N2: TMenuItem
      Caption = #1042#1080#1076
      object N10: TMenuItem
        Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100
        ImageIndex = 11
        Visible = False
        OnClick = N10Click
      end
      object N11: TMenuItem
        Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100
        ImageIndex = 10
        Visible = False
        OnClick = N11Click
      end
      object N14: TMenuItem
        Caption = '-'
        Visible = False
      end
      object N12: TMenuItem
        Caption = #1048#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084#1072
        Visible = False
        OnClick = N12Click
      end
      object N88: TMenuItem
        Caption = #1060#1072#1079#1072
        Visible = False
        OnClick = N88Click
      end
      object N94: TMenuItem
        Caption = #1040#1084#1087#1083#1080#1090#1091#1076#1072
        Visible = False
        OnClick = N94Click
      end
      object N13: TMenuItem
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        Visible = False
        OnClick = N13Click
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object N111: TMenuItem
        Caption = #1052#1072#1089#1082#1072' 1'
        Visible = False
        OnClick = N111Click
      end
      object N212: TMenuItem
        Caption = #1052#1072#1089#1082#1072' 2'
        Visible = False
        OnClick = N212Click
      end
      object N97: TMenuItem
        Caption = #1054#1073#1097#1072#1103' '#1084#1072#1089#1082#1072
        Visible = False
        OnClick = N97Click
      end
      object N96: TMenuItem
        Caption = '-'
        Visible = False
      end
      object N80: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1075#1088#1072#1092#1080#1082#1080
        OnClick = N80Click
      end
      object N21: TMenuItem
        Caption = #1040#1082#1089#1086#1085#1086#1084#1077#1090#1088#1080#1103
        ImageIndex = 20
        OnClick = N21Click
      end
      object N84: TMenuItem
        Caption = #1062#1074#1077#1090#1086#1074#1072#1103' '#1096#1082#1072#1083#1072
        object N81: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100
          OnClick = N81Click
        end
        object N85: TMenuItem
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1084#1072#1089#1096#1090#1072#1073
          OnClick = ToolButton8Click
        end
        object N86: TMenuItem
          Caption = #1057#1073#1088#1086#1089#1080#1090#1100
          OnClick = ToolButton2Click
        end
      end
    end
    object N15: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N16: TMenuItem
        Caption = #1054#1089#1085#1086#1074#1085#1099#1077
        ImageIndex = 17
        ShortCut = 16464
        OnClick = ToolButton33Click
      end
      object N17: TMenuItem
        Caption = #1055#1072#1083#1080#1090#1088#1072
        ImageIndex = 18
        Visible = False
        object N18: TMenuItem
          Caption = #1062#1074#1077#1090#1085#1072#1103
          ImageIndex = 19
          OnClick = N18Click
        end
        object N19: TMenuItem
          Caption = #1043#1088#1072#1076#1072#1094#1080#1080' '#1089#1077#1088#1086#1075#1086
          ImageIndex = 19
          OnClick = N19Click
        end
      end
      object N39: TMenuItem
        Caption = #1058#1086#1095#1082#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1096#1080#1074#1082#1080' 1'
        OnClick = N39Click
      end
      object N211: TMenuItem
        Caption = #1058#1086#1095#1082#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1096#1080#1074#1082#1080' 2'
        OnClick = N211Click
      end
      object N98: TMenuItem
        Caption = #1058#1086#1095#1082#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1096#1080#1074#1082#1080' '#1086#1073#1097#1072#1103
        OnClick = N98Click
      end
      object N79: TMenuItem
        Caption = '-'
      end
      object N78: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1073#1072#1079#1091
        ImageIndex = 6
        OnClick = N78Click
      end
    end
    object N22: TMenuItem
      Caption = #1051#1091#1085#1082#1072
      Visible = False
      object N47: TMenuItem
        Caption = #1052#1072#1089#1082#1072' '#1074#1085#1091#1090#1088#1077#1085#1085#1103#1103
        object N48: TMenuItem
          Caption = #1053#1086#1074#1072#1103
          ImageIndex = 25
          OnClick = N48Click
        end
        object N75: TMenuItem
          Caption = #1054#1090#1085#1103#1090#1100
          OnClick = N75Click
        end
        object N49: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          ImageIndex = 6
          OnClick = N49Click
        end
        object N50: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          ImageIndex = 5
          OnClick = N50Click
        end
        object N60: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100
          OnClick = N60Click
        end
      end
      object N51: TMenuItem
        Caption = #1052#1072#1089#1082#1072' '#1074#1085#1077#1096#1085#1103#1103
        object N52: TMenuItem
          Caption = #1053#1086#1074#1072#1103
          ImageIndex = 25
          OnClick = N52Click
        end
        object N53: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          ImageIndex = 6
          OnClick = N53Click
        end
        object N54: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          ImageIndex = 5
          OnClick = N54Click
        end
        object N61: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100
          OnClick = N61Click
        end
      end
      object N110: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1079#1080#1094#1080#1103' '#1088#1077#1092#1077#1088#1077#1085#1090#1085#1072#1103
        object N56: TMenuItem
          Caption = #1056#1072#1089#1095#1077#1090
          OnClick = N56Click
        end
        object N57: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1092#1072#1079#1091
          OnClick = N57Click
        end
        object N63: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          OnClick = N63Click
        end
        object N64: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          OnClick = N64Click
        end
        object N69: TMenuItem
          Caption = #1050#1083#1080#1085
          OnClick = N69Click
        end
        object N71: TMenuItem
          Caption = #1051#1072#1087#1083#1072#1089#1080#1072#1085
          OnClick = N71Click
        end
        object N73: TMenuItem
          Caption = #1043#1088#1072#1076#1080#1077#1085#1090
          OnClick = N73Click
        end
      end
      object N210: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1079#1080#1094#1080#1103' '#1080#1079#1084#1077#1088#1080#1090#1077#1083#1100#1085#1072#1103
        object N58: TMenuItem
          Caption = #1056#1072#1089#1095#1077#1090
          OnClick = N58Click
        end
        object N59: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1092#1072#1079#1091
          OnClick = N59Click
        end
        object N65: TMenuItem
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          OnClick = N65Click
        end
        object N66: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
          OnClick = N66Click
        end
        object N70: TMenuItem
          Caption = #1050#1083#1080#1085
          OnClick = N70Click
        end
        object N72: TMenuItem
          Caption = #1051#1072#1087#1083#1072#1089#1080#1072#1085
          OnClick = N72Click
        end
        object N74: TMenuItem
          Caption = #1043#1088#1072#1076#1080#1077#1085#1090
          OnClick = N74Click
        end
      end
      object N67: TMenuItem
        Caption = #1057#1091#1087#1077#1088' '#1083#1091#1085#1082#1072
        object N62: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1091#1087#1077#1088' '#1083#1091#1085#1082#1091
          OnClick = N62Click
        end
        object N68: TMenuItem
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1091#1087#1077#1088' '#1083#1091#1085#1082#1091
          OnClick = N68Click
        end
      end
      object N55: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1103' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103
        OnClick = N55Click
      end
      object N76: TMenuItem
        Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1089#1077#1088#1080#1102
        OnClick = N76Click
      end
      object N77: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
        OnClick = N77Click
      end
      object EMP1: TMenuItem
        Caption = 'TEMP'
        OnClick = EMP1Click
      end
    end
    object N82: TMenuItem
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      Visible = False
      object RMS1: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090' RMS, PV'
        OnClick = RMS1Click
      end
      object Rz1: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090' Rz, Ra, Rmax'
        OnClick = Rz1Click
      end
      object N83: TMenuItem
        Caption = #1055#1077#1088#1077#1087#1072#1076' '#1074#1099#1089#1086#1090
        OnClick = N83Click
      end
      object N116: TMenuItem
        Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100' '#1088#1072#1076#1080#1091#1089' '#1087#1086#1074#1077#1088#1093#1085#1086#1089#1090#1080
        OnClick = N116Click
      end
    end
    object N89: TMenuItem
      Caption = #1044#1074#1077' '#1076#1083#1080#1085#1099' '#1074#1086#1083#1085#1099
      Visible = False
      object N90: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = N90Click
      end
      object N91: TMenuItem
        Caption = #1056#1072#1089#1095#1077#1090
        OnClick = N91Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 671
    Top = 220
  end
  object ImageList2: TImageList
    Height = 24
    ShareImages = True
    Width = 24
    Left = 602
    Top = 140
    Bitmap = {
      494C01010F002400240018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000006000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A3A3A300A6A6A600A9A9A900ABABAB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009B9B9B00AEAEAE00ADADAD00B4B4B400AFAFAF00ABAB
      AB00A5A5A500A3A3A300A4A4A400A8A8A800ABABAB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9A9A90098989800B4B4B400ACACAC00BABABA00BABABA00BCBC
      BC00BDBDBD00BDBDBD00BBBBBB00B7B7B700B2B2B200ADADAD00A6A6A600A3A3
      A300A7A7A70000000000000000000000000000000000000000008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A0000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A70098989800B4B4B400A9A9A900B9B9B900B8B8B800B8B8
      B800BABABA00BBBBBB00BDBDBD00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBE
      BE00B2B2B20000000000000000000000000000000000000000008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A8A008A8A
      8A008A8A8A008A8A8A0000000000000000000000000000000000828282008282
      8200828282008282820082828200828282008282820082828200828282008282
      8200828282008282820082828200828282008282820082828200828282008282
      8200828282008282820000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A8A8A80097979700B5B5B500A8A8A800B9B9B900B8B8B800B9B9
      B900B7B7B700B2B2B200ADADAD00A6A6A600BCBCBC00BBBBBB00BABABA00BBBB
      BB00B5B5B500ADADAD00000000000000000000000000000000008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C0000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9A9A90096969600B5B5B500A8A8A800BABABA00B4B4B400A1A1
      A100999999009F9F9F00AAAAAA009B9B9B00BCBCBC00BABABA00B9B9B900BABA
      BA00B8B8B800AAAAAA00000000000000000000000000000000008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C0000000000000000000000000000000000868686008686
      8600868686008686860086868600868686008686860086868600868686008686
      8600868686008686860086868600868686008686860086868600868686008686
      8600868686008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AAAAAA0094949400B6B6B600A8A8A800B4B4B400989898009898
      9800A1A1A100ACACAC00B6B6B600A5A5A500BBBBBB00B8B8B800B8B8B800B8B8
      B800B9B9B900A9A9A900000000000000000000000000000000008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F0000000000000000000000000000000000878787008787
      8700878787008787870087878700878787008787870087878700878787008787
      8700878787008787870087878700878787008787870087878700878787008787
      8700878787008787870000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094949400B7B7B700A4A4A4009A9A9A0098989800A0A0
      A000AAAAAA00B0B0B000AEAEAE00A9A9A900B8B8B800B7B7B700B7B7B700B7B7
      B700B9B9B900A7A7A700000000000000000000000000000000008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F0000000000000000000000000000000000898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094949400B4B4B40093939300999999009F9F9F00A9A9
      A900B0B0B000B2B2B2009F9F9F00B6B6B600B7B7B700B6B6B600B6B6B600B6B6
      B600B8B8B800A8A8A800000000000000000000000000000000008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F00000000000000000000000000000000008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B008B8B8B008B8B8B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000939393009E9E9E00999999009E9E9E00A7A7A700B0B0
      B000B2B2B200A1A1A100B0B0B000B6B6B600B5B5B500B5B5B500B5B5B500B5B5
      B500B7B7B700AAAAAA0000000000000000000000000000000000929292009292
      9200929292009292920092929200AAAAAA009292920092929200929292009292
      9200AAAAAA0092929200AAAAAA00AAAAAA00AAAAAA00AAAAAA00929292009292
      92009292920092929200000000000000000000000000000000008C8C8C008C8C
      8C008C8C8C008C8C8C00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA008C8C8C00AAAAAA00AAAAAA00AAAAAA00AAAAAA008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008D8D8D009A9A9A009E9E9E00A6A6A600B0B0B000B1B1
      B100A7A7A700A9A9A900B5B5B500B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B5B5B500ACACAC0000000000000000000000000000000000929292009292
      9200929292009292920092929200ABABAB00929292009292920092929200ABAB
      AB009292920092929200ABABAB00929292009292920092929200929292009292
      92009292920092929200000000000000000000000000000000008E8E8E008E8E
      8E008E8E8E008E8E8E00AAAAAA008E8E8E008E8E8E008E8E8E008E8E8E00AAAA
      AA008E8E8E00AAAAAA008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E008E8E8E008E8E8E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009B9B9B00979797009F9F9F00A4A4A400AFAFAF00B0B0B000AEAE
      AE00A2A2A200B6B6B600B5B5B500B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B5B5B500B0B0B000ADADAD00000000000000000000000000929292009292
      9200929292009292920092929200B0B0B0009292920092929200B0B0B0009292
      9200929292009292920092929200B0B0B0009292920092929200929292009292
      92009292920092929200000000000000000000000000000000008F8F8F008F8F
      8F008F8F8F008F8F8F008F8F8F00AAAAAA008F8F8F008F8F8F00AAAAAA008F8F
      8F008F8F8F008F8F8F00AAAAAA008F8F8F008F8F8F008F8F8F008F8F8F008F8F
      8F008F8F8F008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009E9E9E009F9F9F00A8A8A800A6A6A600ADADAD00AFAFAF00B3B3B3009D9D
      9D00B6B6B600B6B6B600B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B6B6B600B4B4B400ACACAC00000000000000000000000000929292009292
      9200929292009292920092929200B0B0B000B0B0B000B0B0B000B0B0B0009292
      920092929200929292009292920092929200B0B0B00092929200929292009292
      9200929292009292920000000000000000000000000000000000909090009090
      9000909090009090900090909000AAAAAA009090900090909000AAAAAA009090
      9000909090009090900090909000AAAAAA009090900090909000909090009090
      9000909090009090900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A0A0
      A000A0A0A000A0A0A000A9A9A900A9A9A900A5A5A500B0B0B0009E9E9E00B4B4
      B400BABABA00B7B7B700B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B5B5
      B500B6B6B600B8B8B800AAAAAA00000000000000000000000000949494009494
      9400949494009494940094949400B3B3B300949494009494940094949400B3B3
      B3009494940094949400949494009494940094949400B3B3B300949494009494
      9400949494009494940000000000000000000000000000000000919191009191
      9100919191009191910091919100AAAAAA009191910091919100AAAAAA009191
      910091919100919191009191910091919100AAAAAA0091919100919191009191
      9100919191009191910000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009595
      9500A8A8A8009191910098989800A9A9A900B7B7B700A6A6A600ABABAB00BBBB
      BB00BABABA00B9B9B900B9B9B900B7B7B700B7B7B700B7B7B700BDBDBD00BEBE
      BE00BFBFBF00BABABA00ACACAC00000000000000000000000000949494009494
      9400949494009494940094949400B3B3B300949494009494940094949400B3B3
      B3009494940094949400B3B3B300B3B3B300B3B3B300B3B3B300949494009494
      9400949494009494940000000000000000000000000000000000929292009292
      920092929200929292009292920092929200AAAAAA00AAAAAA00929292009292
      920092929200AAAAAA00AAAAAA00AAAAAA00AAAAAA0092929200929292009292
      9200929292009292920000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009898
      9800B5B5B5009C9C9C00979797009F9F9F00A8A8A800A7A7A700BBBBBB00BBBB
      BB00BABABA00BABABA00BABABA00B9B9B900B7B7B700B7B7B700BCBCBC00BABA
      BA00B5B5B500ABABAB00AEAEAE00000000000000000000000000949494009494
      9400949494009494940094949400B3B3B300949494009494940094949400B3B3
      B300949494009494940094949400949494009494940094949400949494009494
      9400949494009494940000000000000000000000000000000000939393009393
      930093939300939393009393930093939300AAAAAA00AAAAAA00939393009393
      9300939393009393930093939300939393009393930093939300939393009393
      9300939393009393930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A8A8
      A80098989800B4B4B400A0A0A0009393930096969600B4B4B400BCBCBC00BBBB
      BB00BABABA00BABABA00BABABA00BABABA00B9B9B900B8B8B800BABABA00BABA
      BA00B3B3B300A8A8A80000000000000000000000000000000000949494009494
      9400949494009494940094949400B3B3B300B3B3B300B3B3B300B3B3B3009494
      9400949494009494940094949400949494009494940094949400949494009494
      9400949494009494940000000000000000000000000000000000939393009393
      930093939300939393009393930093939300AAAAAA00AAAAAA00939393009393
      9300939393009393930093939300939393009393930093939300939393009393
      9300939393009393930000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A50094949400A5A5A500AAAAAA00B2B2B200BDBDBD00BBBB
      BB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00B9B9B900BABABA00BBBB
      BB00ABABAB00ADADAD0000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000949494009494
      9400949494009494940094949400949494009494940094949400949494009494
      9400949494009494940094949400949494009494940094949400949494009494
      9400949494009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009D9D9D00AAAAAA00ADADAD00AFAFAF00BDBDBD00BCBC
      BC00BCBCBC00BBBBBB00BBBBBB00BCBCBC00BCBCBC00BBBBBB00BDBDBD00B8B8
      B800A9A9A9000000000000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000949494009494
      9400949494009494940094949400949494009494940094949400949494009494
      9400949494009494940094949400949494009494940094949400949494009494
      9400949494009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009F9F9F00A7A7A700AEAEAE00ADADAD00BFBFBF00BDBD
      BD00BDBDBD00BEBEBE00BEBEBE00BEBEBE00BCBCBC00B7B7B700B2B2B200ACAC
      AC00000000000000000000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A0A0A000A6A6A600B0B0B000ACACAC00BFBFBF00B9B9
      B900B4B4B400AFAFAF00ACACAC00A9A9A900A5A5A500A1A1A100A3A3A3000000
      0000000000000000000000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A3A3A300A1A1A100B8B8B800A9A9A900A9A9A900A5A5
      A500A1A1A100A1A1A100A6A6A600ABABAB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950095959500959595009595950095959500959595009595
      9500959595009595950000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700A3A3A300A7A7A700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000808080000000000000000000808080000000
      0000000000008080800000000000000000008080800000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E8E8E009494
      9400909090000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00A7A7A700AAAA
      AA00A6A6A6008E8E8E0000000000000000009E9E9E009B9B9B00888888000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080000000000000000000000000008080800000000000808080008080
      8000808080000000000080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      000000000000B0B0B0000000000000000000B0B0B0000000000000000000B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B00000000000000000000000000000000000000000009A9A9A009A9A
      9A00999999009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900A8A8A800A8A8
      A800A7A7A7009F9F9F008A8A8A0096969600A8A8A800A9A9A900A1A1A1008989
      8900000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000008080800000000000000000000000
      0000808080000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      000000000000B0B0B0000000000000000000B0B0B0000000000000000000B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B0000000000000000000000000000000000000000000A4A4A400A9A9
      A900A2A2A2009F9F9F009C9C9C009B9B9B009999990099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E0000000000000000000000000097979700A7A7A700A2A2
      A200A1A1A100A1A1A100A4A4A400A6A6A600A9A9A900A6A6A600A4A4A4009E9E
      9E00000000000000000000000000000000000000000000000000000000008080
      8000808080000000000080808000808080008080800000000000000000008080
      8000808080000000000000000000808080008080800000000000000000000000
      000000000000000000000000000000000000000000000000000080808000B0B0
      B00095959500B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0
      B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0
      B000B0B0B000B0B0B0000000000000000000000000009C9C9C00AAAAAA00B7B7
      B700AFAFAF00ADADAD00ABABAB00A9A9A900A4A4A400A1A1A1009D9D9D009A9A
      9A009A9A9A009999990099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009A9A9A00A8A8A8009A9A9A008C8C8C009B9B9B00A7A7A700A7A7A700A1A1
      A100A1A1A100A2A2A200A7A7A700A8A8A800A7A7A700A2A2A200A1A1A1009F9F
      9F008C8C8C000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000808080008080800000000000808080000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      000095959500B0B0B0000000000000000000B0B0B0000000000000000000B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000959595009595
      9500B0B0B00000000000000000000000000000000000A1A1A100ADADAD00B5B5
      B500B3B3B300B1B1B100B2B2B200B1B1B100B1B1B100B0B0B000AEAEAE00ABAB
      AB00A7A7A700A3A3A3009F9F9F009C9C9C009B9B9B009A9A9A00000000000000
      0000000000000000000000000000000000000000000000000000000000009797
      9700A7A7A700A7A7A700A7A7A700A6A6A600A7A7A700A7A7A700A5A5A500A1A1
      A100A1A1A100A1A1A100A2A2A200A2A2A200A2A2A200A1A1A100A1A1A1009F9F
      9F009D9D9D008888880000000000000000000000000000000000808080008080
      8000808080000000000000000000000000008080800000000000000000008080
      8000808080000000000000000000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000080808000808080000000
      000000000000959595000000000000000000B0B0B00000000000000000009595
      95000000000000000000B0B0B0000000000000000000B0B0B000959595000000
      00009595950095959500000000000000000000000000A4A4A400ACACAC00B3B3
      B300B5B5B500B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B200B0B0B000ADADAD00A9A9A9009F9F9F00999999000000
      000000000000000000000000000000000000000000000000000000000000A0A0
      A000A6A6A600A3A3A300A2A2A200A4A4A400A5A5A500A3A3A300A1A1A100A1A1
      A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A5A5
      A500A6A6A6009E9E9E0087878700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000B0B0
      B000B0B0B00095959500B0B0B000B0B0B000B0B0B000B0B0B000B0B0B0009595
      950095959500B0B0B000B0B0B000B0B0B000B0B0B00095959500B0B0B000B0B0
      B000B0B0B000B0B0B000000000000000000000000000A4A4A400ABABAB00B0B0
      B000B8B8B800B4B4B400B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3
      B300B3B3B300B3B3B300B3B3B300B4B4B400B3B3B300A9A9A9009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000009A9A
      9A00A5A5A500A2A2A200A1A1A100A2A2A200A2A2A200A1A1A100A1A1A100A3A3
      A300A4A4A400A5A5A500A5A5A500A5A5A500A3A3A300A1A1A100A1A1A100A2A2
      A200A4A4A400A3A3A30091919100000000000000000000000000A0A0A0000000
      000000000000A0A0A0000000000000000000A0A0A0000000000000000000A0A0
      A0000000000000000000A0A0A0000000000000000000A0A0A000000000000000
      0000A0A0A0000000000000000000000000000000000000000000808080000000
      000000000000959595000000000000000000B0B0B00000000000000000009595
      95000000000095959500B0B0B000000000000000000095959500000000000000
      0000B0B0B00000000000000000000000000000000000A4A4A400ADADAD00ABAB
      AB00B8B8B800B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B3B3B300B2B2B200A2A2A2009898
      9800000000000000000000000000000000000000000000000000000000000000
      0000A2A2A200A3A3A300A2A2A200A2A2A200A2A2A200A3A3A300A6A6A600A3A3
      A300A5A5A5000000000000000000A6A6A600ABABAB00A6A6A600A2A2A200A2A2
      A200A2A2A200A3A3A30093939300000000000000000000000000A0A0A0000000
      000000000000A0A0A0000000000000000000A0A0A0000000000000000000A0A0
      A0000000000000000000A0A0A0000000000000000000A0A0A000000000000000
      0000A0A0A0000000000000000000000000000000000080808000808080000000
      000000000000B0B0B0009595950000000000B0B0B00000000000000000009595
      9500000000000000000095959500000000000000000095959500000000000000
      0000B0B0B00000000000000000000000000000000000A4A4A400AFAFAF00A8A8
      A800B7B7B700B7B7B700B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B4B4B400B5B5B500ADADAD009B9B
      9B00000000000000000000000000000000000000000000000000000000009595
      9500A2A2A200A2A2A200A3A3A300A3A3A300A4A4A400A5A5A5009A9A9A000000
      00000000000000000000000000000000000000000000AFAFAF00A6A6A600A3A3
      A300A3A3A3009C9C9C0000000000000000000000000000000000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A0000000000000000000000000000000000080808000B0B0
      B000B0B0B000B0B0B00095959500B0B0B000B0B0B000B0B0B00095959500B0B0
      B000B0B0B000B0B0B000B0B0B0009595950095959500B0B0B000B0B0B000B0B0
      B000B0B0B000B0B0B000000000000000000000000000A4A4A400AFAFAF00AAAA
      AA00B1B1B100BABABA00B7B7B700B7B7B700B7B7B700B7B7B700B7B7B700B7B7
      B700B7B7B700B7B7B700B7B7B700B7B7B700B4B4B400B6B6B600B8B8B800A1A1
      A1009999990000000000000000000000000000000000A2A2A200A3A3A300A2A2
      A200A0A0A000A1A1A100A3A3A300A4A4A400A1A1A10000000000000000000000
      000000000000000000000000000000000000A0A0A000B2B2B200ABABAB00A4A4
      A4009E9E9E000000000000000000000000000000000000000000818181008585
      85008A8A8A008F8F8F00949494009A9A9A00A1A1A100A7A7A700AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00A8A8A800A3A3A3009E9E9E009999990098989800A4A4
      A400B2B2B200BEBEBE0000000000000000000000000000000000808080000000
      000000000000B0B0B0009595950000000000B0B0B0000000000095959500B0B0
      B0000000000000000000B0B0B0000000000095959500B0B0B000000000000000
      0000B0B0B00000000000000000000000000000000000A4A4A400B0B0B000AEAE
      AE00ACACAC00B9B9B900BABABA00BABABA00B9B9B900B9B9B900B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B800B8B8B800B5B5B500B6B6B600BBBBBB00ADAD
      AD009A9A9A0000000000000000000000000000000000A4A4A4009E9E9E009E9E
      9E009F9F9F00A3A3A300A4A4A400A4A4A4000000000000000000000000000000
      000000000000000000000000000000000000A6A6A600B2B2B200ADADAD00A5A5
      A500A1A1A1009393930000000000000000000000000000000000818181008585
      85008A8A8A008F8F8F00949494009A9A9A00A1A1A100A7A7A700AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00A8A8A800A3A3A3009E9E9E009999990098989800A4A4
      A400B2B2B200BEBEBE0000000000000000000000000080808000808080000000
      000000000000B0B0B0000000000095959500B0B0B0000000000095959500B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B00000000000000000000000000000000000A4A4A400B2B2B200B0B0
      B000ACACAC00AEAEAE00B2B2B200B4B4B400B5B5B500B9B9B900BBBBBB00BBBB
      BB00BABABA00BABABA00BABABA00BABABA00B6B6B600B7B7B700BDBDBD00B8B8
      B800A1A1A10099999900000000000000000000000000A3A3A300A1A1A100A3A3
      A300A4A4A400A5A5A500A6A6A600939393000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF00AFAFAF00ABABAB00A5A5
      A500A4A4A400A1A1A10000000000000000000000000000000000818181008585
      85008A8A8A008F8F8F00949494009A9A9A00A1A1A100A7A7A700AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00A8A8A800A3A3A3009E9E9E009999990098989800A4A4
      A400B2B2B200BEBEBE000000000000000000000000000000000080808000B0B0
      B000B0B0B000B0B0B000B0B0B00095959500B0B0B000B0B0B00095959500B0B0
      B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0
      B000B0B0B000B0B0B000000000000000000000000000A4A4A400B2B2B200B2B2
      B200B2B2B200AFAFAF00AFAFAF00AFAFAF00AFAFAF00AEAEAE00B0B0B000BABA
      BA00BDBDBD00BCBCBC00BCBCBC00BCBCBC00B8B8B800B8B8B800BEBEBE00BDBD
      BD00ADADAD009A9A9A00000000000000000000000000A5A5A500A4A4A400A6A6
      A600A5A5A500A5A5A500A3A3A300000000000000000000000000000000000000
      0000000000000000000000000000AAAAAA00ACACAC00ACACAC00A8A8A800A5A5
      A500A6A6A6009595950000000000000000000000000000000000818181008585
      85008A8A8A008F8F8F00949494009A9A9A00A1A1A100A7A7A700AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00A8A8A800A3A3A3009E9E9E009999990098989800A4A4
      A400B2B2B200BEBEBE0000000000000000000000000000000000808080000000
      000000000000B0B0B0000000000095959500B0B0B0000000000095959500B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B00000000000000000000000000000000000A5A5A500B4B4B400B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B3B3B300B3B3B300B2B2B200B0B0
      B000B6B6B600B8B8B800B8B8B800BABABA00B9B9B900BBBBBB00BFBFBF00BFBF
      BF00BABABA00A2A2A200999999000000000000000000A5A5A500A7A7A700A7A7
      A700A5A5A500A6A6A600A2A2A200000000000000000000000000000000000000
      0000000000008F8F8F00A7A7A700AAAAAA00A7A7A700A9A9A900A7A7A7009D9D
      9D00999999000000000000000000000000000000000000000000818181008585
      85008A8A8A008F8F8F00949494009A9A9A00A1A1A100A7A7A700AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00A8A8A800A3A3A3009E9E9E009999990098989800A4A4
      A400B2B2B200BEBEBE0000000000000000000000000080808000808080000000
      000000000000B0B0B0000000000000000000959595000000000095959500B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B00000000000000000000000000000000000A5A5A500B6B6B600B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B4B4
      B400AFAFAF00B1B1B100B2B2B200B2B2B200B0B0B000ADADAD00ACACAC00ACAC
      AC00ADADAD00A1A1A10099999900000000000000000000000000A4A4A400A5A5
      A500A3A3A300A7A7A700A4A4A400A0A0A000949494008B8B8B00000000009292
      92009C9C9C00A7A7A700A5A5A500A4A4A400A7A7A700A8A8A8009D9D9D000000
      0000000000000000000000000000000000000000000000000000818181008585
      85008A8A8A008F8F8F00949494009A9A9A00A1A1A100A7A7A700AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00A8A8A800A3A3A3009E9E9E009999990098989800A4A4
      A400B2B2B200BEBEBE000000000000000000000000000000000080808000B0B0
      B000B0B0B000B0B0B000B0B0B000B0B0B0009595950095959500B0B0B000B0B0
      B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0
      B000B0B0B000B0B0B000000000000000000000000000A6A6A600B7B7B700B7B7
      B700B7B7B700B7B7B700B7B7B700B7B7B700B8B8B800B8B8B800B8B8B800B7B7
      B700B7B7B700B7B7B700B7B7B700B6B6B600ACACAC009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000A5A5A5009E9E
      9E00A0A0A000A7A7A700A5A5A500A1A1A100A4A4A400A3A3A300A3A3A300A5A5
      A500A3A3A300A1A1A100A1A1A100A4A4A400A7A7A700A7A7A7009A9A9A000000
      0000000000000000000000000000000000000000000000000000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A00000000000000000000000000000000000808080000000
      000000000000B0B0B0000000000000000000959595009595950000000000B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B00000000000000000000000000000000000A2A2A200B2B2B200B7B7
      B700B7B7B700B7B7B700B7B7B700B9B9B900B6B6B600B0B0B000B0B0B000AFAF
      AF00B7B7B700B9B9B900B9B9B900B9B9B900AFAFAF009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000A2A2A200A3A3
      A300A5A5A500A7A7A700A8A8A800A4A4A4009F9F9F009E9E9E009E9E9E009E9E
      9E009E9E9E00A1A1A100A5A5A500A7A7A700A7A7A700A8A8A8009B9B9B000000
      0000000000000000000000000000000000000000000000000000A0A0A0000000
      000000000000A0A0A0000000000000000000A0A0A0000000000000000000A0A0
      A0000000000000000000A0A0A0000000000000000000A0A0A000000000000000
      0000A0A0A0000000000000000000000000000000000080808000808080000000
      000000000000B0B0B0000000000000000000B0B0B0009595950000000000B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B0000000000000000000000000000000000000000000A7A7A700BABA
      BA00B8B8B800B7B7B700B8B8B800B8B8B800A6A6A6009C9C9C009D9D9D009E9E
      9E00A7A7A700AAAAAA00AAAAAA00AAAAAA00A5A5A50000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A9A9
      A900A9A9A900A8A8A800A8A8A800A8A8A800A7A7A700A4A4A400A3A3A300A4A4
      A400A5A5A500A7A7A700A6A6A6009F9F9F009E9E9E009A9A9A00000000000000
      0000000000000000000000000000000000000000000000000000A0A0A0000000
      000000000000A0A0A0000000000000000000A0A0A0000000000000000000A0A0
      A0000000000000000000A0A0A0000000000000000000A0A0A000000000000000
      0000A0A0A000000000000000000000000000000000000000000080808000B0B0
      B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B00095959500B0B0B000B0B0
      B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0
      B000B0B0B000B0B0B00000000000000000000000000000000000A1A1A100A9A9
      A900A8A8A800A7A7A700A7A7A700A6A6A6009E9E9E0000000000000000000000
      0000000000009C9C9C009B9B9B009B9B9B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A0A0
      A000A5A5A50000000000A2A2A200A4A4A400A9A9A900A9A9A900A9A9A900A8A8
      A800A9A9A900AAAAAA0094949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      000000000000B0B0B0000000000000000000B0B0B0000000000000000000B0B0
      B0000000000000000000B0B0B0000000000000000000B0B0B000000000000000
      0000B0B0B0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A200A9A9A900A9A9A900A2A2A20000000000A4A4
      A400A8A8A800A2A2A20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700A6A6A60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AAAAAA009F9F9F00A3A3A3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A700A8A8A800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A2A2A200A3A3A300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A6A6A6009292920092929200959595009E9E9E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000818181008181
      8100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ABABAB00979797009E9E9E00A6A6A600A2A2A2009E9E
      9E00A2A2A200AAAAAA000000000000000000000000000000000000000000A5A5
      A500929292009C9C9C00ACACAC00A5A5A5000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800000000000000000000000000000000000000000000000000000000000A8A8
      A80098989800929292009F9F9F00AAAAAA00989898009B9B9B00000000000000
      00000000000000000000000000000000000000000000000000009F9F9F009D9D
      9D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081818100919191008E8E
      8E00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB00989898009E9E9E00AEAEAE00B1B1B100B4B4B400B7B7
      B700B7B7B700A7A7A7009999990098989800979797009B9B9B00999999009191
      91009A9A9A00ABABAB00B6B6B600A5A5A5000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000009B9B
      9B00B2B2B200B2B2B20091919100A7A7A700A8A8A8009A9A9A00999999000000
      000000000000000000000000000000000000A5A5A5009191910091919100A2A2
      A2009F9F9F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000089898900A5A5A500A6A6
      A600939393008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000098989800B2B2B2009E9E9E00A8A8A800A1A1A100AFAFAF00B2B2
      B200A8A8A8009797970097979700ACACAC00B7B7B700B6B6B600ACACAC009898
      98009F9F9F00B5B5B500AEAEAE00ADADAD000000000000000000000000000000
      0000000000000000000080808000808080008080800000000000000000000000
      0000838383008383830083838300838383008383830083838300838383008383
      8300000000000000000000000000000000000000000000000000000000009696
      9600B8B8B800BDBDBD00ABABAB0092929200A7A7A700A6A6A6009D9D9D009797
      9700000000000000000000000000A0A0A0008E8E8E0091919100A5A5A500A4A4
      A4009C9C9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008383830091919100A7A7A700A7A7
      A700A6A6A6009494940083838300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A6A6A6009D9D
      9D009C9C9C00A0A0A000BBBBBB00BDBDBD00A0A0A0009C9C9C00B7B7B700A2A2
      A2009393930097979700B8B8B800BCBCBC00B7B7B700ADADAD00B2B2B200BCBC
      BC009C9C9C00A2A2A200AAAAAA00000000000000000000000000000000000000
      0000000000008080800000000000808080000000000080808000000000000000
      0000878787008787870087878700878787008787870087878700878787008787
      870000000000000000000000000000000000000000000000000000000000A6A6
      A60095959500BABABA00BCBCBC00A5A5A50094949400A7A7A700A5A5A5009F9F
      9F0095959500ABABAB009E9E9E008E8E8E0091919100A5A5A500A0A0A000A2A2
      A200A3A3A3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008282820094949400A1A1A100A1A1
      A100A2A2A200A0A0A0008F8F8F008C8C8C000000000000000000000000000000
      000000000000848484008484840000000000000000000000000096969600ABAB
      AB00A0A0A000A1A1A1009C9C9C009E9E9E00ACACAC009C9C9C00A9A9A9009797
      970095959500AEAEAE00B9B9B900BCBCBC00BEBEBE00BBBBBB00B1B1B100B9B9
      B900B9B9B9009A9A9A0000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      00008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
      8B00000000000000000000000000000000000000000000000000000000000000
      0000A5A5A50096969600BCBCBC00BDBDBD009E9E9E0096969600A6A6A600A3A3
      A300A2A2A200919191008D8D8D0091919100A5A5A5009F9F9F00A6A6A6009898
      9800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008686860090909000939393009898
      98009D9D9D00A0A0A000A0A0A0008D8D8D008181810000000000000000000000
      0000858585008A8A8A00888888000000000000000000A3A3A3009C9C9C00ACAC
      AC00A1A1A100ACACAC00ABABAB00A8A8A800A4A4A4009D9D9D008D8D8D00A0A0
      A00097979700B2B2B200BCBCBC00BCBCBC00BDBDBD00BDBDBD00B8B8B800BCBC
      BC00BDBDBD00A6A6A600AAAAAA00000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      00008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E00000000000000000000000000000000000000000000000000000000000000
      000000000000A3A3A30098989800BCBCBC00BCBCBC009999990099999900A5A5
      A500A1A1A100A3A3A30091919100A4A4A400A0A0A000A4A4A40097979700AAAA
      AA00000000000000000000000000000000000000000000000000000000000000
      0000818181008B8B8B008A8A8A0086868600898989008C8C8C00919191009393
      9300959595009A9A9A00A1A1A1009E9E9E008F8F8F0082828200000000008484
      84008E8E8E008C8C8C00000000000000000000000000A4A4A40099999900ACAC
      AC009E9E9E00ABABAB00B1B1B100B0B0B000AFAFAF00A4A4A40098989800A2A2
      A2009A9A9A00AEAEAE00B4B4B400B0B0B000B1B1B100B0B0B000ABABAB00ACAC
      AC00B1B1B100B1B1B100A2A2A200000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000929292009292920092929200929292009292920092929200929292009292
      9200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A0A0A0009C9C9C00BCBCBC00BBBBBB00949494009C9C
      9C00A5A5A5009F9F9F00A9A9A900A2A2A2009F9F9F00A1A1A1009E9E9E000000
      0000000000000000000000000000000000000000000000000000000000008282
      8200909090009E9E9E00A0A0A000989898008B8B8B008A8A8A008C8C8C009090
      900093939300989898009E9E9E00A3A3A300A1A1A10097979700919191009393
      93009292920085858500000000000000000000000000A4A4A40099999900AEAE
      AE009E9E9E00ABABAB00B1B1B100B5B5B500B5B5B500A0A0A0009F9F9F00A6A6
      A60097979700A5A5A500A9A9A900ABABAB00ADADAD00ADADAD00ADADAD00ABAB
      AB00A7A7A700A8A8A8009F9F9F00000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000969696009696960096969600969696009696960096969600969696009696
      9600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009E9E9E00A1A1A100BFBFBF00B8B8B8009090
      90009D9D9D009B9B9B009F9F9F009A9A9A00A5A5A50093939300000000000000
      0000000000000000000000000000000000000000000081818100878787009898
      9800A2A2A200A2A2A200A1A1A100A1A1A1009898980089898900898989008D8D
      8D0091919100969696009C9C9C00A3A3A300A3A3A300A1A1A1009C9C9C009595
      95008E8E8E0084848400000000000000000000000000A5A5A50097979700AEAE
      AE009D9D9D00AAAAAA00B1B1B100B5B5B500B5B5B500A3A3A3009C9C9C00ACAC
      AC0095959500ADADAD00B0B0B000B0B0B000B1B1B100B1B1B100B1B1B100B0B0
      B000B0B0B000B2B2B200A1A1A100000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      00009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A009F9F9F00929292009393
      9300A2A2A200A2A2A200A2A2A200A2A2A200A2A2A20094949400A1A1A1000000
      000000000000000000000000000000000000000000008E8E8E009E9E9E00A9A9
      A900A6A6A600A4A4A400A2A2A200A1A1A100A0A0A00095959500888888008B8B
      8B008E8E8E00949494009B9B9B00A2A2A200A3A3A300A1A1A100989898009393
      93008A8A8A0000000000000000000000000000000000A6A6A60096969600B0B0
      B0009C9C9C00A9A9A900AFAFAF00B3B3B300B4B4B400ABABAB0097979700B4B4
      B40097979700ACACAC00B0B0B000B2B2B200B3B3B300B5B5B500B4B4B400B2B2
      B200B2B2B200ADADAD00A8A8A800000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      00009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AAAAAA00939393008E8E8E0095959500A5A5
      A500A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A4A4A400999999009E9E
      9E00000000000000000000000000000000000000000086868600919191009D9D
      9D00A4A4A400A6A6A600A3A3A300A1A1A1009F9F9F00969696008B8B8B008989
      89008C8C8C00909090009A9A9A00A2A2A200A3A3A3009F9F9F00979797009090
      90008585850000000000000000000000000000000000A7A7A70095959500B0B0
      B0009C9C9C00A9A9A900B0B0B000B5B5B500B5B5B500B4B4B40097979700B0B0
      B000ACACAC0098989800B2B2B200B6B6B600BABABA00BCBCBC00BCBCBC00B9B9
      B900B8B8B8009D9D9D0000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A9A9A900939393008F8F8F0097979700A8A8A800A5A5
      A500A5A5A500A8A8A800AEAEAE00AEAEAE00A8A8A800A5A5A500A7A7A7009D9D
      9D009C9C9C000000000000000000000000000000000000000000808080008282
      82008B8B8B00969696009D9D9D009F9F9F0094949400888888008B8B8B008A8A
      8A008A8A8A009090900099999900A2A2A200A4A4A4009E9E9E00959595008D8D
      8D000000000000000000000000000000000000000000A8A8A80095959500B0B0
      B0009C9C9C00A9A9A900B0B0B000B6B6B600B6B6B600B6B6B600ADADAD009797
      9700BABABA00A6A6A60099999900B4B4B400BEBEBE00BFBFBF00BFBFBF00BBBB
      BB009F9F9F00AAAAAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      000000000000A8A8A800929292008F8F8F0098989800ABABAB00A7A7A700A9A9
      A900ACACAC00B3B3B3009B9B9B009E9E9E00B3B3B300ACACAC00A9A9A900A9A9
      A900A3A3A3009999990000000000000000000000000000000000000000000000
      00008080800081818100868686008E8E8E008E8E8E008B8B8B00898989008C8C
      8C00888888008F8F8F0097979700A3A3A300A4A4A4009B9B9B00959595008D8D
      8D000000000000000000000000000000000000000000A8A8A80094949400B1B1
      B1009C9C9C00AAAAAA00B0B0B000B7B7B700B7B7B700B7B7B700B7B7B700ADAD
      AD009C9C9C00B1B1B100AFAFAF00999999009C9C9C00A4A4A400A0A0A0009A9A
      9A00A9A9A9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900000000000000000000000000000000000000000000000000000000000000
      0000A6A6A600909090008F8F8F0098989800ADADAD00A8A8A800ABABAB00AEAE
      AE00B4B4B400AFAFAF00949494009F9F9F00A5A5A500B6B6B600AFAFAF00ABAB
      AB00ABABAB00A9A9A90097979700000000000000000000000000000000000000
      0000000000000000000000000000828282009292920097979700929292009191
      91008A8A8A008B8B8B0096969600A4A4A400A5A5A5009B9B9B00909090008888
      88000000000000000000000000000000000000000000ABABAB0093939300B1B1
      B1009C9C9C00AAAAAA00AFAFAF00B8B8B800B7B7B700B7B7B700B7B7B700B7B7
      B700B7B7B700AFAFAF00A6A6A600A5A5A500A2A2A200A1A1A100A6A6A600A0A0
      A000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADADAD00ADAD
      AD0000000000000000000000000000000000000000000000000000000000A5A5
      A5008F8F8F008F8F8F0098989800B0B0B000A9A9A900ACACAC00AFAFAF00B3B3
      B300BBBBBB0092929200B4B4B400BDBDBD0097979700AEAEAE00B6B6B600B0B0
      B000ABABAB00AFAFAF00A4A4A400A7A7A7000000000000000000000000000000
      000000000000000000000000000000000000838383008D8D8D008F8F8F009797
      9700909090008989890095959500A4A4A400A4A4A400989898008F8F8F000000
      000000000000000000000000000000000000000000000000000093939300B1B1
      B1009C9C9C00ABABAB00ADADAD00B8B8B800B7B7B700B7B7B700B7B7B700B7B7
      B700B7B7B700B8B8B800B8B8B800B2B2B200B2B2B200A9A9A900A9A9A9009F9F
      9F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0
      B000000000000000000000000000000000000000000000000000A4A4A4009393
      93009090900099999900B2B2B200ABABAB00ABABAB00AFAFAF00B3B3B300BBBB
      BB00A5A5A5009494940097979700BCBCBC00BABABA0094949400B4B4B400B6B6
      B600B0B0B000B1B1B10098989800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000828282009090
      9000989898008A8A8A0093939300A5A5A500A3A3A30096969600898989000000
      000000000000000000000000000000000000000000000000000093939300B0B0
      B0009C9C9C00ACACAC00ACACAC00B9B9B900B8B8B800B8B8B800B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B800B6B6B600B3B3B300B4B4B400AAAAAA00A0A0
      A000ADADAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B40000000000000000000000000000000000000000000000000098989800B3B3
      B3009B9B9B009D9D9D00B2B2B200ADADAD00AEAEAE00B2B2B200B8B8B800B7B7
      B7009494940000000000A1A1A1009B9B9B00BDBDBD00B8B8B80093939300B7B7
      B700B6B6B600A2A2A200A9A9A900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008383
      830092929200909090008F8F8F00A5A5A500A2A2A20090909000878787000000
      000000000000000000000000000000000000000000000000000094949400B0B0
      B0009C9C9C00ADADAD00AAAAAA00B5B5B500B5B5B500B6B6B600B5B5B500B6B6
      B600B7B7B700B7B7B700B8B8B800B8B8B800B4B4B400B4B4B400B3B3B300A4A4
      A400ABABAB000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000808080000000000080808000000000000000
      0000B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8
      B800000000000000000000000000000000000000000000000000AAAAAA009898
      9800B0B0B0009F9F9F0098989800B2B2B200B2B2B200B5B5B500BDBDBD009696
      9600A6A6A60000000000000000009E9E9E00A0A0A000BDBDBD00B4B4B4009595
      9500B7B7B7009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000087878700949494008F8F8F00A2A2A2009E9E9E008D8D8D00000000000000
      000000000000000000000000000000000000000000000000000094949400B0B0
      B0009E9E9E00AEAEAE00AFAFAF00ADADAD00ABABAB00ABABAB00AAAAAA00A9A9
      A900A9A9A900A8A8A800A8A8A800A9A9A900A9A9A900AAAAAA00ACACAC00A9A9
      A900A8A8A8000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800000000000000000000000
      0000BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00000000000000000000000000000000000000000000000000000000000000
      00009B9B9B00A8A8A800A8A8A80096969600B3B3B300BCBCBC00A9A9A9009999
      9900000000000000000000000000000000009C9C9C00A6A6A600BFBFBF00B4B4
      B40094949400ACACAC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000818181008B8B8B00919191009E9E9E009898980089898900000000000000
      000000000000000000000000000000000000000000000000000098989800B3B3
      B300A7A7A7009F9F9F00A0A0A000A0A0A000A0A0A000A1A1A100A1A1A100A2A2
      A200A2A2A200A4A4A400A4A4A400A4A4A400A5A5A500A5A5A500A5A5A500A5A5
      A500A6A6A6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000009F9F9F00A0A0A000AFAFAF0094949400B2B2B20091919100ACAC
      AC000000000000000000000000000000000000000000A7A7A700A4A4A400A3A3
      A300A9A9A9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000838383008F8F8F00939393008C8C8C0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A6A6
      A600A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2
      A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A2A2A200A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A2009B9B9B00AFAFAF0093939300A1A1A1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000083838300868686008181810000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A6A6A600A8A8A800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2A2A2009B9B
      9B00989898009B9B9B00A2A2A200ABABAB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A9A9
      A900A0A0A000A4A4A40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB00A1A1A100A6A6A60000000000000000000000000000000000000000000000
      00000000000000000000A7A7A70097979700949494009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800969696008F8F8F0093939300A0A0
      A000A7A7A700A7A7A700A2A2A2009696960094949400A8A8A800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009F9F9F009393
      9300A6A6A600AAAAAA00AAAAAA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1009292
      9200A6A6A600A9A9A900A8A8A800000000000000000000000000000000000000
      000000000000000000009999990092929200A1A1A100AEAEAE0095959500A1A1
      A100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009F9F9F008F8F8F0093939300A8A8A800ADADAD00AAAA
      AA00A7A7A700A7A7A700A9A9A900ADADAD00ADADAD009A9A9A00999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9A00949494009E9E
      9E00A7A7A700ADADAD00A8A8A800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00919191009E9E
      9E00A7A7A700ADADAD00A6A6A600000000000000000000000000000000000000
      000000000000A2A2A2009393930092929200B4B4B400B3B3B300B8B8B800A5A5
      A5009A9A9A00000000000000000000000000A1A1A100939393009E9E9E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E008E8E8E0095959500AAAAAA00A6A6A6009D9D9D00A0A0
      A000A0A0A000A0A0A000A0A0A000A1A1A100A3A3A300AAAAAA00A5A5A5009595
      9500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A2A2A2009D9D9D009D9D
      9D009D9D9D009F9F9F00A6A6A600AAAAAA009D9D9D00939393009D9D9D00AEAE
      AE00A7A7A700BABABA00B3B3B300ACACAC000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A3009D9D9D009D9D
      9D009D9D9D00A0A0A000A6A6A600000000009E9E9E00909090009C9C9C00ADAD
      AD00A6A6A600BABABA00B2B2B200ACACAC000000000000000000000000000000
      00000000000096969600ADADAD009595950092929200A6A6A600B5B5B500B6B6
      B600AEAEAE009A9A9A0000000000999999008F8F8F0094949400ABABAB009E9E
      9E00000000000000000000000000000000000000000000000000000000000000
      0000A2A2A2008F8F8F0091919100A8A8A800A1A1A1009D9D9D008D8D8D009292
      92009A9A9A009B9B9B009B9B9B009C9C9C009D9D9D009F9F9F00A5A5A500A6A6
      A600989898000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009D9D9D009F9F9F00A7A7A700B1B1B100BABA
      BA00BCBCBC00BBBBBB00B4B4B400A7A7A7009A9A9A00AEAEAE00A9A9A900B3B3
      B300B7B7B700BABABA00A5A5A500000000000000000000000000000000000000
      00000000000000000000000000009E9E9E009E9E9E00A7A7A700B0B0B000B9B9
      B900BCBCBC00BABABA00B3B3B300A6A6A60098989800ADADAD00AAAAAA00B3B3
      B300B7B7B700B9B9B900A5A5A500000000000000000000000000000000000000
      0000A4A4A4009F9F9F00BFBFBF00BCBCBC00B7B7B7009C9C9C0099999900B4B4
      B400B4B4B400AAAAAA00949494008E8E8E0091919100B1B1B100B3B3B300A4A4
      A400A2A2A200000000000000000000000000000000000000000000000000A9A9
      A900939393008E8E8E00A1A1A100A1A1A100999999009898980095959500A2A2
      A20097979700919191009696960097979700989898009A9A9A009C9C9C00A2A2
      A2009F9F9F00A1A1A10000000000000000000000000000000000000000000000
      000000000000A9A9A90097979700A4A4A400AFAFAF00BCBCBC00BEBEBE00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BEBEBE00B4B4B400A2A2A200A9A9A900ADAD
      AD00BDBDBD00A3A3A30000000000000000000000000000000000000000000000
      000000000000ABABAB0098989800A3A3A300AEAEAE00BCBCBC00BEBEBE00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BEBEBE00B3B3B300A2A2A200A8A8A800ADAD
      AD00BDBDBD00A3A3A30000000000000000000000000000000000000000000000
      0000000000009F9F9F009B9B9B00ACACAC00BFBFBF00BFBFBF00A2A2A2009D9D
      9D00B1B1B100B2B2B2009B9B9B009F9F9F00B3B3B300B2B2B200B1B1B1009696
      9600A8A8A8000000000000000000000000000000000000000000000000009B9B
      9B009292920091919100A3A3A300989898009696960095959500939393008E8E
      8E00BFBFBF00ABABAB008E8E8E00909090009292920095959500979797009999
      9900A3A3A3009494940000000000000000000000000000000000000000000000
      0000AAAAAA0096969600A4A4A400B2B2B200BCBCBC00BBBBBB00BCBCBC00BEBE
      BE00BFBFBF00BFBFBF00BEBEBE00BDBDBD00BCBCBC00B8B8B800A7A7A700A6A6
      A600A5A5A5000000000000000000000000000000000000000000000000000000
      00000000000097979700A4A4A400B0B0B000BCBCBC00BBBBBB00BCBCBC00BEBE
      BE00BEBEBE00BEBEBE00BEBEBE00BDBDBD00BCBCBC00B7B7B700A7A7A700A6A6
      A600A6A6A6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A1A1A10099999900BCBCBC00B9B9B9009393
      9300ADADAD00A9A9A900B1B1B100B0B0B000ADADAD00B1B1B10099999900A1A1
      A100000000000000000000000000000000000000000000000000A8A8A8009393
      93008F8F8F00989898009E9E9E009393930092929200909090008F8F8F008F8F
      8F0099999900BFBFBF00BDBDBD00979797008E8E8E008F8F8F00919191009393
      930098989800A0A0A0009F9F9F00000000000000000000000000000000000000
      000098989800A4A4A400ACACAC00BBBBBB00BBBBBB00BABABA00BBBBBB00B4B4
      B4009F9F9F00A2A2A200A3A3A300BCBCBC00BABABA00BBBBBB00B6B6B600A6A6
      A600ABABAB000000000000000000000000000000000000000000000000000000
      000099999900A3A3A300AAAAAA00BBBBBB00BBBBBB00BABABA00BBBBBB00BDBD
      BD00BEBEBE00BEBEBE00BCBCBC00BBBBBB00BABABA00BBBBBB00B6B6B600A6A6
      A600ABABAB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009F9F9F009A9A9A00B4B4B400A0A0
      A000A0A0A000A5A5A500A7A7A700AFAFAF00A9A9A90094949400A0A0A0000000
      00000000000000000000000000000000000000000000000000009E9E9E009A9A
      9A008D8D8D009B9B9B0096969600909090008F8F8F008F8F8F00909090009191
      91008E8E8E00B2B2B200BFBFBF00BFBFBF00ADADAD008E8E8E008F8F8F008F8F
      8F00919191009D9D9D0093939300000000000000000000000000000000009F9F
      9F009F9F9F00A4A4A400B9B9B900BABABA00BABABA00BABABA00BBBBBB00B3B3
      B300B1B1B100BFBFBF00A5A5A500BBBBBB00BABABA00BABABA00BABABA00AEAE
      AE00ACACAC00000000000000000000000000000000000000000000000000A1A1
      A1009D9D9D00A5A5A500B7B7B700BABABA00BABABA00BBBBBB00BBBBBB00BCBC
      BC00BEBEBE00BEBEBE00BCBCBC00BBBBBB00BBBBBB00BABABA00BABABA00ADAD
      AD00ACACAC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C9C9C008F8F8F00AAAAAA00A6A6
      A60098989800A3A3A300A6A6A6009696960090909000A0A0A000000000000000
      000000000000000000000000000000000000000000000000000097979700A0A0
      A0008D8D8D009B9B9B00929292008F8F8F009090900092929200939393009494
      9400939393008F8F8F00BFBFBF00BFBFBF00BFBFBF00BEBEBE009A9A9A008E8E
      8E008F8F8F009393930095959500ACACAC000000000000000000A9A9A9009595
      9500AAAAAA00A9A9A900B9B9B900B9B9B900BABABA00BBBBBB00BCBCBC00B6B6
      B600ACACAC00BFBFBF00A7A7A700BABABA00BCBCBC00BBBBBB00BABABA00B7B7
      B700A6A6A6000000000000000000000000000000000000000000ABABAB009595
      9500AAAAAA00A7A7A700B9B9B900B9B9B900B9B9B900BABABA00ABABAB00ABAB
      AB00ABABAB00ABABAB00ABABAB00ABABAB00ABABAB00B9B9B900B9B9B900B6B6
      B600A5A5A5000000000000000000000000000000000000000000000000000000
      00000000000000000000A8A8A800949494009090900092929200919191009D9D
      9D0095959500A1A1A1009E9E9E009A9A9A00919191009292920095959500A5A5
      A50000000000000000000000000000000000000000000000000094949400A5A5
      A5008D8D8D009999990092929200919191009292920093939300959595009696
      96009898980092929200A9A9A900BFBFBF00BFBFBF00BFBFBF00BFBFBF00A9A9
      A9008E8E8E009090900096969600A5A5A5000000000000000000A0A0A0009E9E
      9E00A6A6A600AEAEAE00B6B6B600B9B9B900B0B0B000A7A7A700A7A7A700A4A4
      A400A7A7A700BFBFBF00ACACAC00A3A3A300A4A4A400A4A4A400B8B8B800B6B6
      B600A7A7A7000000000000000000000000000000000000000000A3A3A3009B9B
      9B00A9A9A900ACACAC00B7B7B700B7B7B700B9B9B900B9B9B900A0A0A000B8B8
      B800B7B7B700B7B7B700B7B7B700B8B8B800ACACAC00B4B4B400B8B8B800B5B5
      B500A7A7A7000000000000000000000000000000000000000000000000000000
      000000000000000000009696960098989800939393009F9F9F009C9C9C009191
      910098989800A4A4A4009E9E9E00A1A1A1009F9F9F009F9F9F009F9F9F009696
      9600A6A6A600000000000000000000000000000000000000000093939300A9A9
      A9008C8C8C009898980095959500959595009A9A9A009D9D9D009F9F9F00A0A0
      A000A2A2A20092929200BBBBBB00BFBFBF00BFBFBF00BFBFBF00AAAAAA009292
      92009B9B9B009696960098989800A1A1A10000000000000000009A9A9A00AAAA
      AA00A4A4A400AFAFAF00B0B0B000B6B6B600A4A4A400B3B3B300BABABA00BABA
      BA00BDBDBD00BFBFBF00BFBFBF00BDBDBD00BFBFBF00ACACAC00B4B4B400AFAF
      AF00A8A8A800ADADAD00000000000000000000000000000000009C9C9C00A8A8
      A800A6A6A600ACACAC00B0B0B000B5B5B500B7B7B700B9B9B900A0A0A000BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00B7B7B700AFAFAF00B6B6B600AFAF
      AF00A8A8A800ADADAD0000000000000000000000000000000000000000000000
      000000000000A0A0A000A1A1A100B7B7B70096969600A6A6A600A9A9A900A8A8
      A800A7A7A700A8A8A800A8A8A800A9A9A900A5A5A500A1A1A100AAAAAA009E9E
      9E00A5A5A500000000000000000000000000000000000000000094949400AAAA
      AA008D8D8D009D9D9D00A2A2A2009E9E9E00A0A0A000A1A1A100A2A2A200A3A3
      A300A2A2A20095959500BFBFBF00BFBFBF00BFBFBF009B9B9B0098989800A2A2
      A200A1A1A100A0A0A000A1A1A100A0A0A000000000000000000097979700B1B1
      B100A3A3A300ABABAB00AAAAAA00B3B3B300A7A7A700B9B9B900BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00B3B3B300AFAFAF00ABAB
      AB00A7A7A700ABABAB000000000000000000000000000000000098989800ACAC
      AC00A5A5A500AAAAAA00AAAAAA00B0B0B000B5B5B500B7B7B700A0A0A000BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BCBCBC00AAAAAA00B4B4B400ABAB
      AB00A7A7A700ABABAB0000000000000000000000000000000000000000000000
      000000000000A7A7A70095959500BABABA00B8B8B80095959500A8A8A800B3B3
      B300B3B3B300B4B4B400B4B4B400B2B2B20093939300AFAFAF009C9C9C009292
      920000000000000000000000000000000000000000000000000097979700AAAA
      AA009393930095959500A7A7A700A0A0A000A2A2A200A3A3A300A4A4A400A7A7
      A70098989800B3B3B300BFBFBF00B9B9B90092929200A2A2A200A7A7A700A6A6
      A600A4A4A400A3A3A300A1A1A100A3A3A300000000000000000096969600B3B3
      B300A5A5A500A8A8A800A7A7A700AEAEAE00A8A8A800A3A3A300A6A6A600A4A4
      A400A6A6A600BFBFBF00BBBBBB009C9C9C009F9F9F009F9F9F00B1B1B100AFAF
      AF00AAAAAA00ABABAB000000000000000000000000000000000098989800ADAD
      AD00A7A7A700A7A7A700A7A7A700ACACAC00B4B4B400B8B8B8009C9C9C00A7A7
      A700A3A3A300A1A1A100A0A0A0009F9F9F009F9F9F00ABABAB00B6B6B600AFAF
      AF00AAAAAA00ABABAB0000000000000000000000000000000000000000000000
      00000000000000000000A6A6A60097979700B9B9B900BFBFBF009F9F9F009393
      93009C9C9C00A2A2A2009C9C9C009292920096969600BEBEBE00B2B2B200A2A2
      A2000000000000000000000000000000000000000000000000009E9E9E00A0A0
      A000A4A4A4008D8D8D00AAAAAA00A5A5A500A4A4A400A6A6A600A7A7A700AAAA
      AA0092929200BFBFBF00ADADAD0092929200AAAAAA00ABABAB00AAAAAA00A8A8
      A800A7A7A700A9A9A9009B9B9B00A8A8A800000000000000000099999900B0B0
      B000AAAAAA00A6A6A600AFAFAF00B1B1B100B4B4B400B1B1B100B4B4B400B7B7
      B7009F9F9F00BFBFBF00BDBDBD00A7A7A700BABABA00B8B8B800B4B4B400B1B1
      B100AEAEAE00ACACAC00000000000000000000000000000000009A9A9A00ABAB
      AB00ADADAD00A5A5A500AFAFAF00B0B0B000B4B4B400B7B7B700B4B4B400B4B4
      B400B6B6B600B8B8B800B9B9B900B9B9B900B9B9B900B7B7B700B3B3B300B1B1
      B100ADADAD00ACACAC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A0009C9C9C00ADADAD00B2B2
      B200A8A8A80093939300929292009A9A9A00919191009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000A6A6A6009494
      9400B4B4B4008D8D8D009F9F9F00ABABAB00A7A7A700A8A8A800ABABAB00A2A2
      A200AAAAAA00A0A0A0009A9A9A00AFAFAF00AEAEAE00AEAEAE00ADADAD00ACAC
      AC00AAAAAA00AFAFAF00919191000000000000000000000000009D9D9D00A2A2
      A200B2B2B200A3A3A300B2B2B200B0B0B000B2B2B200B5B5B500B7B7B700B9B9
      B9009F9F9F00BFBFBF00BFBFBF00A3A3A300B8B8B800B4B4B400B3B3B300B3B3
      B300A9A9A900AEAEAE0000000000000000000000000000000000A0A0A0009E9E
      9E00B5B5B500A2A2A200B1B1B100B1B1B100B2B2B200B5B5B500B6B6B600B7B7
      B700B7B7B700B7B7B700B7B7B700B7B7B700B6B6B600B4B4B400B2B2B200B3B3
      B300A9A9A9000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009A9A9A009393
      93009393930092929200A2A2A200A6A6A600A0A0A00093939300000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      9900ABABAB00A4A4A4008D8D8D00ACACAC00ADADAD00AAAAAA00AEAEAE009090
      900092929200A5A5A500B1B1B100B1B1B100B1B1B100B0B0B000AFAFAF00AEAE
      AE00AFAFAF00AAAAAA0098989800000000000000000000000000A6A6A6009494
      9400BCBCBC00A3A3A300ACACAC00B3B3B300B2B2B200B3B3B300B4B4B400B8B8
      B800A0A0A000B5B5B500B0B0B0009F9F9F00B7B7B700B4B4B400B5B5B500B5B5
      B500A6A6A6000000000000000000000000000000000000000000A8A8A8009393
      9300BBBBBB00A5A5A500A9A9A900B3B3B300B3B3B300B3B3B300B4B4B400B6B6
      B600B7B7B700B9B9B900B9B9B900B8B8B800B6B6B600B4B4B400B5B5B500B5B5
      B500A6A6A6000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A9A9A90093939300A2A2
      A2009595950097979700999999009A9A9A009A9A9A0098989800A3A3A3000000
      000000000000000000000000000000000000000000000000000000000000A7A7
      A70094949400BABABA009393930092929200B1B1B100AFAFAF00ACACAC008E8E
      8E00ADADAD00B3B3B300B3B3B300B3B3B300B3B3B300B2B2B200B1B1B100B1B1
      B100B4B4B40092929200AAAAAA00000000000000000000000000000000009999
      9900ACACAC00B1B1B100A2A2A200B2B2B200B5B5B500B5B5B500B5B5B500B7B7
      B700AEAEAE00ABABAB00B1B1B100B8B8B800BABABA00B7B7B700B8B8B800AEAE
      AE00ABABAB000000000000000000000000000000000000000000000000009B9B
      9B00A7A7A700B6B6B600A2A2A200B0B0B000B5B5B500B5B5B500B5B5B500B6B6
      B600BABABA00BCBCBC00BDBDBD00BCBCBC00BABABA00B7B7B700B9B9B900ADAD
      AD00ACACAC000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7A7A70094949400ADAD
      AD00979797009E9E9E00A4A4A400A4A4A400A7A7A700A3A3A300A1A1A1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A2A2A2009A9A9A00BABABA008D8D8D0097979700B3B3B300B3B3B300B1B1
      B100B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B4B4B400B7B7
      B7009D9D9D009D9D9D000000000000000000000000000000000000000000A7A7
      A70094949400BBBBBB00A9A9A900A4A4A400B6B6B600B8B8B800B7B7B700B9B9
      B900BEBEBE00BFBFBF00BFBFBF00BFBFBF00BCBCBC00BABABA00B5B5B500A6A6
      A60000000000000000000000000000000000000000000000000000000000A9A9
      A90095959500B8B8B800AEAEAE00A3A3A300B4B4B400B8B8B800B7B7B700B8B8
      B800BCBCBC00BEBEBE00BEBEBE00BEBEBE00BCBCBC00BBBBBB00B4B4B400A6A6
      A600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000094949400B3B3
      B300A4A4A4009B9B9B00B0B0B000B1B1B100B4B4B4009D9D9D00A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A1A1A1009C9C9C00BBBBBB009191910090909000AFAFAF00B8B8
      B800B6B6B600B6B6B600B5B5B500B5B5B500B6B6B600B8B8B800B8B8B8009C9C
      9C00989898000000000000000000000000000000000000000000000000000000
      0000A5A5A50096969600BBBBBB00A9A9A900A4A4A400B4B4B400BBBBBB00BBBB
      BB00BDBDBD00BEBEBE00BEBEBE00BEBEBE00BEBEBE00B4B4B400A5A5A500AEAE
      AE00000000000000000000000000000000000000000000000000000000000000
      0000A7A7A70095959500B8B8B800ADADAD00A3A3A300B1B1B100BBBBBB00BCBC
      BC00BDBDBD00BEBEBE00BEBEBE00BEBEBE00BEBEBE00B3B3B300A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009F9F9F00A0A0
      A000BDBDBD0096969600A5A5A500B4B4B400A5A5A50099999900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A6A6A60098989800B1B1B100A3A3A3008D8D8D009898
      9800AEAEAE00B7B7B700B9B9B900B8B8B800B4B4B400A4A4A400909090009A9A
      9A00000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A70097979700ADADAD00B1B1B100A4A4A400A9A9A900B5B5
      B500BBBBBB00BDBDBD00BCBCBC00B6B6B600AAAAAA00A3A3A300ADADAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9A9A90099999900A8A8A800B4B4B400A5A5A500A7A7A700B2B2
      B200B9B9B900BCBCBC00BABABA00B4B4B400A9A9A900A3A3A300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A2A2
      A2009D9D9D00A6A6A6009C9C9C00949494009B9B9B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A5009C9C9C00A0A0A0009898
      9800909090008E8E8E008E8E8E008E8E8E009090900096969600A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A4A4A4009B9B9B00A1A1A100A7A7A700A7A7
      A700A6A6A600A6A6A600A6A6A600A3A3A300A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A6A6A6009C9C9C009E9E9E00A5A5A500A7A7
      A700A7A7A700A6A6A600A5A5A500A1A1A100A4A4A40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A9A9
      A900A5A5A500A3A3A300A3A3A300A7A7A7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A700A3A3
      A300A3A3A300A5A5A500ABABAB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A9A9A900A6A6
      A600A5A5A500A8A8A80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000600000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF00FE1FFFFFFFFFFFFFFF000000FC007FFF
      FFFFFFFFFF000000F80007C00003C00003000000F80007C00003C00003000000
      F80003C00003C00003000000F80003C00003C00003000000F80003C00003C000
      03000000FC0003C00003C00003000000FC0003C00003C00003000000FC0003C0
      0003C00003000000FC0003C00003C00003000000F80001C00003C00003000000
      F00001C00003C00003000000E00001C00003C00003000000E00001C00003C000
      03000000E00001C00003C00003000000E00003C00003C00003000000F80003C0
      0003C00003000000FC0007C00003C00003000000FC000FC00003C00003000000
      FC001FC00003C00003000000FC00FFC00003C00003000000FE3FFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6
      DB6FFFFFFFFFC7FFFFFFFFC00003FFFFFFFF831FC7447FDB6DB7C3FFFFFF800F
      F7777F9B6DB7C00FFFFB800FE4667FC000038001FFF00007F65DFFD36D878000
      3FE00003C7667F9B6D9380001FE00001FFFFFFC0000380001FE00001DB6DB7DB
      69B780000FF00601DB6DB7996DB780000FE01F83C00003C00003800007807F07
      C00003D94D3780000780FF03C000039A4DB780000380FF03C00003C000038000
      0381FE03C00003DA4DB780000181F807C000039B4DB7800001C0201FC00003C0
      000380003FC0001FC00003DB2DB780003FC0001FDB6DB79B2DB7C0007FE0003F
      DB6DB7C00003C078FFE401FFFFFFFFDB6DB7FFFFFFFC23FFFFFFFFFFFFFFFFFF
      FFFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFF3FF9FF
      FFFFF07FFFFFCFFFFC03E0F0000FE03FCFFF87FFF80000FEF00FE01F07FF83FF
      F80000FC700FE00E07FF01FFC00001FAB00FE00007FF00F9C00003FEF00FF000
      0FFF0071800001FEF00FF8000FF00023800001FEF00FFC001FE00003800001FE
      F00FFE003F800003800001FEF00FFF001F800007800001FEF00FFE000F800007
      800003FEF00FFC0007C0000F800003FEF00FF80003F0000F800007FEF00FF000
      01FE000F80000FFEF00FE00000FF001FC0000FFEF00FC00001FFC01FC00007FE
      F00FC00401FFE01FC00007FAB00FC00603FFF03FC00007FC700FF00F03FFF03F
      C00007FEF00FF80F87FFF87FE0000FF0000FFC1FFFFFFC7FFFFFFFFFFFFFFF3F
      FFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0FFFFFFE3FFFFE3FC3FFFFE
      003FFFFFC1FFFFC1FC0FFFFC001FFFFF81FFFF81F8071FF8000FFF8000FF8100
      F8020FF00007FE0001FE0001F00007E00003F80003F80003F80007E00003F000
      07F80007FE000FC00001F00007F00007FF001FC00001E00007E00007FF003FC0
      0000C00007C00007FC000FC00000C00007C00007FC0007C00000C00003C00003
      F80007C00000C00003C00003F8000FC00000C00003C00003FC000FC00000C000
      03C00003FF003FC00001C00003C00007FFC03FE00001C00007C00007FF801FE0
      0001E00007E00007FF801FF00003E0000FE0000FFFC01FF80007F0000FF0001F
      FFC03FFC000FF8001FF8003FFFE07FFF001FFE007FFE007FFFFFFFFFE0FFFFC1
      FFFFC3FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList3: TImageList
    Height = 32
    Width = 32
    Left = 467
    Top = 140
    Bitmap = {
      494C01010B002400240020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A8A8A7009E9B9500A6A09600B5B0
      A900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A8A8A7009E9B9500A6A09600B5B0
      A900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000959DA5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000087898B004470
      9B00787D6C00B9A6830000000000000000000000000000000000000000000000
      00000000000000000000888987009F723100E5890600E98C0100E78F0200E589
      0100DA850A00BF7A2100B28140009D886B00A29A8E00B1AEAA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000888987009F723100E5890600EA8D0100EA8D0100E589
      0100DA850A00C27E2100B28140009D886B00A29A8E00B1AEAA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB00797979002994F4002487E5001A93FE001E8CF3004480BA008C9EAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00535C6300055897000DBA
      FA0028D6FD00C8A7660000000000000000000000000000000000000000000000
      00000000000073737300BC781300E5890100FECA7300FFE6A900FFE2A300FFEA
      AA00FFE6B000FCDEA200F9CE8200EEB34B00EC9F2600E68C0500DA850A00BF7A
      2100AD7D420097836A009F988F00B1AEAA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073737300BC781300E5890100FECA7400FFE5A600FFE1A100FFE6
      A900FFE6B000FCDEA200F9CE8200ECAF4C00EC9E2600E68D0500DA850A00BD78
      2100AD7D420097836A009F988F00B1AEAA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008383
      83004C5F7000259BFE00238DF4001284F2003CBAF8003CBAF8001B8DFF002487
      E5004E80AF0098A0A70000000000000000000000000000000000A3A3A2009A93
      8A009A938A00A9A19700ABABAB0087898B00354D6600055897000FA2E00000D2
      FF0069F3FE006DB7E000ADB4B500000000000000000000000000000000000000
      00008585850081613100E5860000FED17D00FDC56B00FFC14E00FEC05300FECB
      6D00FFD27400FFDA8300FFE39400FFE9A400FFF5C800FFFFD300FFFEDC00FFFA
      CB00FEE5AD00FECD7900F1AD3E00E9951400CE811000B8935E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008585850081613100E5860000FED28300FEC96200FFC04E00FFC85E00FEC9
      6200FFD17300FFDA8400FFE29300FFE9A400FFF5C800FFFFD300FFFEDC00FFFA
      CB00FEE4AD00FECD7900F1AC3C00E9941300CE811000B8935E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ABABAB005E5E
      5E0069A7D8002195FC003CBAF800238DF40022B3F80071F1FF0064EAFD0055CE
      FB0036A2FC001492FD002487E50044709B006B6B6B00AF824700EDA23B00EDA2
      3B00F0A63F00F0A63F00EDA23B00A47737002472A4000984D60069F3FE0064EA
      FD00D8FFFF004897CA0000000000000000000000000000000000000000000000
      00005B5B5B00DE901700E2911200FED28300FFB33400FFBA4B00FEC05300FECA
      6300FECB6D00FFD27400FFDA8300FFDA8D00FFE39B00FFE9A400FFEAAA00FFF3
      B700FFF5B900FFFACB00FFFACB00FFFFD300FFFACB00F9CE8200C0822E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005B5B5B00DC8D1500E3911100FED28300FEB23300FFC04E00FFC15100FFC8
      5E00FFD06E00FED27C00FFDA8400FFDE8D00FFE39B00FFE9A400FFEBA900FFF3
      B700FFF5B900FFFACB00FFFACB00FFFFD300FFFACB00F9CE8200C0822E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000929292004749
      4C008AD0FE001E8CF3003CBAF80036A2FC000CA5F7009AFFFF0028E5FD0034E7
      FE0064EAFD0064EAFD002C9AC40053636900EA993300E49C4000F9D8A800FBF5
      EA00E9F6FD00E9F6FD00FDFCF400F5CB8800EA993300B1853D003DBFEE00D8FF
      FF004897CA000000000000000000000000000000000000000000000000008D8D
      8D00645B4D00E9951400E9A33300FEC05300FFB33400FFB94200FFC14E00FEC3
      5C00FECA6300FECB6D00FFD97E00FFDA8300FFDA8D00FFE39400FFE39B00FFE9
      A400FFEAAA00FFEAAA00FFEAAA00FFE9A400FFE39B00FFE9A400FFDA8D00B58B
      5100000000000000000000000000000000000000000000000000000000008D8D
      8D00645B4D00E9941300E6A13200FEBC5300FEB23300FEBA4300FFC04E00FEC3
      5C00FEC96200FFD06E00FED27C00FFDA8400FFDD8A00FFE29300FFE39B00FFE9
      A400FFEBA900FFEBA900FFEBA900FFE9A400FFE39B00FFE9A400FDD68C00B58B
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000929292004749
      4C0089CDFF001284F2003CBAF8003CBAF8001390F4009AFFFF000CE4FF0014E6
      FF000CE4FF00009CBA00636D5000E9962C00E3A14800FBF6C800FDFBD400DFE1
      D500D8D8C800C0C0C000BEC0B500EFF2D800FBF6C800EA993300B8A472003C9E
      DC0095B0C7000000000000000000000000000000000000000000000000006C6C
      6C00B99B6A00E2911200E4A23500FFB64400FFB33400FFB53C00FFB94200FFC1
      4E00FFC14E00F5B34500FDC36200FECB6D00FFD97E00FFE39400FFE39B00FFEA
      9E00FFE9A400FFE9A400FFE9A400FFE39400FFE39400FFDA8D00FFE39400E29B
      2B00BDB6AC000000000000000000000000000000000000000000000000006C6C
      6C00B99B6A00E3911100E6A13200FEBA4B00FFB12D00FFB43C00FEBA4300FFC0
      4E00FEC35C00FEC96200FFD06E00FFD17300FED27C00FFDE8D00FFDE8D00FFE2
      9300FFE39B00FFE39B00FFE39B00FFE29300FFE29300FFDD8A00FFE29300DE9A
      2F00BDB6AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000087898B004749
      4C008AD0FE001284F2003CBAF80045BDF8000A7DF00084FAFF0028E5FD0014E6
      FF00009CBA004B6A5500EA993300E49C4000FBF6C800FDFBD400FDFBD400FBF5
      EA00FBF5EA00E3E3D700D8D8C800DCD3AB00FDFBD400FCF3BB00DF922D00ADB4
      B500000000000000000000000000000000000000000000000000000000005B5B
      5B00E8BF7E00DC8D1400E79C2700FFBA4B00FEAA2300FFB33400FFB93F00FFB9
      4200F5B03800D7922A00E3A64B00DC963200D68B1800D6820300D6820300DA85
      0A00E2911200E79C2700EEB34B00F4C26000FFDA8D00FFD97E00FFD27400F7CC
      7D00BEA27A000000000000000000000000000000000000000000000000005B5B
      5B00E8BF7E00DC8D1500E69B2600FEBA4B00FFAD2900FEB23300FFB83E00FEBA
      4300FFC04E00FEC35C00FEC96200FFD06E00DA850A00FED27C00FFDB8A00FFDB
      8A00FFDD8A00FFDE8D00FFDE8D00FFDD8A00FFDA8400FED27C00FFD17300FECD
      7900BEA27A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000838383004749
      4C008AD0FE001284F20045BDF8004BC8F9000F78EF0071F1FF0034E7FE0008B8
      D100175A6200F3AA4A00DA943600EBC37B00ECE6B600FBF6C800FDFBD400FDFB
      D400FBF5EA00FDFBD400FBF6C800ECE2AE00FDFBD400FDFBD400ECC88C00C897
      5600000000000000000000000000000000000000000000000000000000005656
      5600E8BF7E00DD8F1C00DC921D00FFBA4B00FEA61B00FDAD2A00FFB33400FFB9
      3F00F7B03300E4B06300FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FCF9F600F9EEE000F5E2C700D9922600FFD97E00FFD27400FECB6D00FED5
      8A00C08E4A000000000000000000000000000000000000000000000000005656
      5600E8BF7E00DB921D00DB921D00FEBA4B00FFA81C00FFAD2900FEB23300FFB8
      3E00FEBA4300FFC04E00FEC35C00FFD06E00D6830300DC8D1500FFD06E00FED2
      7C00FED27C00FED27C00FED27C00FED27C00FED27C00FFD17300FECA6C00FFD5
      8900C08E4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000838383004D54
      5A0084CAFE001284F20045BDF8005BE6FB000F78EF004EF4FF005BE6FB000075
      89009D8E6100EAAA5700DA943600E9D89A00ECE2AE00FDFBD400FDFBD400FDFB
      D400FDFBD400FDFBD400FDFBD400FCF3BB00FDFBD400FDFBD400FBF6C800E996
      2C002487E5000000000000000000000000000000000000000000000000005B5B
      5B00E5BC7D00DF942100DE901700FFBA4B00FEA21200FEAA2300FDAD2A00FFB3
      3400FDAD2A00DC9F4100FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00E3A64B00FECA6300FECA6300FEBD5A00FED1
      7D00C88A30000000000000000000000000000000000000000000000000005B5B
      5B00E4BC7D00DF942100DE911700FEBA4B00FFA21300FFAA2200FFAD2900FEB2
      3300FFB83E00FEBA4300FFC15100FEC35C00DB890A00F8EDDD00DB890A00FEC9
      6200FFD06E00FFD06E00FFD06E00FFD06E00FECA6C00FEC96200FFC85E00FED2
      7C00C88A30000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000083838300454E
      54008AD0FE001284F20045BDF8005BE6FB000F78EF0034E7FE0065CFD9000052
      6200F2C47B00EAAA5700DA943600ECC88C00ECE6B600FBF6C800ECE6B600ECE6
      B600FCF3BB00ECE6B600D9D7B000DBCFA800ECE2AE00ECE6B600FCF3BB00F0A6
      3F004D9AD500A7B8C70000000000000000000000000000000000000000005B5B
      5B00D3AF7500E29B2B00DE8C0C00FFBA4B00FE9E0900FEA61B00FEAA2300FDAD
      2A00FDAD2A00DA932900FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00E8BF7E00FFBA4B00FEC35C00FEC05300FECB
      6D00D1881C000000000000000000000000000000000000000000000000005B5B
      5B00D3AF7600E39A2A00DB890A00FEBA4B00FF9E0A00FFA51A00FFAA2200FFAD
      2900FEB23300FFB43C00FFB83E00FEBA4B00DE880000FEFEFE00F9F0E300D985
      0200FEC35C00FEC96200FEC96200FFC85E00FFC85E00FEC35C00FFC15100FFD0
      6E00D1881C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000838383004D54
      5A0084CAFE001284F20045BDF80064EAFD001284F20021CAFC0069B7BA001859
      5E00FFD39100E5AE6400DA943600D7B87900D3BC8200CFC08400CFC08400D1C4
      9200D1C49200D1C49200D1C49200CBC19000CBBB8200C2AD7200D7B87900F3AA
      4A0077A7AA0095B0C70000000000000000000000000000000000000000006060
      6000C3A26F00E39E3100DA860500FFBA4B00FE9A0100FEA21200FEA61B00FEAA
      2300FEAA2300D68E1C00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00F0D6B100F4AB2D00FEBC5200FFB94200FEC0
      5300DC921D000000000000000000000000000000000000000000000000006060
      6000C3A26F00E39E3000D9860500FEBA4B00FF9A0200FFA21300FFA51A00FFA8
      1C00FFAD2900FFAD3100FEB23300FFB83E00E68D0500F9EFE100FEFEFE00F9EF
      E100D9860500FFC04E00FFC15100FFC15100FFC04E00FEBA4B00FEBA4300FEBC
      5300DB921D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000797979004B57
      64007BC6FE001284F20045BDF80064EAFD001390F40018A6FC0069B7BA001859
      5E00F9D8A800E7B26C00DF922D00CBA55500D7B87900E5C99C00DCD3AB00DCD3
      AB00DCD3AB00DCD3AB00DCD3AB00DCD3AB00DCD3AB00D1C49200D3BC8200F3AA
      4A0088B2A20071A4D30000000000000000000000000000000000000000006060
      6000C3A26F00E4A33C00D9850200FEBD5A00FF960000FE9E0900FEA21200FEA6
      1B00FEA61B00D6820300FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00F5E5CD00F09E1800FFB94200FFB53C00FFB5
      3C00E39E3100BDB6AC0000000000000000000000000000000000000000006060
      6000C3A26F00E4A33C00D9850200FEBD5900FF960000FF9E0A00FFA21300FFA5
      1A00FFA81C00FFAA2200FFAD2900FFAD3100E6910800F2DDBC00FEFEFE00FEFE
      FE00F8EDDD00D9850200FEBA4300FEBA4300FEBA4300FFB83E00FFB43C00FFB8
      3E00E39E3000BDB6AC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000797979004B57
      640089CDFF000A7DF0004BC8F90064EAFD001B9BFC0018A6FC0069B7BA000654
      5C00F9D8A800ECC88C00DA943600D7B87900E5C99C00E7CBA200DCD3AB00E6D4
      AA00E6D4AA00E6D4AA00E6D4AA00E6D4AA00E6D4AA00E7CBA200E5C99C00F6C6
      6F0088B3B800509BE10000000000000000000000000000000000000000006060
      6000B99B6A00E4A33C00D8830000FECA6300FF960000FE9A0100FE9E0900FE9E
      0900FEA21200D47C0000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FCF9F600E78F0200FFB33400FDAD2A00FDAD
      2A00EDAC4200BEAE960000000000000000000000000000000000000000006060
      6000B99B6A00E4A33C00D9810000FFC26300FF960000FF9A0200FF9E0A00FF9E
      0A00FFA21300FFA51A00FFA51A00FFAA2200F1980A00EED3A600FEFEFE00FEFE
      FE00FEFEFE00F8EDDD00D9850200FFB12D00FEB23300FEB23300FFAD2900FFAD
      2900EBA73C00BEAE960000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000757574004C5F
      70007BC6FE000A7DF0004BC8F90064EAFD0022B3F8001492FD0067D7DA00004E
      5D00E6D4AA00F4E3C700DA943600E8B77600E5C99C00E7CBA200E6D4AA00E6D4
      AA00E7D6B400E7D6B400E7D6B400E7D6B400E6D4AA00E7CBA200F9D8A800F4AB
      500054A4DA003A97E90000000000000000000000000000000000000000006565
      6500B99B6A00E8A84800D47C0000FECB6D00FE9A0100FF960000FF960000FE9A
      0100FEA61B00D47C0000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00DF890600FFB93F00FEA61B00FEA2
      1200F6B65000C0A57E0000000000000000000000000000000000000000006565
      6500B99B6A00E7AA4A00D87D0000FECA7400FF9A0200FF960000FF960000FF9A
      0200FFA81C00FFAD3100FFB43C00FEB54300F5A82E00E9BF8300FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00F3E2C700E38E0C00FEBA4300FFB43C00FFA81C00FFA2
      1300F3B55200C0A57E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000797979004B57
      640084CAFE000A7DF0004BC8F90064EAFD0037CCFB001284F2005BE6FB001366
      72006C8B8500FAEBD600E8B77600DA943600E7CBA200E7CBA200E6D4AA00F3DA
      B800F4E3C700FAEBD600FAEBD600F4E3C700E7D6B400F3DAB800F9D8A800DA94
      36002C98F6002994F40000000000000000000000000000000000000000006565
      6500AD916500E8A84800D47C0000FED17D00FE9A0100FEAA2300FFB93F00FFB6
      4400FFBA4B00D47C0000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00DC8D1400FEC35C00FEBC5200FFB6
      4400FEBD5A00C095580000000000000000000000000000000000000000006565
      6500AD916500E8AA4A00D37B0000FED27C00FF9A0200FFAA2200FFB83E00FEB5
      4300FEB54300FEB54300FEB54300FAB54A00F1AC3C00E0A75100FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00D5891400FAB54A00FEC35C00FEBC5300FEBC5300FEB5
      4300FEBD5900C095580000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000075757400586B
      7D007BC6FE000A7DF0004BC8F9005BE6FB0037CCFB00127BF0004EF4FF003EB6
      C400004E5D00E5DACB00FAEBD600DA943600E3A14800E7D6B400F3DAB800F4E3
      C700FBF5EA00FBF5EA00FBF5EA00FBF5EA00F4E3C700FAEBD600F4AB50005995
      C1002890EC002994F400A7B8C700000000000000000000000000000000006C6C
      6C00A98E6500ECAE5300D47C0000FED58A00FEBC5200FDC36200FEBD5A00FEBC
      5200FEC05300D87E0000FCF9F600FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00DD8F1C00FEC05300FEBC5200FFBA
      4B00FED17D00C68C390000000000000000000000000000000000000000006C6C
      6C00AA8E6500EAAF5200D37B0000FFD58900FEBD5900FEC35C00FEBD5900FEBC
      5300FEBA4B00FEBA4B00FEBA4B00FEBA4B00FEBA4B00DEA03800FEFEFE00FEFE
      FE00FEFEFE00DFA54C00F2A63200FEC35C00FEBD5900FEBC5300FEBC5300FEBA
      4B00FED27C00C68C390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B00526D
      860072BBFD000A7DF0004BC8F9005BE6FB004BE5FC00127BF00034E7FE0064EA
      FD000D8A9A0020606900FBF5EA00FAEBD600DA943600E3A14800F4DEC100FBF5
      EA00FDFCF400FBF5EA00FDFCF400FDFCF400FBF5EA00EAAA5700B8A4720018A6
      FC001A85E30041A0F50095B0C700000000000000000000000000000000006C6C
      6C00A48A6200ECB55C00D1750000FFDA8D00FDC36200FDC36200FEC35C00FEBD
      5A00FDC36200DD850000FAF1E500FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00DB983500FEB64A00FFBA4B00FEBC
      5200FECD7900CB861E0000000000000000000000000000000000000000006C6C
      6C00A48A6200ECB55E00D1750000FFD88E00FFC26300FFC26300FFC26300FEBD
      5900FEBD5900FEBD5900FEBC5300FEBA4B00FEBA4B00DA8F2300FEFEFE00FEFE
      FE00EECA9600E38E0C00FEBD5900FEBA4B00FEBA4B00FEBA4B00FEBA4B00FEBC
      5300FECD7900CB861E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B00526D
      860084C6FF000A7DF00055CEFB0064EAFD0049DDFF001284F20021CAFC0084FA
      FF0028D6FD00168CA20013667200C6D3D600FDFCF400EAAA5700DF922D00E7B2
      6C00F3DAB800FAEBD600F3DAB800EBC37B00E9962C00B9A683008AD0FE0093D3
      FF00489BE2003A97E90071A4D300000000000000000000000000000000006C6C
      6C009B845F00F1BA6600D1750000FEDA9400FDC56B00FDC56B00FDC36200FDC3
      6200FDC56B00DE8C0C00F5E5CD00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00E2AB5600FEB64A00FEBD5A00FEBD
      5A00FED17D00D489150000000000000000000000000000000000000000006C6C
      6C009B845F00F1BA6500D1750000FFD99100FEC56A00FEC56A00FFC26300FFC2
      6300FFC26300FEC35C00FEBD5900FEBD5900FEBD5900D7860900FEFEFE00F8ED
      DD00D9810000FEBA4B00FEBA4B00FEBC5300FEBC5300FEBC5300FEBD5900FEBD
      5900FED27C00D589140000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B005E7A
      940072BBFD000A7DF00055CEFB0064EAFD005BE6FB001284F20022B3F80084FA
      FF0028E5FD0034E7FE0023B8D9000D8A9A002E7E910088B3B800C6BCA300DAA2
      5900EA993300EA993300DA943600B8A4720087C7E70069D4FD008AD0FE0093D3
      FF00A1D1FB0069A7D800489BE200000000000000000000000000000000007373
      73008C785900F1BA6600D1750000FEDA9400FECB6D00FECA7300FDC56B00FDC5
      6B00FDC56B00E5981E00F3DAB500FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00EBC79200F5B34500FEC35C00FDC3
      6200FECA7300E194210000000000000000000000000000000000000000007373
      73008C785900F1BA6500D1750000FDD79500FECA6C00FECA6C00FEC56A00FEC5
      6A00FFC26300FFC26300FFC26300FFC26300FEC35C00D7860900FEFEFE00D683
      0300FAB54A00FEBD5900FEBD5900FEBD5900FEBD5900FEBD5900FFC26300FFC2
      6300FECD7900E094200000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B00526D
      860067B6FE000A7DF00055CEFB0064EAFD005BE6FB001390F4000CA5F70084FA
      FF0028E5FD0028E5FD0028E5FD0033DBFE0028D6FD002FC3EB0023B8D90027A7
      D10036AEDB0046BCEC0055CEFB005AD6FC0077D2FE0077D2FE008AD0FE0093D3
      FF0098CCF900CFE2F2002890EC00000000000000000000000000000000007373
      730078695200F4BC6800D1750000FCD69300FECD7900FECA7300FECA7300FECA
      7300FECA7300ECA32F00EDC99500FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00EED0A500F4AE4100FECB6D00FDC5
      6B00FECD7900E9A33300BFB19C00000000000000000000000000000000007373
      730078695200F4BD6C00D1750000FDD79500FECD7900FECA7400FECA7400FECA
      6C00FEC56A00FEC56A00FEC56A00FFC26300FECA6C00D7860900DD9D3B00F1AC
      3C00FFC26300FFC26300FFC26300FFC26300FFC26300FFC26300FFC26300FEC5
      6A00FECD7900E9A43600BFB19C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000686866006387
      A9007BC6FE000A7DF0005AD6FC0064EAFD005BE6FB0023A8FB001390F40070EF
      FE0034E7FE0028E5FD0028E5FD0028E5FD0033DBFE0033DBFE0033DBFE0049DD
      FF0049DDFF005AD6FC0069D4FD0069D4FD0077D2FE0077D2FE008AD0FE0093D3
      FF0098CCF900CADFF2002091F300000000000000000000000000000000007A7A
      7A0072655000F5C27300D1750000FCD69300FED17D00FECD7900FECA7300FECA
      7300FECA7300EDAC4200E4B26900F5E5CD00EED0A500E8B97700DFA24500DA93
      2900D5870E00D47C0000D87E0000D8830000E08A0800F4B54F00FECA7300FECA
      7300FED17D00F0B65800BCA68600000000000000000000000000000000007A7A
      7A0072655000F6C27300D1750000FDD79500FED27C00FECD7900FECA7400FECA
      7400FECA7400FECA7400FECA6C00FEC56A00FECA7400DB890A00E69B2600FEC5
      6A00FEC56A00FFC26300FFC26300FEC56A00FEC56A00FEC56A00FECA6C00FECA
      7400FED27C00F2B85B00BDA78600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063636300608A
      B00067B6FE000A7DF0005AD6FC0064EAFD005BE6FB0022B3F8001284F20064EA
      FD004BE5FC004BE5FC004BE5FC004BE5FC004BE5FC005BE6FB005BE6FB005AD6
      FC005AD6FC005AD6FC0069D4FD0069D4FD0077D2FE0077D2FE008AD0FE0093D3
      FF0098CCF900BFCFDC003A9BF500A7B8C7000000000000000000000000007A7A
      7A0072655000F5C27300D1750000FCD69300FED28300FED28300FED17D00FECD
      7900FED17D00F6BB5A00DA860500DE8C0C00E79C2700EFAC3D00F6B65000FDC3
      6200FDC56B00FECA7300FECD7900FECD7900FECD7900FECD7900FECD7900FECD
      7900FED28300F0B65800C0A98600000000000000000000000000000000007A7A
      7A0072655000F6C27300D1750000FBD59100FED28300FED28300FED27C00FECD
      7900FECD7900FECA7400FECA7400FECA7400FECA7400E8A23200FECA7400FECA
      6C00FECA6C00FECA6C00FECA6C00FECA7400FECA7400FECA7400FECA7400FECD
      7900FED28300F3B55200C0A98600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063636300608A
      B00067B6FE000A7DF0005AD6FC0064EAFD005BE6FB0021CAFC00127BF00055CE
      FB004BC8F9004BC8F9004BC8F9004BC8F9004BC8F9004BC8F90055CEFB0055CE
      FB0055CEFB0064CFFA0064CFFA0069D4FD0069D4FD0069D4FD0069D4FD0077D2
      FE0077D2FE0087C7E70041A0F5008BAFD0000000000000000000000000007A7A
      7A006C614F00FAC67A00D1750000FED58A00FED58A00FED28300FED28300FED2
      8300FED28300FED28300FED28300FED28300FED17D00FED17D00FECD7900FECD
      7900FECD7900FECD7900FECD7900FECD7900FECD7900FECD7900FED17D00FED2
      8300FFE39B00DF942100C1B5A200000000000000000000000000000000007A7A
      7A006C614F00FAC67A00D1750000F9D38D00FDD68C00FED28300FED28300FED2
      8300FED28300FED27C00FECD7900FECD7900FECD7900FECD7900FECD7900FECA
      7400FECA7400FECA7400FECA7400FECD7900FECD7900FECD7900FED27C00FED2
      8300FFE39B00E0942000C1B5A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005E5E5E006D99
      C10072BBFD000A7DF0005AD6FC0064EAFD005BE6FB0037CCFB001284F2001284
      F2001284F2001284F2001284F2001284F2001088F2001284F2001088F2001088
      F2001088F2001088F2001088F2000D87F4001088F2001088F2001088F2001088
      F2000D87F4003E84C7005995C100A7B8C7000000000000000000000000008585
      850059554D00FFD99900D1750000F4C16B00FFE2A300FED58A00FED58A00FED5
      8A00FED28300FED28300FED28300FED28300FED17D00FED17D00FED17D00FED1
      7D00FED17D00FED17D00FED17D00FED17D00FED17D00FED28300FED28300FEDA
      9400FCD69300D1881C0000000000000000000000000000000000000000008585
      850059554D00FFD99900D1750000F1C06B00FFE1A100FDD68C00FFD58900FFD5
      8900FFD58900FED28300FED28300FED28300FED27C00FED27C00FED27C00FED2
      7C00FED27C00FED27C00FED27C00FED27C00FED27C00FED28300FED28300FEDC
      9600FBD89700D1881C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005E5E5E005E88
      AF0067B6FE000A7DF0005AD6FC0064EAFD005BE6FB0049DDFF0034E7FE0028E5
      FD0034E7FE0028D6FD0015D6FF0015D6FF0006C6FE0000D2FF0000D2FF0006C6
      FE0006C6FE0006C6FE0014B9FF0014B9FF0023A8FB0023A8FB0023A8FB0023A8
      FB001A93FE0098A0A70000000000000000000000000000000000000000009A9A
      9A004B4B4B00FEE5B800DA850A00DE901700FFF2CD00FFDA8D00FFDA8D00FFDA
      8D00FFDA8D00FED58A00FED58A00FED58A00FED28300FED28300FED28300FED2
      8300FED28300FED58A00FFDA8D00FFE39B00FFE6A900FEE5AD00FFE2A300F4C1
      6B00D9850200C7B4980000000000000000000000000000000000000000009A9A
      9A004B4B4B00FEE5B800DB890A00DE911700FFF2CD00FFD99100FFD99100FFD8
      8E00FDD68C00FFD58900FFD58900FFD58900FED28300FED28300FED28300FED2
      8300FED28300FFD58900FFD88E00FFE39B00FFE6A900FEE4AD00FFE0A500F7C5
      6D00D9850200C7B4980000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005E5E5E006D99
      C10067B6FE000A7DF0005AD6FC005AD6FC004BC8F9003CBAF80023A8FB0018A6
      FC001B9BFC00148CFE001284F2000A7DF000127BF0000CA5F70000D2FF0006C6
      FE0006C6FE000DBAFA0014B9FF0014B9FF0014B9FF0023A8FB0022B3F80023A8
      FB001A93FE00A7B8C70000000000000000000000000000000000000000000000
      0000656565009B928600F7C37700D5760000F7CC7D00FFEAB900FEDA9400FEDA
      9400FFDA8D00FFDA8D00FED58A00FFDA8D00FEDA9400FFE2A300FFE6B000FFEA
      B900FEE5AD00FCD69300F4C16B00E9A33300E7920E00E98C0100E98C0100C787
      2300AAA192000000000000000000000000000000000000000000000000000000
      0000656565009B928600F7C57800D5760000F7CC7D00FFEAB900FEDC9600FFD9
      9100FFD88E00FFD88E00FDD68C00FFD88E00FEDC9600FFE1A100FFE6B000FFEA
      B900FEE4AD00FBD79400F4C06A00ECA53400E7930F00E98A0100E98A0100C787
      2300AAA192000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ABABAB005E5E5E00A3C3
      E10089CDFF00148CFE00148CFE00148CFE001492FD00259BFE00238DF400378E
      E1004480BA003D679100A1D1FB00BFE2FF0072BBFD000D87F40006C6FE0006C6
      FE0006C6FE0014B9FF0018A6FC001B9BFC001A93FE001B8DFF001A93FE002999
      FD003A97E900A7B8C70000000000000000000000000000000000000000000000
      00009A9A9A0056565600D2CCC100EA9D2700D87E0000F3C67200FFF2CD00FFF1
      CB00FFEDC100FFF1C700FFEDC100FCE1AB00F3CB8000ECAF4800E6971900E589
      0100E5860000E5890100D68B1800B2823B008E7C61008D898300A3A3A4000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009A9A9A0056565600D2CCC100EC9E2600D87D0000F3C67200FFF2CD00FFF1
      C900FFEDC100FFF1C900FFEDC100FCE1AB00F3CB8000ECAF4800E6971900E589
      0100E5860000E98A0100D68B1800B2823B008E7C61008D898300A3A3A4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000838383006868
      660090979C005C8BB60067819A007580890087898B0099989700ABABAB000000
      0000ABABAB007575740064615F00EBEDEE00FFFFFF0059B4FF00148CFE001B8D
      FF001A93FE002999FD003695F0004A8CCA005F82A200758089008A8B8B00A3A3
      A200000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E006565650088898700E8A33A00E2820000DD850000E49A
      2300E49A2300E18B0400E5860000E8850000E68C0500D08B2000AC8445008D7F
      69008E8C8800A2A3A30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E006565650088898700E8A33A00E2820000DE860000E49A
      2300E49A2300E28B0300E5860000E8850000E68D0500D08B2000AC8445008D7F
      69008E8C8800A2A3A30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009D9D9D0083838300757574007B787500798A98007580
      89008A8B8B009D9D9D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009292920067686C0082745E00BF8A3800D992
      2600D08F2D00AB854B008B7F6C00908E8C00A4A4A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009292920067686C0082745E00BF8A3800D892
      2500D08F2D00AB854B008B7F6C00908E8C00A4A4A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AAAAAA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AAAAAA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B4ADA2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A4A09A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A100818192007F7F
      B400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008B8B8B00836B
      4A00E68A0100C38D380000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008989890074665000F3930000E3860100C87B1100AD7525009D7946009284
      70009F999100B1AEAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AB542D00883B
      0700823504008235040082350400823504008235040082350400773100007731
      0000773100007731000077310000672A0000672A0000672A0000672A00005A25
      00005A2500005121000051210000512100005121000051210000461C0000461C
      0000461C0000461C000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009494940053535B000404CE000000
      D3001212C4007272BA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009B9B9B00514E4C00FCC4
      7900DA820000DC8B0A00C3A77D00000000000000000000000000B4B1AD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000065656500C49A5D00DD850000F4C46700FBCF7E00FDC56A00F0A52800EDA1
      2700E9910800E6880000D7800C00BD791E00A97A3B00937F63009E948700A8A7
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AB542D00E289
      6300D9764700D9764700D9764700D9764700D9764700CC734800CC734800CC73
      4800C46D4100C46D4100C46D4100BD6B3E00BD6B3E00B8683900B8683900B462
      3800B4623800AE603700AB5C3100AB5C3100AB5C3100A4592B00A4592B00A459
      2B00A4592B00461C000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000666666002323B4000000D30099A5
      FB00A5ABF7001F1FD3002323BF009797B7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000062626200D0A35E00FAD5
      A500D5820100F0C97D00D4830C00836B4A00C9871A00E68A0100E88A0100D483
      0C00BF832F00C0A9850000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A1A1
      A1004B4B4B00FAC97D00D57D0000F3BF6100FEBA4D00FFC35300FFB83D00FEE6
      C100FEEBC300FEE8BC00FFE2AC00FCD59700FBC57200F2B04900EE9F2500E991
      0800E0870900C47B1800A77431009B7E5600A0917C00A4A09A00000000000000
      0000000000000000000000000000000000000000000000000000AB542D00E08C
      6800A46C54008C5C45007F5542007F5542007F5542007F5542007F5542007F55
      42007F55420077523B0077523B00734E3C00734E3C00734E3C00734E3C006946
      3600694636006946360069463600694636006946360069463600694636006946
      3600A4592B00461C000000000000000000000000000000000000000000000000
      0000000000000000000000000000818181003C3C6A000405DB001F25DA00C9D6
      FF009CAEFF00D3DDFF008D8FF0000606C9007272BA0000000000000000000000
      000000000000000000008D8D8E004C4C8F008585BA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000939393004D4C4B00FCDD9E00E9BF
      8100D5820100E7B76200E8B35600DA820000F1B34D00FFCE7200FED07300FED0
      6A00FFC55900EA992200D48B2400B4ADA2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      99004B4B4B00FECF8800D5810100EEB95800FFB94300FFB94300FFB23400FEE6
      C100FEEBC300FEE6C100FEE6C100FEEBC300FEEBC300FEEBC300FFECCB00FEEB
      C300FEE8BC00FFE2AC00FCD59700FBC57200F3AF4500F19D1800E4921200CC96
      4900000000000000000000000000000000000000000000000000AB542D00E691
      6E00A46C5400FEFBFA00FDFAF900FDF8F700FDF8F700FCF7F500FBF6F400FAF4
      F200FAF2F000FAF2F000F8F0EE00F9EFEC00F8EEEA00F7ECE800F7E9E600F7E8
      E400F5E6E100F5E6E100F5E6E100F4E2DC00F4E2DC00F4E2DC00F4E2DC006946
      3600A4592B00461C000000000000000000000000000000000000000000000000
      00000000000000000000A1A1A10059595A004545D0000000CD002B37E200A8B9
      FF00B9C5FF00A0B1FE00C3CDFF00C9CEFE001919D0006262BB00000000000000
      0000999999005A5A62000D0D9E000000D3001315D1008585BA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093939300514E4C00D6A64500D175
      0000D5820100EE9B2B00E0972900EBAB4100FFDA8400FCA52900BA912F009D96
      4500BD943100FDB14B00FFCE7200E28D0D007B603800D8870A00C2B29A000000
      0000000000000000000000000000000000000000000000000000000000009999
      99004B4B4B00FECF8800D5810100EBB14C00FFB83D00FFB83D00FFAD2B00FFEC
      CB00FEF1DB00FFEDD300FFEDD300FFECCB00FFECCB00FEEBC300FEEBC300FEE6
      C100FEE6C100FEE6C100FEEBC300FEEBC300FFECCB00FED47D00FFF6BA00D38E
      2300000000000000000000000000000000000000000000000000AB5C3100E996
      7400A46C5400FEFBFA00FEFBFA00FDFAF900FDF8F700FDF8F700FCF7F500FBF6
      F400FAF4F200FAF2F000FAF2F000F8F0EE00F9EFEC00F8EEEA00F7ECE800F7E9
      E600F7E8E400F5E6E100F5E6E100F5E6E100F4E2DC00F4E2DC00F4E2DC006946
      3600A4592B005121000000000000000000000000000000000000000000000000
      000000000000000000007D7D7D004D4D7400DADBFD008585E5001C1BCE000000
      C5002931DD00A8B9FF00B0C1FF00B2BDFF00DADBFD00191BCF007272B6009292
      92004D4D59000303A5000000C9005A62E900C9D6FF00191BCF008B8ABB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7C0092641F00E2850000EDA4
      4100FFC07600FEC76700FFEAA500FFDD8A00C9871A000AC1E50001D2FF0001D2
      FF0001D2FF0000CCFE0078A47400FEC76700E48F1000D87F0000C2B29A000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C004B4B4B00FCCC8400D8880700E9AC4400FEB53A00FEB53A00FFAD2B00FEEB
      C300FEF6E800FFF4E400FFF4E400FFF4E400FEF6E800FEF1DB00FEF1DB00FEF1
      DB00FEF1DB00FEF1DB00FFEDD300FFEDD300FEF1DB00FDC56A00FFE69700D38E
      2300000000000000000000000000000000000000000000000000AB5C3100E69E
      7F00AB745C00FEFCFB00FEFBFA00FEFBFA00FDFAF900FDF8F700FDF8F700FCF7
      F500FBF6F400FAF4F200FAF2F000FAF2F000F8F0EE00F9EFEC00F8EEEA00F7EC
      E800F7E9E600F7E8E400F5E6E100F5E6E100F5E6E100F4E2DC00F4E2DC006946
      3600AB5C31005121000000000000000000000000000000000000000000000000
      000000000000000000005E5E5E00B8B8E800FDFDFE00E5E5FB00E8E7F900D3D3
      F4003332D4000000CD0099A5FB00ADBBFF00A6B4FF00C9CEFE000A0AD3004D4D
      59000C0C8E000000C9003C3FDD00C8D2FF0091A5FE00A8B9FF000909CD00A0A0
      B800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000828282007B5C2C00E2850000F2AF5800FBCB
      9600FFBF7400FFDA8400FFECAE00D98C190000CCFE0001D2FF0001D2FF0028C2
      EA0000CCFE0000B5FF0001D2FF002DB8C200F7BE6400DD880500C2B29A000000
      000000000000000000000000000000000000000000000000000000000000A1A1
      A10052525200EBC18000D98A0D00E4A33B00FFB83D00FFB02C00FFAB2300FEE5
      BC00FFFCF300FFF4E400FFF4E400FFEDD300FEF1DB00FFEDD300FFEDD300FFED
      D300FFEDD300FEF1DB00FEF1DB00FEF1DB00FEFAEB00FECE7A00FFD88400DF9B
      2C00000000000000000000000000000000000000000000000000AE603700E69E
      7F00AB745C00FEFCFB00FEFCFB00FEFBFA00FEFBFA00FDFAF900FDF9F800FDF8
      F700FCF7F500FBF6F400FAF4F200FAF2F000FAF2F000F8F0EE00F9EFEC00F8EE
      EA00F7ECE800F7E9E600F7E8E400F5E6E100F5E6E100F5E6E100F4E2DC006946
      3600AB5C31005121000000000000000000000000000000000000000000000000
      000000000000000000007D7D7D006D6D6E009898A800D3D3F400F1F1FF00FDFD
      FE00FDFDFE006C6BE0000000CD00A6B9FF0091A5FE00A0B1FE008489F4000000
      C9000000D300646EF100BCCBFF009CAEFF0094AAFF006475F3001212C4000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000939393005E554700E68A0100DD931C00FAD5A500FFC7
      8D00FFC85D00FFF0B800FFCE72005CB49D001BD6FC0034DBFC0034DBFC0034DB
      FC0029DBFF001BD6FC0001D2FF0000CCFE002DB8C200FCBC6100D18F34000000
      000000000000000000000000000000000000000000000000000000000000A5A5
      A50052525200EBC18000DC8D1100DF9B2C00FFB23400FFAD2B00FFA81D00FEE1
      B400FFFEFD00FFFCF300FFFCF300FFFCF300FFFCF300FFFCF300FFFCF300FFFC
      F300FFFCF300FFFCF300FEFAEB00FEF6E800FFFCF300FEDB9800FEC96C00E5A9
      4400C3B5A2000000000000000000000000000000000000000000AE603700E9A5
      8900AB745C00FEFDFC00FEFCFB00FEFCFB009B634C008D543800875031008750
      3100D0BAAD00FCF7F500FBF6F4008A4B2600774825006A4420006A442000553B
      1500E2D2C900F7ECE800F7E9E600F7E8E400F5E6E100F5E6E100F5E6E1006946
      3600AE6037005121000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F8F9000666666007B7B7D00FDFD
      FE00F1F1FF00E8E7F9003735D500202BDE00B0C1FF00718AFF00B9C5FF00A0AB
      FC00BCCBFF00BCCBFF008CA3FF0091A5FE008899FA000404CE008B8ABB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ACACAC005A5A5B00D4922500D87F0000FDC48200FFCFA000FFC7
      8D00FFCE7200FFF9CA00EA99220034DBFC0047E8FE0071CCDD0057E8FD0057E8
      FD0047E8FE0047E8FE0034DBFC0028C2EA001BC5F60070AA8500ECA03400C3AD
      8C0000000000000000000000000000000000000000000000000000000000A5A5
      A50052525200EBC18000DC8D1100DE952000FEB53A00FFA81D00FFA31400FEDB
      9800FFFEFD00FFF4E400FEF1DB00FEF1DB00FEF1DB00FEF1DB00FEF1DB00FEF1
      DB00FFF4E400FFF4E400FEFAEB00FEFAEB00FFFEFD00FEE6C100FEBC5400F1BB
      5B00C5AD8A000000000000000000000000000000000000000000B4623800E9A5
      8900AB745C00FFFEFD00FEFDFC00FEFCFB009B634C00D28B7100AB542D009F52
      280087503100FDF8F700FCF7F5008F512F00AB542D0077482500774825006E3C
      16009C8A7600F8EEEA00F7ECE800F7E9E600F7E8E400F5E6E100F5E6E1006946
      3600B46238005121000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000747474005959
      5A00DADBFD00D2D2FB00B4B3EF000000C9007D92FD00718CFF005B7CFF00758D
      FF006A85FF00718CFF00A8B9FF007688F8000000C9006A69BE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7C007B603800EA992200D5820100FFCFA000FFC78D00FFC0
      7600FDD67D00FEFBD300D492250047E8FE0065EDFF0065EDFF0065EDFF0065ED
      FF0065EDFF0068F5FF005ACEDD0047E8FE0029DBFF0001D2FF00E5AF4C00D48B
      240000000000000000000000000000000000000000000000000000000000A8A7
      A50052525200EBC18000DE952000DB911B00FEB53A00FFA00D00FFA31400FFCC
      7E00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFE
      FD00FFFEFD00FFFEFD00FFFEFD00FFFCF300FFFEFD00FEF1DB00FEB53A00F4C4
      6900C8A26D000000000000000000000000000000000000000000B4653F00E6AB
      9300AB745C00FFFEFD00FFFEFD00FEFDFC00A46C5400D8977B00CC734800CC73
      48008A4B2600D0BAAD00FDF8F70098593900C2603400AB542D00A95026009A4B
      2000553B1500E2D2C900F8EEEA00F7ECE800F7E9E600F7E8E400F5E6E1006946
      3600B86839005A25000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006A6A
      6A0064646E00BCBCFA00ACACED001919D0004455EB00718CFF003C5FFF00758D
      FF00A1B5FF0094AAFF003444EB000000CD006C6CBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3A3A3005A5A5B00E2AC5100DC8B0A00DD931C00FBCA8600FCC47900FFBF
      7400FFDA8400FEFBD300C096330068F5FF0079F5FF0079F5FF0079F5FF0079F5
      FF0079F5FF0079F5FF006BBEC50068F5FF0057E8FD0029DBFF006FB19400EA99
      2200C2B29A00000000000000000000000000000000000000000000000000ABAB
      AC005A5A5A00DCB47800DF972900D98A0D00FEB53A00FF9E0A00FFA00D00FEC1
      5C00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFE
      FD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFFEFD00FFAD2B00FEC9
      6C00CC9649000000000000000000000000000000000000000000B9694300EDB1
      9900B37D6600FFFFFF00FFFEFD00FFFEFD00A46C5400DA9C8300CE7A5400CC73
      4800AE6037008F512F00FDF9F8009B634C00C46D4100B65A3100AB542D00A950
      26006E3C16009C8A7600F9EFEC00F8EEEA00F7ECE800F7E9E600F7E8E4006946
      3600BD6B3E005A25000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007A7A
      7A00333355009292DE009797EA004645D8002129D9006D8DFF001D4AFE0094AA
      FF001B24DD000000CD000F0FC3008787A8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000939393004C484300FCBC6100DA820000EA9E3300FFBF7400FCBB6B00FCBC
      6100FFDD8A00FEFCDB00BD94310079F5FF004CA4FF0088FBFE0088FBFE0088FB
      FE0088FBFE0088FBFE0077C7CA0079F5FF0065EDFF0057E8FD0034DBFC00FBA9
      3600CB9C55000000000000000000000000000000000000000000000000000000
      00005A5A5A00DBB37700E19B3100D98A0D00FFB83D00FF960000FF9E0A00FF9A
      0100FF9A0100FF9A0100FFA00D00FFA31400FFA61A00FFA81D00FFAB2300FFB0
      2C00FFB02C00FFAF3500FEB53A00FFB54300FFB54300FEBA4D00FFAB2300FEC1
      5C00CE8E2F000000000000000000000000000000000000000000B9694300EDB1
      9900B37D6600FFFFFF00FFFFFF00FFFEFD00AB745C00DDA48B00D5835F00CE7A
      5400CA7651008A4B2600D0BAAD00A7694C00C6735100B65A3100B65A3100AB54
      2D009A4B2000553B1500E2D2C900F9EFEC00F8EEEA00F7ECE800F7E9E600734E
      3C00C46D4100672A000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000999999005A5A62000D0D
      9E000000D3001513CD008585E5005D5CDC000E12D3006482FE000436FF007090
      FF000E12D3000202AC002323A8004848A4008585BA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7C005E554700FCC47900D87F0000ECA03400FCBC6100FCB85700FCB8
      5700FED07300FFFFE500CD90220088FBFE0088FBFE009AFEFE009AFEFE009AFE
      FE009AFEFE0076DDFB0088D3D10088FBFE0079F5FF0065EDFF0047E8FE00D6A6
      4500D78D1D000000000000000000000000000000000000000000000000000000
      00005A5A5A00DBB37700E19B3100D8880700FFC14B00FF960000FF9A0100FF9E
      0A00FFA00D00FFA00D00FFA81D00FFA81D00FFAB2300FFAD2B00FFB02C00FFB2
      3400FFB23400FFB23400FFB23400FFB23400FFB02C00FFB02C00FFAD2B00FFB9
      4300D38E23000000000000000000000000000000000000000000C16E4A00F0B7
      A000B37D6600FFFFFE00FFFFFF00FFFFFF00AB745C00E6AB9300D58A6600CD80
      5F00D17D5700AE6037008D543800A46C5400CB7B5C00BF633D00C2603400C260
      3400AB542D006E3C16009C8A7600F8F0EE00F9EFEC00F8EEEA00F7ECE800734E
      3C00C46D4100672A000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000949494004D4D59000202AC000000
      D3000016E8000000D3000F0DBF002423C6000909CD006D8DFF000027FF004169
      FF00273CEA00000EE000001AEB000016E8000000D3002A2AC300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007373730077685100FBCA8600D87F0000E0982500FCB85700FDB14B00FDB1
      4B00FFC85D00FFFFE500E097290088FBFE0093FEFE0093FEFE0093FEFE0076DD
      FB00359CFF00409DF0007DB0AF0088FBFE0088FBFE0079F5FF005CF4FF00B3B2
      6500DA8B12000000000000000000000000000000000000000000000000000000
      00005A5A5A00D7B17600E4A33B00D5810100FEC15C00FF9A0100FF960000FF96
      0000FFA61A00FFAD2B00FFB83D00FFB64800FEBA4D00FEBA4D00FEBA4D00FEBC
      5400FEBC5400FEBC5400FEBC5400FEBA4D00FFB94300FFB02C00FFA61A00FFAB
      2300DB911B000000000000000000000000000000000000000000C16E4A00F0B7
      A000B37D6600FFFFFF00FFFFFE00FFFFFF00B37D6600E6AB9300D28B7100B572
      5700DA9C8300CD805F008F512F00AB745C00CF856700C46D4100C2603400C46D
      4100CC7348009F522800553B1500E2D2C900F8F0EE00F9EFEC00F8EEEA00734E
      3C00CC734800672A000000000000000000000000000000000000000000000000
      00000000000000000000000000009999990053535B003333C2000000D300172A
      E5002455FF002251FF001722DC000000C5002123D4006D8DFF001D4AFE002C57
      FF00315CFF002251FF002552FF002455FF002455FF001836EF002423C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006D6D6D0077685100FCD69A00D7880B00E48F1000FFAF4400FFB33900FBA9
      3600FDC15200FEFBD300F4C67A0098E6D10093FEFE009AFEFE009AFEFE007FE6
      FF009AFEFE0098F3ED00A4FFFF0088D3D10088FBFE0088FBFE005AD6FF009BBA
      8A00EC920B00C1B6A40000000000000000000000000000000000000000000000
      00005A5A5A00C0A06D00E8AA4800D57D0000FEC96C00FFA61A00FFB83D00FFB6
      4800FFB54300FFB54300FFB54300FFB64800FEBA4D00FEBC5400FEBC5400FFBD
      5B00FEBC5400FEBC5400FEBC5400FEBC5400FFBD5B00FEBC5400FEBA4D00FFB8
      3D00DF9926000000000000000000000000000000000000000000C6735100F1BE
      AA00BA866F00FFFFFF00FFFFFF00FFFFFE00B37D6600EDB19900D59176009B63
      4C00CD805F00DA9C8300D17D5700CE7A5400C6735100CC734800BF633D009859
      3900CA765100C26034006E3C16009C8A7600FAF2F000F8F0EE00F9EFEC00734E
      3C00CC734800672A000000000000000000000000000000000000000000000000
      00000000000000000000000000006A6A6A006868BA00B7B7FE003735D5003337
      D9005579FF005173FE005579FF005173FE00506DFA005173FE005173FE005173
      FE005173FE005B7CFF006482FE006482FE006788FF005C82FF000A0AC7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000737373005E554700FFD49100DD982D00D5820100FBA93600FCA52900FCA5
      2900FFB33900FFE39B00FEFBD300BEA54C009AFEFE00A3DFE0009AFEFE00A4FF
      FF00A4FFFF009AFEFE009AFEFE0093FEFE008CE1E10088FBFE0088FBFE00A1C3
      9000EA992200C2B29A0000000000000000000000000000000000000000000000
      000062626200B0936600E8AA4800D57D0000FEDB9800FEC15C00FEC36300FFBD
      5B00FEC15C00FEC15C00FEC15C00FEBC5400FEBC5400FEC15C00FEC36300FEC3
      6300FDC56A00FBC57200FFCB7800FFCB7800FFCC7E00FECF8800FEBA4D00FEBA
      4D00E9A93E00C3B39B0000000000000000000000000000000000CA765100F1BE
      AA00BA866F00FFFFFF00FFFFFF00FFFFFF00C7836A00EABCA900D8977B009B63
      4C00AB745C00DA9C8300D28B7100CD805F00CE7A5400CA765100BF633D008C5C
      45009B634C00CC7348009F52280056432000E2D2C900FAF2F000F8F0EE007752
      3B00CE7A54007731000000000000000000000000000000000000000000000000
      00000000000000000000000000007171710063637000E8E8FE00DADBFD001513
      CD004F54E100829CFF00829CFF007D98FF007D98FF007D98FF00829CFF00829C
      FF008CA8FF004D59E7000000C9000D0BCC00555CE3004B64F4003333C2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000828282004D4C4B00FFE3A900E5B46B00D37B0000FEA21900FEA21900FEA2
      1900FE9D1200FEC76700FFFFEB00ECA0340093FAF7009AFEFE00B4FEFE00BAFF
      FF00BAFFFF00B4FEFE00A4FFFF009AFEFE0093FEFE0093FEFE0088FBFE00B8B1
      6400EA992200C2B29A0000000000000000000000000000000000000000000000
      000062626200B0936600EAB05500D1750000FFE09C00FDC56A00FEC36300FEC1
      5C00EFAB5200DA893700D9873200FEE6C100FEE1B400FEE1B400FEE5BC00FEE5
      BC00FEEBC300FFECCB00FFF4CE00FFECCB00FEE6C100FEE6C100FEBC5400FEBC
      5400F1BB5B00C5A8800000000000000000000000000000000000CE7A5400F1BE
      AA00BA866F00FFFFFF00FFFFFF00FFFFFF00C7836A00EABCA900DA9C83009B63
      4C00D0BAAD00B37D6600DDA48B00CF856700CD805F00D17D5700B96943009B63
      4C00BF917B00A46C5400C46D410077482500B5A39200FAF2F000FAF2F0007F55
      4200D17D57007731000000000000000000000000000000000000000000000000
      00000000000000000000000000009D9D9D00616161008F8F9900FDFDFE00E5E5
      FB001C1BCE002123D40095A1F600BCCBFF00BCCBFF00BCCBFF00C3CDFF00C2D3
      FF00B0C1FF000000C900CAC9F500FDFDFE006C6BE0000000C9007272BA000000
      0000000000000000000000000000000000000000000000000000000000000000
      000093939300514E4C00F4D39A00F4D39A00D37B0000EC920B00FE9D1200FF9C
      0A00FF9C0A00FFB33900FFF0B800FEFBD300C4A34600B4FEFE00D3FFFF00E6FE
      FE00E6FEFE00D3FFFF00BAFFFF00A4FFFF009AFEFE0093FEFE008FE8F500D6A6
      4500DD942400C1B6A40000000000000000000000000000000000000000000000
      000062626200AE926500ECB45D00D1750000FFE09C00FEC96C00FDC56A00FEC9
      6C00EA9C3900C65A0000C85B0000FEEBC300FEE1B400FEE5BC00FEE5BC00FEE5
      BC00FBDEAC00CC680400CC680400C85B0000FBDEAC00FEEBC300FEC96C00FEC1
      5C00FBC57200C49A5D0000000000000000000000000000000000CE7A5400F1BE
      AA00BA866F00FFFFFF00FFFFFF00FFFFFF00D28B7100EABCA900DDA48B009B63
      4C00EADCD600D0BAAD00DA9C8300DA9C8300D58A6600D5835F00C16E4A00A46C
      5400FBF6F4009B634C00CD805F00AB5C310056432000EADCD600FAF2F0007F55
      4200D78059007731000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D006666660083838400FDFD
      FE00FDFDFE007979E6000000C9000000C9003337D900555CE3004E5BE8002129
      D9000000CD000D0D9E00D7D7C600FDFDFE00E1E1F0007A79CF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005A5A5B00A3937800FEE4BD00DB962B00DA820000FE9A0200FE9A
      0200FE9A0200FE9A0200FEC76700FFFFEB00F4C67A00CBCD9B00E6FEFE00EBCF
      D000FFFFFE00F5FFFF00D3FFFF00A4FFFF009AFEFE0093FEFE008EF2EA00FEC7
      6700DA8B12000000000000000000000000000000000000000000000000000000
      000065656500A2886000EEB66000D1750000FFE09C00FEC96C00FDCC7300FDCC
      7300F0A84B00C85B0000C85B0000FEEBC300FEE8BC00FEE8BC00FEE8BC00FEE8
      BC00FEEBC300C7560000CB640000C65A0000F7D8A600FFECCB00FED28300FEC1
      5C00FED28300C98E3C0000000000000000000000000000000000D17D5700F4C8
      B700BA866F00FFFFFF00FFFFFF00EADCD600D28B7100EABCA900E6AB9300A46C
      5400E2D2C900FAF2F000BA866F00E6AB9300D5917600D58A6600C16E4A00AB74
      5C00FDFAF900B5A39200B5725700CB7B5C0077482500B5A39200EADCD6007F55
      4200D78059007731000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000818181005E5E
      5E00A2A2A900F5F5FE00F5F5FE00A8A8F3005655DC001C1BCE000000C5000000
      C5000000C9000000C500393983008F8F90000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7C00514E4C00FEECC300F3D3A400D37B0000F2910000FE9A
      0200FE9A0200FF9C0A00FFB33900FFDD8A00FFFFF200E8AE4C00EFD7AF00FFFF
      FE00FFFFFE00FFFFFE00BDDBFF00B4FEFE00A0E1E40093FEFE00C4A34600FEDA
      9300CC8620000000000000000000000000000000000000000000000000000000
      00006C6C6C008E795900EFBA6700D1750000FFE09C00FDCC7300FFCB7800FDCC
      7300F1BB5B00C85B0000C85B0000FEF1DB00FEF1DB00FFECCB00FEEBC300FEEB
      C300FFF4CE00C85B0000CB640000C85B0000F1CC9400FFF4CE00FEDEA000FEC3
      6300FEDB9800CE8B240000000000000000000000000000000000D5835F00F4C8
      B700BF917B00FFFFFF00FFFFFF00DA9C8300DA9C8300EABCA900E6AB9300BA86
      6F00B37D6600F7EAE700D8C4B900C9907400DDA48B00D5917600C1775C00B37D
      6600FDFAF900DFBCAF00AB745C00CB7B5C00B46238006C5A3A00D8C4B9007F55
      4200DD855F007731000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009292920074747400484845005A5ACE004141D8001110CD000C12D6006079
      FC007A94FE004D69FF00040ADB005858BD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A3A3A3005A5A5B00B8AA9400FFEED400E1A44200D5820100DA82
      0000DA820000E2850000F6970C00FDC15200FFECAE00FFFFF200E8B65D00E2AD
      6200FFFFFE00FFFFFE00D3F6FF00BAFFFF0093FEFE00B8B16400FEDA9300E3A0
      3400C8A36C000000000000000000000000000000000000000000000000000000
      00006C6C6C008E795900F2BE6D00D0730000FEDB9800FED28300FED47D00FFCC
      7E00F9BF6800C85B0000C7560000FCF0D300FEF6E800FFF4E400FFF4E400FFF4
      E400FFFCF300CC680400CB640000C85B0000E7B27200FFFCDB00FEE1B400FDCC
      7300F8CC7900CE91390000000000000000000000000000000000D5835F00F4C8
      B700BF917B00FFFFFF00D5917600D5917600EDB19900EABCA900EABCA900E6AB
      9300B37D6600AB745C00FFFFFF00BA866F00DA9C8300DDA48B00DA9C8300B37D
      6600FDFAF900C6735100D5917600D5917600D8977B00D58A6600C16E4A007F55
      4200DD855F008235040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7D00323273001E1EDD001110CD000000CD001343FF00315A
      FF00365CFF002552FF000436FF000909C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7C0047464500F4C17500E1A44200D1750000E3A9
      4400E2AC5100D98C1900D1750000D37B0000F8B94700FFECAE00FFFFF200F7E9
      B800DD982D00E09D3A00D6B26700C6A74D00DD982D00FFE3A900FCDD9E00D483
      0C00000000000000000000000000000000000000000000000000000000000000
      00006C6C6C008E795900F2C07200D1750000FEDB9400FED28300FED28300FED2
      8300F8CC7900C85B0000C7560000F9E6CA00FEFAEB00FFFAE600FFFAE600FFFA
      E600FFFEFD00D1761B00CB640000C85B0000DF9A4C00FFFCDB00FFECCB00FFD9
      8D00D7891100C3B5A20000000000000000000000000000000000D5835F00F4C8
      B700BF917B00FFFFFF00DA9C8300DA9C8300DA9C8300D8977B00D5917600D591
      7600D28B7100D28B7100FFFFFE00E2D2C900CD805F00CB7B5C00CB7B5C00C673
      5100FDFBFA00C16E4A00C6735100C6735100C16E4A00C16E4A00BF633D007F55
      4200DD855F008235040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000616161004A4AC3005555E2001919D000000FDF000033FF000033
      FF000436FF000436FF000C41FF000513DC008080B70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7C006A5A4000F1B34D00DA8B1200D8870A00FFFF
      FE00FFFFF200FFFFF200FEFBD300E2A33A00D1750000F8B54400FFDA8400FEFC
      DB00FFFFF200FFFFEB00FEFCDB00FFFFE500FFFFF200F8DFA700D87F0000C9B1
      8E00000000000000000000000000000000000000000000000000000000000000
      00007373730081705600F4C17300D1750000F7D88F00FFD98D00FCD58900FCD5
      8900FED28300C65A0000C85B0000F4DCB900FEFAEB00FFFAE600FFFAE600FFFA
      E600FFFEFD00D6823000C85B0000C7560000D47C2500FFFAE600FFFCDB00F4C4
      6900CE8E33000000000000000000000000000000000000000000DB886500F4C8
      B700BF917B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFE00FFFFFF00FFFFFF00FFFEFD00FFFE
      FD00FEFDFC00FEFCFB00FEFCFB00FEFBFA00FEFBFA00FDFAF900FDF9F8008C5C
      4500DD855F008235040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009D9D9D00555555007676DB008080E6001917CD00122BE8002E5AFF00315A
      FF003A61FF004267FF004F76FF002432E2006D6DBB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006D6D6D008D795A00FBC98D00D98C1900DD982D00FFFF
      F200FEFCDB00FEFCDB00FFFFE500FFFFE500E2AC5100D5820100FCBB6B00FFC5
      5900FDD67D00FFECAE00F6E0A900E1A44200D5820100D1750000BD985F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073737300665D4D00F7C77A00D1750000F6D38600FEDB9800FFD98D00FFD9
      8D00FFD98D00C85B0000C85B0000EFCC9F00FFFCF300FEFAEB00FEFAEB00FEFA
      EB00FFFCF300E6B37B00E2AC7400F2D6B700FEF6E800FFFEFD00FFFEFD00DF9B
      2C00C3B39B000000000000000000000000000000000000000000DB886500F4C8
      B700BF917B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFE00FFFFFF00FFFFFF00FFFE
      FD00FFFEFD00FEFDFC00FEFCFB00FEFCFB00FEFBFA00FEFBFA00FDFAF9008C5C
      4500E28963008235040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A1A1A10059595A008787C900A3A3F2003735D5001924DB006D8DFF006D8A
      FF00718CFF007A94FE008CA8FF002429D9007C7CB80000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000737373006B635600FFDEA800E19F3200D5820100FFFF
      F200FFFFEB00FEFCDB00FEFCDB00FEFCDB00F6DCA100D87F0000FDC48200FDC4
      8200FCBB6B00DD880500CE730000D37B0000E9B96400E8B35600BF9E6F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000079797900665D4D00FAC97D00D1750000F4CF7F00FFE1A000FEDB9400FEDB
      9400FFE09C00C85B0000C7560000E8B98500FFFEFD00FFFEFD00FFFEFD00FFFE
      FD00FFFEFD00FFFCF300FCF0D300F3D08E00E9AC4400E4921200E6880000D998
      3600000000000000000000000000000000000000000000000000E08C6800F4C8
      B700BF917B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFE00FFFFFF00FFFF
      FF00FFFEFD00FFFEFD00FEFDFC00FEFCFB00FEFCFB00FEFBFA00FEFBFA008C5C
      4500E28963008235040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006D6D6E0066667A00C5C5FF008B8AE7000000C90091A5FE00A6B9
      FF00A8B9FF00B7C7FF00A5B3FB000909C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008B8B8B004D4C4B00F9E5C700FAD5A500D1750000E3A9
      4400F3D29300EFCB8300FEFCDB00FEFCDB00E19F3200D37B0000D87F0000D37B
      0000D1750000D98C1900F4D39A00FFFFE500FFFFF200DA8B1200C3AD8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000079797900665D4D00FAC97D00D1750000F1CB7800FFE4A400FFE1A000FFE4
      A400FFEFB200D88A3900DE9B5000EFCFA200FCF0D300F0D09100E8AA4800E393
      1900E3860100E8840000E2870600CF881B00AA8042008D7F6800979592000000
      0000000000000000000000000000000000000000000000000000E08C6800F4C8
      B700BF917B00BF917B00BF917B00BF917B00BF917B00BF917B00BF917B00BA86
      6F00BA866F00BA866F00BA866F00B37D6600B37D6600B37D6600B37D6600B37D
      6600AB745C00AB745C00AB745C00AB745C00AB745C00A46C5400A46C5400A46C
      5400E2896300883B070000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009292920055555500BEBED200F5F5FE00403FDB000404CE0099A0
      F200CED7FE0099A0F2000909CD006867C1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7C0054535200EDEAE700F2CB8900D37B
      0000D37B0000D98C1900F2CB8900E69D2900E2850000A2835700FCD69A00F3D3
      A400DD931C00E3A94400FFF2CE00F3D29300D8870A00D1973C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007C7C7C00635A4B00FAC97D00D47A0000F0C67100FFF5C500FAE2A300F1CB
      7800EAB04A00DC8D1100E1880000E6850000EA890000E18A0900C5882800A683
      4E008B7F6E0091908E00A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E08C6800F4C8
      B700F4C8B700F4C8B700F4C8B700F4C8B700F4C8B700F4C8B700F4C8B700F4C8
      B700F1BEAA00F1BEAA00F1BEAA00F0B7A000F0B7A000EDB19900EDB19900E6AB
      9300E9A58900E9A58900E69E7F00E9967400E9967400E08C6800E2896300DD85
      5F00E2896300883B070000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F8F9000616161009D9D9D00F0F0F5006D6CEA000201
      E0000000DE000908D4006A6AB200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D0082776400FFEABB00F4C1
      7500DA820000E88A0100EE910000DD9424008A807200626262009FA0A000F6F3
      EE00FDF3DC00EC920B00E88A0100E68A0100CC86200000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000838383005E5B5600FFE1A400DC810000DD850000E0820000E6850000EB8C
      0100DC8D1100C08A36009F835A008983780096969600ABABAC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E08C6800E08C
      6800E08C6800E08C6800DB886500DB886500DB886500D5835F00D5835F00D583
      5F00CD805F00CB7B5C00CB7B5C00CE7A5400C6735100C6735100C16E4A00C16E
      4A00C16E4A00B9694300B9694300B4653F00B4653F00B4653F00AE603700AE60
      3700AE603700AE60370000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000999999008D8D8E007D7D7D008383
      84008D8D8E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B00737373006D6D6D00B3A3
      8B00D1973C008B8B8B009FA0A000000000000000000000000000A3A3A3009393
      9300828282007B7B7C00807D780093939300C1BBB20000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A500656565009B989500DC9A3300B88A4200958263008D8881009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AAAAAA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A4A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A7A7A800A4A099000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B9B4AC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007979
      79003487D4002D7CC6001B94FD002485E3004C77A10095989C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AEAE
      AE007A7A7A00C5821D00E3860200EA8E0000C1842C000000000000000000AAAA
      AA00968F8600B2A5920000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB00807E7C00B57B2500DA880900D5810100AA7F4300A39C9200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000838383004D57
      61002B9EFF001B8BF3001B8BF3002EA9FD002EA9FD001B94FD002485E3005879
      98009A9A9A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099999900947D
      5600A28B6700A99D8C00B4B2AE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009595
      950056687800327BA600BC934A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      7300A9804000E8971E00EEB95700FFFDC900EAA22B00927D6100858585006655
      3B00E3860200E4941500BD7E2600B4ADA3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007474
      740094784B00E2880000EE900000FBB44600EAB25600E2880000C47B1700A382
      5200A6A29B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000656565006B9C
      CB002294FB0036B1F7002AA1F5001D9BF40063EBFD005BE4FC004CCCFC0025A3
      FE001390FE00277DD200637C9400A2A2A4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000071717100B1731600E589
      0000F0A62B00E6951500E38B0800C67B1A00A6885600B7AC9C00000000000000
      00000000000000000000000000000000000000000000ABABA9006D6F7000184A
      6F000083CF0035E9FF0070B0BD00C3AC85000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000858585007861
      3D00FAC77700DC922100E4A83D00FFF8BE00FEF1B300DB830300D87C0100D87C
      0100DC8A0A00FFFCD200F6C86B00C89E61000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2A2A2005252
      5200EDBD7100DC830000F5920000FFB74B00FDFEFB00FFFEE200FDE1AA00EFAA
      4500E2880000C47B1700A1866000B3AEA7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9A00494B4D0083CA
      FE001B8BF30033ADF60039B1F7000F8FF40090FBFE0038E4FE004DE3FE0063E6
      FC0063E6FC003DC9FF0025A3FE00158BFE002D80D200637C9400ABABAC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6F7000B1731600E3860000FBCB
      8200FFDA8800FFE19500FFECAB00FDEBB100FBCB8200EA9B1B00BE802900908A
      82008C8A86008A7F6C008A7F6C00A2998C00959595005A5A5A00064A83000072
      BB000BD1FF001BDAFF00C3F5FF007199B0000000000000000000000000000000
      000000000000000000000000000082828200A3763300D087150066503300A788
      5800DC922100D1750000E3A33700FEEAAC00FEF4BC00FFF8BE00FFFAC400FFE9
      A500FFE89E00FFFAC400F7DA8C00C58C3E000000000000000000000000000000
      000000000000000000000000000000000000000000000000000082828200655A
      4900FCCD8400D5810100F5920000FBAD3800FDFEFB00FFFEE200EBB35E00E7A7
      4800F8D09400FDD39C00E9A23C00E2880000B57B2500A6907000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000908F8D00494B4D008BD1
      FF001B8BF30033ADF60042C1FB000D81F10086FAFF002AE8FF0013E2FF0013E2
      FF002DE2FE0053E2FD0063E6FC0063E6FC0042C1FB001C9AFE00158BFE00347A
      C10071859800ABABAC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000071717100B6935400E3860000F5BA5C00FECB
      6600FEC45600FECB6600FFDA8800FFE59C00FFECAB00CBC19F009A7935009569
      150096640B00A57B2A00A57B2A00A9791E00A06C0F00585C3B002D8DCD004DD4
      F7005BFBFE00D7FEFF005FAAD700ABB8C0000000000000000000000000000000
      00000000000000000000828282007D5C2C00E68A0000F0A93100E28C0600D47C
      0000D47C0000F5C76A00FEEAAC00FEE29B00FED37A00FECC6B00FECC6B00FED3
      7A00FFE19500FEEAAC00FEE4A300D27F0900A396850000000000000000000000
      00000000000000000000000000000000000000000000000000006F6E6E007A69
      5100F5C98200D5810100F5920000FEA92C00FDFEFB00FFFEE200EAAC5300D27B
      0000D27B0000D5810100DD911D00FFEBC400F5C98200E99C2800D07D0900AC78
      2E00A59987000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000908F8D00454646008BD1
      FF00138AF20036B1F7004CD4FD000E79EF0065F4FE0039EBFF001AE3FF0013E2
      FF0010DCFF0006D8FF0006D8FF0022DDFE004DE3FE0063EBFD0053DFFE0033BA
      FD001B94FD001B8CFB00397ABB007D8B98000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484007B6B4E00F7ECC100E1A34300D47B0000FFB4
      3900D47B0000FECB6600FDD37700F5CB73009B7E4E007C5A1C008D5E0900B693
      5400F5EADB00FCFBFA00E2E7EF00E4E9F200FBF6E900BC934A0096640B006B8F
      920076FDFF00A1D3EE008AABC000000000000000000000000000000000000000
      0000000000009999990056524C00E58C0200E4941500FEDB8B00FEDB8B00F5C7
      6A00FED37A00FFE19500FECC6B00FEC25500FECC6B00FEDB8B00FFD98300FED1
      7300FDC96200FEC65B00FFD98300FFE89E00E28E0D00A36D2500DA860A00B098
      76000000000000000000000000000000000000000000000000006F6E6E006C61
      4D00FCCD8400D5810100EE900000FFA41B00FDFEFB00FFFEE200EBBE6C00D27B
      0000D5810100D5810100D27B0000FFE3BC00FDDBAB00DE9B3100FAC98C00FCC4
      7E00EB9B2100D07D0900B7843B00A39C92000000000000000000000000000000
      000000000000000000000000000000000000000000008D8D8D004C52570083CA
      FE00138AF20039B1F70053E2FD000E79EF0049EBFE005BF0FF0013E2FF0013E2
      FF0010DCFF000ADBFF0006D8FF0001D3FF0002CAFF0002CAFF0028D3FE0053E2
      FD0063EBFD0053DFFE0033BAFD001C9AFE001B8BF3004078AF008B939A000000
      0000000000000000000000000000000000000000000000000000000000008A8A
      8A00947D5600D98B14008D5F1E00E9BD7900FBF6E900FCFBFA00E9BD7900D47B
      0000CE750000F7D7A500F9D597008F734500805F22008F610E00CBB06A00FDFC
      D900FCF8C800EAE6D300CBCBC500ABABA900C8C6B700FBF6E900D8C69800A36C
      1900558F9F005D9CC60000000000000000000000000000000000000000000000
      00000000000065656500D4B98E00F0BE7100D47C0000FECC6B00FED37A00FED4
      8200FED48200FEC65B00FECC6B00FEF4BC00FEF4BC00FEEAAC00FFE19500FFD9
      8300FED17300FEC76000FEC65B00FFD06D00FFE19500ECB24A00FFDC7D00D889
      1100BBB5AB00000000000000000000000000000000000000000074747400655A
      4900FCCD8400D5810100EE900000FC9D1000FDFEFB00FFFEE200ECC37400D27B
      0000D5810100D5810100D27B0000FDDBAB00FDDBAB00D1740000CE740000F2B9
      6C00F2B36400FDD39C00F2B96C00E5961C00C87C0E00AE854C00B9AC99000000
      000000000000000000000000000000000000000000008383830047515A0089CC
      FF001482F10039B1F7005CEBFD00137DF1003AD9FE0079F6FF0013E2FF0013E2
      FF0010DCFF000ADBFF0006D8FF0001D3FF0002CAFF0002CAFF0003C4FE0002BF
      FF000AC1FF0031CEFE0053E2FD0063EBFD004CD4FD002EB0FF001B94FD00218C
      EB005681AA000000000000000000000000000000000000000000999999005551
      4800F5BA5C00D8850400E6951500D47B0000CE750000CD8F3900E8D5AC00EAE6
      D300D8850400F0C88A00988366008160200095691500A8833B00EFF0C600FCF8
      C800FDFCD900FBF6E900FBF6E900EBE2C800D8CFB200E8E5B700FBF6E900CAB2
      7700A17E41000000000000000000000000000000000000000000000000000000
      00008988880069605300FFFCDC00FDF5E800DB983000DB830300FED17300FED1
      7300FEC65B00FFD06D00FFFCD200FFF8BE00FEEAAC00FEE29B00FED58B00FED3
      7A00FECC6B00FEC76000FDC96200FECC6B00FFC85E00FEDB8B00FEDB8B00EEA9
      3300BD965B0000000000000000000000000000000000000000007A7876005B55
      4B00FCCD8400D5810100EB8C0000FE990100FDFEFB00FFFEE200F5C98200D174
      0000D27B0000D5810100D27B0000F7DCA500FFEBC400F7DCA500EAAC5300EBB3
      5E00D27B0000D27B0000F2B96C00F4C17C00FFCFA000F2B36400E08F0B00BDAC
      930000000000000000000000000000000000000000008383830049545D0083CA
      FE001482F1003DB4F8005BF0FF001985F00021C1FA0090FBFE0013E2FF0013E2
      FF0010DCFF000ADBFF0006D8FF0001D3FF0002CAFF0002CAFF0003C4FE000AC1
      FF000ABBFE000CB5FD000CB5FD001AB2FD0034C6FC0053DFFE0063EBFD004CD4
      FD002AA5FD009CB2C8000000000000000000000000000000000067676700C79A
      5800F1BB6B00D47B0000FFDA8300FBAE3700FD9F1C00EA8F1000DB7B0000D377
      0000D37700009A7935006E5B3B00A8833B008F610E00DDC98E00E8D5AC00FDFC
      D900FDFCD900FDFCD900FBF6E900FDFCD900E8E5B700E8E5B700FDFCD900FDFC
      D9009F701B00B7AC9C0000000000000000000000000000000000000000000000
      00008C8C8C004D4C4C00FAECD800FFF1DC00E4AF5D00D1750000FECC6B00FECC
      6B00FEC65B00FEF1B300FEF1B300FEF4BC00FEECB300FFE9A500FEE29B00FEDB
      8B00FED17300FDC96200FECC6B00FED17300FED17300FECC6B00FED37A00D681
      0200C2B7A80000000000000000000000000000000000000000007C7C7C005B55
      4B00FCCD8400D6870A00EB8C0000FE990100FDFEFB00FFFCDB00FFFBD400FDE1
      AA00EBBE6C00E09A2C00D27B0000F5C98200FEE5C100E39D3600F8C38300FFE3
      BC00FBCB9400E4A13C00EAAC5300D27B0000D27B0000FBCB9400F2B36400C0A1
      740000000000000000000000000000000000000000008383830049545D0083CA
      FE001482F1003DB4F80065F4FE001B8BF30016AAF60098FDFF0025E7FF001AE3
      FF0010DCFF000ADBFF0006D8FF0001D3FF0002CAFF0002CAFF0003C4FE000AC1
      FF000AC1FF0011BAFE0011BAFE001AB2FD001BACFD001BA5FD002AA5FD003CBB
      F90053D3FE0080A8D000000000000000000000000000ABABA9005A5A5A00D9B5
      7300EAB66700CE750000FDD377003BEDCF005AF9EB00A0DA9E00E5C05B00FFB4
      3900EB9C23006A3500009B7E4E00A37D350095691500DDC98E00E8E5B700FDFC
      D900FDFCD900FDFCD900FDFCD900FDFCD900FCF8C800FCF8C800FDFCD900FDFC
      D900D9B573009A82570000000000000000000000000000000000000000000000
      0000000000007373730052525200F2C68700D8880B00D7850900FFD06D00FEC6
      5B00FED37A00FFE9A500FEF4BC00FFFDC900FFFAC400FFE9A500ECB24A00E7A0
      2800F1B54A00FECC6B00FFD06D00FED17300FEDB8B00FFD06D00FED17300D283
      0B00000000000000000000000000000000000000000000000000807E7C005550
      4900FCCD8400DA8C1400E2880000FE940000FDFEFB00FFFCDB00FEF4D200F0E9
      D600FFFBD400FFFACE00FFF1C300FFEBC400FFEBC400D27B0000CE740000DD91
      1D00F0AF5E00F5C58300FFDCB800F8C38300E0942400F5C58300F8C38300C494
      500000000000000000000000000000000000000000008383830049545D0089CC
      FF000D81F1003CBBF90063EBFD001D9BF4001399F50098FDFF002AE8FF002AE8
      FF001AE3FF000ADBFF0006D8FF0001D3FF0001D3FF0002CAFF0003C4FE000AC1
      FF000AC1FF0011BAFE0011BAFE001AB2FD001BACFD0022AAFE0025A3FE00229A
      FD004CCCFC00579AD900000000000000000000000000ABABA9005A5A5A00C5A5
      6500EEC07900CE750000FECB660052E3B50062FEFE0047FDFF0020FFFF003CFF
      FF0062BDA400494C3300C6AB7600A57B2A009B732600DDC98E00E8D5AC00E8D5
      AC00D7C9A600D7C9A600D7C9A600CEBFA200BFB58D00BFB58D00D6BE9600E8D5
      AC00F9D597009B73260000000000000000000000000000000000000000000000
      0000000000009494940049494900DA9A3800D6810200E79F2700FDC96200FEC6
      5B00FEDB9200FEE29B00FFFDC900FFFDC900FEF1B300D47C0000D6810200DFA0
      4000DB8E1900D6810200FDC96200FED37A00FFD98300FEDB9200FDC96200EEA9
      3300B39E80000000000000000000000000000000000000000000828282004B49
      4600FCCD8400DA8C1400E2880000FE940000FDF6F200FFFCDB00C8CCDB001742
      F0003A5DEB006279E400A2A8D500DBCDC600FFEBC400F7D19400E7A74800E094
      2400E0942400CE740000DC8F1A00F0AF5E00F5C58300FED4A400FBCB9400C88B
      330000000000000000000000000000000000000000007979790052616F007DC5
      FF000D81F10043BCF80063EBFD0028AAF7000F8FF40086FAFF0036EAFF002AE8
      FF0031E1FE0022DDFE000ADBFF0001D3FF0001D3FF0002CAFF0003C4FE000AC1
      FF000AC1FF0011BAFE0011BAFE001AB2FD001BACFD0022AAFE0025A3FE00229A
      FD004ABEFB003994E500000000000000000000000000000000005A5A5A00C5A5
      6500EEC07900CE750000FECB660067DCA00076FDFF0096FAFE00A8F6FE0076FD
      FF0029AFB50025656300D8BB8500A37D35009B732600CBB06A00BEA87900C6AB
      7600C3AC8500C3B99000C3B99000C3B99000C3B99000C6B68800B6A06E00AE9A
      5A00E9C06900956915000000000000000000000000000000000000000000AAAA
      AA007A7A7A00B2782000D6810200DB830300D47C0000F5B54600FDC96200FEC7
      6000FFD98300FFE19500FFF8BE00FFFDC900EBA83B00E2941A00FFF5E200FEFE
      FD00FEFEFD00E7B97600DD8D0C00FED37A00FFD98300FEE29B00FFD06D00FEC2
      5500C4790C00A689600000000000000000000000000000000000868789004B49
      4600FCCD8400DA8C1400DC830000FE940000FFF6EA00FFFCDB00DEDED800244D
      EE00244DEE00244DEE001F4AF1006D80DE00FFF1C300F4C17C00FDD39C00FFE3
      BC00FED4A400EAAC5300E0942400E0942400CE740000E39D3600FED4A400CE8A
      21000000000000000000000000000000000000000000797979004B5F720082C5
      FF000D81F10043BCF80063EBFD0033BAFD000D81F10065F4FE0044EBFF002AE8
      FF002DE2FE0031E1FE0032DBFE0010DCFF0001D3FF0002CAFF0003C4FE000AC1
      FF000AC1FF0011BAFE0011BAFE001AB2FD001BACFD0022AAFE0025A3FE00229A
      FD0040AAF7002C93EF00000000000000000000000000000000005A5A5A00B799
      6400EEC07900D47B0000FEC456007BD1890047FDFF0062FEFE005BFBFE0062FE
      FE003EA6AA0027635E00D6BE9600A8833B0096640B00B6935400D8BB8500D8C6
      9800D7C9A600D7C9A600D7C9A600D7C9A600D7C9A600D7C9A600D8C69800D6BE
      9600E4C694009B73260000000000000000000000000000000000000000006C6C
      6C00BE8C4000E58E0800E08F1000FECC6B00FED17300FED17300FDC96200FEC7
      6000FED37A00FEDB9200FEF1B300FFF8BE00E38A0000614F39008D919500FFFD
      EA00F7E5CA00F2DDBC00D47C0000FED17300FFD98300FEE4A300FEDB9200FFC8
      5E00FDC96200EAA22B00BF9E6D00000000000000000000000000868789004B49
      4600FCCD8400DD911D00DC830000FE940000FDF4DD00FFFCDB00FFFBD400FEF4
      D200ECE2CF00BCBCD3007486DF008792D900FFF1C300E0942400D1740000D581
      0100F5C58300F5C58300FFD6AA00FED4A400EFAF5D00E9A23C00FFD6AA00D588
      0C000000000000000000000000000000000000000000747474005467790082C5
      FF000D81F10043BCF80068EAFE0038C3FB00137DF10049EBFE005BF0FF002AE8
      FF002DE2FE0031E1FE0031E1FE0032DBFE0032DBFE0016D1FF0003C4FE0003C4
      FE000AC1FF0011BAFE0011BAFE001AB2FD001BACFD0022AAFE0025A3FE0025A3
      FE003295F3002B9DF4000000000000000000000000000000000067676700B799
      6400EEC07900D47B0000FEC4560091C9730076FDFF00A8F6FE00A8F6FE0096FA
      FE005EBABD0027595D00D8C69800BEA8790095691500C6B68800D6BE9600D8C6
      9800D7C9A600D7C9A600D7C9A600D7C9A600D7C9A600D7C9A600D7C9A600E4C6
      9400F7D7A5009A79350000000000000000000000000000000000999999004D4C
      4C00FDC97A00D9890D00E39C2700FFD98300FFD06D00FECC6B00FDC96200FEC7
      6000FFD06D00FFD98300FFE9A500FEF1B300E58C02007E756B0055555500CCB5
      9100F1CB8C00E9BD7A00D8891100F4C16000FEDB8B00FEE29B00FEE4A300FFC8
      5E00FED17300FED17300C99141000000000000000000000000008A8A8B004B49
      4600FCCD8400DD942400D5810100FE940000FEEBCC00FFFEE200FFFCDB00FEF2
      CC00FFFCDB00FFFCDB00FFFACE00FFEEBF00FFEBC400F4C17C00DA8C1400D27B
      0000ECB46500CE740000D27B0000F4BC7400EFAF5D00FBCB9400FEDCB300D589
      14000000000000000000000000000000000000000000747474004E63770073C0
      FF000D81F10042C1FB0068EAFE0042DCFE001379EF002DE2FE0073F2FE0025E8
      FF002DE2FE0031E1FE0031E1FE0032DBFE0032DBFE0042DCFE004ADBFE0031CE
      FE0015C4FF000ABBFE000CB5FD000CB5FD001AB2FD0022AAFE0025A3FE0025A3
      FE00218CEB003699F40094B1CA0000000000000000000000000067676700A688
      5600F3C58100D47B0000FCBB4900A8BE5C0047FDFF0062FEFE005BFBFE0076FD
      FF0064D7DA0027595D00CEBFA200E6D4B4008F610E00B7996400D6BE9600E3CB
      A700E3CBA700E6D4B400E6D4B400ECDEC500E6D4B400E6D4B400E3CBA700E3CB
      A700DDC98E00A688560000000000000000000000000000000000919191004949
      4900FED58B00D9890D00DC8A0A00FBCD7000FFD98300FED37A00FECC6B00FEC6
      5B00FECC6B00FED37A00FEE29B00FEEAAC00EA9B1C0096764A0065656500816D
      4D00ECB25300DFA04000D6810200F6C86B00FFE19500FFE9A500FEEAAC00FFC8
      5E00FEC76000EA9B1C00D1903000000000000000000000000000939393004B49
      4600FCCD8400DE9B3100D5810100FE940000FFE7C900FFFEE200FEF4D200D174
      0000D6870A00E0942400EAAC5300EDBD7100FEEBCC00FFE3BC00FFE7C900FFE3
      BC00FFD6AA00E7A34100D6870A00ECB46500CE740000D27B0000FFD6AA00E09A
      2C00C1B4A10000000000000000000000000000000000747474004E63770089CC
      FF000D81F1004DC6F90068EAFE004DE3FE00137DF10026CEFD0083F4FF0025E8
      FF002DE2FE002DE2FE0031E1FE0032DBFE0032DBFE003AD9FE0042D5FD004CD4
      FD005AD3FD005AD3FD0050CDFB0038C3FB0022B5FE001BA5FD001BACFD0025A3
      FE00218CEB0046A1F3007AA8D20000000000000000000000000067676700A688
      5600F3C58100D47B0000FCBB4900C0B545005BFBFE0089FBFE0089FBFE0089FB
      FE0084E4FE00387E82006B837C00EBE2C800B79964008F610E00D8C69800E3CB
      A700E6D4B400F4E3CA00F5EADB00FBF6E900FBF6E900EAE6D300E6D4B400ECDE
      C500A8833B00B7AC9C0000000000000000000000000000000000949494004949
      4900FEDB9A00EBBA7200D47C0000D1750000D47C0000E9A63300FED37A00FECC
      6B00FED17300FFD06D00FFE19500FEE29B00FED37A00DB830300544C44009168
      2900C4790C00B0670000D47C0000FFE19500FEE4A300FEF1B300FEF1B300FFD0
      6D00E49415009C7F5400B7B4AF00000000000000000000000000939393004C4B
      4B00F5C58300DE9B3100D5810100FE940000FEDCB300FFFEE200FFFCDB00D174
      0000D27B0000D27B0000D27B0000D27B0000FFEBC400EDBD7100D27B0000DA8C
      1400FBCB9400FBCB9400FEDCB300FEDCB300F4BC7400E4A13C00FFCFA000E9A6
      4600C3AB860000000000000000000000000000000000706F6F0064819D007DC5
      FF000D81F1004DC6F90068EAFE004DE3FE001482F10018BCF90090FBFE0025E8
      FF002DE2FE002DE2FE0031E1FE0032DBFE0032DBFE003AD9FE0042D5FD004CD4
      FD0053D3FE005AD3FD0064D2FF0073D1FF0083D1FF008BD1FF0069C4FF002EA9
      FD001B8BF3004EA4EF004C99E10000000000000000000000000067676700947D
      5600F3C58100D8850400EDA73600D7A6370047FDFF0089FBFE0089FBFE0089FB
      FE0089FBFE006ECAD100345F6400C8C6B700FDFCD9009B732600996F2200E6D4
      B400EBE2C800F5EADB00FBF6E900FCFBFA00FCFBFA00FBF6E900FBF6E900C6AB
      7600A68856000000000000000000000000000000000000000000A1A1A1005C5C
      5C00CCC9C100FEFEFD00FEFEFD00FFF1DC00DFA04000D6810200FEDB9200FED3
      7A00FED37A00FED48200FED58B00FEDB8B00FFE19500F1B54A00D87C0100BC6E
      0000B4680000D47C0000EEB95700FEE4A300FEE4A300FFF8BE00FEEAAC00FFE1
      9500E18D0B00BBB5AB0000000000000000000000000000000000939393004C4B
      4B00F5C58300E9A23C00D5810100FE940000FFDA9C00FFFEE200FFFEE200FDE2
      B300F8D09400EBBE6C00E9A23C00DD911D00FEE5C100F3CC9100D1740000CE74
      0000EAAC5300D27B0000D27B0000EBB35E00EFAF5D00F4C17C00FED4A400F2B7
      6D00C5A06800000000000000000000000000000000006B6B6B005C81A3006BB9
      FF000B7DF0004DC6F90063E6FC005CEBFD001B8BF30016AAF60086FAFF0025E8
      FF002DE2FE002DE2FE0031E1FE0032DBFE0032DBFE003AD9FE0042D5FD004CD4
      FD0053D3FE005AD3FD0064D2FF006CD1FF007CD0FF0083D1FF0092D2FE0096D8
      FF004FA9F4004395DB003392EA000000000000000000000000006D6F70008A77
      5800F6C88300D8850400EDA73600E5AB2C0047FDFF0096FAFE0096FAFE0096FA
      FE0096FAFE0089FBFE0063ACB2002E5D6100DCDBD700FBF6E900A57B2A009569
      1500D6BE9600FBF6E900FCFBFA00FCFBFA00FCFBFA00FBF6E900B7996400A37D
      350000000000000000000000000000000000000000000000000000000000AAAA
      AA00949494006A6A6A0055555500FEE3B600EDC78B00D1750000FED58B00FEDB
      9200FED37A00FEDB8B00FEDB9200FED58B00FED48200FEDB8B00FED37A00ECB2
      4A00EAAD4500FED48200FFE9A500FFE9A500FEEAAC00FFF8CE00FEDB8B00FEE2
      9B00D481080000000000000000000000000000000000000000009A9A9A004C4B
      4B00EFC17D00E9A64600D5810100FE940000FFD38C00FFFEE200FFFBD400FEF4
      D200FFFCDB00FEF4D200FEF2CC00FEE5C100FEE5C100FFE3BC00FDDBAB00F4CE
      8B00FAC98C00DD911D00D27B0000E7A34100D5810100CE740000F2B76D00F8C3
      8300C7924700000000000000000000000000000000006B6B6B005C81A30082C5
      FF000B7DF00050CDFB0063E6FC005BE4FC001D9BF4001290F4007DFBFF002AE8
      FF002DE2FE002DE2FE0031E1FE0032DBFE0032DBFE003AD9FE0042D5FD004CD4
      FD0053D3FE005AD3FD0064D2FF006CD1FF0073D1FF007DCEFF008BD1FF0092D2
      FE009ED3FF0075A2C7001B8BF300000000000000000000000000717171007B6B
      4E00F6C88300D8850400E49E3200E5AB2C0047FDFF0096FAFE0096FAFE0096FA
      FE0096FAFE0096FAFE0099E5FC0073BAC400406F76009AABAE00FCFBFA00CAB2
      770096640B00A06C0F00B68D4400B6935400B27D34009F701B00947D56000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E0052525200E1C9A100F7DEB600D7850900E4A83D00FFE9
      A500FED48200FED58B00FEE29B00FEDB9A00FED58B00FED48200FED58B00FFE1
      9500FEE29B00FFE89E00FEE4A300FEEAAC00FFF3C400FFF6C900FED48200FEEA
      AC00E3A43B00AA8B6000000000000000000000000000000000009A9A9A005252
      5200E8BD7800E3A94C00D27B0000FE990100FFC66F00FEFCF300FFFBD400F6F3
      DF00F2F6F700FEFCF300FEFCF300FFFEE200FEF4D200FEE5C100FDE2B300FEDC
      B300FDDBAB00FEDCB300FDDBAB00FFD6AA00F2B76D00E09A2C00EBB35E00FBCB
      9400CD8A2B000000000000000000000000000000000065656500698FB20070BA
      FE000B7DF00050CDFB0063E6FC005BE4FC001CAFF700138AF20065F4FE0039EB
      FF002DE2FE002DE2FE0031E1FE0032DBFE0032DBFE003AD9FE0042D5FD004CD4
      FD0053D3FE005AD3FD0064D2FF006CD1FF0073D1FF007DCEFF008BD1FF0092D2
      FE0094CDFC00BED2E1003295F300ABB8C5000000000000000000717171006C60
      4D00FBCB8200D98B1400E19A2800FBAE370047FDFF0096FAFE0096FAFE00A8F6
      FE00A8F6FE00A8F6FE00A8F6FE00A8F6FE0099E5FC0073BAC4005D939F005191
      A30082A5AD008C9886008A8D68007A89670058A1AB00E38B0800B7AC9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000065656500816D4D00E2A34100D6810200E29B2A00FDE5
      AA00FEE29B00FED58B00FEDB9200FDE5AA00FDE5AA00FEDB9A00FEDB9200FEDB
      9A00FEE29B00FEE4A300FEEAAC00FFF3C400FFFCD200FEDB9200FEDB9A00FEEA
      AC00FEF4BC00D7850900BBB3A700000000000000000000000000A2A2A2005252
      5200E3BB7B00ECB46500D27B0000FE940000FBAD3800FDFEFB00FFFBD400D9E5
      D8000E95FF00289CFD0045ADF50074BFEE00AFD8E900E3ECEA00FEFCF300FFFE
      E200FFFEE200FEEBCC00FFDCB800FED4A400FED4A400FFCE9C00FFCFA000FFCE
      9C00CF87190000000000000000000000000000000000656565005B88B20066B4
      FD000B7DF00050CDFB0063E6FC005BE4FC0026BAFA001482F10049EBFE0049EB
      FE002DE2FE002DE2FE0031E1FE0032DBFE0032DBFE003AD9FE0042D5FD004CD4
      FD0053D3FE005AD3FD0064D2FF006CD1FF0073D1FF007DCEFF0083D1FF0092D2
      FE0094CDFC00C6DEF10055A9F80094B1CA0000000000000000007B7B7B006158
      4B00FBCB8200D98B1400E0951E00FFB4390028E8FB00B6F5FF00A8F6FE00A8F6
      FE00A8F6FE00A8F6FE00A8F6FE00A8F6FE00A8F6FE00A8F6FE00B6EEFF0084E4
      FE0067D6FA0067D6FA0015C7FF0022C6FD0015C7FF00E8930B00BEA879000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A6A6A60055555500CC7C0600D47C0000D6810200FEE29B00FEEA
      AC00FDE5AA00FEE29B00FED48200FEDB9A00FEECB300FEECBB00FEECBB00FEEC
      B300FEECBB00FFF3C400FFF6C900FFFCD200FEE4A300FEDB9200FEEAAC00FDE5
      AA00FFF6C900D785090000000000000000000000000000000000A2A2A2005252
      5200D8B98C00F3D09C00D5810100EE900000FE940000FDFEFB00FFFBD400FFFA
      CE00289CFD0024A3FF0024A3FF001CA1FF0013A2FF000BA2FF000BA2FF001EAD
      FB0043BBF10078CAE900B5DEE600E3ECEA00FFF6EA00FDF4DD00FEEBD000FED4
      A400D5880C00000000000000000000000000ABABAC00656565006E97BF007DBF
      FD000B7DF0005AD3FD0063E6FC005BE4FC0034C6FC001379EF002AE8FF0063EB
      FD0025E8FF002BDFFE0038E4FE0038E4FE0037D5FD0037D5FD0042DCFE004CD4
      FD0050CDFB005AD3FD0064D2FF006CD1FF0073CFFF007CD0FF0083D1FF0092D2
      FE0094CDFC00BDD8EC007DBFFD006AA2D50000000000000000007B7B7B006158
      4B00FBCB8200E0951E00D98B1400FCBB490028E8FB00B6F5FF00A8F6FE00A8F6
      FE00A8F6FE00A8F6FE00A8F6FE00B6F5FF00B6F5FF00B6F5FF00B6F5FF00B6F5
      FF0077D9FF0084E4FE0087DDFF0022C6FD0015C7FF00E19A2800C79A58000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000073737300A67D3D00EBA83B00D47C0000E9B55D00FFF3C400FEEC
      B300FEECB300FEECB300FDE5AA00FED58B00FFD79000FEEAAC00FEEFC100FFF6
      C900FFF8CE00FFF8CE00FEECBB00FEDB9200FEDB9A00FFF3C400E29B2A00E294
      1A00E2941A00D095400000000000000000000000000000000000000000006262
      62008A7C6600FDE2B300DA8C1400DC830000FE940000FEEBCC00FFFEE200FFFA
      CE005FB2F4001CA1FF0028A1FE0024A3FF0024A3FF0022AAFE001EADFB0014B2
      FF0013ADFF0009B2FF0001B5FF0001B5FF0001B5FF0015C0F60043CBF200FEF2
      CC00DC8F1A00C4B399000000000000000000A5A5A5005C5C5C006FA0CE006AB7
      FE000B7DF0005AD3FD0063E6FC005BE4FC0037D5FD00137DF10032DBFE0098FD
      FF0071F9FF0071F9FF0071F9FF0079F6FF0079F6FF0079F6FF0079F6FF0083F4
      FF0083F4FF0083F4FF0089EFFF0089EFFF0087EFFF0091E3FF008FE3FF0096D8
      FF009CD8FF00ADC9DA0090BDE7004C99E10000000000000000007B7B7B005551
      4800FBCB8200DB972800D98B1400FFC24B0028E8FB00C3F5FF00B6F5FF00B6F5
      FF00B6F5FF00B6F5FF00B6F5FF00B6F5FF00B6F5FF00B6EEFF00B6EEFF00B6EE
      FF0099E5FC0084E4FE0084E4FE0087DDFF0022C6FD00C5A56500CD8F39000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000656565009F958200FFF3D300DB8E1900D9890D00FFF3C400FEF4
      BC00EEC27800E7AF5600FEF4BC00FEECBB00FEE4A300FFD79000FED58B00FFD7
      9000FEDB9200FFD79000FEDB9200FDE5AA00FFF3C400ECB25300C77F15009494
      9400A79E9000C5BEB40000000000000000000000000000000000000000007C7C
      7C004C4B4B00FDE2B300E5AF5500D27B0000FE940000FECB7D00FFFEE200FFFA
      CE00BFD9DE0028A1FE001D9CFF000F9FFF0013A2FF0013A2FF0013ADFF0013AD
      FF0013ADFF0014B2FF0012BAFE0012BAFE000CBDFF0002C1FF0000BDFF00EDF2
      ED00F9B36200CA9B53000000000000000000A5A5A5005C5C5C006397CA005BB1
      FD000B7DF0005AD3FD0063E6FC005BE4FC003AD9FE001482F1001482F1001482
      F1001482F1001482F1001482F1001482F1001482F1001482F1001482F1001482
      F1001482F1001985F0001985F0001985F0001985F0001B8BF3001B8BF3001B8B
      F3002294FB00229AFD0025A3FE003B9DF1000000000000000000848484005551
      4800FBCB8200D7963600D8850400FFD16B0028E8FB00C3F5FF00C3F5FF00C3F5
      FF00C3F5FF00C3F5FF00C3F5FF00C3F5FF00C3F5FF00C3F5FF00C3F5FF00C3F5
      FF00C3F5FF0099E5FC0099E5FC0099E5FC0087DDFF00A0BA8C00D18624000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009494940052525200DBD2C300FFF3D300D87C0100E0962500E29B
      2A00DA860A00D6810200DD901A00F5DA9E00FFF3C400FEEFC100FEECBB00FEEC
      B300FEECB300FEEFC100FFF3C400FEEFC100FFF6CD00DB830300AEAAA4000000
      0000000000000000000000000000000000000000000000000000000000009A9A
      9A0052525200E8C69700F3CC9100D27B0000EE900000FFA41B00FDFEFB00FEF4
      D200FEF2CC00FFF1C300FFF1C300FEE5C100DFDDC600BCD1CE008BC6DB005BBD
      E80035B7F50014B2FF0009B2FF0001B5FF0000BDFF0002C1FF0000BDFF0079DC
      F500FED4A400D28718000000000000000000A1A1A1005C5C5C0076A6D60070BA
      FE000B7DF0005AD3FD0063E6FC005BE4FC004ADBFE0026BAFA0022B5FE0022B5
      FE001AB2FD001AB2FD0011BAFE0011BAFE000ABBFE000ABBFE000CB5FD000CB5
      FD0014B3FD0016AFFE0016AFFE001BACFD001AB2FD001BA5FD0025A3FE0025A3
      FE00229AFD00647688009A9A9A00000000000000000000000000848484005551
      4800FBCB8200E1A34300D8850400FDD3770057CAB20048D1CA0048D1CA0041D2
      D70041D2D70041D2D70042D4E90042D4E90042D4E9004DD4F70057D5FD0057D5
      FD0067D6FA0067D6FA0067D6FA0077D9FF0077D9FF009DD1CC00D98B14000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008988880052525200E2DED700FCEAC900E49415008866
      3200C0C6CD00FEFEFD00E2A74E00D47C0000F5DA9E00FFF3C400FFF3C800FEEC
      BB00FEECBB00F5DA9E00F1CB8C00FFF8CE00FFFCDC00DD901A00C2B7A8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000626262009B8A6F00FDDBAB00D8870E00DC830000FE990100FDF6F200FFFE
      E200FFFBD400FEF2CC00FEEBCC00FFEEBF00FDE2B300FDE2B300FDE1AA00FDE1
      AA00FFDA9C00FFDA9C00FDD39C00F5D2A500D3CDB000AAC9BF006AC6D60053CB
      E400FFE7C900DD911D00C4B3990000000000A1A1A1005C5C5C0076A6D60066B4
      FD000D81F1005AD3FD0068EAFE0063EBFD005CEBFD004DE3FE0040E0FD0037D5
      FD002ACDFD0021C1FA001BACFD0015A1F7001399F50002CAFF0002CAFF0003C4
      FE000AC1FF0011BAFE0011BAFE0014B3FD001AB2FD001BACFD0022AAFE0025A3
      FE00229AFD007CA4C800000000000000000000000000000000008A8A8A004E4C
      4700FECB7E00E1A34300D47B0000FFE59C00FFDA8300FDD37700FDD37700FFD1
      6B00FFD16B00FECB6600FECB6600FEC45600FEC45600FEC45600FFC24B00FFC2
      4B00FFC24B00FFC24B00FFC24B00FEC45600FEC45600FECB6600D88504000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A80099999900A1A1A100000000008282
      820042424200FAC06800E9BC7700D7860D00F3D59A00FFF6CD00FFF8CE00DB8E
      1900D1750000D6810200D8891100F7E0AE00FFFFE700E0962500C0B097000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007A7876005B554B00FDE1AA00E3A94C00D5810100FE990100FFA82300FDE2
      B300FEEBD000FFF3E100FFF6EA00FDFEFB00FDFEFB00FDFEFB00FDFEFB00FDF6
      F200FFF6EA00FFEDDD00FEEBD000FEE5C100FDE2B300FFD6AA00FDD39C00FDD3
      9C00FFCE9C00F2B36400CA9B530000000000A1A1A1005C5C5C006AA2D5005BAF
      FD000D81F10043BCF8003DB4F8002AA1F5001B94FD001B8CFB00158BFE00158B
      FE00158BFE00158BFE001B8CFB003295F3001482F10002BFFF0002CAFF0003C4
      FE000AC1FF000AC1FF0011BAFE0011BAFE001AB2FD0022AAFE001C9AFE00229A
      FD001B94FD006EAADF0000000000000000000000000000000000959595004F50
      5100FCEACB00FBCB8200E3860000E5890000E5890000E3860000E5890000E589
      0000E5890000E5890000E5890000E7900900E7900900E7900900E6951500EB98
      1500EB981500EB981500EA9B1B00EB9C2300EB9C2300F0A62B00E3860000C1B6
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009191
      910049494900FCC26600E5B36300D9890D00F2D39900FFFFE700FCE5B200C97A
      0600FBF1E200FFFFF100F9DEB300E59A2700E58E0800CF8C2800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009393930052525200F3DAB700FDDBAB00D5810100E2880000E3850000EB85
      0000EB850000EB850000EB850000F58E0000F5920000FE990100FFA01100FFA6
      2100FDAE3500FFB74B00FFC26100FECB7D00FFD38C00FDDBAB00FEE5C100FEEB
      CC00FFF3E100FFEDDD00D589140000000000A5A5A50065656500A5BBCF00A1DB
      FE001390FE001B94FD00229AFD003098FC00449BEC005591CA00668AAB007185
      9800646D7500636A6F00E9FBFE00E9FBFE00419EF700138AF2000CB5FD000CB5
      FD0013A4FB001C9AFE001B94FD001B94FD001B94FD002294FB002E8DEA004182
      BE0064819D00A9B1B70000000000000000000000000000000000000000009595
      95007B7B7B007B7B7B0080756500807565008075650080756500807565008075
      650080756500807565008075650080756500807565007E7463007E7463007E74
      63007E7463007E7463007D725F007D725F007D725F0084796900A2998C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009999
      990055555500E7D5B500FEE6B400F0A53300E28C0600E8AA4600EBA235007C64
      490066696E0089888800C1C0BD00D7B27B0098876D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007C7C7C006F6E6E00A9A9A700CA9B5300CE8A2100DC8F1A00DC8F
      1A00E4921400E8930A00E8930A00E8930A00EB8C0000E2880000E2880000E288
      0000E2880000E3850000DC830000E3850000E3850000EB850000E3850000EB85
      0000EB850000E3850000CD8A2B000000000000000000A5A5A500908F8D008383
      83007E858B008D9092009A9A9A00ABABAC000000000000000000000000000000
      00000000000083838300706F6F00D8D8D800EBF3FB005BB1FD001B94FD002294
      FB002E8DEA003D84C8005C81A30076828E0092929300A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A1A1A100898888006A6C6F0075716B00A8885400C78D3400DE9A32000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A9A9A700A2A2A200A09E9B009A9A9A009393
      93008A8A8B0086878900828282007C7C7C007A7876007874700079736B007970
      6300807360008D7B5F00907955009C7D4F00A7834900AC813F00C08D3E00CD95
      3B009F804F00A09E9B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5A5A5009A9A9A00908F8D0092929300A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AAAAAA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ABABAB00ABABAB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFF0FFFFFFF0FFFFF00000000
      FEFFFFC3FC003FFFFC003FFF00000000E01FFF03F80000FFF80000FF00000000
      E003C001F000003FF000003F00000000C0000003F000001FF000001F00000000
      C0000007E000000FE000000F00000000C0000007E0000007E000000700000000
      C000000FE0000007E000000700000000C000000FE0000007E000000700000000
      C0000007E0000007E000000700000000C0000003E0000007E000000700000000
      C0000003E0000007E000000700000000C0000003E0000003E000000300000000
      C0000003E0000003E000000300000000C0000003E0000003E000000300000000
      C0000003E0000003E000000300000000C0000001E0000003E000000300000000
      C0000001E0000003E000000300000000C0000001E0000003E000000300000000
      C0000001E0000003E000000300000000C0000001E0000001E000000100000000
      C0000001E0000001E000000100000000C0000000E0000001E000000100000000
      C0000000E0000001E000000100000000C0000000E0000003E000000300000000
      C0000003E0000003E000000300000000C0000003F0000007F000000700000000
      80000003F000001FF000001F00000000C010000FF80003FFF80003FF00000000
      FFFC03FFFE007FFFFE007FFF00000000FFFFFFFFFFDFFFFFFFDFFFFF00000000
      FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFF7FFFFFDFFFFFF
      FFFFFFFFFF8FFFFFFFC3FFFFF003FFFFC0000003FF03FFFFFF81DFFFF0000FFF
      C0000003FF00FFFFFF8003FFE000003FC0000003FE007C7FFF0000FFE000000F
      C0000003FC00303FFF00001FE000000FC0000003FC00001FFF00001FE000000F
      C0000003FC00000FFE00001FE000000FC0000003FC00001FFC00001FE0000007
      C0000003FF00001FF800000FE0000007C0000003FFC0003FF800000FE0000007
      C0000003FFE0007FF0000007E0000007C0000003FFE000FFF0000007F0000007
      C0000003FF80007FF0000007F0000007C0000003FF00003FF0000007F0000007
      C0000003FE00001FF0000003F0000007C0000003FE00001FF0000003F0000003
      C0000003FE00001FF0000003F0000003C0000003FE00001FF0000003F0000003
      C0000003FF00003FF8000007F0000003C0000003FFC000FFF8000007F0000003
      C0000003FFF000FFF8000007F0000003C0000003FFF800FFFC00000FF0000003
      C0000003FFF8007FFC00000FF0000007C0000003FFF0007FFC00001FF0000007
      C0000003FFF0007FFC00001FF000000FC0000003FFF800FFFC00001FF000001F
      C0000003FFF800FFFE00003FF00001FFC0000003FFFC01FFFF00007FF0003FFF
      C0000003FFFF07FFFF01C07FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFFFFCFFFFFEFFFFFF
      E03FFFFFFFFFFFFFFFE063FFE03FFFFFC007FFFFFFC1FFE1FFE000FFE007FFFF
      C000FFFFFF803F80FFC000FFC000FFFF80001FFFFF000000FE0000FFC0003FFF
      800003FFFE000000FC00007FC00007FF800000FFFC000001F800000FC00000FF
      8000001FE0000003F8000007C000001F80000007C0000007F0000007C000000F
      80000003C0000003F0000007C000000F8000000380000003F800000FC000000F
      8000000380000003F8000007C000000F80000003C0000003E0000003C000000F
      80000003C0000003E0000001C000000F80000003C0000003C0000001C000000F
      80000001C0000003C0000001C000000780000001C0000003C0000001C0000007
      80000001C0000007C0000003C000000780000001C000000FE0000007C0000007
      80000001C000001FF8000003C000000780000000C000001FFC000001C0000007
      80000000C000001FF8000003C000000700000000C000001FF8000003E0000003
      00000000C000001FF8000003E000000300000000C000001FF800001FE0000003
      00000001C000001FFC00001FF000000100000003C000001FFE20001FF0000001
      00000003C000000FFFE0003FF000000100000003E000001FFFE0007FF8000001
      80F8003FFFFFFFFFFFF01FFFFE000003FFFE0FFFFFFFFFFFFFFF7FFFFFFFFF9F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList5: TImageList
    Height = 32
    Width = 32
    Left = 532
    Top = 141
    Bitmap = {
      494C010106002400240020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000004000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A8A8A800A1A1A100A4A4
      A400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000999999009090
      90008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008F8F8F008E8E8E008E8E
      8E008E8E8E008E8E8E008E8E8E008C8C8C008C8C8C008C8C8C008C8C8C008A8A
      8A008A8A8A008989890089898900898989008989890089898900888888008888
      8800888888008888880000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A50095959500919191009191
      910093939300A2A2A20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099999900A6A6
      A600A1A1A100A1A1A100A1A1A100A1A1A100A1A1A100A0A0A000A0A0A000A0A0
      A0009E9E9E009E9E9E009E9E9E009D9D9D009D9D9D009C9C9C009C9C9C009B9B
      9B009B9B9B009B9B9B009A9A9A009A9A9A009A9A9A0098989800989898009898
      9800989898008888880000000000000000000000000000000000000000000000
      000000000000000000000000000000000000999999009494940091919100AFAF
      AF00B0B0B0009696960095959500A8A8A8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099999900A7A7
      A7009D9D9D009999990097979700979797009797970097979700979797009797
      9700979797009595950095959500959595009595950095959500959595009393
      9300939393009393930093939300939393009393930093939300939393009393
      9300989898008888880000000000000000000000000000000000000000000000
      0000000000000000000000000000A0A0A000929292009393930097979700B7B7
      B700B0B0B000B9B9B900ABABAB0091919100A2A2A20000000000000000000000
      00000000000000000000A3A3A30098989800A5A5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099999900A8A8
      A8009D9D9D00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BBBBBB00BBBBBB00BABA
      BA00BABABA00BABABA00BABABA00B9B9B900B9B9B900B9B9B900B9B9B9009393
      9300989898008888880000000000000000000000000000000000000000000000
      00000000000000000000A8A8A800969696009C9C9C00919191009B9B9B00B2B2
      B200B5B5B500B1B1B100B6B6B600B7B7B700959595009F9F9F00000000000000
      0000A6A6A600979797008F8F8F009191910094949400A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009A9A9A00A9A9
      A9009D9D9D00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BBBBBB00BBBB
      BB00BABABA00BABABA00BABABA00BABABA00B9B9B900B9B9B900B9B9B9009393
      9300989898008989890000000000000000000000000000000000000000000000
      000000000000000000009F9F9F0096969600B9B9B900A9A9A900959595009090
      900099999900B2B2B200B4B4B400B3B3B300B9B9B90095959500A2A2A200A4A4
      A400949494008E8E8E0090909000A3A3A300B7B7B70095959500A6A6A6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009A9A9A00AAAA
      AA009F9F9F00BFBFBF00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBE
      BE00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BBBB
      BB00BBBBBB00BABABA00BABABA00BABABA00BABABA00B9B9B900B9B9B9009393
      93009A9A9A008989890000000000000000000000000000000000000000000000
      0000000000000000000097979700B2B2B200BFBFBF00BBBBBB00BBBBBB00B7B7
      B7009A9A9A0091919100AFAFAF00B3B3B300B2B2B200B7B7B700939393009494
      94008D8D8D00909090009C9C9C00B7B7B700AFAFAF00B2B2B20092929200AAAA
      AA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B9B9B00AAAA
      AA009F9F9F00BFBFBF00BFBFBF00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBE
      BE00BEBEBE00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BCBCBC00BCBCBC00BCBC
      BC00BBBBBB00BBBBBB00BABABA00BABABA00BABABA00BABABA00B9B9B9009393
      93009A9A9A008989890000000000000000000000000000000000000000000000
      000000000000000000009F9F9F009B9B9B00A7A7A700B7B7B700BDBDBD00BFBF
      BF00BFBFBF00A4A4A40091919100B2B2B200AFAFAF00B1B1B100AAAAAA009090
      900091919100A5A5A500B5B5B500B0B0B000AFAFAF00A6A6A600939393000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B9B9B00ACAC
      AC009F9F9F00BFBFBF00BFBFBF00BFBFBF009B9B9B0097979700969696009696
      9600AFAFAF00BEBEBE00BDBDBD00949494009393930091919100919191008D8D
      8D00B5B5B500BBBBBB00BBBBBB00BABABA00BABABA00BABABA00BABABA009393
      93009B9B9B008989890000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A3A3A300999999009E9E9E00BFBF
      BF00BDBDBD00BBBBBB009A9A9A0098989800B4B4B400AAAAAA00B5B5B500B0B0
      B000B5B5B500B5B5B500AEAEAE00AFAFAF00ACACAC0091919100A6A6A6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009B9B9B00ACAC
      AC009F9F9F00BFBFBF00BFBFBF00BFBFBF009B9B9B00A6A6A600999999009797
      970096969600BEBEBE00BEBEBE00969696009999990093939300939393009090
      9000A2A2A200BCBCBC00BBBBBB00BBBBBB00BABABA00BABABA00BABABA009393
      93009B9B9B008989890000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D009696
      9600B9B9B900B7B7B700B1B1B10090909000ABABAB00AAAAAA00A7A7A700AAAA
      AA00A9A9A900AAAAAA00B2B2B200A9A9A90090909000A1A1A100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C00ADAD
      AD009F9F9F00BFBFBF00BFBFBF00BFBFBF009D9D9D00A8A8A800A0A0A000A0A0
      A00094949400AFAFAF00BEBEBE00989898009C9C9C0099999900979797009595
      95008D8D8D00B5B5B500BCBCBC00BBBBBB00BBBBBB00BABABA00BABABA009393
      93009C9C9C008A8A8A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009A9A
      9A0099999900B4B4B400B0B0B00095959500A0A0A000AAAAAA00A2A2A200AAAA
      AA00B1B1B100AFAFAF009D9D9D0091919100A1A1A10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D00AFAF
      AF00A1A1A100BFBFBF00BFBFBF00BFBFBF009D9D9D00AAAAAA00A2A2A200A0A0
      A0009B9B9B0096969600BEBEBE009B9B9B009E9E9E009A9A9A00999999009797
      970090909000A2A2A200BCBCBC00BCBCBC00BBBBBB00BBBBBB00BABABA009393
      93009D9D9D008A8A8A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009E9E
      9E008F8F8F00AAAAAA00ACACAC009D9D9D0098989800AAAAAA009D9D9D00AFAF
      AF00979797009191910092929200A4A4A4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D00AFAF
      AF00A1A1A100BFBFBF00BFBFBF00BFBFBF009F9F9F00ABABAB00A4A4A400A2A2
      A200A1A1A10094949400AFAFAF009D9D9D00A0A0A0009A9A9A009A9A9A009999
      9900959595008D8D8D00B5B5B500BCBCBC00BCBCBC00BBBBBB00BBBBBB009595
      95009E9E9E008C8C8C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A6A6A600979797008F8F
      8F009191910094949400A9A9A900A1A1A10094949400A8A8A8009A9A9A00AAAA
      AA00949494008E8E8E009393930099999900A5A5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009F9F9F00B0B0
      B000A1A1A100BFBFBF00BFBFBF00BFBFBF009F9F9F00ADADAD00A5A5A500A3A3
      A300A3A3A3009B9B9B00979797009D9D9D00A2A2A2009D9D9D009C9C9C009C9C
      9C009999990090909000A2A2A200BCBCBC00BCBCBC00BCBCBC00BBBBBB009595
      95009E9E9E008C8C8C0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500949494008E8E8E009191
      91009595950091919100929292009696960092929200AAAAAA0098989800A3A3
      A3009B9B9B009393930095959500959595009191910097979700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009F9F9F00B0B0
      B000A1A1A100BFBFBF00BFBFBF00BFBFBF00A1A1A100ADADAD00A6A6A6009F9F
      9F00AAAAAA00A3A3A300969696009F9F9F00A4A4A4009E9E9E009C9C9C009E9E
      9E00A0A0A000979797008D8D8D00B5B5B500BCBCBC00BCBCBC00BCBCBC009595
      9500A0A0A0008C8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000A6A6A6009595950098989800919191009898
      98009F9F9F009E9E9E00979797009090900097979700AAAAAA009D9D9D00A0A0
      A000A1A1A1009E9E9E009F9F9F009F9F9F009F9F9F009A9A9A00969696000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A000B2B2
      B200A3A3A300BFBFBF00BFBFBF00BFBFBF00A1A1A100AFAFAF00A7A7A7009B9B
      9B00A3A3A300AAAAAA00A3A3A300A2A2A200A0A0A000A0A0A0009D9D9D009898
      9800A1A1A1009C9C9C0090909000A2A2A200BDBDBD00BCBCBC00BCBCBC009595
      9500A0A0A0008C8C8C0000000000000000000000000000000000000000000000
      00000000000000000000000000009A9A9A00A0A0A000B3B3B3009A9A9A009A9A
      9A00A6A6A600A5A5A500A6A6A600A5A5A500A4A4A400A5A5A500A5A5A500A5A5
      A500A5A5A500A7A7A700A8A8A800A8A8A800A9A9A900A7A7A700929292000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A1A1A100B2B2
      B200A3A3A300BFBFBF00BFBFBF00BFBFBF00A4A4A400B1B1B100A8A8A8009B9B
      9B009F9F9F00AAAAAA00A6A6A600A3A3A300A2A2A200A1A1A1009D9D9D009999
      99009B9B9B00A0A0A000979797008F8F8F00B5B5B500BDBDBD00BCBCBC009595
      9500A2A2A2008E8E8E0000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C0099999900BBBBBB00B9B9B9009494
      9400A0A0A000ADADAD00ADADAD00ACACAC00ACACAC00ACACAC00ADADAD00ADAD
      AD00AEAEAE00A1A1A1009090900093939300A1A1A100A2A2A200989898000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2A2A200B2B2
      B200A3A3A300BFBFBF00BFBFBF00BFBFBF00A4A4A400B1B1B100AAAAAA009B9B
      9B00AFAFAF00A1A1A100ABABAB00A4A4A400A3A3A300A3A3A3009D9D9D009B9B
      9B00A6A6A6009D9D9D009E9E9E0093939300A8A8A800BDBDBD00BDBDBD009797
      9700A3A3A3008E8E8E0000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A70098989800A4A4A400BFBFBF00BBBB
      BB009595950097979700AEAEAE00B5B5B500B5B5B500B5B5B500B6B6B600B7B7
      B700B4B4B40090909000B6B6B600BFBFBF00A4A4A40090909000A2A2A2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A2A2A200B2B2
      B200A3A3A300BFBFBF00BFBFBF00BFBFBF00A6A6A600B1B1B100ABABAB009B9B
      9B00B7B7B700AFAFAF00AAAAAA00AAAAAA00A5A5A500A4A4A4009F9F9F009D9D
      9D00BDBDBD009B9B9B00A3A3A3009A9A9A008F8F8F00B7B7B700BDBDBD009797
      9700A4A4A4008E8E8E0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A70099999900A0A0A000BFBF
      BF00BFBFBF00A7A7A70090909000909090009A9A9A00A1A1A100A1A1A1009898
      9800919191008F8F8F00B4B4B400BFBFBF00B9B9B900A5A5A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A3A3A300B4B4
      B400A3A3A300BFBFBF00BFBFBF00B7B7B700A6A6A600B1B1B100ADADAD009D9D
      9D00B5B5B500BDBDBD00A3A3A300ADADAD00A7A7A700A5A5A5009F9F9F009F9F
      9F00BEBEBE00A8A8A8009F9F9F00A2A2A20093939300A8A8A800B7B7B7009797
      9700A4A4A4008E8E8E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A0009797
      9700A9A9A900BEBEBE00BEBEBE00B0B0B000A0A0A00095959500909090009090
      9000909090009090900094949400A3A3A3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A4A400B4B4
      B400A6A6A600BFBFBF00BFBFBF00AAAAAA00AAAAAA00B1B1B100ADADAD00A3A3
      A300A1A1A100BBBBBB00B1B1B100A6A6A600ABABAB00A7A7A700A1A1A100A1A1
      A100BEBEBE00B0B0B0009F9F9F00A2A2A2009B9B9B0095959500B1B1B1009797
      9700A5A5A5008E8E8E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A4A4A4009D9D9D0091919100A0A0A0009C9C9C009393930094949400A7A7
      A700ABABAB00A4A4A400939393009E9E9E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A4A400B4B4
      B400A6A6A600BFBFBF00A7A7A700A7A7A700AFAFAF00B1B1B100B1B1B100ADAD
      AD00A1A1A1009F9F9F00BFBFBF00A3A3A300AAAAAA00ABABAB00AAAAAA00A1A1
      A100BEBEBE00A0A0A000A7A7A700A7A7A700A8A8A800A5A5A5009F9F9F009797
      9700A5A5A5008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E9E9E00919191009797970093939300919191009C9C9C00A0A0
      A000A1A1A1009F9F9F009A9A9A00929292000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A4A400B4B4
      B400A6A6A600BFBFBF00AAAAAA00AAAAAA00AAAAAA00A8A8A800A7A7A700A7A7
      A700A6A6A600A6A6A600BFBFBF00B5B5B500A3A3A300A2A2A200A2A2A200A0A0
      A000BEBEBE009F9F9F00A0A0A000A0A0A0009F9F9F009F9F9F009D9D9D009797
      9700A5A5A5008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000989898009C9C9C00A1A1A1009595950093939300999999009999
      99009A9A9A009A9A9A009B9B9B0094949400A4A4A40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A6A6A600B4B4
      B400A6A6A600BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BEBEBE00BEBEBE00BEBEBE00BEBEBE009999
      9900A5A5A5008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A7A7A70095959500A5A5A500A8A8A8009595950098989800A0A0A000A0A0
      A000A2A2A200A3A3A300A5A5A5009A9A9A00A1A1A10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A6A6A600B4B4
      B400A6A6A600BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BEBEBE00BEBEBE00BEBEBE009999
      9900A6A6A6008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A8A8A80096969600A7A7A700AFAFAF009A9A9A0097979700AAAAAA00A9A9
      A900AAAAAA00ABABAB00AEAEAE0098989800A4A4A40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A700B4B4
      B400A6A6A600BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BEBEBE00BEBEBE009999
      9900A6A6A6008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009B9B9B009B9B9B00B6B6B600AAAAAA0090909000AFAFAF00B2B2
      B200B2B2B200B5B5B500B1B1B100929292000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A700B4B4
      B400A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A3A3
      A300A3A3A300A3A3A300A3A3A300A1A1A100A1A1A100A1A1A100A1A1A100A1A1
      A1009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009D9D9D009D9D9D009D9D
      9D00A6A6A6009090900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A4A4A40095959500B1B1B100BEBEBE009C9C9C0091919100AEAE
      AE00B8B8B800AEAEAE0092929200A1A1A1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A700B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4
      B400B2B2B200B2B2B200B2B2B200B0B0B000B0B0B000AFAFAF00AFAFAF00ADAD
      AD00ACACAC00ACACAC00AAAAAA00A9A9A900A9A9A900A7A7A700A6A6A600A5A5
      A500A6A6A6009090900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A3A3A30098989800A7A7A700BCBCBC00A5A5A5009292
      92009292920093939300A0A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A700A7A7
      A700A7A7A700A7A7A700A6A6A600A6A6A600A6A6A600A4A4A400A4A4A400A4A4
      A400A3A3A300A2A2A200A2A2A200A2A2A200A0A0A000A0A0A0009F9F9F009F9F
      9F009F9F9F009D9D9D009D9D9D009C9C9C009C9C9C009C9C9C009B9B9B009B9B
      9B009B9B9B009B9B9B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A6A6A600A3A3A3009F9F9F00A0A0
      A000A3A3A3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A8A8A800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A9A9A900A7A7A7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ACACAC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009E9E
      9E00A1A1A1009E9E9E00A3A3A300A1A1A1009D9D9D00A6A6A600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB009E9E9E009D9D9D009E9E9E009F9F9F009E9E9E000000000000000000AAAA
      AA00A3A3A300A8A8A80000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AAAA
      AA009F9F9F009C9C9C009E9E9E009C9C9C009E9E9E00A6A6A600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A0009595
      9500A6A6A600A2A2A200A2A2A200A7A7A700A7A7A700A3A3A300A1A1A1009E9E
      9E00A6A6A6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A6A6A6009D9D
      9D00A1A1A100A6A6A600ACACAC00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A5A5
      A500999999009C9C9C00A2A2A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009E9E9E00A2A2A200AAAAAA00BBBBBB00A4A4A4009E9E9E00A1A1A1009494
      94009E9E9E00A1A1A1009D9D9D00ABABAB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009D9D
      9D009C9C9C009E9E9E009F9F9F00A9A9A900A9A9A9009E9E9E009C9C9C009F9F
      9F00A8A8A8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099999900A6A6
      A600A4A4A400A7A7A700A5A5A500A3A3A300B0B0B000AFAFAF00ACACAC00A5A5
      A500A2A2A2009F9F9F009E9E9E00A8A8A8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C009A9A9A009E9E
      9E00A5A5A500A1A1A1009F9F9F009C9C9C00A0A0A000AAAAAA00000000000000
      00000000000000000000000000000000000000000000AAAAAA009B9B9B009191
      91009C9C9C00ADADAD00A7A7A700A9A9A9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A1A1A1009797
      9700AFAFAF00A1A1A100A6A6A600B9B9B900B8B8B8009D9D9D009C9C9C009C9C
      9C009E9E9E00BBBBBB00AEAEAE00A5A5A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A8009494
      9400ACACAC009D9D9D00A0A0A000AAAAAA00BFBFBF00BDBDBD00B6B6B600A7A7
      A7009E9E9E009C9C9C00A0A0A000ABABAB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A6A6A60092929200B0B0
      B000A2A2A200A7A7A700A8A8A800A1A1A100B6B6B600ACACAC00AEAEAE00B0B0
      B000B0B0B000ABABAB00A5A5A500A2A2A2009F9F9F009E9E9E00AAAAAA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009B9B9B009A9A9A009E9E9E00B0B0
      B000B2B2B200B4B4B400B7B7B700B7B7B700B0B0B000A2A2A2009D9D9D00A2A2
      A200A2A2A2009F9F9F009F9F9F00A5A5A500A5A5A50096969600919191009999
      9900A7A7A700A9A9A900B9B9B900A4A4A4000000000000000000000000000000
      0000000000000000000000000000A0A0A0009B9B9B009E9E9E0093939300A0A0
      A000A1A1A1009B9B9B00A5A5A500B7B7B700B9B9B900B9B9B900BABABA00B6B6
      B600B5B5B500BABABA00B2B2B200A1A1A1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A0009696
      9600B1B1B1009C9C9C00A0A0A000A8A8A800BFBFBF00BDBDBD00AAAAAA00A7A7
      A700B2B2B200B3B3B300A5A5A5009E9E9E009C9C9C00A3A3A300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A30092929200B2B2
      B200A2A2A200A7A7A700AAAAAA009F9F9F00B5B5B500ACACAC00A9A9A900A9A9
      A900ABABAB00AEAEAE00B0B0B000B0B0B000AAAAAA00A4A4A400A2A2A2009E9E
      9E00A1A1A100AAAAAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C00A2A2A2009E9E9E00ABABAB00AEAE
      AE00ACACAC00AEAEAE00B2B2B200B5B5B500B7B7B700AEAEAE009B9B9B009696
      9600959595009B9B9B009B9B9B009A9A9A009797970093939300A0A0A000ACAC
      AC00B1B1B100BCBCBC00A8A8A800ADADAD000000000000000000000000000000
      00000000000000000000A0A0A000959595009E9E9E00A6A6A6009F9F9F009C9C
      9C009C9C9C00ADADAD00B7B7B700B4B4B400B0B0B000AFAFAF00AFAFAF00B0B0
      B000B4B4B400B7B7B700B5B5B5009C9C9C00A5A5A50000000000000000000000
      00000000000000000000000000000000000000000000000000009B9B9B009999
      9900B0B0B0009C9C9C00A0A0A000A6A6A600BFBFBF00BDBDBD00A8A8A8009B9B
      9B009B9B9B009C9C9C00A0A0A000B9B9B900B0B0B000A3A3A3009C9C9C009C9C
      9C00A5A5A5000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A30091919100B2B2
      B200A1A1A100A7A7A700ADADAD009F9F9F00B1B1B100ADADAD00AAAAAA00A9A9
      A900A8A8A800A7A7A700A7A7A700AAAAAA00AEAEAE00B0B0B000AEAEAE00A8A8
      A800A3A3A300A2A2A2009E9E9E00A2A2A2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A1A1A10099999900B8B8B800A5A5A5009B9B9B00A9A9
      A9009B9B9B00AEAEAE00B0B0B000AEAEAE009D9D9D009494940094949400A2A2
      A200BABABA00BEBEBE00BABABA00BABABA00BCBCBC00A2A2A20095959500A1A1
      A100B4B4B400B2B2B200A9A9A900000000000000000000000000000000000000
      000000000000A6A6A600949494009E9E9E00A1A1A100B3B3B300B3B3B300ADAD
      AD00B0B0B000B4B4B400AFAFAF00ACACAC00AFAFAF00B3B3B300B2B2B200B0B0
      B000AEAEAE00ADADAD00B2B2B200B5B5B5009F9F9F00999999009E9E9E00A5A5
      A5000000000000000000000000000000000000000000000000009B9B9B009797
      9700B1B1B1009C9C9C009F9F9F00A5A5A500BFBFBF00BDBDBD00ACACAC009B9B
      9B009C9C9C009C9C9C009B9B9B00B7B7B700B5B5B500A3A3A300B1B1B100AFAF
      AF00A3A3A3009C9C9C009F9F9F00A6A6A6000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A30094949400B0B0
      B000A1A1A100A8A8A800AEAEAE009F9F9F00AEAEAE00B0B0B000A9A9A900A9A9
      A900A8A8A800A8A8A800A7A7A700A6A6A600A6A6A600A6A6A600AAAAAA00AEAE
      AE00B0B0B000AEAEAE00A8A8A800A4A4A400A2A2A2009D9D9D00A4A4A4000000
      000000000000000000000000000000000000000000000000000000000000A2A2
      A2009D9D9D009F9F9F0096969600ADADAD00BCBCBC00BEBEBE00ADADAD009B9B
      9B009A9A9A00B4B4B400B3B3B3009B9B9B009595950095959500A8A8A800BCBC
      BC00BABABA00B8B8B800B2B2B200AAAAAA00B0B0B000BCBCBC00AFAFAF009898
      9800A0A0A000A5A5A50000000000000000000000000000000000000000000000
      00000000000099999900ACACAC00ADADAD009C9C9C00AFAFAF00B0B0B000B1B1
      B100B1B1B100ADADAD00AFAFAF00B9B9B900B9B9B900B7B7B700B4B4B400B2B2
      B200B0B0B000ADADAD00ADADAD00AFAFAF00B4B4B400A8A8A800B2B2B2009E9E
      9E00ACACAC0000000000000000000000000000000000000000009D9D9D009696
      9600B1B1B1009C9C9C009F9F9F00A3A3A300BFBFBF00BDBDBD00ADADAD009B9B
      9B009C9C9C009C9C9C009B9B9B00B5B5B500B5B5B5009B9B9B009A9A9A00ACAC
      AC00ABABAB00B3B3B300ACACAC00A1A1A1009C9C9C009F9F9F00AAAAAA000000
      00000000000000000000000000000000000000000000A0A0A00094949400B1B1
      B100A0A0A000A8A8A800B0B0B000A0A0A000ACACAC00B3B3B300A9A9A900A9A9
      A900A8A8A800A8A8A800A7A7A700A6A6A600A6A6A600A6A6A600A5A5A500A5A5
      A500A6A6A600AAAAAA00AEAEAE00B0B0B000ADADAD00A7A7A700A3A3A300A2A2
      A200A0A0A0000000000000000000000000000000000000000000A6A6A6009393
      9300ABABAB009D9D9D00A1A1A1009B9B9B009A9A9A00A1A1A100B3B3B300B8B8
      B8009D9D9D00B0B0B000A0A0A00095959500969696009D9D9D00B8B8B800BABA
      BA00BCBCBC00BCBCBC00BCBCBC00B7B7B700B2B2B200B5B5B500BCBCBC00A9A9
      A9009D9D9D000000000000000000000000000000000000000000000000000000
      0000A2A2A20097979700BCBCBC00BCBCBC00A2A2A2009D9D9D00B0B0B000B0B0
      B000ADADAD00AFAFAF00BBBBBB00B9B9B900B7B7B700B4B4B400B2B2B200B0B0
      B000AFAFAF00ADADAD00AEAEAE00AFAFAF00ADADAD00B3B3B300B3B3B300A6A6
      A600A3A3A30000000000000000000000000000000000000000009E9E9E009494
      9400B1B1B1009C9C9C009F9F9F00A2A2A200BFBFBF00BDBDBD00B0B0B0009B9B
      9B009B9B9B009C9C9C009B9B9B00B4B4B400B9B9B900B4B4B400A8A8A800AAAA
      AA009B9B9B009B9B9B00ACACAC00AEAEAE00B3B3B300ABABAB009F9F9F00AAAA
      AA000000000000000000000000000000000000000000A0A0A00094949400B0B0
      B000A0A0A000A8A8A800B0B0B000A1A1A100A7A7A700B6B6B600A9A9A900A9A9
      A900A8A8A800A8A8A800A7A7A700A6A6A600A6A6A600A6A6A600A5A5A500A6A6
      A600A5A5A500A5A5A500A5A5A500A6A6A600A9A9A900AEAEAE00B0B0B000ADAD
      AD00A6A6A600ACACAC000000000000000000000000000000000099999900A4A4
      A400ACACAC009B9B9B00B2B2B200A8A8A800A4A4A400A0A0A0009C9C9C009B9B
      9B009B9B9B009B9B9B00959595009D9D9D0095959500AFAFAF00B3B3B300BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00B5B5B500B5B5B500BCBCBC00BCBC
      BC0098989800AAAAAA0000000000000000000000000000000000000000000000
      0000A3A3A30093939300BABABA00BBBBBB00A9A9A9009B9B9B00AFAFAF00AFAF
      AF00ADADAD00B8B8B800B8B8B800B9B9B900B7B7B700B6B6B600B4B4B400B3B3
      B300B0B0B000AEAEAE00AFAFAF00B0B0B000B0B0B000AFAFAF00B0B0B0009C9C
      9C00ADADAD0000000000000000000000000000000000000000009F9F9F009494
      9400B1B1B1009D9D9D009F9F9F00A2A2A200BFBFBF00BCBCBC00BBBBBB00B6B6
      B600ACACAC00A3A3A3009B9B9B00B0B0B000B8B8B800A4A4A400AFAFAF00B7B7
      B700B2B2B200A5A5A500A8A8A8009B9B9B009B9B9B00B2B2B200ABABAB00A7A7
      A7000000000000000000000000000000000000000000A0A0A00094949400B0B0
      B000A0A0A000A8A8A800B1B1B100A2A2A200A4A4A400B7B7B700ABABAB00AAAA
      AA00A8A8A800A8A8A800A7A7A700A6A6A600A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A5A5A500A6A6A600A9A9
      A900ADADAD00AAAAAA00000000000000000000000000AAAAAA0096969600AAAA
      AA00ABABAB009A9A9A00B0B0B000A9A9A900AFAFAF00ACACAC00AAAAAA00A9A9
      A900A3A3A3008D8D8D009D9D9D009C9C9C0096969600AFAFAF00B5B5B500BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BABABA00BABABA00BCBCBC00BCBC
      BC00AAAAAA009E9E9E0000000000000000000000000000000000000000000000
      0000000000009C9C9C0094949400AFAFAF009E9E9E009D9D9D00AFAFAF00ADAD
      AD00B0B0B000B6B6B600B9B9B900BBBBBB00BABABA00B6B6B600A8A8A800A3A3
      A300A9A9A900AFAFAF00AFAFAF00B0B0B000B3B3B300AFAFAF00B0B0B0009D9D
      9D000000000000000000000000000000000000000000000000009F9F9F009393
      9300B1B1B1009F9F9F009E9E9E00A1A1A100BFBFBF00BCBCBC00BBBBBB00B9B9
      B900BBBBBB00BBBBBB00B9B9B900B9B9B900B9B9B9009B9B9B009A9A9A00A0A0
      A000AAAAAA00AFAFAF00B6B6B600AFAFAF00A2A2A200AFAFAF00AFAFAF00A3A3
      A3000000000000000000000000000000000000000000A0A0A00094949400B1B1
      B1009F9F9F00A9A9A900B0B0B000A3A3A300A2A2A200B7B7B700ACACAC00ACAC
      AC00AAAAAA00A8A8A800A7A7A700A6A6A600A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A6A6A600A5A5A500A4A4
      A400ACACAC00A6A6A600000000000000000000000000AAAAAA0096969600A6A6
      A600ADADAD009A9A9A00AEAEAE00A8A8A800B2B2B200B0B0B000ADADAD00AFAF
      AF00A5A5A50090909000A8A8A8009B9B9B0099999900AFAFAF00B3B3B300B3B3
      B300B0B0B000B0B0B000B0B0B000AEAEAE00AAAAAA00AAAAAA00AEAEAE00B3B3
      B300B3B3B3009999990000000000000000000000000000000000000000000000
      000000000000A5A5A50092929200A3A3A3009C9C9C00A3A3A300AEAEAE00ADAD
      AD00B3B3B300B4B4B400BBBBBB00BBBBBB00B8B8B8009C9C9C009C9C9C00A5A5
      A500A0A0A0009C9C9C00AEAEAE00B0B0B000B2B2B200B3B3B300AEAEAE00A6A6
      A600A6A6A6000000000000000000000000000000000000000000A0A0A0009292
      9200B1B1B1009F9F9F009E9E9E00A1A1A100BDBDBD00BCBCBC00B3B3B3009B9B
      9B00A0A0A000A5A5A500ADADAD00B3B3B300B9B9B900B2B2B200A7A7A700A2A2
      A200A2A2A2009A9A9A00A0A0A000AAAAAA00AFAFAF00B4B4B400B2B2B200A0A0
      A00000000000000000000000000000000000000000009E9E9E0098989800B0B0
      B0009F9F9F00A9A9A900B0B0B000A6A6A600A1A1A100B5B5B500ADADAD00ACAC
      AC00ACACAC00AAAAAA00A8A8A800A6A6A600A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A6A6A600A5A5A500A4A4
      A400AAAAAA00A4A4A4000000000000000000000000000000000096969600A6A6
      A600ADADAD009A9A9A00AEAEAE00A8A8A800B4B4B400B6B6B600B7B7B700B4B4
      B400A1A1A10093939300ACACAC009C9C9C0099999900A8A8A800A7A7A700A8A8
      A800A9A9A900ABABAB00ABABAB00ABABAB00ABABAB00ABABAB00A5A5A500A2A2
      A200ACACAC00969696000000000000000000000000000000000000000000AAAA
      AA009E9E9E009B9B9B009C9C9C009D9D9D009C9C9C00A9A9A900AEAEAE00ADAD
      AD00B2B2B200B4B4B400B9B9B900BBBBBB00A6A6A600A1A1A100BCBCBC00BFBF
      BF00BFBFBF00ACACAC009F9F9F00B0B0B000B2B2B200B4B4B400AFAFAF00ACAC
      AC009B9B9B00A1A1A10000000000000000000000000000000000A1A1A1009292
      9200B1B1B1009F9F9F009D9D9D00A1A1A100BDBDBD00BCBCBC00B7B7B7009D9D
      9D009D9D9D009D9D9D009C9C9C00A6A6A600B9B9B900AEAEAE00B3B3B300B7B7
      B700B4B4B400A8A8A800A2A2A200A2A2A2009A9A9A00A4A4A400B4B4B4009F9F
      9F0000000000000000000000000000000000000000009E9E9E0097979700B0B0
      B0009F9F9F00A9A9A900B0B0B000A8A8A8009F9F9F00B1B1B100AEAEAE00ACAC
      AC00ABABAB00ACACAC00ABABAB00A8A8A800A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A6A6A600A5A5A500A4A4
      A400A8A8A800A3A3A3000000000000000000000000000000000096969600A4A4
      A400ADADAD009B9B9B00ACACAC00A7A7A700B0B0B000B2B2B200B1B1B100B2B2
      B200A1A1A10093939300AEAEAE009D9D9D0095959500A2A2A200ACACAC00AFAF
      AF00B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000AFAFAF00AEAE
      AE00AFAFAF009999990000000000000000000000000000000000000000009B9B
      9B00A0A0A0009F9F9F009F9F9F00AFAFAF00B0B0B000B0B0B000AEAEAE00ADAD
      AD00B0B0B000B3B3B300B8B8B800B9B9B9009E9E9E0093939300A4A4A400BDBD
      BD00B8B8B800B6B6B6009C9C9C00B0B0B000B2B2B200B5B5B500B3B3B300ADAD
      AD00AEAEAE00A4A4A400A6A6A600000000000000000000000000A1A1A1009292
      9200B1B1B100A0A0A0009D9D9D00A1A1A100BBBBBB00BCBCBC00BBBBBB00BBBB
      BB00B7B7B700B0B0B000A7A7A700A9A9A900B9B9B900A2A2A2009B9B9B009C9C
      9C00AFAFAF00AFAFAF00B5B5B500B4B4B400AAAAAA00A5A5A500B5B5B5009E9E
      9E0000000000000000000000000000000000000000009D9D9D0099999900B0B0
      B0009F9F9F00A9A9A900B1B1B100A9A9A900A0A0A000AEAEAE00B0B0B000ACAC
      AC00ABABAB00ACACAC00ACACAC00ABABAB00ABABAB00A8A8A800A5A5A500A5A5
      A500A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A6A6A600A5A5A500A5A5
      A500A4A4A400A5A5A5000000000000000000000000000000000099999900A4A4
      A400ADADAD009B9B9B00ACACAC00A6A6A600B4B4B400B7B7B700B7B7B700B6B6
      B600A7A7A70092929200AFAFAF00A7A7A70096969600ABABAB00AEAEAE00AFAF
      AF00B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000B0B0B000AFAF
      AF00B4B4B4009B9B9B0000000000000000000000000000000000A6A6A6009393
      9300B0B0B0009E9E9E00A3A3A300B2B2B200AFAFAF00AFAFAF00AEAEAE00ADAD
      AD00AFAFAF00B2B2B200B6B6B600B8B8B8009E9E9E009D9D9D0095959500ACAC
      AC00B0B0B000ADADAD009E9E9E00ACACAC00B3B3B300B4B4B400B5B5B500ADAD
      AD00B0B0B000B0B0B000A2A2A200000000000000000000000000A2A2A2009292
      9200B1B1B100A1A1A1009C9C9C00A1A1A100B9B9B900BDBDBD00BCBCBC00BABA
      BA00BCBCBC00BCBCBC00BBBBBB00B9B9B900B9B9B900AEAEAE009F9F9F009B9B
      9B00ABABAB009A9A9A009B9B9B00ADADAD00AAAAAA00B2B2B200B6B6B6009E9E
      9E0000000000000000000000000000000000000000009D9D9D0098989800AEAE
      AE009F9F9F00AAAAAA00B1B1B100ADADAD009F9F9F00ABABAB00B2B2B200ABAB
      AB00ABABAB00ACACAC00ACACAC00ABABAB00ABABAB00ADADAD00ADADAD00AAAA
      AA00A7A7A700A5A5A500A5A5A500A5A5A500A6A6A600A6A6A600A5A5A500A5A5
      A500A2A2A200A5A5A500ABABAB0000000000000000000000000099999900A0A0
      A000AFAFAF009B9B9B00AAAAAA00A5A5A500B0B0B000B2B2B200B1B1B100B4B4
      B400ACACAC0092929200AEAEAE00B3B3B30095959500A4A4A400AEAEAE00B1B1
      B100B1B1B100B3B3B300B3B3B300B6B6B600B3B3B300B3B3B300B1B1B100B1B1
      B100AFAFAF00A0A0A00000000000000000000000000000000000A4A4A4009292
      9200B2B2B2009E9E9E009E9E9E00AFAFAF00B2B2B200B0B0B000AFAFAF00ADAD
      AD00AFAFAF00B0B0B000B4B4B400B7B7B700A2A2A2009C9C9C00999999009A9A
      9A00A9A9A900A5A5A5009C9C9C00AEAEAE00B4B4B400B6B6B600B7B7B700ADAD
      AD00ADADAD00A2A2A200A1A1A100000000000000000000000000A4A4A4009292
      9200B1B1B100A3A3A3009C9C9C00A1A1A100B9B9B900BDBDBD00BBBBBB009B9B
      9B009D9D9D00A2A2A200A8A8A800ACACAC00B9B9B900B7B7B700B9B9B900B7B7
      B700B5B5B500A6A6A6009D9D9D00ABABAB009A9A9A009B9B9B00B5B5B500A3A3
      A300ACACAC00000000000000000000000000000000009D9D9D0098989800B1B1
      B1009F9F9F00ABABAB00B1B1B100AEAEAE00A0A0A000A9A9A900B4B4B400ABAB
      AB00ABABAB00ABABAB00ACACAC00ABABAB00ABABAB00ACACAC00ACACAC00ADAD
      AD00AEAEAE00AEAEAE00ACACAC00A9A9A900A7A7A700A5A5A500A5A5A500A5A5
      A500A2A2A200A7A7A700A9A9A90000000000000000000000000099999900A0A0
      A000AFAFAF009B9B9B00AAAAAA00A4A4A400B1B1B100B5B5B500B5B5B500B5B5
      B500B3B3B3009A9A9A009E9E9E00B7B7B700A4A4A40095959500AFAFAF00B1B1
      B100B3B3B300B8B8B800BABABA00BCBCBC00BCBCBC00B8B8B800B3B3B300B6B6
      B6009D9D9D00AAAAAA0000000000000000000000000000000000A5A5A5009292
      9200B4B4B400ACACAC009C9C9C009B9B9B009C9C9C00A5A5A500B0B0B000AFAF
      AF00B0B0B000AFAFAF00B4B4B400B4B4B400B0B0B0009D9D9D00939393009898
      98009B9B9B00979797009C9C9C00B4B4B400B5B5B500B8B8B800B8B8B800AFAF
      AF00A1A1A1009E9E9E00ACACAC00000000000000000000000000A4A4A4009292
      9200AFAFAF00A3A3A3009C9C9C00A1A1A100B6B6B600BDBDBD00BCBCBC009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B00B9B9B900ACACAC009B9B9B009F9F
      9F00B2B2B200B2B2B200B6B6B600B6B6B600ADADAD00A5A5A500B3B3B300A7A7
      A700A9A9A900000000000000000000000000000000009B9B9B00A0A0A000B0B0
      B0009F9F9F00ABABAB00B1B1B100AEAEAE00A0A0A000A6A6A600B6B6B600ABAB
      AB00ABABAB00ABABAB00ACACAC00ABABAB00ABABAB00ACACAC00ACACAC00ADAD
      AD00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1B100B2B2B200AEAEAE00A7A7
      A700A2A2A200A8A8A800A5A5A500000000000000000000000000999999009D9D
      9D00AFAFAF009D9D9D00A6A6A600A4A4A400B0B0B000B5B5B500B5B5B500B5B5
      B500B5B5B500ABABAB0094949400B0B0B000BCBCBC009999990098989800B3B3
      B300B7B7B700BABABA00BCBCBC00BEBEBE00BEBEBE00BCBCBC00BCBCBC00A8A8
      A800A0A0A0000000000000000000000000000000000000000000A8A8A8009797
      9700B1B1B100BFBFBF00BFBFBF00BBBBBB00A5A5A5009C9C9C00B3B3B300B0B0
      B000B0B0B000B1B1B100B2B2B200B3B3B300B4B4B400A9A9A9009C9C9C009898
      9800979797009C9C9C00AAAAAA00B5B5B500B5B5B500B9B9B900B7B7B700B4B4
      B4009F9F9F00ACACAC0000000000000000000000000000000000A4A4A4009292
      9200AFAFAF00A5A5A5009C9C9C00A1A1A100B4B4B400BDBDBD00BDBDBD00B6B6
      B600B2B2B200ACACAC00A5A5A500A0A0A000B8B8B800B1B1B1009B9B9B009A9A
      9A00A8A8A8009B9B9B009B9B9B00AAAAAA00AAAAAA00AEAEAE00B4B4B400ACAC
      AC00A6A6A600000000000000000000000000000000009A9A9A00A0A0A000ADAD
      AD009F9F9F00ABABAB00B0B0B000B0B0B000A2A2A200A4A4A400B5B5B500ABAB
      AB00ABABAB00ABABAB00ACACAC00ABABAB00ABABAB00ACACAC00ACACAC00ADAD
      AD00ADADAD00AEAEAE00AFAFAF00AFAFAF00B0B0B000B1B1B100B2B2B200B3B3
      B300A9A9A900A4A4A400A3A3A3000000000000000000000000009B9B9B009C9C
      9C00B0B0B0009D9D9D00A6A6A600A5A5A500B0B0B000B6B6B600B6B6B600B6B6
      B600B6B6B600B5B5B500A5A5A50093939300B6B6B600BCBCBC009B9B9B009696
      9600AEAEAE00BCBCBC00BEBEBE00BEBEBE00BEBEBE00BCBCBC00A4A4A4009C9C
      9C0000000000000000000000000000000000000000000000000000000000AAAA
      AA00A5A5A5009A9A9A0095959500B7B7B700AFAFAF009B9B9B00B2B2B200B3B3
      B300B0B0B000B3B3B300B3B3B300B2B2B200B1B1B100B3B3B300B0B0B000A8A8
      A800A7A7A700B1B1B100B6B6B600B6B6B600B7B7B700BBBBBB00B3B3B300B4B4
      B4009D9D9D000000000000000000000000000000000000000000A6A6A6009292
      9200AEAEAE00A7A7A7009C9C9C00A1A1A100B2B2B200BDBDBD00BBBBBB00BBBB
      BB00BCBCBC00BBBBBB00BABABA00B8B8B800B8B8B800B7B7B700B5B5B500B1B1
      B100B1B1B100A0A0A0009B9B9B00A6A6A6009C9C9C009A9A9A00ACACAC00AFAF
      AF00A2A2A200000000000000000000000000000000009A9A9A00A0A0A000B0B0
      B0009F9F9F00ACACAC00B0B0B000AFAFAF00A3A3A300A1A1A100B4B4B400ACAC
      AC00ABABAB00ABABAB00ACACAC00ABABAB00ABABAB00ACACAC00ACACAC00ADAD
      AD00ADADAD00AEAEAE00AFAFAF00AFAFAF00B0B0B000B0B0B000B2B2B200B2B2
      B200B4B4B400A7A7A700A2A2A2000000000000000000000000009C9C9C009999
      9900B0B0B0009D9D9D00A4A4A400A5A5A500B0B0B000B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B4B4B400A9A9A90098989800A9A9A900BEBEBE00A9A9
      A9009595950097979700A0A0A000A2A2A2009D9D9D00989898009D9D9D000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A70094949400B0B0B000B6B6B6009D9D9D00A6A6A600B6B6
      B600B1B1B100B2B2B200B4B4B400B4B4B400B2B2B200B1B1B100B2B2B200B4B4
      B400B4B4B400B5B5B500B5B5B500B7B7B700B9B9B900BABABA00B1B1B100B7B7
      B700A5A5A500A1A1A10000000000000000000000000000000000A6A6A6009494
      9400ADADAD00A7A7A7009B9B9B00A2A2A200AFAFAF00BEBEBE00BBBBBB00BBBB
      BB00BDBDBD00BEBEBE00BEBEBE00BDBDBD00BBBBBB00B8B8B800B6B6B600B6B6
      B600B5B5B500B6B6B600B5B5B500B5B5B500ACACAC00A3A3A300AAAAAA00B2B2
      B200A0A0A0000000000000000000000000000000000099999900A3A3A300AEAE
      AE009F9F9F00ACACAC00B0B0B000AFAFAF00A5A5A500A1A1A100B1B1B100ADAD
      AD00ABABAB00ABABAB00ACACAC00ABABAB00ABABAB00ACACAC00ACACAC00ADAD
      AD00ADADAD00AEAEAE00AFAFAF00AFAFAF00B0B0B000B0B0B000B2B2B200B2B2
      B200B2B2B200B4B4B400A4A4A400AEAEAE0000000000000000009C9C9C009797
      9700B0B0B0009F9F9F00A2A2A200A8A8A800B0B0B000B6B6B600B6B6B600B7B7
      B700B7B7B700B7B7B700B7B7B700B7B7B700B4B4B400A9A9A900A1A1A100A0A0
      A000A7A7A700A3A3A3009F9F9F009E9E9E00A3A3A3009F9F9F00AAAAAA000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000999999009A9A9A00A5A5A5009C9C9C00A3A3A300B6B6
      B600B4B4B400B2B2B200B3B3B300B6B6B600B6B6B600B4B4B400B3B3B300B4B4
      B400B4B4B400B5B5B500B7B7B700B9B9B900BBBBBB00B3B3B300B4B4B400B7B7
      B700B9B9B9009D9D9D00ACACAC00000000000000000000000000A8A8A8009494
      9400ACACAC00ABABAB009B9B9B00A1A1A100A8A8A800BFBFBF00BBBBBB00B7B7
      B700A2A2A200A5A5A500A8A8A800ADADAD00B4B4B400BABABA00BEBEBE00BDBD
      BD00BDBDBD00B9B9B900B6B6B600B4B4B400B4B4B400B3B3B300B3B3B300B3B3
      B3009E9E9E000000000000000000000000000000000099999900A1A1A100ACAC
      AC009F9F9F00ACACAC00B0B0B000AFAFAF00A7A7A700A0A0A000AEAEAE00AEAE
      AE00ABABAB00ABABAB00ACACAC00ABABAB00ABABAB00ACACAC00ACACAC00ADAD
      AD00ADADAD00AEAEAE00AFAFAF00AFAFAF00B0B0B000B0B0B000B1B1B100B2B2
      B200B2B2B200B7B7B700A9A9A900ABABAB0000000000000000009E9E9E009595
      9500B0B0B0009F9F9F00A1A1A100A9A9A900ABABAB00B8B8B800B7B7B700B7B7
      B700B7B7B700B7B7B700B7B7B700B7B7B700B7B7B700B7B7B700B8B8B800B3B3
      B300AFAFAF00AFAFAF00A7A7A700A8A8A800A7A7A700A0A0A000A7A7A7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9A9A900959595009B9B9B009C9C9C009C9C9C00B4B4B400B7B7
      B700B6B6B600B4B4B400B1B1B100B4B4B400B7B7B700B8B8B800B8B8B800B7B7
      B700B8B8B800B9B9B900BABABA00BBBBBB00B5B5B500B3B3B300B7B7B700B6B6
      B600BABABA009D9D9D0000000000000000000000000000000000A8A8A8009494
      9400ADADAD00B2B2B2009C9C9C009F9F9F00A1A1A100BFBFBF00BBBBBB00BBBB
      BB00A5A5A500A5A5A500A5A5A500A5A5A500A4A4A400A3A3A300A3A3A300A5A5
      A500A9A9A900AEAEAE00B4B4B400BABABA00BDBDBD00BBBBBB00BABABA00B4B4
      B4009E9E9E00000000000000000000000000AAAAAA0099999900A5A5A500AFAF
      AF009F9F9F00AEAEAE00B0B0B000AFAFAF00A9A9A9009F9F9F00ACACAC00B0B0
      B000ABABAB00ABABAB00ACACAC00ACACAC00ABABAB00ABABAB00ADADAD00ADAD
      AD00ACACAC00AEAEAE00AFAFAF00AFAFAF00B0B0B000B0B0B000B1B1B100B2B2
      B200B2B2B200B5B5B500AFAFAF00A8A8A80000000000000000009E9E9E009595
      9500B0B0B000A1A1A1009F9F9F00AAAAAA00ABABAB00B8B8B800B7B7B700B7B7
      B700B7B7B700B7B7B700B7B7B700B8B8B800B8B8B800B8B8B800B8B8B800B8B8
      B800B1B1B100B3B3B300B2B2B200A8A8A800A7A7A700A2A2A200A4A4A4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009D9D9D00A6A6A6009C9C9C00AAAAAA00B9B9B900B7B7
      B700B7B7B700B7B7B700B6B6B600B2B2B200B3B3B300B7B7B700B9B9B900BABA
      BA00BBBBBB00BBBBBB00B8B8B800B3B3B300B4B4B400B9B9B900A3A3A300A1A1
      A100A1A1A100A3A3A30000000000000000000000000000000000000000009898
      98009E9E9E00B6B6B6009F9F9F009D9D9D00A1A1A100B9B9B900BDBDBD00BBBB
      BB00ABABAB00A5A5A500A5A5A500A5A5A500A5A5A500A6A6A600A5A5A500A5A5
      A500A5A5A500A4A4A400A4A4A400A4A4A400A4A4A400A6A6A600AAAAAA00BABA
      BA00A0A0A000ACACAC000000000000000000A9A9A90097979700A7A7A700ADAD
      AD009F9F9F00AEAEAE00B0B0B000AFAFAF00ABABAB00A0A0A000ABABAB00B7B7
      B700B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B4B4
      B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B4B4B400B3B3
      B300B4B4B400B1B1B100AFAFAF00A5A5A50000000000000000009E9E9E009393
      9300B0B0B000A2A2A2009F9F9F00ABABAB00ABABAB00B9B9B900B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800B8B8
      B800B4B4B400B3B3B300B3B3B300B2B2B200A8A8A800A6A6A600A1A1A1000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099999900A4A4A400BBBBBB00A0A0A0009E9E9E00B9B9B900B9B9
      B900AEAEAE00A9A9A900B9B9B900B8B8B800B5B5B500B3B3B300B2B2B200B3B3
      B300B3B3B300B3B3B300B3B3B300B6B6B600B9B9B900A9A9A9009C9C9C00A5A5
      A500A7A7A700AFAFAF0000000000000000000000000000000000000000009F9F
      9F0092929200B6B6B600A8A8A8009B9B9B00A1A1A100B0B0B000BDBDBD00BBBB
      BB00B4B4B400A5A5A500A4A4A400A3A3A300A4A4A400A4A4A400A5A5A500A5A5
      A500A5A5A500A5A5A500A6A6A600A6A6A600A6A6A600A5A5A500A5A5A500BBBB
      BB00ABABAB00A4A4A4000000000000000000A9A9A90097979700A5A5A500ABAB
      AB009F9F9F00AEAEAE00B0B0B000AFAFAF00ACACAC00A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A1A1A100A1A1A100A1A1A100A1A1A100A2A2A200A2A2A200A2A2
      A200A4A4A400A4A4A400A5A5A500A6A6A6000000000000000000A1A1A1009393
      9300B0B0B000A2A2A2009D9D9D00AFAFAF00ABABAB00B9B9B900B9B9B900B9B9
      B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900B9B9B900B4B4B400B4B4B400B4B4B400B2B2B200A8A8A8009F9F9F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A50094949400B4B4B400BBBBBB009C9C9C00A2A2A200A3A3
      A3009E9E9E009C9C9C00A0A0A000B3B3B300B9B9B900B9B9B900B8B8B800B7B7
      B700B7B7B700B9B9B900B9B9B900B9B9B900BABABA009D9D9D00AAAAAA000000
      000000000000000000000000000000000000000000000000000000000000A6A6
      A60094949400B0B0B000B1B1B1009B9B9B009F9F9F00A5A5A500BFBFBF00BBBB
      BB00BABABA00B9B9B900B9B9B900B8B8B800B5B5B500B2B2B200AEAEAE00AAAA
      AA00A8A8A800A5A5A500A4A4A400A4A4A400A5A5A500A5A5A500A5A5A500B0B0
      B000B4B4B4009E9E9E000000000000000000A8A8A80097979700A9A9A900AEAE
      AE009F9F9F00AEAEAE00B0B0B000AFAFAF00ADADAD00A7A7A700A7A7A700A7A7
      A700A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A6A6A600A5A5A500A5A5A500A5A5
      A500A4A4A4009D9D9D00A6A6A600000000000000000000000000A1A1A1009393
      9300B0B0B000A5A5A5009D9D9D00B0B0B000A6A6A600A8A8A800A8A8A800A8A8
      A800A8A8A800A8A8A800AAAAAA00AAAAAA00AAAAAA00ACACAC00AEAEAE00AEAE
      AE00AFAFAF00AFAFAF00AFAFAF00B1B1B100B1B1B100AFAFAF009F9F9F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A20094949400B7B7B700B9B9B900A1A1A1009898
      9800B1B1B100BFBFBF00A7A7A7009C9C9C00B3B3B300B9B9B900BABABA00B8B8
      B800B8B8B800B3B3B300B0B0B000BBBBBB00BCBCBC00A0A0A000ADADAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000098989800A1A1A100B5B5B5009E9E9E009D9D9D00A2A2A200BDBDBD00BDBD
      BD00BBBBBB00BABABA00B9B9B900B9B9B900B6B6B600B6B6B600B6B6B600B6B6
      B600B4B4B400B4B4B400B3B3B300B3B3B300B1B1B100AEAEAE00ABABAB00AAAA
      AA00B9B9B900A0A0A000ACACAC0000000000A8A8A80097979700A9A9A900ACAC
      AC009F9F9F00AEAEAE00B1B1B100B0B0B000B0B0B000AEAEAE00ADADAD00ABAB
      AB00A9A9A900A7A7A700A5A5A500A3A3A300A2A2A200A6A6A600A6A6A600A5A5
      A500A6A6A600A6A6A600A6A6A600A5A5A500A6A6A600A5A5A500A6A6A600A5A5
      A500A4A4A400A8A8A80000000000000000000000000000000000A2A2A2009292
      9200B0B0B000A5A5A5009B9B9B00B5B5B500B2B2B200B0B0B000B0B0B000AFAF
      AF00AFAFAF00AEAEAE00AEAEAE00ACACAC00ACACAC00ACACAC00ABABAB00ABAB
      AB00ABABAB00ABABAB00ABABAB00ACACAC00ACACAC00AEAEAE009D9D9D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A9A9A900A6A6A600A8A8A80000000000A0A0
      A00090909000ADADAD00ADADAD009E9E9E00B2B2B200BABABA00BBBBBB00A0A0
      A0009B9B9B009C9C9C009E9E9E00B5B5B500BDBDBD00A2A2A200ABABAB000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009E9E9E0094949400B6B6B600A7A7A7009C9C9C00A2A2A200A6A6A600B6B6
      B600BABABA00BCBCBC00BDBDBD00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BDBD
      BD00BDBDBD00BBBBBB00BABABA00B8B8B800B6B6B600B5B5B500B3B3B300B3B3
      B300B3B3B300ABABAB00A4A4A40000000000A8A8A80097979700A8A8A800ABAB
      AB009F9F9F00A9A9A900A8A8A800A5A5A500A3A3A300A2A2A200A2A2A200A2A2
      A200A2A2A200A2A2A200A2A2A200A4A4A400A0A0A000A5A5A500A6A6A600A5A5
      A500A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A4A4A400A4A4
      A400A3A3A300A9A9A90000000000000000000000000000000000A5A5A5009494
      9400B9B9B900B0B0B0009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E
      9E009E9E9E009E9E9E009E9E9E00A0A0A000A0A0A000A0A0A000A1A1A100A2A2
      A200A2A2A200A2A2A200A2A2A200A3A3A300A3A3A300A5A5A5009E9E9E00ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A4A4
      A40092929200ADADAD00AAAAAA009E9E9E00B2B2B200BDBDBD00B6B6B6009B9B
      9B00BBBBBB00BEBEBE00B6B6B600A3A3A3009F9F9F00A0A0A000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A4A4A40094949400B5B5B500B5B5B5009C9C9C009E9E9E009E9E9E009E9E
      9E009E9E9E009E9E9E009E9E9E00A0A0A000A0A0A000A2A2A200A4A4A400A5A5
      A500A8A8A800AAAAAA00ADADAD00B0B0B000B2B2B200B5B5B500B8B8B800B9B9
      B900BCBCBC00BBBBBB009E9E9E0000000000A9A9A90099999900AEAEAE00B4B4
      B400A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A4A4A400A2A2A200A1A1
      A1009B9B9B009A9A9A00BDBDBD00BDBDBD00A7A7A700A1A1A100A5A5A500A5A5
      A500A4A4A400A4A4A400A3A3A300A3A3A300A3A3A300A4A4A400A3A3A300A0A0
      A000A0A0A000ACACAC000000000000000000000000000000000000000000A5A5
      A5009E9E9E009E9E9E009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009B9B9B009B9B9B009B9B9B009D9D9D00A5A5A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A6A6
      A60095959500B4B4B400B7B7B700A6A6A6009F9F9F00A7A7A700A5A5A5009898
      98009A9A9A00A2A2A200AFAFAF00ABABAB00A1A1A10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009F9F9F009B9B9B00AAAAAA00A4A4A4009F9F9F00A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A0009F9F9F009E9E9E009E9E9E009E9E
      9E009E9E9E009E9E9E009D9D9D009E9E9E009E9E9E009E9E9E009E9E9E009E9E
      9E009E9E9E009E9E9E00A0A0A0000000000000000000A9A9A900A3A3A300A0A0
      A000A1A1A100A3A3A300A6A6A600AAAAAA000000000000000000000000000000
      000000000000A0A0A0009B9B9B00B6B6B600BCBCBC00ABABAB00A3A3A300A4A4
      A400A3A3A300A0A0A000A0A0A000A0A0A000A4A4A400A9A9A900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A8A8A800A2A2A2009B9B9B009C9C9C00A0A0A000A0A0A000A3A3A3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AAAAAA00A8A8A800A7A7A700A6A6A600A4A4
      A400A2A2A200A1A1A100A0A0A0009F9F9F009E9E9E009D9D9D009C9C9C009B9B
      9B009C9C9C009D9D9D009D9D9D009E9E9E009E9E9E009E9E9E00A0A0A000A2A2
      A2009E9E9E00A7A7A70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A9A9A900A6A6A600A3A3A300A4A4A400A9A9
      A900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AAAAAA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00AAAAAA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000400000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFF8FFFFF0000000000000000C0000003FF03FFFF0000000000000000
      C0000003FF00FFFF0000000000000000C0000003FE007C7F0000000000000000
      C0000003FC00303F0000000000000000C0000003FC00001F0000000000000000
      C0000003FC00000F0000000000000000C0000003FC00001F0000000000000000
      C0000003FF00001F0000000000000000C0000003FFC0003F0000000000000000
      C0000003FFE0007F0000000000000000C0000003FFE000FF0000000000000000
      C0000003FF80007F0000000000000000C0000003FF00003F0000000000000000
      C0000003FE00001F0000000000000000C0000003FE00001F0000000000000000
      C0000003FE00001F0000000000000000C0000003FE00001F0000000000000000
      C0000003FF00003F0000000000000000C0000003FFC000FF0000000000000000
      C0000003FFF000FF0000000000000000C0000003FFF800FF0000000000000000
      C0000003FFF8007F0000000000000000C0000003FFF0007F0000000000000000
      C0000003FFF0007F0000000000000000C0000003FFF800FF0000000000000000
      C0000003FFF800FF0000000000000000C0000003FFFC01FF0000000000000000
      C0000003FFFF07FF0000000000000000FFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFF0000000000000000FDFFFFFFFFFFFFFFFFFCFFFFFEFFFFFF
      E03FFFFFFFFFFFFFFFE063FFE03FFFFFC007FFFFFFC1FFE1FFE000FFE007FFFF
      C000FFFFFF803F80FFC000FFC000FFFF80001FFFFF000000FE0000FFC0003FFF
      800003FFFE000000FC00007FC00007FF800000FFFC000001F800000FC00000FF
      8000001FE0000003F8000007C000001F80000007C0000007F0000007C000000F
      80000003C0000003F0000007C000000F8000000380000003F800000FC000000F
      8000000380000003F8000007C000000F80000003C0000003E0000003C000000F
      80000003C0000003E0000001C000000F80000003C0000003C0000001C000000F
      80000001C0000003C0000001C000000780000001C0000003C0000001C0000007
      80000001C0000007C0000003C000000780000001C000000FE0000007C0000007
      80000001C000001FF8000003C000000780000000C000001FFC000001C0000007
      80000000C000001FF8000003C000000700000000C000001FF8000003E0000003
      00000000C000001FF8000003E000000300000000C000001FF800001FE0000003
      00000001C000001FFC00001FF000000100000003C000001FFE20001FF0000001
      00000003C000000FFFE0003FF000000100000003E000001FFFE0007FF8000001
      80F8003FFFFFFFFFFFF01FFFFE000003FFFE0FFFFFFFFFFFFFFF7FFFFFFFFF9F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Left = 672
    Top = 144
    object N118: TMenuItem
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100
      OnClick = N118Click
    end
    object N119: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnClick = N119Click
    end
  end
end
