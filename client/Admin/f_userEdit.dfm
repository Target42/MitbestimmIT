object UserEditForm: TUserEditForm
  Left = 0
  Top = 0
  Caption = 'Benutzerdaten'
  ClientHeight = 391
  ClientWidth = 396
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
    Top = 331
    Width = 396
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 331
    ExplicitWidth = 396
    inherited StatusBar1: TStatusBar
      Width = 396
      ExplicitWidth = 396
    end
    inherited Panel1: TPanel
      Width = 396
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 396
      inherited OKBtn: TBitBtn
        Left = 292
        ExplicitLeft = 292
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 169
    Height = 23
    EditLabel.Width = 35
    EditLabel.Height = 15
    EditLabel.Caption = 'PersNr'
    ReadOnly = True
    TabOrder = 1
    Text = ''
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 72
    Width = 169
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Name'
    ReadOnly = True
    TabOrder = 2
    Text = ''
  end
  object LabeledEdit3: TLabeledEdit
    Left = 199
    Top = 72
    Width = 184
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Vorname'
    ReadOnly = True
    TabOrder = 3
    Text = ''
  end
  object LabeledEdit4: TLabeledEdit
    Left = 16
    Top = 120
    Width = 121
    Height = 23
    EditLabel.Width = 58
    EditLabel.Height = 15
    EditLabel.Caption = 'Geschlecht'
    ReadOnly = True
    TabOrder = 4
    Text = ''
  end
  object LabeledEdit5: TLabeledEdit
    Left = 160
    Top = 120
    Width = 223
    Height = 23
    EditLabel.Width = 52
    EditLabel.Height = 15
    EditLabel.Caption = 'Abteilung'
    ReadOnly = True
    TabOrder = 5
    Text = ''
  end
  object LabeledEdit6: TLabeledEdit
    Left = 199
    Top = 32
    Width = 184
    Height = 23
    EditLabel.Width = 76
    EditLabel.Height = 15
    EditLabel.Caption = 'Geburtsdatum'
    ReadOnly = True
    TabOrder = 6
    Text = ''
  end
  object LabeledEdit7: TLabeledEdit
    Left = 16
    Top = 168
    Width = 367
    Height = 23
    EditLabel.Width = 33
    EditLabel.Height = 15
    EditLabel.Caption = 'Rollen'
    ReadOnly = True
    TabOrder = 7
    Text = ''
  end
  object LabeledEdit8: TLabeledEdit
    Left = 16
    Top = 216
    Width = 367
    Height = 23
    EditLabel.Width = 29
    EditLabel.Height = 15
    EditLabel.Caption = 'eMail'
    TabOrder = 8
    Text = ''
  end
  object LabeledEdit9: TLabeledEdit
    Left = 16
    Top = 264
    Width = 121
    Height = 23
    EditLabel.Width = 30
    EditLabel.Height = 15
    EditLabel.Caption = 'Login'
    TabOrder = 9
    Text = ''
  end
end
