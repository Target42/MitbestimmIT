object WahlListeMod: TWahlListeMod
  Height = 480
  Width = 640
  object WahlListe: TFDQuery
    BeforeOpen = WahlListeBeforeOpen
    Connection = DBMod.FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT a.WT_ID, a.WA_ID, a.WT_NAME, a.WT_KURZ'
      'FROM WT_WAHL_LISTE a '
      'WHERE'
      '    a.WA_ID = :wa_id'
      '')
    Left = 56
    Top = 48
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object WahllisteQry: TDataSetProvider
    DataSet = WahlListe
    Left = 64
    Top = 112
  end
  object WahllisteMA: TFDQuery
    BeforeOpen = WahllisteMABeforeOpen
    Connection = DBMod.FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'SELECT '
      '    a.WA_ID, a.MA_ID, a.WT_ID, a.WT_WA_POS,'
      
        '    b.MA_PERSNR, b.MA_NAME, b.MA_VORNAME, b.MA_GENDER, b.MA_ABTE' +
        'ILUNG, b.MA_GEB'
      'FROM '
      '    WT_WA a,'
      '    MA_Mitarbeiter b    '
      'where '
      '  a.WA_ID = :wa_id'
      'and  '
      '  a.WT_ID = :wt_id'
      'and  '
      '  a.MA_ID = b.MA_ID  '
      'order by '
      '  a.WT_WA_POS')
    Left = 64
    Top = 184
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
  object WahllisteMAQry: TDataSetProvider
    DataSet = WahllisteMA
    Left = 64
    Top = 256
  end
  object WahlPersTab: TFDTable
    IndexFieldNames = 'WA_ID;MA_ID;WT_ID'
    Connection = DBMod.FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'WT_WA'
    Left = 232
    Top = 128
  end
  object DelMAWTQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WT_WA a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.WT_ID = :wt_id'
      '')
    Left = 544
    Top = 56
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
  object DelWTQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WT_WAHL_LISTE a '
      'WHERE'
      '    a.WT_ID = :wt_id AND '
      '    a.WA_ID = :wa_id'
      '')
    Left = 552
    Top = 128
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
  object DelMaQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WT_WA a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.MA_ID = :ma_id AND '
      '    a.WT_ID = :wt_id'
      '')
    Left = 552
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
        Name = 'WT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object WahlListeTab: TFDTable
    IndexFieldNames = 'WT_ID'
    Connection = DBMod.FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckReadOnly]
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.AutoIncFields = 'WT_ID'
    TableName = 'WT_WAHL_LISTE'
    Left = 232
    Top = 48
  end
end
