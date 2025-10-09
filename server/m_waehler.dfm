object WaehlerMod: TWaehlerMod
  Height = 480
  Width = 640
  object Mitarbeiter: TFDTable
    Connection = DBMod.FDConnection1
    TableName = 'MA_MITARBEITER'
    Left = 120
    Top = 56
  end
  object MitarbeiterTab: TDataSetProvider
    DataSet = Mitarbeiter
    Left = 120
    Top = 120
  end
end
