object ServerMain: TServerMain
  DisplayName = 'ServerMain'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 705
  Width = 718
  PixelsPerInch = 144
  object DSServer1: TDSServer
    Left = 216
    Top = 26
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
    Left = 216
    Top = 165
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
    Left = 216
    Top = 305
  end
  object DSCertFiles1: TDSCertFiles
    SSLVersion = sslvSSLv23
    RootCertFile = 'D:\git_d12\MitbestimmIT\server\Zertifikat\cert.pem'
    CertFile = 'D:\git_d12\MitbestimmIT\server\Zertifikat\cert.pem'
    KeyFile = 'D:\git_d12\MitbestimmIT\server\Zertifikat\key.pem'
    OnGetPEMFileSBPasskey = DSCertFiles1GetPEMFileSBPasskey
    Left = 486
    Top = 468
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
    Left = 450
    Top = 305
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 216
    Top = 444
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 450
    Top = 26
  end
end
