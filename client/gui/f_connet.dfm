object ConnectForm: TConnectForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Serverwahl'
  ClientHeight = 325
  ClientWidth = 294
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
  object Label1: TLabel
    Left = 32
    Top = 84
    Width = 27
    Height = 15
    Caption = 'Wahl'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 265
    Width = 294
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 265
    ExplicitWidth = 294
    inherited StatusBar1: TStatusBar
      Width = 294
      ExplicitWidth = 294
    end
    inherited Panel1: TPanel
      Width = 294
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 294
      inherited OKBtn: TBitBtn
        Left = 190
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 190
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
    Top = 165
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
    Top = 205
    Width = 183
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Passwort'
    PasswordChar = '*'
    TabOrder = 3
    Text = 'admin'
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 61
    Width = 97
    Height = 17
    Caption = 'Admin'
    TabOrder = 4
  end
  object ComboBox1: TComboBox
    Left = 32
    Top = 105
    Width = 225
    Height = 23
    TabOrder = 5
    Text = 'ComboBox1'
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 240
    Top = 32
  end
end
