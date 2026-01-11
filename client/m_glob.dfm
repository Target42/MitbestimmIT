object GM: TGM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 369
  Width = 640
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}'
      'DSAuthenticationPassword=251169'
      'DSAuthenticationUser=stephan')
    AfterDisconnect = SQLConnection1AfterDisconnect
    Left = 128
    Top = 40
    UniqueId = '{EB9B5E39-4CF2-45D6-BE61-1B20D4640028}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWaehlerMod'
    SQLConnection = SQLConnection1
    Left = 256
    Top = 40
  end
  object MAList: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'MitarbeiterTab'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 160
    Top = 96
    object MAListMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Required = True
    end
    object MAListMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Size = 10
    end
    object MAListMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Size = 100
    end
    object MAListMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Size = 100
    end
    object MAListMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      FixedChar = True
      Size = 1
    end
    object MAListMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Size = 100
    end
    object MAListMA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Size = 255
    end
    object MAListMA_GEB: TDateField
      FieldName = 'MA_GEB'
    end
    object MAListWA_ID: TIntegerField
      FieldName = 'WA_ID'
      ReadOnly = True
    end
    object MAListMA_ID_1: TIntegerField
      FieldName = 'MA_ID_1'
      ReadOnly = True
    end
    object MAListMW_ROLLE: TStringField
      FieldName = 'MW_ROLLE'
      ReadOnly = True
      Size = 100
    end
  end
  object MAUserTab: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 296
    Top = 296
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveDataSetWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 160
    Top = 224
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = MAList
    Left = 160
    Top = 160
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = MAUserTab
    Left = 152
    Top = 288
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 440
    Top = 288
  end
end
