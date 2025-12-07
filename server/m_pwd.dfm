object PwdCheckMod: TPwdCheckMod
  Height = 480
  Width = 640
  object PwdQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT a.MW_PWD'
      'FROM MA_PWD a '
      'WHERE'
      '    a.MA_ID = :ma_id'
      '')
    Left = 248
    Top = 360
    ParamData = <
      item
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.FDConnection1
    Left = 176
    Top = 272
  end
end
