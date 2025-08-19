object MailFrame: TMailFrame
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
    Height = 185
    Align = alTop
    Caption = 'SMTP-Server'
    TabOrder = 0
    object LabeledEdit1: TLabeledEdit
      Left = 24
      Top = 40
      Width = 217
      Height = 23
      EditLabel.Width = 25
      EditLabel.Height = 15
      EditLabel.Caption = 'Host'
      TabOrder = 0
      Text = 'smtp.1und1.de'
    end
    object LabeledEdit2: TLabeledEdit
      Left = 272
      Top = 40
      Width = 33
      Height = 23
      EditLabel.Width = 22
      EditLabel.Height = 15
      EditLabel.Caption = 'Port'
      NumbersOnly = True
      TabOrder = 1
      Text = '465'
    end
    object LabeledEdit3: TLabeledEdit
      Left = 24
      Top = 88
      Width = 369
      Height = 23
      EditLabel.Width = 46
      EditLabel.Height = 15
      EditLabel.Caption = 'Benutzer'
      TabOrder = 2
      Text = 'archivar.server@stephanwinter.eu'
    end
    object LabeledEdit4: TLabeledEdit
      Left = 24
      Top = 143
      Width = 217
      Height = 23
      EditLabel.Width = 47
      EditLabel.Height = 15
      EditLabel.Caption = 'Passwort'
      PasswordChar = '*'
      TabOrder = 3
      Text = 'kH5l9wFiSnkvQnw6dWp5!'
    end
    object CheckBox1: TCheckBox
      Left = 392
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Nicht einrichten'
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 185
    Width = 640
    Height = 176
    Align = alTop
    Caption = 'Probemail'
    TabOrder = 1
    object Panel1: TPanel
      Left = 2
      Top = 17
      Width = 636
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      object LabeledEdit5: TLabeledEdit
        Left = 22
        Top = 24
        Width = 369
        Height = 23
        EditLabel.Width = 81
        EditLabel.Height = 15
        EditLabel.Caption = 'Mailempf'#228'nger'
        TabOrder = 0
        Text = 'stephan.winter@online.de'
      end
      object BitBtn1: TBitBtn
        Left = 424
        Top = 24
        Width = 113
        Height = 25
        Caption = 'Testmail senden'
        TabOrder = 1
        OnClick = BitBtn1Click
      end
    end
    object Memo1: TMemo
      Left = 2
      Top = 81
      Width = 636
      Height = 93
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    Port = 465
    SASLMechanisms = <>
    UseTLS = utUseImplicitTLS
    Left = 480
    Top = 64
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':465'
    MaxLineAction = maException
    Port = 465
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 480
    Top = 136
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    Subject = 'Testmail'
    ConvertPreamble = True
    Left = 560
    Top = 64
  end
end
