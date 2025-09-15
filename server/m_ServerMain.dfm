object MitbestimmITSrv: TMitbestimmITSrv
  OnCreate = ServiceCreate
  DisplayName = 'MitbestimmIT Server'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 470
  Width = 479
  object DSServer1: TDSServer
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
    RootCertFile = 'D:\git_d12\MitbestimmIT\server\Zertifikat\cert.pem'
    CertFile = 'D:\git_d12\MitbestimmIT\server\Zertifikat\cert.pem'
    KeyFile = 'D:\git_d12\MitbestimmIT\server\Zertifikat\key.pem'
    OnGetPEMFileSBPasskey = DSCertFiles1GetPEMFileSBPasskey
    Left = 188
    Top = 240
  end
  object DSHTTPService2: TDSHTTPService
    HttpPort = 8081
    CertFiles = DSCertFiles1
    Server = DSServer1
    Filters = <
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 204
    Top = 171
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 72
    Top = 240
  end
  object DSAdmin: TDSServerClass
    OnGetClass = DSAdminGetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 340
    Top = 25
  end
end
