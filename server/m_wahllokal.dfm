object WahlLokalMod: TWahlLokalMod
  Height = 480
  Width = 645
  object Wahllokale: TFDQuery
    BeforeOpen = WahllokaleBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = DBMod.FDTransaction1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
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
    Connection = DBMod.FDConnection1
    Left = 48
    Top = 392
  end
  object WahllokaleQry: TDataSetProvider
    DataSet = Wahllokale
    Left = 64
    Top = 96
  end
  object MAListe: TFDQuery
    BeforeOpen = MAListeBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    FormatOptions.AssignedValues = [fvSE2Null, fvFmtDisplayDateTime]
    FormatOptions.StrsEmpty2Null = True
    SQL.Strings = (
      'select '
      
        '  a.ma_id, a.MA_PERSNR, a.MA_NAME, a.MA_VORNAME, a.MA_GENDER, a.' +
        'MA_ABTEILUNG, a.MA_GEB,'
      
        '  COALESCE(b.WL_BAU, '#39#39') as WL_BAU, b.WL_STOCKWERK, b.WL_RAUM, b' +
        '.WL_TIMESTAMP'
      'from  '
      '  MA_LISTE a'
      '  '
      'LEFT JOIN'
      '    WA_STAMP b ON a.MA_ID = b.MA_ID     '
      ''
      'where '
      '  a.WA_ID = :wa_id'
      '')
    Left = 208
    Top = 32
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object MAListeMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
    end
    object MAListeMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      Size = 10
    end
    object MAListeMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      Size = 100
    end
    object MAListeMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      Size = 100
    end
    object MAListeMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      FixedChar = True
      Size = 1
    end
    object MAListeMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
      Size = 100
    end
    object MAListeMA_GEB: TDateField
      FieldName = 'MA_GEB'
      Origin = 'MA_GEB'
    end
    object MAListeWL_BAU: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'WL_BAU'
      Origin = 'WL_BAU'
      ProviderFlags = []
      Size = 100
    end
    object MAListeWL_STOCKWERK: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'WL_STOCKWERK'
      Origin = 'WL_STOCKWERK'
      ProviderFlags = []
      Size = 10
    end
    object MAListeWL_RAUM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'WL_RAUM'
      Origin = 'WL_RAUM'
      ProviderFlags = []
      Size = 10
    end
    object MAListeWL_TIMESTAMP: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'WL_TIMESTAMP'
      Origin = 'WL_TIMESTAMP'
      ProviderFlags = []
    end
  end
  object MaListrQry: TDataSetProvider
    DataSet = MAListe
    Left = 208
    Top = 96
  end
  object CheckUserQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT *'
      'FROM WH_WAHL_HELFER  '
      'WHERE'
      '    WL_ID = :wl_id '
      'AND '
      '    MA_ID = :ma_id '
      'AND '
      '    WA_ID = :wa_id'
      '')
    Left = 376
    Top = 32
    ParamData = <
      item
        Name = 'WL_ID'
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
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object InsertUserQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'INSERT INTO MA_WL (WA_ID, MA_ID, WL_ID)'
      'VALUES ('
      '    :WA_ID, '
      '    :MA_ID, '
      '    :WL_ID'
      ');')
    Left = 496
    Top = 152
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
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object GetTimestampQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT '
      '  a.WL_TIMESTAMP, b.WL_BAU, b.WL_STOCKWERK, b.WL_RAUM'
      'FROM '
      '  MA_WL a, WL_WAHL_LOKAL b'
      'WHERE'
      '    b.WL_ID = a.WL_ID'
      'and'
      '    a.WA_ID = :wa_id '
      'AND '
      '    a.MA_ID = :ma_id '
      'AND '
      '    a.WL_ID = :wl_id'
      '')
    Left = 496
    Top = 224
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
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FindUserQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT '
      '  a.WL_TIMESTAMP'
      'FROM '
      '  MA_WL a '
      'WHERE'
      '    a.WA_ID = :wa_id '
      'AND '
      '    a.MA_ID = :ma_id '
      'AND '
      '    a.WL_ID = :wl_id'
      '')
    Left = 504
    Top = 88
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
        Name = 'WL_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object WAUpdate: TFDQuery
    BeforeOpen = WAUpdateBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'select '
      '  * '
      'from '
      '  WA_STAMP'
      'where '
      '  wa_id = :wa_id')
    Left = 208
    Top = 192
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object WAUpdateQry: TDataSetProvider
    DataSet = WAUpdate
    Left = 208
    Top = 264
  end
  object Helfer: TFDQuery
    BeforeOpen = HelferBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT '
      '  b.*, a.WH_ROLLE'
      'FROM '
      '    WH_WAHL_HELFER a,'
      '    MA_MITARBEITER b'
      'where'
      '  a.MA_ID = b.MA_ID'
      'and'
      '  a.WA_ID = :wa_id')
    Left = 40
    Top = 208
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object HelferQry: TDataSetProvider
    DataSet = Helfer
    Left = 48
    Top = 272
  end
end
