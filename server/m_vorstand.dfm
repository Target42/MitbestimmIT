object VortandMod: TVortandMod
  Height = 480
  Width = 640
  object ListMAQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'select '
      '    a.wv_rolle, a.wv_chef, b.*'
      'from'
      '  wv_wahl_vorstand a, ma_mitarbeiter b'
      'where'
      '  a.WA_ID = :wa_id'
      'and '
      '  a.MA_ID = b.MA_ID')
    Left = 72
    Top = 64
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object ListMAQryWV_ROLLE: TStringField
      FieldName = 'WV_ROLLE'
      Origin = 'WV_ROLLE'
      Size = 100
    end
    object ListMAQryWV_CHEF: TStringField
      FieldName = 'WV_CHEF'
      Origin = 'WV_CHEF'
      FixedChar = True
      Size = 1
    end
    object ListMAQryMA_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInKey]
      ReadOnly = True
    end
    object ListMAQryMA_PERSNR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object ListMAQryMA_NAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object ListMAQryMA_VORNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object ListMAQryMA_GENDER: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object ListMAQryMA_ABTEILUNG: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object ListMAQryMA_MAIL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'MA_MAIL'
      Origin = 'MA_MAIL'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object ListMAQryMA_GEB: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'MA_GEB'
      Origin = 'MA_GEB'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object LoginQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'select '
      '    a.mw_login, a.MA_ID'
      'from'
      '  MA_PWD a'
      '  '
      'where a.MA_ID in'
      '('
      '    select '
      '       ma_id '
      '    from'
      '      WV_WAHL_VORSTAND'
      '    where '
      '      wa_id = :wa_id'
      ')')
    Left = 160
    Top = 64
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object LoginQryMW_LOGIN: TStringField
      FieldName = 'MW_LOGIN'
      Origin = 'MW_LOGIN'
    end
    object LoginQryMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object DelQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'DELETE FROM WV_WAHL_VORSTAND a '
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.MA_ID = :ma_id and'
      '    a.WV_CHEF <> '#39'T'#39
      '    '
      '')
    Left = 80
    Top = 144
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
  object UpdateWVQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE WV_WAHL_VORSTAND a'
      'SET '
      '    a.WV_ROLLE = :WV_ROLLE, '
      '    a.WV_CHEF = :WV_CHEF'
      'WHERE'
      '    a.WA_ID = :wa_id AND '
      '    a.MA_ID = :ma_id'
      '')
    Left = 224
    Top = 136
    ParamData = <
      item
        Name = 'WV_ROLLE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'WV_CHEF'
        DataType = ftString
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
  object UpdateLoginQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE MA_PWD a'
      'SET '
      '    a.MW_LOGIN = :MW_LOGIN'
      'WHERE'
      '    a.MA_ID = :ma_id'
      '')
    Left = 216
    Top = 200
    ParamData = <
      item
        Name = 'MW_LOGIN'
        DataType = ftString
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
  object UpdateMailQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'UPDATE MA_MITARBEITER a'
      'SET  '
      '    a.MA_MAIL = :MA_MAIL'
      'WHERE'
      '    a.MA_ID = :ma_id'
      '')
    Left = 216
    Top = 280
    ParamData = <
      item
        Name = 'MA_MAIL'
        DataType = ftString
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
  object AddLoginQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'INSERT INTO MA_PWD (MA_ID)'
      'VALUES ('
      '    :MA_ID'
      ');'
      '')
    Left = 440
    Top = 128
    ParamData = <
      item
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object AddVorstandQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'INSERT INTO WV_WAHL_VORSTAND (WA_ID, MA_ID)'
      'VALUES ('
      '    :WA_ID, '
      '    :MA_ID'
      ');'
      '')
    Left = 448
    Top = 208
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
end
