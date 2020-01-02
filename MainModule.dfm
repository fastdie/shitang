object UniMainModule: TUniMainModule
  OldCreateOrder = False
  BrowserOptions = [boDisableMouseRightClick, boDisableChromeRefresh]
  MonitoredKeys.Keys = <>
  EnableSynchronousOperations = True
  Height = 406
  Width = 540
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    Database = 'shitang'
    Username = 'fastdie'
    Server = '192.168.100.102'
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 56
    EncryptedPassword = 'AEFFA5FFC7FFC7FFC7FFC7FFC7FFC7FFC7FFC7FF97FF98FF'
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 88
    Top = 128
  end
  object exec_query: TUniQuery
    Connection = UniConnection1
    Left = 208
    Top = 192
  end
  object dingcan_query: TUniQuery
    Connection = UniConnection1
    Left = 208
    Top = 56
  end
  object tuican_query: TUniQuery
    Connection = UniConnection1
    Left = 208
    Top = 120
  end
  object fankui_ds: TUniDataSource
    DataSet = fankui_query
    Left = 336
    Top = 56
  end
  object fankui_query: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'select food_name from menulist_table'
      ''
      'group by food_name'
      ''
      'order by food_name')
    Left = 424
    Top = 56
  end
end
