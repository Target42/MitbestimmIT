object ConnectForm: TConnectForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Serverwahl'
  ClientHeight = 251
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 191
    Width = 255
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 191
    ExplicitWidth = 255
    inherited StatusBar1: TStatusBar
      Width = 255
      ExplicitWidth = 255
    end
    inherited Panel1: TPanel
      Width = 255
      ExplicitWidth = 255
      inherited OKBtn: TBitBtn
        Left = 151
        ExplicitLeft = 151
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
    Top = 101
    Width = 183
    Height = 23
    EditLabel.Width = 76
    EditLabel.Height = 15
    EditLabel.Caption = 'Benutzername'
    TabOrder = 2
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
    TabOrder = 3
    Text = 'snoopy'
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 61
    Width = 97
    Height = 17
    Caption = 'Admin'
    TabOrder = 4
    OnClick = CheckBox1Click
  end
end
