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
  object Doppelt: TFDQuery
    BeforeOpen = DoppeltBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'select '
      
        '  a.ma_id, c.MA_NAME, c.MA_VORNAME, c.MA_PERSNR, c.MA_ABTEILUNG,' +
        ' d.WL_BAU, d.WL_STOCKWERK, d.WL_RAUM, a.BW_EMPFANGEN'
      'from '
      '  BW_BRIEF_WAHL a, MA_WL b, MA_MITARBEITER c, WL_WAHL_LOKAL d'
      '  '
      'where '
      '    a.WA_ID = :wa_id'
      'and'
      '    a.MA_ID = b.MA_ID'
      'and '
      '    a.MA_ID = c.MA_ID'
      'and'
      '    b.WL_ID = d.WL_ID'
      'and'
      '    a.BW_EMPFANGEN is not null'
      '')
    Left = 160
    Top = 32
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object MarkDoppeltQry: TFDQuery
    BeforeOpen = MarkDoppeltQryBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE BW_BRIEF_WAHL a'
      'SET '
      '    a.BW_ERROR = '#39'D'#39
      'WHERE'
      '    a.WA_ID in'
      '('
      '  select '
      '    ma_id'
      '  from '
      '    MA_WL'
      '  where  '
      '    WA_ID = :wa_id'
      '   '
      ')'
      '    '
      '')
    Left = 288
    Top = 40
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object Mark: TFDQuery
    BeforeOpen = MarkBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE BW_BRIEF_WAHL a'
      'SET '
      '    a.BW_ERROR = '#39'U'#39
      'WHERE'
      '    a.WA_ID = :wa_id'
      'and '
      '  a.BW_EMPFANGEN is null'
      '')
    Left = 288
    Top = 104
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object BriefDaten: TFDQuery
    BeforeOpen = BriefDatenBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT '
      
        '    r.BW_ID, r.MA_ID, r.BW_ANTRAG, r.BW_VERSENDET, r.BW_EMPFANGE' +
        'N, r.BW_ERROR, a.MA_PERSNR, a.MA_NAME, a.MA_VORNAME, a.MA_ABTEIL' +
        'UNG, a.MA_GENDER, a.MA_GEB'
      'FROM '
      '    BW_BRIEF_WAHL r, MA_MITARBEITER a'
      'where'
      '    r.WA_ID = :wa_id'
      'and'
      '  r.MA_ID = a.MA_ID'
      ' '
      'order by'
      '  a.MA_NAME, a.MA_VORNAME, a.MA_ABTEILUNG')
    Left = 152
    Top = 128
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object BriefdatenQry: TDataSetProvider
    DataSet = BriefDaten
    Left = 160
    Top = 200
  end
  object GetBriefStreamQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT  '
      '  BW_DATA'
      'FROM '
      '  BW_BRIEF_WAHL'
      'where'
      '  wa_id = :wa_id'
      'and  '
      '  bw_id = :bw_id')
    Left = 448
    Top = 56
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BW_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object SetBriefStreamQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE BW_BRIEF_WAHL a'
      'SET '
      '    a.BW_ERROR = :BW_ERROR '
      '    a.BW_DATA = :BW_DATA'
      'WHERE'
      '    a.BW_ID = :bw_id '
      'AND '
      '    a.WA_ID = :wa_id '
      'AND '
      '    a.MA_ID = :ma_id'
      '')
    Left = 448
    Top = 128
    ParamData = <
      item
        Name = 'BW_ERROR'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BW_DATA'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BW_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
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
end
