object LogMod: TLogMod
  Height = 480
  Width = 640
  object AddLogQry: TFDQuery
    Connection = DBMod.FDConnection1
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'LG_ID'
    SQL.Strings = (
      'INSERT INTO LG_LOG (WA_ID, LG_DATA, LG_USER)'
      'VALUES ('
      '    :WA_ID, '
      '    :LG_DATA,'
      '    :LG_USER'
      ');'
      '')
    Left = 120
    Top = 56
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'LG_DATA'
        DataType = ftBlob
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'LG_USER'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
