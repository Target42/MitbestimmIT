object WahlVorstandPersonForm: TWahlVorstandPersonForm
  Left = 0
  Top = 0
  Caption = 'Mitglied des Wahlvorstandes'
  ClientHeight = 271
  ClientWidth = 465
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
    Left = 240
    Top = 149
    Width = 26
    Height = 15
    Caption = 'Rolle'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 211
    Width = 465
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 211
    ExplicitWidth = 465
    inherited StatusBar1: TStatusBar
      Width = 465
      ExplicitWidth = 465
    end
    inherited Panel1: TPanel
      Width = 465
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 465
      inherited OKBtn: TBitBtn
        Left = 361
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 361
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 23
    EditLabel.Width = 35
    EditLabel.Height = 15
    EditLabel.Caption = 'PersNr'
    Enabled = False
    TabOrder = 1
    Text = ''
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 75
    Width = 193
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Name'
    Enabled = False
    TabOrder = 2
    Text = ''
  end
  object LabeledEdit3: TLabeledEdit
    Left = 240
    Top = 75
    Width = 193
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Vorname'
    Enabled = False
    TabOrder = 3
    Text = ''
  end
  object LabeledEdit4: TLabeledEdit
    Left = 16
    Top = 120
    Width = 417
    Height = 23
    EditLabel.Width = 29
    EditLabel.Height = 15
    EditLabel.Caption = 'eMail'
    TabOrder = 4
    Text = ''
  end
  object ComboBox1: TComboBox
    Left = 240
    Top = 165
    Width = 193
    Height = 23
    ItemIndex = 0
    TabOrder = 5
    Text = 'Vorsitzender'
    Items.Strings = (
      'Vorsitzender'
      'Stellvertreter'
      'Ersatz'
      'Gewerksachftsmitglied')
  end
  object LabeledEdit5: TLabeledEdit
    Left = 16
    Top = 165
    Width = 185
    Height = 23
    EditLabel.Width = 30
    EditLabel.Height = 15
    EditLabel.Caption = 'Login'
    TabOrder = 6
    Text = ''
  end
  object LabeledEdit6: TLabeledEdit
    Left = 240
    Top = 24
    Width = 121
    Height = 23
    EditLabel.Width = 58
    EditLabel.Height = 15
    EditLabel.Caption = 'Geschlecht'
    Enabled = False
    TabOrder = 7
    Text = ''
  end
end
