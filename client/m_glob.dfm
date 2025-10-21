object GM: TGM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
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
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'MitarbeiterTab'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 376
    Top = 32
  end
  object MAUserTab: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 72
    Top = 168
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveDataSetWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 168
    Top = 168
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = ClientDataSet1
    Left = 304
    Top = 168
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = MAUserTab
    Left = 304
    Top = 232
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 480
    Top = 256
  end
end
