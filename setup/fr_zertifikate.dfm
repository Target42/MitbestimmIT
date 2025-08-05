object ZertifikatFrame: TZertifikatFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Align = alClient
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 640
    Height = 105
    Align = alTop
    Caption = 'Passwort'
    TabOrder = 0
    object LabeledEdit1: TLabeledEdit
      Left = 24
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 47
      EditLabel.Height = 15
      EditLabel.Caption = 'Passwort'
      PasswordChar = '*'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 168
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 75
      EditLabel.Height = 15
      EditLabel.Caption = 'Wiederholung'
      PasswordChar = '*'
      TabOrder = 1
      Text = ''
    end
    object BitBtn1: TBitBtn
      Left = 328
      Top = 39
      Width = 75
      Height = 25
      Caption = 'Erstellen'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 105
    Width = 640
    Height = 375
    Align = alClient
    Caption = 'Log'
    TabOrder = 1
    ExplicitTop = 111
    object Memo1: TMemo
      Left = 2
      Top = 17
      Width = 636
      Height = 356
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
      ExplicitLeft = 56
      ExplicitTop = 64
      ExplicitWidth = 185
      ExplicitHeight = 89
    end
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 512
    Top = 296
  end
  object IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.RootCertFile = 'D:\DelphiBin\MitbestimmIT\Server\Zertifikat\cert.pem'
    SSLOptions.CertFile = 'D:\DelphiBin\MitbestimmIT\Server\Zertifikat\cert.pem'
    SSLOptions.KeyFile = 'D:\DelphiBin\MitbestimmIT\Server\Zertifikat\key.pem'
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 512
    Top = 216
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 5555
    IOHandler = IdServerIOHandlerSSLOpenSSL1
    OnQuerySSLPort = IdHTTPServer1QuerySSLPort
    Left = 512
    Top = 144
  end
  object DosCommand1: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    Left = 152
    Top = 120
  end
end
