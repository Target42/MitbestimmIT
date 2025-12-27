object DSVorschlagListenImport: TDSVorschlagListenImport
  Height = 480
  Width = 640
  object FDTransaction1: TFDTransaction
    Options.AutoStart = False
    Connection = DBMod.FDConnection1
    Left = 88
    Top = 64
  end
  object GetQrpQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *'
      'FROM WT_WAHL_LISTE'
      'WHERE'
      '  wa_id = :wa_id'
      'and'
      '  upper(WT_KURZ) = upper(:kurz)'
      '')
    Left = 232
    Top = 56
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'KURZ'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DeleteMAQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM WT_WA a '
      'WHERE'
      '    a.WA_ID = :wa_id '
      'AND '
      '    a.WT_ID = :wt_id'
      '')
    Left = 232
    Top = 128
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DeleteListeQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM WT_WAHL_LISTE a '
      'WHERE'
      '    a.WT_ID = :wt_id '
      'AND '
      '    a.WA_ID = :wa_id'
      '')
    Left = 224
    Top = 192
    ParamData = <
      item
        Name = 'WT_ID'
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
  object AddlisteQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'WT_ID'
    SQL.Strings = (
      'INSERT INTO WT_WAHL_LISTE (WA_ID, WT_NAME, WT_KURZ)'
      'VALUES ('
      '    :WA_ID, '
      '    :WT_NAME, '
      '    :WT_KURZ'
      ');'
      '')
    Left = 400
    Top = 64
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WT_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WT_KURZ'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object InsertMaQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'INSERT INTO WT_WA (WA_ID, MA_ID, WT_ID, WT_WA_POS, WT_WA_JOB)'
      'VALUES ('
      '    :WA_ID, '
      '    :MA_ID, '
      '    :WT_ID, '
      '    :WT_WA_POS, '
      '    :WT_WA_JOB'
      ');'
      '')
    Left = 400
    Top = 216
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
      end
      item
        Name = 'WT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WT_WA_POS'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WT_WA_JOB'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object FindMAQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *'
      'FROM MA_MITARBEITER '
      'WHERE'
      '    MA_PERSNR = :MA_PERSNR'
      '')
    Left = 408
    Top = 152
    ParamData = <
      item
        Name = 'MA_PERSNR'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
