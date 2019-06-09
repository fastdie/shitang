object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 411
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
    Height = 411
    Hint = ''
    ActivePage = UniTabSheet3
    Align = alClient
    TabOrder = 0
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = #35746#39184
      OnBeforeActivate = UniTabSheet1BeforeActivate
      object UniGroupBox2: TUniGroupBox
        Left = 10
        Top = 10
        Width = 503
        Height = 359
        Hint = ''
        Caption = #36873#25321#35746#39184#26085#26399#65292#23558#24038#20391#33756#21333#28155#21152#21040#21491#20391#65292#28857#20987#20445#23384#30830#35748
        TabOrder = 0
        object UniDateTimePicker1: TUniDateTimePicker
          Left = 10
          Top = 24
          Width = 175
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
          Width = 175
          Height = 293
          Hint = ''
          Items.FontData = {0100000000}
          TabOrder = 2
          Color = clWindow
        end
        object UniTreeView2: TUniTreeView
          Left = 280
          Top = 52
          Width = 177
          Height = 293
          Hint = ''
          Items.FontData = {0100000000}
          TabOrder = 3
          Color = clWindow
        end
        object UniButton2: TUniButton
          Left = 191
          Top = 111
          Width = 75
          Height = 25
          Hint = ''
          Caption = '>>'
          TabOrder = 4
          OnClick = UniButton2Click
        end
        object UniButton3: TUniButton
          Left = 191
          Top = 224
          Width = 75
          Height = 25
          Hint = ''
          Caption = '>>>>'
          TabOrder = 5
          OnClick = UniButton3Click
        end
        object UniButton4: TUniButton
          Left = 280
          Top = 21
          Width = 177
          Height = 25
          Hint = ''
          Caption = #20445#23384#35746#39184#20449#24687
          TabOrder = 6
          OnClick = UniButton4Click
        end
      end
    end
    object UniTabSheet2: TUniTabSheet
      Hint = ''
      Caption = #36864#39184
      OnBeforeActivate = UniTabSheet2BeforeActivate
      object UniGroupBox3: TUniGroupBox
        Left = 10
        Top = 10
        Width = 503
        Height = 359
        Hint = ''
        Caption = #36873#25321#36864#39184#26085#26399#65292#23558#24038#20391#35746#39184#20449#24687#31227#21160#21040#21491#20391#65292#28857#20987#21024#38500#30830#35748
        TabOrder = 0
        object UniDateTimePicker2: TUniDateTimePicker
          Left = 10
          Top = 24
          Width = 175
          Hint = ''
          DateTime = 43625.000000000000000000
          DateFormat = 'yyyy-MM-dd'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 1
          OnChange = UniDateTimePicker2Change
        end
        object UniTreeView3: TUniTreeView
          Left = 10
          Top = 52
          Width = 175
          Height = 293
          Hint = ''
          Items.FontData = {0100000000}
          TabOrder = 2
          Color = clWindow
        end
        object UniTreeView4: TUniTreeView
          Left = 280
          Top = 52
          Width = 177
          Height = 293
          Hint = ''
          Items.FontData = {0100000000}
          TabOrder = 3
          Color = clWindow
        end
        object UniButton5: TUniButton
          Left = 191
          Top = 111
          Width = 75
          Height = 25
          Hint = ''
          Caption = '>>'
          TabOrder = 4
          OnClick = UniButton5Click
        end
        object UniButton6: TUniButton
          Left = 191
          Top = 224
          Width = 75
          Height = 25
          Hint = ''
          Caption = '>>>>'
          TabOrder = 5
          OnClick = UniButton6Click
        end
        object UniButton7: TUniButton
          Left = 280
          Top = 21
          Width = 177
          Height = 25
          Hint = ''
          Caption = #21024#38500#35746#39184#20449#24687
          TabOrder = 6
          OnClick = UniButton7Click
        end
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
        Caption = #35831#36755#20837#26087#23494#30721#19982#26032#23494#30721
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
