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
      ImageIndex = 0
      Images = PngImageList1
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 448
      Top = 39
      Width = 75
      Height = 25
      Caption = 'Testen'
      ImageIndex = 1
      Images = PngImageList1
      TabOrder = 3
      OnClick = BitBtn2Click
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
    object Memo1: TRichEdit
      Left = 2
      Top = 17
      Width = 636
      Height = 356
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnMouseWheelDown = Memo1MouseWheelDown
      OnMouseWheelUp = Memo1MouseWheelUp
      ExplicitLeft = -158
      ExplicitTop = 41
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
    OnGetPassword = IdServerIOHandlerSSLOpenSSL1GetPassword
    Left = 360
    Top = 224
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 5555
    IOHandler = IdServerIOHandlerSSLOpenSSL1
    OnQuerySSLPort = IdHTTPServer1QuerySSLPort
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 512
    Top = 144
  end
  object DosCommand1: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCommand1NewLine
    OnTerminateProcess = DosCommand1TerminateProcess
    Left = 152
    Top = 120
  end
  object PngImageList1: TPngImageList
    PngImages = <
      item
        Background = clWindow
        Name = 'Plus_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA793000000E54944415478DA6364A0
          1030A20B04AE0B14FBCDF83F13C8F4066279A8F043C6FF8C5BFEFC6199BE3D6C
          F56B9C06F86EF08FFAFF9F711690C98DC3C22F0C8CFF53B6046C5C896180F7BA
          C05046C6FF2BB1B90A0DFC075A12B23568FD3AB8019EAB424599597FDF0132F9
          9055DA485B81E9234F8FA11BF281F53FA3CAFAA0F56FC106F8AE0F68FACFC050
          8BAE6A73C07AA8D702B1B9A4614BE08646B0013EEB022F02FDA647A201E78106
          18410C581FF01948F1C09C5D6E5A8AD5F39DA7BB91BDF31968001F950CA0D40B
          140722C5D1080214252418A02829C3005A66D2860A5F252A339103004DC68C11
          CCE2F5530000000049454E44AE426082}
      end
      item
        Background = clWindow
        Name = 'Approval_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA7930000019F4944415478DA6364A0
          1030E2926838E3CBC5FDFDDF0410FB2B27534183C9E66F4419D07DD86B3B9032
          63F8FFFF3F0323A33054F80D103301F1C952DB6D5E380DE83DE869F88F89F10C
          543136F0EF3F13837199F5B60B2806CC3C63CCFAF1BBF85620C7198F66B0E2FF
          404380C49EAF7FBF7937381EF8037701D0E96F8194102ECDDC5C3C0C3A9AFA0C
          57AE5F64F8FAF5F3DB52BBED227017F41D0BE5FCFBF7EB5D2053129B663E5E3E
          067D6D13860F9FDE335CBD7191E1DFBFBFCFBEFEF9AE0C74C10FB001DD873C17
          00032C1EC46666666660676367F8F61D12E83CDCBC0C063A260C5FBE7E62B87C
          ED02C3DF7F7F21DE6164585062B32D9111EAFC45402A16C45656506390109762
          B878E52C4811833E48F3974F0C97AE9D07DAFC0FD9618B803112CF8888F3BF77
          405E60626202FB959F570014600C9F3E7F04FBFB1FD4662878CECCCCAD5C64B5
          FA3B7220BE07520210E73131686BE881C5AFDEB8044C12FFD04285E13DD07621
          BCD108720938E2FF6168C61E8D14252464803529FFFFFF16C806A9C59F949141
          C37E070E2E16CE8920F6B73FDFF341718E2B75520400ECA0B1116437FF650000
          000049454E44AE426082}
      end>
    Left = 216
    Top = 225
  end
end
