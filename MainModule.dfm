object UniMainModule: TUniMainModule
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Height = 630
  Width = 831
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    Database = 'shitang'
    Username = 'fastdie'
    Server = '111.59.173.10'
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
    Left = 88
    Top = 200
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
end
