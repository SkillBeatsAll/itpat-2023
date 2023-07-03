object dmDatabase: TdmDatabase
  Height = 419
  Width = 460
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\joelc\Docu' +
      'ments\GitHub\itpat-2023\Preparation for Phase 2\FMX - authentica' +
      'tion\Win32\Debug\PAT_DB.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 176
  end
  object tblCredentials: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblCredentials'
    Left = 136
    Top = 80
  end
  object dsCredentials: TDataSource
    DataSet = tblCredentials
    Left = 272
    Top = 80
  end
  object tblEmployees: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'tblEmployees'
    Left = 136
    Top = 208
  end
  object dsEmployees: TDataSource
    DataSet = tblEmployees
    Left = 272
    Top = 208
  end
end
