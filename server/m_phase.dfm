object PhasenMod: TPhasenMod
  Height = 480
  Width = 640
  object Phasen: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *'
      'FROM WP_WAHLPHASE r'
      'where'
      '  wa_id = :wa_id'
      'and'
      '  WP_ACTIVE = '#39'T'#39
      'and'
      '  WP_PHASE = :phase')
    Left = 120
    Top = 64
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PHASE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.FDConnection1
    Left = 216
    Top = 48
  end
  object Data: TFDQuery
    BeforeOpen = DataBeforeOpen
    SQL.Strings = (
      'SELECT '
      '  *'
      'FROM WD_WAHLDATEN a '
      'WHERE'
      '    a.WA_ID = :wa_id'
      '')
    Left = 88
    Top = 216
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DataQry: TDataSetProvider
    DataSet = Data
    Left = 80
    Top = 288
  end
end
