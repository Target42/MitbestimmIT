object RollenMod: TRollenMod
  Height = 480
  Width = 640
  object GetQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT '
      '  * '
      'FROM '
      '  MA_WA'
      'where'
      '  wa_id = :WA_ID'
      'and'
      '  MA_ID = :MA_ID ')
    Left = 112
    Top = 80
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
  object FDTransaction1: TFDTransaction
    Connection = DBMod.FDConnection1
    Left = 120
    Top = 160
  end
  object SetQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'UPDATE MA_WA a'
      'SET '
      '    a.MW_ROLLE = :MW_ROLLE'
      'WHERE'
      '    a.WA_ID = :wa_id '
      'AND '
      '    a.MA_ID = :ma_id'
      '')
    Left = 296
    Top = 72
    ParamData = <
      item
        Name = 'MW_ROLLE'
        DataType = ftString
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
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
