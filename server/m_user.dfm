object UserMod: TUserMod
  Height = 480
  Width = 640
  object User: TFDQuery
    BeforeOpen = UserBeforeOpen
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT  '
      '    a.*, c.MW_ROLLE, b.MW_LOGIN'
      'FROM '
      '    MA_Mitarbeiter a, MA_PWD b, ma_wa c'
      'where '
      '  b.MA_ID = a.MA_ID'
      'and'
      '  b.MA_ID = c.MA_ID'
      'and'
      '  c.WA_ID = :wa_id'
      'and'
      '  b.ma_ID in '
      '('
      '  select '
      '    ma_id '
      '  from '
      '    ma_wa'
      '  where '
      '    wa_id = :wa_id'
      ')')
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
  object UserQry: TDataSetProvider
    DataSet = User
    Left = 48
    Top = 104
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.FDConnection1
    Left = 40
    Top = 200
  end
  object UpdateUserLogin: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'UPDATE MA_PWD a'
      'SET '
      '    a.MW_LOGIN = :MW_LOGIN'
      'WHERE'
      '    a.MA_ID = :ma_id'
      'and'
      '('
      '  ( a.MW_LOGIN <> :MW_LOGIN )'
      '  or'
      '  ( a.MW_LOGIN is null )  '
      ')')
    Left = 232
    Top = 128
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
  object UpdateUserMail: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'UPDATE MA_MITARBEITER a'
      'SET '
      '    a.MA_MAIL = :MA_MAIL'
      'WHERE'
      '    a.MA_ID = :ma_id '
      'and'
      '('
      '  ( a.MA_MAIL <> :MA_MAIL )'
      '  or'
      '  ( a.MA_MAIL is null )'
      ')')
    Left = 232
    Top = 192
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
  object GetUserID: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT '
      '    a.MA_ID'
      'FROM '
      '    MA_MITARBEITER a, ma_wa b'
      'WHERE'
      '    b.WA_ID = :wa_id'
      'and '
      '    b.MA_ID = a.MA_ID'
      'and    '
      '    a.MA_PERSNR =  :MA_PERSNR'
      '')
    Left = 232
    Top = 48
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MA_PERSNR'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
