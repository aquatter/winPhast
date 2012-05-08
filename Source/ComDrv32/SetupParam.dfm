object frmSetupParam: TfrmSetupParam
  Left = 182
  Top = 197
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1057#1054#1052' '#1087#1086#1088#1090#1072
  ClientHeight = 134
  ClientWidth = 174
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 0
    Top = 0
    Width = 174
    Height = 134
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 5
    Top = 5
    Width = 64
    Height = 16
    HelpContext = 219
    Caption = 'COM '#1087#1086#1088#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 5
    Top = 53
    Width = 113
    Height = 16
    HelpContext = 219
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1086#1073#1084#1077#1085#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object Bevel2: TBevel
    Left = 88
    Top = 99
    Width = 79
    Height = 29
    Shape = bsFrame
    Style = bsRaised
  end
  object Bevel1: TBevel
    Left = 5
    Top = 99
    Width = 79
    Height = 29
    Shape = bsFrame
    Style = bsRaised
  end
  object cmbPort: TComboBox
    Left = 5
    Top = 25
    Width = 161
    Height = 22
    Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1057#1054#1052' '#1087#1086#1088#1090#1072
    HelpContext = 219
    AutoDropDown = True
    AutoCloseUp = True
    BevelKind = bkSoft
    BevelOuter = bvRaised
    Style = csOwnerDrawVariable
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
    Items.Strings = (
      'COM01'
      'COM02'
      'COM03'
      'COM04'
      'COM05'
      'COM06'
      'COM07'
      'COM08'
      'COM09'
      'COM10'
      'COM11'
      'COM12'
      'COM13'
      'COM14'
      'COM15'
      'COM16'
      'COM17'
      'COM18'
      'COM19'
      'COM20')
  end
  object cmbSpeed: TComboBox
    Left = 5
    Top = 73
    Width = 161
    Height = 22
    Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1057#1054#1052' '#1087#1086#1088#1090#1072
    HelpContext = 219
    AutoDropDown = True
    AutoCloseUp = True
    BevelKind = bkSoft
    BevelOuter = bvRaised
    Style = csOwnerDrawVariable
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 1
    Items.Strings = (
      '110'
      '300'
      '600'
      '1200'
      '2400'
      '4800'
      '9600'
      '14400'
      '19200'
      '38400'
      '56000'
      '57600'
      '115200')
  end
  object btnOk: TButton
    Left = 90
    Top = 101
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 7
    Top = 101
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
