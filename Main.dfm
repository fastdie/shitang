object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 761
  ClientWidth = 852
  Caption = #38054#24030#28023#20851#39135#22530#35746#39184#31649#29702#31995#32479
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
    Height = 761
    Hint = ''
    ActivePage = UniTabSheet5
    Align = alClient
    TabOrder = 0
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = #26085#24120#35746#39184
      OnBeforeActivate = UniTabSheet1BeforeActivate
      object UniGroupBox2: TUniGroupBox
        Left = 10
        Top = 10
        Width = 330
        Height = 631
        Hint = ''
        Caption = #28857#20987#33756#21697#21517#65292#25353#25552#31034#30830#35748#21363#21487#23436#25104#35746#39184#24037#20316
        TabOrder = 0
        object UniDateTimePicker1: TUniDateTimePicker
          Left = 10
          Top = 24
          Width = 300
          Hint = ''
          DateTime = 43625.000000000000000000
          DateFormat = 'yyyy-MM-dd'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 1
          OnChange = UniDateTimePicker1Change
        end
        object UniTreeView1: TUniTreeView
          Left = 10
          Top = 52
          Width = 300
          Height = 440
          Hint = ''
          Items.FontData = {0100000000}
          AutoExpand = True
          TabOrder = 2
          Color = clWindow
          OnChange = UniTreeView1Change
          OnClick = UniTreeView1Click
          OnDblClick = UniTreeView1DblClick
        end
        object UniLabel4: TUniLabel
          Left = 18
          Top = 510
          Width = 46
          Height = 13
          Hint = ''
          Caption = 'UniLabel4'
          TabOrder = 3
        end
      end
    end
    object UniTabSheet2: TUniTabSheet
      Hint = ''
      Caption = #26597#35810' / '#36864#39184
      OnBeforeActivate = UniTabSheet2BeforeActivate
      object UniDateTimePicker2: TUniDateTimePicker
        Left = 20
        Top = 20
        Width = 300
        Hint = ''
        DateTime = 43644.000000000000000000
        DateFormat = 'yyyy-MM-dd'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 0
        OnChange = UniDateTimePicker2Change
      end
      object UniButton6: TUniButton
        Left = 20
        Top = 520
        Width = 300
        Height = 25
        Hint = ''
        Caption = #20840#36873#36864#39184
        TabOrder = 1
        OnClick = UniButton6Click
      end
      object UniListBox1: TUniListBox
        Left = 20
        Top = 60
        Width = 300
        Height = 400
        Hint = ''
        TabOrder = 2
        ParentFont = False
        Font.Height = -21
      end
      object UniButton2: TUniButton
        Left = 20
        Top = 480
        Width = 300
        Height = 25
        Hint = ''
        Caption = #36864#39184
        TabOrder = 3
        OnClick = UniButton2Click
      end
    end
    object UniTabSheet3: TUniTabSheet
      Hint = ''
      Caption = #20462#25913#23494#30721
      OnBeforeActivate = UniTabSheet3BeforeActivate
      object UniGroupBox1: TUniGroupBox
        Left = 20
        Top = 20
        Width = 289
        Height = 317
        Hint = ''
        Caption = #35831#36755#20837#21407#23494#30721#19982#26032#23494#30721
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
          Caption = #21407#23494#30721#65306
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
        object UniButton8: TUniButton
          Left = 27
          Top = 245
          Width = 193
          Height = 25
          Hint = ''
          Caption = #26597#30475#24403#21069#29992#25143#29366#24577
          TabOrder = 8
          OnClick = UniButton8Click
        end
      end
    end
    object UniTabSheet4: TUniTabSheet
      Hint = ''
      Caption = #35746#39184#32479#35745
      OnBeforeActivate = UniTabSheet4BeforeActivate
      object UniDateTimePicker3: TUniDateTimePicker
        Left = 20
        Top = 10
        Width = 200
        Hint = ''
        DateTime = 43644.000000000000000000
        DateFormat = 'yyyy-MM-dd'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 0
        OnChange = UniDateTimePicker3Change
      end
      object UniMemo1: TUniMemo
        Left = 20
        Top = 40
        Width = 200
        Height = 330
        Hint = ''
        TabOrder = 1
      end
    end
    object UniTabSheet5: TUniTabSheet
      Hint = ''
      Caption = #28857#36873#29289#21697
      OnBeforeActivate = UniTabSheet5BeforeActivate
      object UniGroupBox3: TUniGroupBox
        Left = 10
        Top = 10
        Width = 330
        Height = 631
        Hint = ''
        Caption = #29289#21697#28165#21333
        TabOrder = 0
        object UniListBox2: TUniListBox
          Left = 30
          Top = 38
          Width = 269
          Height = 460
          Hint = ''
          TabOrder = 1
        end
        object UniLabel5: TUniLabel
          Left = 30
          Top = 529
          Width = 46
          Height = 13
          Hint = ''
          Caption = 'UniLabel5'
          TabOrder = 2
        end
      end
    end
  end
  object UniTimer1: TUniTimer
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 576
    Top = 56
  end
end
