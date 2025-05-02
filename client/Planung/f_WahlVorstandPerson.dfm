object WahlVorstandPersonForm: TWahlVorstandPersonForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Mitglied des Wahlvorstandes'
  ClientHeight = 250
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
    Top = 128
    Width = 26
    Height = 15
    Caption = 'Rolle'
  end
  object Label2: TLabel
    Left = 240
    Top = 8
    Width = 38
    Height = 15
    Caption = 'Anrede'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 190
    Width = 465
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 190
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
    EditLabel.Width = 30
    EditLabel.Height = 15
    EditLabel.Caption = 'Login'
    TabOrder = 1
    Text = ''
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 64
    Width = 193
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Name'
    TabOrder = 3
    Text = ''
  end
  object LabeledEdit3: TLabeledEdit
    Left = 240
    Top = 64
    Width = 193
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Vorname'
    TabOrder = 4
    Text = ''
  end
  object LabeledEdit4: TLabeledEdit
    Left = 16
    Top = 104
    Width = 417
    Height = 23
    EditLabel.Width = 29
    EditLabel.Height = 15
    EditLabel.Caption = 'eMail'
    TabOrder = 5
    Text = ''
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 149
    Width = 121
    Height = 17
    Caption = 'Stimmberechtigt'
    TabOrder = 6
  end
  object ComboBox1: TComboBox
    Left = 240
    Top = 149
    Width = 193
    Height = 23
    ItemIndex = 0
    TabOrder = 7
    Text = 'Vorsitzender'
    Items.Strings = (
      'Vorsitzender'
      'Stellvertreter'
      'Ersatz'
      'Gewerksachftsmitglied')
  end
  object ComboBox2: TComboBox
    Left = 240
    Top = 24
    Width = 145
    Height = 23
    ItemIndex = 0
    TabOrder = 2
    Text = 'Herr'
    Items.Strings = (
      'Herr'
      'Frau'
      'Div.')
  end
end
