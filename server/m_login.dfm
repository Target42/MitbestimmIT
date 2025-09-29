object LoginMod: TLoginMod
  OnCreate = DSServerModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\DelphiBin\MitbestimmIT\Setup\db\WAHL2026.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object WATab: TFDTable
    Filter = 'WA_ACTIVE = '#39'T'#39
    IndexFieldNames = 'WA_ID'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'WA_WAHL'
    Left = 184
    Top = 48
    object WATabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object WATabWA_TITLE: TStringField
      FieldName = 'WA_TITLE'
      Origin = 'WA_TITLE'
      Size = 150
    end
    object WATabWA_SIMU: TStringField
      FieldName = 'WA_SIMU'
      Origin = 'WA_SIMU'
      OnGetText = WATabWA_SIMUGetText
      OnSetText = WATabWA_SIMUSetText
      FixedChar = True
      Size = 1
    end
    object WATabWA_ACTIVE: TStringField
      FieldName = 'WA_ACTIVE'
      Origin = 'WA_ACTIVE'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 64
    Top = 112
  end
  object PwdQry: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM MA_PWD '
      'where MW_LOGIN = :login')
    Left = 312
    Top = 56
    ParamData = <
      item
        Name = 'LOGIN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
