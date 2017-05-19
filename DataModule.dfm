object dm: Tdm
  OldCreateOrder = False
  Height = 631
  Width = 828
  object dbConn: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'Teplosnab'
    Options.KeepDesignConnected = False
    Username = 'sa'
    Server = 'KOLESNIK\DEVELOPER'
    LoginPrompt = False
    Left = 24
    Top = 26
    EncryptedPassword = '97FFB7FFABFFBEFFAAFFB0FFB0FF8FFFC8FF'
  end
  object MSSQLProvider: TSQLServerUniProvider
    Left = 112
    Top = 26
  end
  object SQLMonitor: TUniSQLMonitor
    Left = 224
    Top = 26
  end
end
