object ConnectForm: TConnectForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Serverwahl'
  ClientHeight = 259
  ClientWidth = 326
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 199
    Width = 326
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = 304
    ExplicitWidth = 326
    inherited StatusBar1: TStatusBar
      Width = 326
      ExplicitWidth = 326
    end
    inherited Panel1: TPanel
      Width = 326
      ExplicitWidth = 326
      inherited OKBtn: TBitBtn
        Left = 222
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
    Text = ''
  end
  object CheckBox1: TCheckBox
    Left = 221
    Top = 35
    Width = 97
    Height = 17
    Caption = 'Simulation'
    TabOrder = 2
  end
  object LabeledEdit2: TLabeledEdit
    Left = 32
    Top = 88
    Width = 183
    Height = 23
    EditLabel.Width = 76
    EditLabel.Height = 15
    EditLabel.Caption = 'Benutzername'
    TabOrder = 3
    Text = ''
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
    TabOrder = 4
    Text = ''
  end
end
