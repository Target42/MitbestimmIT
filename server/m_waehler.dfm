object WaehlerMod: TWaehlerMod
  Height = 480
  Width = 640
  object MitarbeiterTab: TDataSetProvider
    DataSet = Mitarbeiter
    Left = 120
    Top = 120
  end
  object MAQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *'
      'FROM MA_MITARBEITER a, MA_WA b'
      'where'
      '  b.WA_ID = :wa_id'
      'and'
      '  b.MA_ID = a.MA_ID'
      '    ')
    Left = 296
    Top = 168
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object MAQryMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MAQryMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      Size = 10
    end
    object MAQryMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      Size = 100
    end
    object MAQryMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      Size = 100
    end
    object MAQryMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      FixedChar = True
      Size = 1
    end
    object MAQryMA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Origin = 'MA_MAIL'
      Size = 255
    end
    object MAQryMA_GEB: TDateField
      FieldName = 'MA_GEB'
      Origin = 'MA_GEB'
    end
    object MAQryMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
      Size = 100
    end
  end
  object NewMaTab: TFDTable
    IndexFieldNames = 'MA_ID'
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'MA_ID'
    TableName = 'MA_MITARBEITER'
    Left = 360
    Top = 168
  end
  object FDTransaction1: TFDTransaction
    Options.AutoStop = False
    Connection = DBMod.FDConnection1
    Left = 352
    Top = 56
  end
  object DelWahlHelferQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WH_WAHL_HELFER a '
      'WHERE'
      '    a.MA_ID = :ma_id AND '
      '    a.WA_ID = :wa_id'
      '')
    Left = 448
    Top = 168
    ParamData = <
      item
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DelWahlVorQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM WV_WAHL_VORSTAND a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.MA_ID = :ma_id AND '
      '    a.WV_CHEF <> '#39'T'#39
      '')
    Left = 448
    Top = 248
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
  object DelMaWaQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM MA_WA a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.MA_ID = :ma_id'
      '')
    Left = 440
    Top = 320
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
  object DelOldPwdQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM MA_PWD a '
      'WHERE'
      '    not a.MA_ID  in'
      '( select distinct ma_id from MA_WA )'
      '')
    Left = 296
    Top = 344
  end
  object DeloldMAQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM MA_MITARBEITER a '
      'WHERE'
      '    not MA_ID  in'
      '(select distinct ma_id from  ma_wa)'
      '')
    Left = 288
    Top = 408
  end
  object AddMAWAQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'INSERT INTO MA_WA (WA_ID, MA_ID)'
      'VALUES ('
      '    :WA_ID, '
      '    :MA_ID'
      ');'
      '')
    Left = 352
    Top = 232
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
  object DelWTQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WT_WA a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.MA_ID = :ma_id'
      '')
    Left = 448
    Top = 392
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
  object MCTab: TFDTable
    IndexFieldNames = 'WA_ID;MC_ID'
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'MC_DEL'
    TableName = 'MC_MA_CHANGE'
    Left = 552
    Top = 360
    object MCTabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object MCTabMC_STAMP: TSQLTimeStampField
      FieldName = 'MC_STAMP'
      Origin = 'MC_STAMP'
    end
    object MCTabMC_ADD: TIntegerField
      FieldName = 'MC_ADD'
      Origin = 'MC_ADD'
    end
    object MCTabMC_CHG: TIntegerField
      FieldName = 'MC_CHG'
      Origin = 'MC_CHG'
    end
    object MCTabMC_DEL: TIntegerField
      FieldName = 'MC_DEL'
      Origin = 'MC_DEL'
    end
    object MCTabMC_DATA: TBlobField
      FieldName = 'MC_DATA'
      Origin = 'MC_DATA'
    end
    object MCTabMC_ID: TIntegerField
      FieldName = 'MC_ID'
      Origin = 'MC_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object Mitarbeiter: TFDQuery
    BeforeOpen = MitarbeiterBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM MA_MITARBEITER a, MA_WA b'
      'where'
      '  b.WA_ID = :wa_id'
      'and'
      '  b.MA_ID = a.MA_ID'
      'order by MA_NAME, MA_VORNAME, MA_ABTEILUNG'
      '    ')
    Left = 120
    Top = 64
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
