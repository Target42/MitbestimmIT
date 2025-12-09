object StadMod: TStadMod
  Height = 480
  Width = 640
  object MAQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'select '
      '  b.MA_GENDER,'
      '  count(a.ma_id) '
      'from '
      '    ma_wa a, ma_mitarbeiter b'
      'where '
      '  a.wa_id = :wa_id'
      'and  '
      '  a.MA_ID = b.MA_ID'
      'group by b.ma_gender'
      '')
    Left = 48
    Top = 40
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object ListenQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT '
      '  distinct a.WT_NAME, a.WT_KURZ, count(b.WA_ID)'
      'FROM '
      '  WT_WAHL_LISTE a, wt_wa b'
      'where'
      '  a.WA_ID = :wa_id'
      'and  '
      '  b.WT_ID = a.WA_ID'
      'group by '
      '  a.wt_name, a.WT_KURZ'
      '   ')
    Left = 160
    Top = 56
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object LokaleQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'select  '
      '  distinct a.wl_bau, a.wl_stockwerk, a.wl_raum, count(b.WL_ID)'
      'from'
      '  wl_wahl_lokal a, WH_WAHL_HELFER b'
      'where'
      '  a.WA_ID = :wa_id'
      'and'
      '  a.WL_ID = b.WL_ID  '
      'group by'
      '  a.WL_BAU, a.WL_STOCKWERK, a.WL_RAUM'
      ''
      '   ')
    Left = 56
    Top = 120
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object WahlQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT '
      '  *'
      'FROM '
      '  WF_FRISTEN '
      'where'
      '  wa_id = :wa_id'
      '  ')
    Left = 152
    Top = 144
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object BriefQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT'
      
        '    SUM(CASE WHEN r.BW_ANTRAG IS NOT NULL THEN 1 ELSE 0 END) AS ' +
        'ANTRAG_COUNT,'
      
        '    SUM(CASE WHEN r.BW_VERSENDET IS NOT NULL THEN 1 ELSE 0 END) ' +
        'AS VERSENDET_COUNT,'
      
        '    SUM(CASE WHEN r.BW_EMPFANGEN IS NOT NULL THEN 1 ELSE 0 END) ' +
        'AS EMPFANGEN_COUNT'
      'FROM BW_BRIEF_WAHL r'
      'where'
      '  r.wa_id = :wa_id')
    Left = 344
    Top = 80
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object StimmenQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT count(r.WA_ID)'
      'FROM MA_WL r'
      'where'
      '  wa_id = :wa_id')
    Left = 344
    Top = 160
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
