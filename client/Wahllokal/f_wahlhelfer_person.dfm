object WahlhelferPersonForm: TWahlhelferPersonForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Wahlhelfer'
  ClientHeight = 237
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 224
    Top = 8
    Width = 51
    Height = 15
    Caption = 'Geschlect'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 129
    Height = 23
    EditLabel.Width = 91
    EditLabel.Height = 15
    EditLabel.Caption = 'Personalnummer'
    TabOrder = 0
    Text = ''
  end
  object ComboBox1: TComboBox
    Left = 224
    Top = 29
    Width = 145
    Height = 23
    ItemIndex = 0
    TabOrder = 1
    Text = 'm'#228'nnlich'
    Items.Strings = (
      'm'#228'nnlich'
      'weilblich'
      'divers')
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 80
    Width = 185
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Name'
    TabOrder = 2
    Text = ''
  end
  object LabeledEdit3: TLabeledEdit
    Left = 224
    Top = 80
    Width = 172
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Vorname'
    TabOrder = 3
    Text = ''
  end
  object LabeledEdit4: TLabeledEdit
    Left = 16
    Top = 128
    Width = 185
    Height = 23
    EditLabel.Width = 52
    EditLabel.Height = 15
    EditLabel.Caption = 'Abteilung'
    TabOrder = 4
    Text = ''
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 177
    Width = 409
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 5
    ExplicitTop = 177
    ExplicitWidth = 409
    inherited StatusBar1: TStatusBar
      Width = 409
      ExplicitWidth = 409
    end
    inherited Panel1: TPanel
      Width = 409
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 409
      inherited OKBtn: TBitBtn
        Left = 305
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 305
      end
    end
  end
end
