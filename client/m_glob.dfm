object GM: TGM
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      
        'Filters={"ZLibCompression":{"CompressMoreThan":"1024"},"RSA":{"U' +
        'seGlobalKey":"true","KeyLength":"1024","KeyExponent":"3"},"PC1":' +
        '{"Key":"5FxYRfCbFnZDuVx6"}}')
    Left = 224
    Top = 120
    UniqueId = '{AEFBC6FD-4AE3-4A88-BC72-BCE5BEFDB22C}'
  end
end
