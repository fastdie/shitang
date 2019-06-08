object UniLoginForm1: TUniLoginForm1
  Left = 0
  Top = 0
  ClientHeight = 200
  ClientWidth = 260
  Caption = #30331#24405
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniLoginFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniLabel1: TUniLabel
    Left = 40
    Top = 40
    Width = 36
    Height = 13
    Hint = ''
    Caption = #24037#21495#65306
    TabOrder = 0
  end
  object UniLabel2: TUniLabel
    Left = 40
    Top = 80
    Width = 36
    Height = 13
    Hint = ''
    Caption = #23494#30721#65306
    TabOrder = 1
  end
  object UniEdit1: TUniEdit
    Left = 100
    Top = 40
    Width = 120
    Hint = ''
    Text = ''
    TabOrder = 2
    OnKeyPress = UniEdit1KeyPress
  end
  object UniEdit2: TUniEdit
    Left = 100
    Top = 80
    Width = 120
    Hint = ''
    PasswordChar = '*'
    Text = ''
    TabOrder = 3
    OnKeyPress = UniEdit2KeyPress
  end
  object UniButton1: TUniButton
    Left = 40
    Top = 128
    Width = 180
    Height = 25
    Hint = ''
    Caption = #30331#24405
    TabOrder = 4
    OnClick = UniButton1Click
  end
end
