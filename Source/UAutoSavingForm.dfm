object AutoSavingForm: TAutoSavingForm
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsDialog
  Caption = #1040#1074#1090#1086#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1086#1073#1083#1072#1089#1090#1077#1081
  ClientHeight = 245
  ClientWidth = 210
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 153
    Height = 26
    Caption = #1055#1091#1090#1100' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103':'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 66
    Height = 21
    Caption = #1052#1072#1089#1082#1072' '#1092#1072#1081#1083#1072
  end
  object Label3: TLabel
    Left = 16
    Top = 32
    Width = 177
    Height = 33
    AutoSize = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 16
    Top = 160
    Width = 97
    Height = 13
    Caption = #1057#1095#1077#1090#1095#1080#1082' '#1086#1073#1083#1072#1089#1090#1077#1081':'
  end
  object Label5: TLabel
    Left = 16
    Top = 110
    Width = 42
    Height = 13
    Caption = #1060#1086#1088#1084#1072#1090':'
  end
  object Button1: TButton
    Left = 65
    Top = 212
    Width = 75
    Height = 25
    Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 97
    Top = 77
    Width = 96
    Height = 21
    TabOrder = 1
    Text = 'name'
    TextHint = #1048#1084#1103' '#1092#1072#1081#1083#1072
  end
  object TrackBar1: TTrackBar
    Left = -4
    Top = 185
    Width = 213
    Height = 21
    Max = 255
    Min = 128
    Position = 255
    TabOrder = 2
    ThumbLength = 15
    TickStyle = tsNone
    OnChange = TrackBar1Change
  end
  object Button2: TButton
    Left = 167
    Top = 8
    Width = 26
    Height = 16
    Caption = '...'
    TabOrder = 3
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 132
    Width = 66
    Height = 17
    Caption = 'Bitmap'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 159
    Top = 132
    Width = 39
    Height = 17
    Caption = 'txt'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object CheckBox3: TCheckBox
    Left = 84
    Top = 132
    Width = 61
    Height = 17
    Caption = 'MatLab'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
end
