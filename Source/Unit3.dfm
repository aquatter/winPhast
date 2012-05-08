object Form3: TForm3
  Left = 499
  Top = 383
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'X'
  ClientHeight = 223
  ClientWidth = 592
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
    Width = 592
    Height = 223
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Legend.Visible = False
    Title.AdjustFrame = False
    Title.Font.Color = clBlack
    Title.Text.Strings = (
      'Line # 1'
      '')
    Title.Visible = False
    BottomAxis.Grid.Style = psSolid
    BottomAxis.MinorGrid.Color = clSilver
    BottomAxis.MinorGrid.Visible = True
    BottomAxis.Title.Caption = 'X, '#1084#1082#1084
    LeftAxis.Grid.Style = psSolid
    LeftAxis.MinorGrid.Color = clSilver
    LeftAxis.MinorGrid.Visible = True
    LeftAxis.Title.Caption = 'Z, '#1085#1084
    View3D = False
    View3DWalls = False
    Zoom.Animated = True
    Zoom.Brush.Style = bsDiagCross
    Zoom.Pen.Color = clBlack
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    AutoSize = True
    object Series1: TFastLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clBlack
      IgnoreNulls = False
      TreatNulls = tnDontPaint
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TPointSeries
      Marks.Arrow.Color = -1
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Color = -1
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
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
