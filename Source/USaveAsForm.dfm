object SaveAsForm: TSaveAsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
  ClientHeight = 280
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 228
    Top = 18
    Width = 45
    Height = 13
    Caption = #1060#1086#1088#1084#1072#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 54
    Top = 18
    Width = 94
    Height = 13
    Caption = #1063#1090#1086' '#1089#1086#1093#1088#1072#1085#1103#1077#1084'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 140
    Width = 154
    Height = 13
    Caption = #1055#1091#1090#1100' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074':'
  end
  object Button1: TButton
    Left = 91
    Top = 239
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 207
    Top = 239
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 197
    Top = 48
    Width = 138
    Height = 17
    Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' BMP'
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 197
    Top = 71
    Width = 97
    Height = 17
    Caption = #1060#1072#1081#1083' Matlab '
    TabOrder = 3
  end
  object CheckBox3: TCheckBox
    Left = 197
    Top = 94
    Width = 138
    Height = 17
    Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083
    TabOrder = 4
  end
  object CheckBox4: TCheckBox
    Left = 197
    Top = 117
    Width = 167
    Height = 17
    Caption = #1041#1080#1085#1072#1088#1085#1099#1081' '#1092#1072#1081#1083' BIN'
    TabOrder = 5
  end
  object CheckBox5: TCheckBox
    Left = 50
    Top = 48
    Width = 97
    Height = 17
    Caption = #1040#1084#1087#1083#1080#1090#1091#1076#1072
    TabOrder = 6
  end
  object CheckBox6: TCheckBox
    Left = 50
    Top = 71
    Width = 97
    Height = 17
    Caption = #1053#1077#1089#1096#1080#1090#1072#1103' '#1092#1072#1079#1072
    TabOrder = 7
  end
  object CheckBox7: TCheckBox
    Left = 50
    Top = 94
    Width = 97
    Height = 17
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    TabOrder = 8
  end
  object Edit1: TEdit
    Left = 14
    Top = 163
    Width = 300
    Height = 21
    TabOrder = 9
  end
  object Panel1: TPanel
    Left = 320
    Top = 153
    Width = 41
    Height = 40
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 10
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 41
      Height = 38
      ButtonHeight = 38
      ButtonWidth = 39
      Caption = 'ToolBar1'
      Images = Form1.ImageList3
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Hint = #1059#1082#1072#1079#1072#1090#1100' '#1080#1084#1103' '#1092#1072#1081#1083#1072
        Caption = 'ToolButton1'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton1Click
      end
    end
  end
  object CheckBox8: TCheckBox
    Left = 50
    Top = 199
    Width = 244
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1086#1073#1083#1072#1089#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1103
    TabOrder = 11
  end
end
