object ConnectForm: TConnectForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Serverwahl'
  ClientHeight = 259
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 199
    Width = 294
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 199
    ExplicitWidth = 326
    inherited StatusBar1: TStatusBar
      Width = 294
      ExplicitWidth = 297
    end
    inherited Panel1: TPanel
      Width = 294
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 326
      inherited OKBtn: TBitBtn
        Left = 190
        ExplicitLeft = 222
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 32
    Top = 32
    Width = 183
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Server'
    TabOrder = 1
    Text = 'ds://localhost:211'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 32
    Top = 88
    Width = 183
    Height = 23
    EditLabel.Width = 76
    EditLabel.Height = 15
    EditLabel.Caption = 'Benutzername'
    TabOrder = 2
    Text = 'ADMIN_USER'
  end
  object LabeledEdit3: TLabeledEdit
    Left = 32
    Top = 136
    Width = 183
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Passwort'
    PasswordChar = '*'
    TabOrder = 3
    Text = 'admin'
  end
end
