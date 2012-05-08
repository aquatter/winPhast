object Form5: TForm5
  Left = 552
  Top = 519
  BorderStyle = bsDialog
  Caption = #1043#1088#1072#1092#1080#1082' '#1089#1077#1095#1077#1085#1080#1103
  ClientHeight = 203
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 477
    Height = 203
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Font.Color = clBlack
    Title.Text.Strings = (
      'Line # 1'
      '')
    Title.Visible = False
    LeftAxis.Title.Angle = 0
    Pages.ScaleLastPage = False
    View3D = False
    View3DWalls = False
    Zoom.Animated = True
    Zoom.AnimatedSteps = 16
    Align = alClient
    BevelOuter = bvNone
    BevelWidth = 0
    Color = clWhite
    TabOrder = 0
    AutoSize = True
    OnDblClick = Chart1DblClick
    OnMouseMove = Chart1MouseMove
    ExplicitWidth = 381
    ExplicitHeight = 151
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      Pointer.InflateMargins = True
      Pointer.Style = psSmallDot
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      object TeeFunction1: TLowTeeFunction
      end
    end
    object Series2: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 20
      Marks.Style = smsXValue
      Marks.Visible = False
      SeriesColor = clBlue
      LinePen.Color = clBlue
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series3: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
