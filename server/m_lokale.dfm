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
end
