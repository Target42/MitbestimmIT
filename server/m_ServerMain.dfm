object MitbestimmITSrv: TMitbestimmITSrv
  OnCreate = ServiceCreate
  DisplayName = 'MitbestimmIT Server'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 470
  Width = 1026
  object DSServer1: TDSServer
    OnConnect = DSServer1Connect
    AutoStart = False
    Left = 72
    Top = 25
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Server = DSServer1
    Filters = <
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=08KZrMJEE8YLYZBg')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 72
    Top = 94
  end
  object DSHTTPService1: TDSHTTPService
    HttpPort = 8080
    Server = DSServer1
    Filters = <
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=3bFmaErZcTWmmXCJ')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 72
    Top = 163
  end
  object DSCertFiles1: TDSCertFiles
    SSLVersion = sslvSSLv23
    OnGetPEMFileSBPasskey = DSCertFiles1GetPEMFileSBPasskey
    Left = 220
    Top = 208
  end
  object DSHTTPService2: TDSHTTPService
    HttpPort = 8081
    CertFiles = DSCertFiles1
    Filters = <
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 220
    Top = 139
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 64
    Top = 296
  end
  object DSAdmin: TDSServerClass
    OnGetClass = DSAdminGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 460
    Top = 17
  end
  object DSLogin: TDSServerClass
    OnGetClass = DSLoginGetClass
    Server = DSServer1
    Left = 384
    Top = 16
  end
  object UserPWDQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM MA_PWD '
      'where MW_LOGIN = :login')
    Left = 224
    Top = 304
    ParamData = <
      item
        Name = 'LOGIN'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object AdminTab: TFDTable
    Connection = DBMod.FDConnection1
    TableName = 'AD_ADMIN'
    Left = 352
    Top = 304
  end
  object DSWahl: TDSServerClass
    OnGetClass = DSWahlGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 552
    Top = 16
  end
  object DSWaehler: TDSServerClass
    OnGetClass = DSWaehlerGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 624
    Top = 16
  end
  object DSLokale: TDSServerClass
    OnGetClass = DSLokaleGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 712
    Top = 16
  end
  object DSVorstand: TDSServerClass
    OnGetClass = DSVorstandGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 784
    Top = 16
  end
  object GetUserQry: TFDQuery
    Connection = DBMod.FDConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM MA_MITARBEITER '
      'where'
      '  ma_id = :ma_id')
    Left = 224
    Top = 368
    ParamData = <
      item
        Name = 'MA_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DSWahlliste: TDSServerClass
    OnGetClass = DSWahllisteGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 856
    Top = 16
  end
  object DSBriefwahl: TDSServerClass
    OnGetClass = DSBriefwahlGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 384
    Top = 88
  end
  object DsStat: TDSServerClass
    OnGetClass = DsStatGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 472
    Top = 88
  end
  object DSUser: TDSServerClass
    OnGetClass = DSUserGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 552
    Top = 88
  end
  object DSWahlLokal: TDSServerClass
    OnGetClass = DSWahlLokalGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 624
    Top = 88
  end
  object DSGlob: TDSServerClass
    OnGetClass = DSGlobGetClass
    Server = DSServer1
    Left = 496
    Top = 216
  end
  object DSAuswertung: TDSServerClass
    OnGetClass = DSAuswertungGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 720
    Top = 88
  end
end
