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
    object Label1: TLabel
      Left = 426
      Top = 63
      Width = 19
      Height = 15
      Caption = 'TLS'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 24
      Top = 37
      Width = 217
      Height = 23
      EditLabel.Width = 25
      EditLabel.Height = 15
      EditLabel.Caption = 'Host'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 272
      Top = 37
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
      Text = ''
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
      Text = ''
    end
    object CheckBox1: TCheckBox
      Left = 426
      Top = 40
      Width = 161
      Height = 17
      Caption = 'Nicht jetzt einrichten'
      TabOrder = 4
    end
    object ComboBox1: TComboBox
      Left = 426
      Top = 84
      Width = 145
      Height = 23
      ItemIndex = 2
      TabOrder = 5
      Text = 'Implizit (Port 465)'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Keines (Port 25 )'
        'Explizit (Port 587)'
        'Implizit (Port 465)')
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 185
    Width = 640
    Height = 295
    Align = alClient
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
        Text = ''
      end
      object BitBtn1: TBitBtn
        Left = 424
        Top = 24
        Width = 113
        Height = 25
        Caption = 'Testmail senden'
        ImageIndex = 1
        Images = ResMod.PngImageList1
        TabOrder = 1
        OnClick = BitBtn1Click
      end
    end
    object Memo1: TMemo
      Left = 2
      Top = 81
      Width = 636
      Height = 212
      Align = alClient
      Lines.Strings = (
        'Herzlichen Gl'#252'ckwunch!'
        ''
        'Dies ist eine erfolgreiche Testmail vom MitbestimmIT.')
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    SASLMechanisms = <>
    Left = 336
    Top = 240
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':25'
    MaxLineAction = maException
    Port = 25
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 416
    Top = 352
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
    Left = 552
    Top = 296
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 376
    Top = 168
  end
end
