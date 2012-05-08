object Form9: TForm9
  Left = 281
  Top = 419
  AlphaBlend = True
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = #1047#1072#1093#1074#1072#1090' '#1082#1072#1076#1088#1086#1074
  ClientHeight = 394
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 84
    Height = 13
    Caption = #1069#1082#1089#1087#1086#1079#1080#1094#1080#1103', '#1084#1089'.'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 50
    Height = 13
    Caption = #1059#1089#1080#1083#1077#1085#1080#1077
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 68
    Height = 13
    Caption = #1055#1100#1077#1079#1086#1087#1088#1080#1074#1086#1076
  end
  object Bevel1: TBevel
    Left = 8
    Top = 297
    Width = 449
    Height = 17
    Shape = bsTopLine
  end
  object Label4: TLabel
    Left = 8
    Top = 343
    Width = 72
    Height = 13
    Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100
  end
  object Label5: TLabel
    Left = 146
    Top = 343
    Width = 175
    Height = 13
    Caption = #1055#1091#1090#1100' '#1076#1083#1103' '#1079#1072#1087#1080#1089#1080' '#1080#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084
  end
  object Label6: TLabel
    Left = 146
    Top = 362
    Width = 204
    Height = 13
    AutoSize = False
    Caption = 'xxxx'
  end
  object Label7: TLabel
    Left = 120
    Top = 102
    Width = 104
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1077#1077' '#1087#1086#1083#1086#1078#1077#1085#1080#1077
    Visible = False
  end
  object Label8: TLabel
    Left = 343
    Top = 102
    Width = 89
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1089#1076#1074#1080#1075#1072
    Visible = False
    OnDblClick = Label8DblClick
  end
  object Chart1: TChart
    Left = 8
    Top = 128
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
  object Button1: TButton
    Left = 181
    Top = 197
    Width = 75
    Height = 25
    Caption = #1047#1072#1093#1074#1072#1090
    TabOrder = 1
    Visible = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 194
    Top = 312
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
  object ScrollBar1: TScrollBar
    Left = 8
    Top = 64
    Width = 385
    Height = 17
    Max = 500
    Min = 1
    PageSize = 0
    Position = 1
    TabOrder = 3
    OnChange = ScrollBar1Change
  end
  object ScrollBar2: TScrollBar
    Left = 8
    Top = 104
    Width = 385
    Height = 17
    Max = 2047
    PageSize = 0
    TabOrder = 4
    OnChange = ScrollBar2Change
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 320
    Width = 13
    Height = 17
    TabOrder = 5
    Visible = False
    OnClick = CheckBox1Click
  end
  object Button3: TButton
    Left = 275
    Top = 312
    Width = 75
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 113
    Top = 312
    Width = 75
    Height = 25
    Caption = #1047#1072#1093#1074#1072#1090
    TabOrder = 7
    OnClick = Button4Click
  end
  object ScrollBar3: TScrollBar
    Left = 8
    Top = 362
    Width = 118
    Height = 17
    Max = 255
    PageSize = 0
    TabOrder = 8
    OnChange = ScrollBar3Change
  end
  object Button5: TButton
    Left = 440
    Top = 359
    Width = 17
    Height = 21
    Caption = '...'
    TabOrder = 9
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 6
    Top = 97
    Width = 32
    Height = 25
    Caption = '<--'
    TabOrder = 10
    Visible = False
    OnClick = Button6Click
  end
  object Button9: TButton
    Left = 44
    Top = 97
    Width = 32
    Height = 25
    Caption = '"0"'
    TabOrder = 11
    Visible = False
    OnClick = Button9Click
  end
  object Button7: TButton
    Left = 82
    Top = 97
    Width = 32
    Height = 25
    Caption = '-->'
    TabOrder = 12
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 257
    Top = 97
    Width = 80
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 13
    Visible = False
    OnClick = Button8Click
  end
  object Button10: TButton
    Left = 439
    Top = 326
    Width = 18
    Height = 24
    Caption = '...'
    TabOrder = 14
    Visible = False
    OnClick = Button10Click
  end
end
