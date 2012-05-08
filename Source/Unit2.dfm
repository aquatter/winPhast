object Form2: TForm2
  Left = 247
  Top = 145
  BorderStyle = bsSingle
  Caption = #1054#1090#1082#1088#1099#1090#1100' '#1080#1085#1090#1077#1088#1092#1077#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 417
  ClientWidth = 842
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 392
    Width = 323
    Height = 13
    Caption = #1042#1089#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1076#1086#1083#1078#1085#1099' '#1073#1099#1090#1100' '#1074' '#1092#1086#1088#1084#1072#1090#1077' *.bmp 8 bit GrayScale'
  end
  object Image1: TImage
    Left = 648
    Top = 48
    Width = 185
    Height = 153
    Proportional = True
  end
  object Label2: TLabel
    Left = 648
    Top = 216
    Width = 3
    Height = 13
  end
  object ListView1: TListView
    Left = 16
    Top = 48
    Width = 353
    Height = 329
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        AutoSize = True
        Caption = 'Size'
      end
      item
        AutoSize = True
        Caption = 'Type'
      end>
    ColumnClick = False
    FlatScrollBars = True
    MultiSelect = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListView1Click
    OnDblClick = ListView1DblClick
  end
  object ComboBoxEx1: TComboBoxEx
    Left = 16
    Top = 16
    Width = 145
    Height = 22
    ItemsEx = <>
    Style = csExDropDownList
    ItemHeight = 16
    TabOrder = 1
    OnClick = ComboBoxEx1Click
    DropDownCount = 8
  end
  object Button1: TButton
    Left = 280
    Top = 16
    Width = 83
    Height = 25
    Cancel = True
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' >>'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 648
    Top = 312
    Width = 49
    Height = 25
    Caption = #1042#1085#1080#1079
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 648
    Top = 272
    Width = 49
    Height = 25
    Caption = #1042#1074#1077#1088#1093
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
  end
  object ListView2: TListView
    Left = 392
    Top = 48
    Width = 241
    Height = 329
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        AutoSize = True
        Caption = 'N Interferogram'
      end>
    ColumnClick = False
    FlatScrollBars = True
    TabOrder = 5
    ViewStyle = vsReport
    OnClick = ListView2Click
  end
  object Button4: TButton
    Left = 520
    Top = 16
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 432
    Top = 16
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 749
    Top = 376
    Width = 75
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    ModalResult = 1
    TabOrder = 8
  end
  object Button7: TButton
    Left = 656
    Top = 376
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 9
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 176
    Top = 16
    Width = 91
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
    TabOrder = 10
    OnClick = Button8Click
  end
end
