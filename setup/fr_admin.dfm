object AdminFrame: TAdminFrame
  Left = 0
  Top = 0
  Width = 496
  Height = 441
  Align = alClient
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 496
    Height = 105
    Align = alTop
    Caption = 'Admin-Passwort'
    TabOrder = 0
    object LabeledEdit1: TLabeledEdit
      Left = 24
      Top = 40
      Width = 217
      Height = 23
      EditLabel.Width = 47
      EditLabel.Height = 15
      EditLabel.Caption = 'Passwort'
      PasswordChar = '*'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 256
      Top = 40
      Width = 217
      Height = 23
      EditLabel.Width = 75
      EditLabel.Height = 15
      EditLabel.Caption = 'Wiederholung'
      PasswordChar = '*'
      TabOrder = 1
      Text = ''
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 105
    Width = 496
    Height = 240
    Align = alTop
    Caption = '2-Faktorauthentifizirung'
    TabOrder = 1
    object Image1: TImage
      Left = 232
      Top = 17
      Width = 262
      Height = 221
      Align = alRight
      Proportional = True
      Stretch = True
      ExplicitLeft = 231
    end
    object Splitter1: TSplitter
      Left = 229
      Top = 17
      Height = 221
      Align = alRight
      ExplicitLeft = 392
      ExplicitTop = 56
      ExplicitHeight = 100
    end
    object Panel1: TPanel
      Left = 2
      Top = 17
      Width = 227
      Height = 221
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 26
        Width = 221
        Height = 45
        Align = alTop
        Caption = 
          'F'#252'r die 2-Faktorauthentifizierung wird ein Authendificatior, wie' +
          ' z.B. der von Google oder  Microsoft ben'#246'tigt.'
        WordWrap = True
      end
      object Label2: TLabel
        Left = 0
        Top = 74
        Width = 227
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = 'Code'
        ExplicitWidth = 28
      end
      object CodeLab: TLabel
        Left = 0
        Top = 89
        Width = 227
        Height = 30
        Align = alTop
        Alignment = taCenter
        Caption = '123456'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 66
      end
      object CheckBox1: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 221
        Height = 17
        Align = alTop
        Caption = 'Aktivieren'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 314
    Top = 234
  end
  object IdSNTP1: TIdSNTP
    Host = 'de.pool.ntp.org'
    Port = 123
    Left = 328
    Top = 161
  end
end
