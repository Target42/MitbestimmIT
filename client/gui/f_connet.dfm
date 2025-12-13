object ConnectForm: TConnectForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Serverwahl'
  ClientHeight = 245
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 32
    Height = 15
    Caption = 'Server'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 185
    Width = 238
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 185
    ExplicitWidth = 238
    inherited StatusBar1: TStatusBar
      Width = 238
      ExplicitWidth = 238
    end
    inherited Panel1: TPanel
      Width = 238
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 238
      inherited OKBtn: TBitBtn
        Left = 134
        ExplicitLeft = 134
      end
    end
  end
  object LabeledEdit2: TLabeledEdit
    Left = 32
    Top = 101
    Width = 183
    Height = 23
    EditLabel.Width = 76
    EditLabel.Height = 15
    EditLabel.Caption = 'Benutzername'
    TabOrder = 1
    Text = ''
  end
  object LabeledEdit3: TLabeledEdit
    Left = 32
    Top = 141
    Width = 183
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Passwort'
    PasswordChar = '*'
    TabOrder = 2
    Text = 'snoopy'
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 61
    Width = 97
    Height = 17
    Caption = 'Admin'
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object ComboBox1: TComboBox
    Left = 32
    Top = 32
    Width = 183
    Height = 23
    TabOrder = 4
    Text = 'ComboBox1'
  end
end
