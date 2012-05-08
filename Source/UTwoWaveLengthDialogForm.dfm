object TwoWaveLengthDialogForm: TTwoWaveLengthDialogForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1052#1091#1083#1100#1090#1080#1101#1082#1089#1087#1086#1079#1080#1094#1080#1103
  ClientHeight = 334
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 645
    Height = 23
    Alignment = taCenter
    AutoSize = False
    Caption = #1044#1083#1080#1085#1072' '#1074#1086#1083#1085#1099' 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 119
    Width = 645
    Height = 23
    Alignment = taCenter
    AutoSize = False
    Caption = #1044#1083#1080#1085#1072' '#1074#1086#1083#1085#1099' 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 17
    Top = 268
    Width = 620
    Height = 12
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 36
    Top = 231
    Width = 198
    Height = 13
    Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1100' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' '#1092#1086#1090#1086#1088#1077#1079#1080#1089#1090#1072
  end
  object Bevel1: TBevel
    Left = 17
    Top = 108
    Width = 620
    Height = 12
    Shape = bsTopLine
  end
  object Button3: TButton
    Left = 216
    Top = 286
    Width = 75
    Height = 26
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object Button6: TButton
    Left = 352
    Top = 286
    Width = 75
    Height = 26
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 262
    Top = 228
    Width = 44
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
    Text = '2'
  end
  object Panel1: TPanel
    Left = 17
    Top = 41
    Width = 620
    Height = 60
    BevelOuter = bvNone
    TabOrder = 3
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 620
      Height = 58
      ButtonHeight = 52
      ButtonWidth = 155
      Caption = 'ToolBar1'
      Images = Form1.ImageList3
      ShowCaptions = True
      TabOrder = 0
      ExplicitWidth = 648
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084#1099
        ImageIndex = 0
        OnClick = Button4Click
      end
      object ToolButton2: TToolButton
        Left = 155
        Top = 0
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        ImageIndex = 2
        OnClick = Button1Click
      end
      object ToolButton5: TToolButton
        Left = 310
        Top = 0
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1105
        ImageIndex = 7
        OnClick = ToolButton5Click
      end
      object ToolButton6: TToolButton
        Left = 465
        Top = 0
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074#1089#1105
        ImageIndex = 8
        OnClick = ToolButton6Click
      end
    end
  end
  object Panel2: TPanel
    Left = 17
    Top = 154
    Width = 620
    Height = 60
    BevelOuter = bvNone
    TabOrder = 4
    object ToolBar2: TToolBar
      Left = 0
      Top = 0
      Width = 620
      Height = 58
      ButtonHeight = 52
      ButtonWidth = 155
      Caption = 'ToolBar1'
      Images = Form1.ImageList3
      ShowCaptions = True
      TabOrder = 0
      ExplicitWidth = 666
      object ToolButton3: TToolButton
        Left = 0
        Top = 0
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084#1099
        ImageIndex = 0
        OnClick = Button5Click
      end
      object ToolButton4: TToolButton
        Left = 155
        Top = 0
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        ImageIndex = 2
        OnClick = Button2Click
      end
      object ToolButton7: TToolButton
        Left = 310
        Top = 0
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1105
        ImageIndex = 7
        OnClick = ToolButton7Click
      end
      object ToolButton8: TToolButton
        Left = 465
        Top = 0
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074#1089#1105
        ImageIndex = 8
        OnClick = ToolButton8Click
      end
    end
  end
end
