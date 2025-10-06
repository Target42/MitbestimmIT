object WahlMod: TWahlMod
  Height = 480
  Width = 640
  object WAtab: TFDTable
    IndexFieldNames = 'WA_ID'
    Connection = DBMod.FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'WA_WAHL'
    Left = 80
    Top = 40
    object WAtabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WAtabWA_TITLE: TStringField
      FieldName = 'WA_TITLE'
      Origin = 'WA_TITLE'
      Size = 150
    end
    object WAtabWA_SIMU: TStringField
      FieldName = 'WA_SIMU'
      Origin = 'WA_SIMU'
      FixedChar = True
      Size = 1
    end
    object WAtabWA_ACTIVE: TStringField
      FieldName = 'WA_ACTIVE'
      Origin = 'WA_ACTIVE'
      FixedChar = True
      Size = 1
    end
    object WAtabWA_DATA: TBlobField
      FieldName = 'WA_DATA'
      Origin = 'WA_DATA'
    end
  end
  object FDQuery1: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM WA_WAHL a'
      'WHERE'
      '    a.WA_ID = :waid'
      '')
    Left = 168
    Top = 40
    ParamData = <
      item
        Name = 'WAID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
