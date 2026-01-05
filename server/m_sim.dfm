object DSSim: TDSSim
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
    Left = 304
    Top = 224
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
    Left = 312
    Top = 320
  end
  object DataTab: TFDTable
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    TableName = 'WD_WAHLDATEN'
    Left = 296
    Top = 80
  end
end
