object DirectShowVideoForm: TDirectShowVideoForm
  Left = 441
  Top = 372
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1080#1089#1100' '#1080#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084
  ClientHeight = 333
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 29
    Top = 8
    Width = 67
    Height = 13
    Caption = #1055#1100#1077#1079#1086#1087#1088#1080#1074#1086#1076
  end
  object Label1: TLabel
    Left = 427
    Top = 31
    Width = 3
    Height = 13
  end
  object Bevel1: TBevel
    Left = 8
    Top = 272
    Width = 449
    Height = 17
    Shape = bsTopLine
  end
  object Chart1: TChart
    Left = 12
    Top = 104
    Width = 449
    Height = 161
    AllowPanning = pmNone
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.ExactDateTime = False
    BottomAxis.Grid.Visible = False
    BottomAxis.Maximum = 255.000000000000000000
    LeftAxis.Visible = False
    TopAxis.Axis.Visible = False
    TopAxis.Grid.Visible = False
    TopAxis.MinorTicks.Visible = False
    TopAxis.Ticks.Visible = False
    TopAxis.TicksInner.Visible = False
    View3D = False
    View3DOptions.Elevation = 332
    View3DWalls = False
    Zoom.Allow = False
    BevelOuter = bvNone
    TabOrder = 0
    object Series1: TAreaSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      ShowInLegend = False
      AreaLinesPen.Color = clGreen
      AreaLinesPen.Visible = False
      Dark3D = False
      DrawArea = True
      LinePen.Color = clGreen
      LinePen.Visible = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object ScrollBar2: TScrollBar
    Left = 29
    Top = 27
    Width = 385
    Height = 17
    Max = 2047
    PageSize = 0
    TabOrder = 1
    OnChange = ScrollBar2Change
  end
  object Button1: TButton
    Left = 29
    Top = 61
    Width = 154
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1074#1080#1076#1077#1086#1082#1072#1084#1077#1088#1099
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 90
    Top = 295
    Width = 75
    Height = 25
    Caption = #1047#1072#1093#1074#1072#1090
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 195
    Top = 295
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 299
    Top = 295
    Width = 75
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 5
    OnClick = Button4Click
  end
  object PopupMenu1: TPopupMenu
    Left = 389
    Top = 54
    object CaprurewithAveraging1: TMenuItem
      Caption = 'Caprure with Averaging'
      ShortCut = 112
      OnClick = CaprurewithAveraging1Click
    end
    object N1: TMenuItem
      Caption = #1054#1073#1085#1091#1083#1080#1090#1100' '#1089#1095#1077#1090#1095#1080#1082
      OnClick = N1Click
    end
  end
end
