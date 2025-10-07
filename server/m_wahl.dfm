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
    object WAtabWA_TYP: TIntegerField
      FieldName = 'WA_TYP'
      Origin = 'WA_TYP'
    end
  end
  object WahlList: TFDQuery
    BeforeOpen = WahlListBeforeOpen
    Connection = DBMod.FDConnection1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      
        'select a.wa_id, a.WA_TITLE, a.WA_SIMU, a.WA_ACTIVE, a.WA_TYP, b.' +
        'MA_ID from WA_WAHL a, MA_WA b'
      'where'
      '  a.WA_ID = b.WA_ID'
      'and  '
      '  b.MA_ID = :ma_id'
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
    object WahlListWA_TYP: TIntegerField
      FieldName = 'WA_TYP'
      Origin = 'WA_TYP'
    end
  end
  object WahlListQry: TDataSetProvider
    DataSet = WahlList
    Left = 328
    Top = 112
  end
  object CheckMAIDQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT WA_ID, MA_ID'
      'FROM MA_WA '
      'where '
      '    ma_id = :ma_id'
      'and'
      '    WA_ID = :wa_id;')
    Left = 464
    Top = 88
    ParamData = <
      item
        Name = 'MA_ID'
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
  object WahlDataQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM WA_WAHL a'
      'WHERE'
      '    WA_ID = :wa_id'
      'and'
      '  WA_ACTIVE = '#39'T'#39)
    Left = 184
    Top = 88
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object UpdateTypeQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'UPDATE WA_WAHL a'
      'SET '
      '    a.WA_TYP = :WA_TYP'
      'WHERE'
      '    a.WA_ID = :wa_id;'
      '')
    Left = 152
    Top = 240
    ParamData = <
      item
        Name = 'WA_TYP'
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
  object DeletePhasenQry: TFDQuery
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM WF_FRISTEN a '
      'WHERE'
      '    a.WA_ID = :wa_id'
      '')
    Left = 144
    Top = 304
    ParamData = <
      item
        Name = 'WA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDTransaction1: TFDTransaction
    Options.AutoStart = False
    Connection = DBMod.FDConnection1
    Left = 264
    Top = 280
  end
  object WFTab: TFDTable
    IndexFieldNames = 'WA_ID;WF_ID'
    Connection = DBMod.FDConnection1
    Transaction = FDTransaction1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'WF_FRISTEN'
    Left = 136
    Top = 368
    object WFTabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WFTabWF_ID: TIntegerField
      FieldName = 'WF_ID'
      Origin = 'WF_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WFTabWF_TITEL: TStringField
      FieldName = 'WF_TITEL'
      Origin = 'WF_TITEL'
      Size = 100
    end
    object WFTabWF_START: TSQLTimeStampField
      FieldName = 'WF_START'
      Origin = 'WF_START'
    end
    object WFTabWF_ENDE: TSQLTimeStampField
      FieldName = 'WF_ENDE'
      Origin = 'WF_ENDE'
    end
    object WFTabWF_TYP: TIntegerField
      FieldName = 'WF_TYP'
      Origin = 'WF_TYP'
    end
  end
end
