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
    ActivePage = UniTabSheet2
    Align = alClient
    TabOrder = 0
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = #26085#24120#35746#39184
      OnBeforeActivate = UniTabSheet1BeforeActivate
      object UniGroupBox2: TUniGroupBox
        Left = 10
        Top = 10
        Width = 495
        Height = 631
        Hint = ''
        Caption = #35843#25972#33756#21333#33267#21491#20391#26639#20869#65292#28857#20445#23384#21363#23436#25104#35746#39184#24037#20316
        TabOrder = 0
        object UniDateTimePicker1: TUniDateTimePicker
          Left = 10
          Top = 24
          Width = 120
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
          Width = 191
          Height = 429
          Hint = ''
          Items.FontData = {0100000000}
          AutoExpand = True
          TabOrder = 2
          Color = clWindow
          OnChange = UniTreeView1Change
          OnDblClick = UniTreeView1DblClick
        end
      end
    end
    object UniTabSheet2: TUniTabSheet
      Hint = ''
      Caption = #26597#35810' / '#36864#39184
      OnBeforeActivate = UniTabSheet2BeforeActivate
      object UniDateTimePicker2: TUniDateTimePicker
        Left = 20
        Top = 10
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
        Top = 664
        Width = 300
        Height = 25
        Hint = ''
        Caption = #20840#36873#36864#39184
        TabOrder = 1
        OnClick = UniButton6Click
      end
      object UniListBox1: TUniListBox
        Left = 20
        Top = 62
        Width = 300
        Height = 507
        Hint = ''
        TabOrder = 2
        ParentFont = False
        Font.Height = -21
      end
      object UniButton2: TUniButton
        Left = 20
        Top = 600
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
      Caption = #26412#21608#24847#35265#21453#39304
      OnBeforeActivate = UniTabSheet5BeforeActivate
      object UniDBGrid1: TUniDBGrid
        Left = 20
        Top = 40
        Width = 253
        Height = 303
        Hint = ''
        DataSource = UniMainModule.fankui_ds
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgConfirmDelete, dgMultiSelect, dgAutoRefreshRow]
        ReadOnly = True
        LoadMask.Message = 'Loading data...'
        TabOrder = 0
        Columns = <
          item
            FieldName = 'food_name'
            Title.Alignment = taCenter
            Title.Caption = #28385#24847#33756#21697
            Width = 244
            Alignment = taCenter
          end>
      end
      object UniButton5: TUniButton
        Left = 20
        Top = 350
        Width = 253
        Height = 25
        Hint = ''
        Caption = 'UniButton5'
        TabOrder = 1
      end
      object UniDateTimePicker4: TUniDateTimePicker
        Left = 20
        Top = 10
        Width = 253
        Hint = ''
        DateTime = 43658.000000000000000000
        DateFormat = 'yyyy-MM-dd'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 2
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
