object DSSim: TDSSim
  OnCreate = DSServerModuleCreate
  Height = 480
  Width = 640
  object DataQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *    '
      'FROM WD_WAHLDATEN '
      'WHERE'
      '    WA_ID = :wa_id'
      '')
    Left = 32
    Top = 88
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.FDConnection1
    Left = 32
    Top = 152
  end
  object DataTab: TFDTable
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    TableName = 'WD_WAHLDATEN'
    Left = 32
    Top = 24
  end
  object SelAllQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT '
      '  MA_ID'
      'FROM '
      '  MA_WA'
      'where'
      '  WA_ID = :wa_id'
      '')
    Left = 176
    Top = 24
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object BWTab: TFDTable
    IndexFieldNames = 'BW_ID;WA_ID;MA_ID'
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'BW_ID'
    TableName = 'BW_BRIEF_WAHL'
    Left = 280
    Top = 88
  end
  object FillLokalQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT '
      '  *  '
      'FROM '
      '    WL_WAHL_LOKAL '
      'where'
      '   WA_ID = :wa_id')
    Left = 152
    Top = 216
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object MAWLTab: TFDTable
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    TableName = 'MA_WL'
    Left = 296
    Top = 168
  end
  object DisableQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'UPDATE WP_WAHLPHASE a'
      'SET '
      '    a.WP_ACTIVE = '#39'F'#39
      'WHERE'
      '    a.WA_ID = :wa_id '
      'AND '
      '    a.WP_PHASE <> '#39'SAZ'#39
      '')
    Left = 384
    Top = 280
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
