object LokaleMod: TLokaleMod
  Height = 480
  Width = 640
  object Lokale: TFDQuery
    BeforeOpen = LokaleBeforeOpen
    BeforePost = LokaleBeforePost
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM WL_WAHL_LOKAL'
      'where WA_ID = :wa_id')
    Left = 96
    Top = 56
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object LokaleQry: TDataSetProvider
    DataSet = Lokale
    Left = 96
    Top = 120
  end
  object WLTab: TFDTable
    IndexFieldNames = 'WA_ID;WL_ID'
    Connection = DBMod.FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'WL_ID'
    TableName = 'WL_WAHL_LOKAL'
    Left = 200
    Top = 64
    object WLTabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WLTabWL_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'WL_ID'
      Origin = 'WL_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object WLTabWL_BAU: TStringField
      FieldName = 'WL_BAU'
      Origin = 'WL_BAU'
      Size = 100
    end
    object WLTabWL_STOCKWERK: TStringField
      FieldName = 'WL_STOCKWERK'
      Origin = 'WL_STOCKWERK'
      Size = 10
    end
    object WLTabWL_RAUM: TStringField
      FieldName = 'WL_RAUM'
      Origin = 'WL_RAUM'
      Size = 10
    end
    object WLTabWL_START: TSQLTimeStampField
      FieldName = 'WL_START'
      Origin = 'WL_START'
    end
    object WLTabWL_ENDE: TSQLTimeStampField
      FieldName = 'WL_ENDE'
      Origin = 'WL_ENDE'
    end
  end
  object DelHelferQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WH_WAHL_HELFER a '
      'WHERE'
      '    a.WL_ID = :wl_id AND '
      '    a.WA_ID = :wa_id'
      '')
    Left = 408
    Top = 80
    ParamData = <
      item
        Name = 'WL_ID'
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
  object DelRaumQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WL_WAHL_LOKAL a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.WL_ID = :wl_id'
      '')
    Left = 408
    Top = 144
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object Helfer: TFDQuery
    BeforeOpen = HelferBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'select * from WH_WAHL_HELFER a, MA_MITARBEITER b'
      'where'
      '  a.WA_ID = :wa_id'
      'and'
      '  a.WL_ID = :wl_id'
      'and'
      '  b.MA_ID = a.MA_ID')
    Left = 96
    Top = 248
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object HelferQry: TDataSetProvider
    DataSet = Helfer
    Left = 96
    Top = 312
  end
  object UpdateHelferQry: TFDQuery
    BeforeOpen = UpdateHelferQryBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE WH_WAHL_HELFER a'
      'SET '
      '    a.WH_ROLLE = :rolle'
      'WHERE'
      '    a.WL_ID = :wl_id AND '
      '    a.MA_ID = :ma_id AND '
      '    a.WA_ID = :wa_id'
      '')
    Left = 288
    Top = 304
    ParamData = <
      item
        Name = 'ROLLE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
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
  object DelHelfer: TFDQuery
    BeforeOpen = DelHelferBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WH_WAHL_HELFER a '
      'WHERE'
      '    a.WL_ID = :wl_id AND '
      '    a.MA_ID = :ma_id AND '
      '    a.WA_ID = :wa_id'
      '')
    Left = 392
    Top = 296
    ParamData = <
      item
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
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
  object AddHelferQry: TFDQuery
    BeforeOpen = AddHelferQryBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'INSERT INTO WH_WAHL_HELFER (WL_ID, MA_ID, WA_ID, WH_ROLLE)'
      'VALUES ('
      '    :WL_ID, '
      '    :MA_ID, '
      '    :WA_ID, '
      '    :WH_ROLLE'
      ');'
      '')
    Left = 288
    Top = 384
    ParamData = <
      item
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
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
      end
      item
        Name = 'WH_ROLLE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
