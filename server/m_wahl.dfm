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
  object WahlList: TFDQuery
    BeforeOpen = WahlListBeforeOpen
    Connection = DBMod.FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      
        'select a.wa_id, a.WA_TITLE, a.WA_SIMU, a.WA_ACTIVE, b.MA_ID from' +
        ' WA_WAHL a, MA_WA b'
      'where'
      '  a.WA_ID = b.WA_ID'
      'and  b.MA_ID = :ma_id'
      '')
    Left = 328
    Top = 48
    ParamData = <
      item
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object WahlListWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WahlListWA_TITLE: TStringField
      FieldName = 'WA_TITLE'
      Origin = 'WA_TITLE'
      Size = 150
    end
    object WahlListWA_SIMU: TStringField
      FieldName = 'WA_SIMU'
      Origin = 'WA_SIMU'
      OnGetText = WahlListWA_SIMUGetText
      FixedChar = True
      Size = 1
    end
    object WahlListWA_ACTIVE: TStringField
      FieldName = 'WA_ACTIVE'
      Origin = 'WA_ACTIVE'
      OnGetText = WahlListWA_ACTIVEGetText
      FixedChar = True
      Size = 1
    end
    object WahlListMA_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object WahlListQry: TDataSetProvider
    DataSet = WahlList
    Left = 328
    Top = 112
  end
end
