object UserMod: TUserMod
  Height = 480
  Width = 640
  object User: TFDQuery
    BeforeOpen = UserBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT  '
      '    a.*, b.MW_ROLLE, b.MW_LOGIN'
      'FROM '
      '    MA_Mitarbeiter a, MA_PWD b'
      'where '
      '  b.MA_ID = a.MA_ID'
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
end
