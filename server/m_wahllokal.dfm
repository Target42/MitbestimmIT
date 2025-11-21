object WahlLokalMod: TWahlLokalMod
  Height = 480
  Width = 640
  object Wahllokale: TFDQuery
    BeforeOpen = WahllokaleBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT '
      '  a.*, b.ma_id, b.wh_rolle  '
      'FROM '
      '    WL_WAHL_LOKAL a, WH_WAHL_HELFER b'
      'where'
      '  a.wa_id = :wa_id'
      'and'
      '  a.wa_id = b.wa_id'
      'and'
      '  b.ma_id = :ma_id'
      '')
    Left = 64
    Top = 32
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
    Left = 48
    Top = 392
  end
  object WahllokaleQry: TDataSetProvider
    DataSet = Wahllokale
    Left = 64
    Top = 96
  end
end
