object BriefWahlMod: TBriefWahlMod
  Height = 480
  Width = 640
  object MaList: TFDQuery
    BeforeOpen = MaListBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT'
      '    m.*,'
      
        '    b.bw_id, b.BW_ANTRAG, b.BW_VERSENDET, b.BW_EMPFANGEN, b.BW_E' +
        'RROR '
      'FROM'
      '    MA_MITARBEITER m'
      'LEFT JOIN'
      '    BW_BRIEF_WAHL b ON m.MA_ID = b.MA_ID '
      'WHERE'
      '    m.MA_ID IN ('
      '        SELECT ma_id'
      '        FROM ma_wa'
      '        WHERE wa_id = :wa_id'
      '    );')
    Left = 96
    Top = 80
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object MaListQry: TDataSetProvider
    DataSet = MaList
    Left = 96
    Top = 152
  end
  object MaBw: TFDQuery
    BeforeOpen = MaBwBeforeOpen
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM BW_BRIEF_WAHL '
      'where WA_ID = :wa_id')
    Left = 200
    Top = 88
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object MaBwQry: TDataSetProvider
    DataSet = MaBw
    Left = 200
    Top = 160
  end
  object BWTab: TFDTable
    IndexFieldNames = 'BW_ID;WA_ID;MA_ID'
    Connection = DBMod.FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoIncFields = 'BW_ID'
    TableName = 'BW_BRIEF_WAHL'
    Left = 328
    Top = 96
  end
end
