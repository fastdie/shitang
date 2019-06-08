object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 411
  ClientWidth = 852
  Caption = #38054#24030#28023#20851#39135#22530#31649#29702#31995#32479
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniPageControl1: TUniPageControl
    Left = 0
    Top = 0
    Width = 852
    Height = 411
    Hint = ''
    ActivePage = UniTabSheet3
    Align = alClient
    TabOrder = 0
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = #35746#39184
    end
    object UniTabSheet2: TUniTabSheet
      Hint = ''
      Caption = #36864#39184
    end
    object UniTabSheet3: TUniTabSheet
      Hint = ''
      Caption = #20462#25913#23494#30721
      object UniGroupBox1: TUniGroupBox
        Left = 20
        Top = 20
        Width = 289
        Height = 317
        Hint = ''
        Caption = 'UniGroupBox1'
        TabOrder = 0
        object UniEdit1: TUniEdit
          Left = 100
          Top = 56
          Width = 120
          Hint = ''
          PasswordChar = '*'
          Text = ''
          TabOrder = 1
        end
        object UniLabel1: TUniLabel
          Left = 40
          Top = 56
          Width = 48
          Height = 13
          Hint = ''
          Caption = #26087#23494#30721#65306
          TabOrder = 2
        end
        object UniLabel2: TUniLabel
          Left = 40
          Top = 104
          Width = 48
          Height = 13
          Hint = ''
          Caption = #26032#23494#30721#65306
          TabOrder = 3
        end
        object UniLabel3: TUniLabel
          Left = 20
          Top = 160
          Width = 72
          Height = 13
          Hint = ''
          Caption = #37325#22797#26032#23494#30721#65306
          TabOrder = 4
        end
        object UniEdit2: TUniEdit
          Left = 100
          Top = 104
          Width = 120
          Hint = ''
          PasswordChar = '*'
          Text = ''
          TabOrder = 5
        end
        object UniEdit3: TUniEdit
          Left = 100
          Top = 160
          Width = 120
          Hint = ''
          PasswordChar = '*'
          Text = ''
          TabOrder = 6
        end
        object UniButton1: TUniButton
          Left = 27
          Top = 200
          Width = 193
          Height = 25
          Hint = ''
          Caption = #20462#25913#23494#30721
          TabOrder = 7
          OnClick = UniButton1Click
        end
      end
    end
  end
end
