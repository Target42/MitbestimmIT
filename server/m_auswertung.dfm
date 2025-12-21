object Auswertungsmod: TAuswertungsmod
  Height = 480
  Width = 640
  object Data: TFDQuery
    BeforeOpen = DataBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT '
      '  *    '
      'FROM '
      '    WD_WAHLDATEN '
      'where '
      '    wa_id = :wa_id')
    Left = 48
    Top = 32
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
    Left = 304
    Top = 224
  end
  object DataQry: TDataSetProvider
    DataSet = Data
    Left = 48
    Top = 96
  end
end
