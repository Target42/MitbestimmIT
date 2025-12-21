object AdminMod: TAdminMod
  OnCreate = DSServerModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=x:\DelphiBin\MitbestimmIT\Setup\db\WAHL2026.FDB'
      'User_Name=admin_user'
      'Password=snoopy'
      'RoleName=appadmin'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 88
    Top = 48
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 88
    Top = 120
  end
  object TabWahl: TFDTable
    Connection = FDConnection1
    Transaction = FDTransaction1
    TableName = 'WA_WAHL'
    Left = 224
    Top = 80
  end
  object WahlTab: TDataSetProvider
    DataSet = TabWahl
    Left = 224
    Top = 160
  end
  object NewWahlTab: TFDTable
    IndexFieldNames = 'WA_ID'
    Connection = FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'WA_ID'
    TableName = 'WA_WAHL'
    Left = 360
    Top = 80
    object NewWahlTabWA_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object NewWahlTabWA_TITLE: TStringField
      FieldName = 'WA_TITLE'
      Origin = 'WA_TITLE'
      Size = 150
    end
    object NewWahlTabWA_SIMU: TStringField
      FieldName = 'WA_SIMU'
      Origin = 'WA_SIMU'
      FixedChar = True
      Size = 1
    end
    object NewWahlTabWA_ACTIVE: TStringField
      FieldName = 'WA_ACTIVE'
      Origin = 'WA_ACTIVE'
      FixedChar = True
      Size = 1
    end
  end
  object MAQry: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *    '
      'FROM MA_MITARBEITER '
      'WHERE'
      '    MA_PERSNR = :persnr'
      '')
    Left = 496
    Top = 264
    ParamData = <
      item
        Name = 'PERSNR'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object MATab: TFDTable
    IndexFieldNames = 'MA_ID'
    Connection = FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'MA_ID'
    TableName = 'MA_MITARBEITER'
    Left = 352
    Top = 152
    object MATabMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MATabMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      Size = 10
    end
    object MATabMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      Size = 100
    end
    object MATabMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      Size = 100
    end
    object MATabMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      FixedChar = True
      Size = 1
    end
    object MATabMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
    end
    object MATabMA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Origin = 'MA_MAIL'
      Size = 255
    end
  end
  object WVTab: TFDTable
    IndexFieldNames = 'WA_ID;MA_ID'
    Connection = FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'WV_WAHL_VORSTAND'
    Left = 352
    Top = 216
    object WVTabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WVTabMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WVTabWV_ROLLE: TStringField
      FieldName = 'WV_ROLLE'
      Origin = 'WV_ROLLE'
      Size = 100
    end
    object WVTabWV_CHEF: TStringField
      FieldName = 'WV_CHEF'
      Origin = 'WV_CHEF'
      FixedChar = True
      Size = 1
    end
  end
  object PwdTab: TFDTable
    IndexFieldNames = 'MA_ID'
    Connection = FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'MA_PWD'
    Left = 352
    Top = 288
    object PwdTabMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PwdTabMW_PWD: TStringField
      FieldName = 'MW_PWD'
      Origin = 'MW_PWD'
      Size = 64
    end
    object PwdTabMW_ROLLE: TStringField
      FieldName = 'MW_ROLLE'
      Origin = 'MW_ROLLE'
      Size = 100
    end
    object PwdTabMW_SECRET: TStringField
      FieldName = 'MW_SECRET'
      Origin = 'MW_SECRET'
      Size = 32
    end
    object PwdTabMW_LOGIN: TStringField
      FieldName = 'MW_LOGIN'
      Origin = 'MW_LOGIN'
    end
  end
  object AddWAQry: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO MA_WA (WA_ID, MA_ID)'
      'VALUES ('
      '    :WA_ID,'
      '    :MA_ID'
      ');'
      '')
    Left = 448
    Top = 160
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object Phasen: TFDQuery
    Connection = FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      
        'INSERT INTO WP_WAHLPHASE (WA_ID, WP_ID, WP_TITLE, WP_ACTIVE, WP_' +
        'PHASE)'
      'VALUES ('
      '    :WA_ID, '
      '    :WP_ID, '
      '    :WP_TITLE, '
      '    :WP_ACTIVE, '
      '    :WP_PHASE'
      ');'
      '')
    Left = 360
    Top = 360
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WP_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WP_TITLE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WP_ACTIVE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WP_PHASE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
