object WahllokalRaumform: TWahllokalRaumform
  Left = 0
  Top = 0
  Caption = 'Wahllokal'
  ClientHeight = 202
  ClientWidth = 460
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
    Left = 48
    Top = 72
    Width = 20
    Height = 15
    Caption = 'Von'
  end
  object Label2: TLabel
    Left = 247
    Top = 72
    Width = 15
    Height = 15
    Caption = 'Bis'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 40
    Top = 40
    Width = 121
    Height = 23
    EditLabel.Width = 47
    EditLabel.Height = 15
    EditLabel.Caption = 'Gebaude'
    TabOrder = 0
    Text = ''
  end
  object LabeledEdit2: TLabeledEdit
    Left = 176
    Top = 40
    Width = 121
    Height = 23
    EditLabel.Width = 77
    EditLabel.Height = 15
    EditLabel.Caption = 'Raumnummer'
    TabOrder = 1
    Text = ''
  end
  object LabeledEdit3: TLabeledEdit
    Left = 312
    Top = 40
    Width = 121
    Height = 23
    EditLabel.Width = 54
    EditLabel.Height = 15
    EditLabel.Caption = 'Stockwerk'
    TabOrder = 2
    Text = ''
  end
  object DateTimePicker1: TDateTimePicker
    Left = 40
    Top = 96
    Width = 186
    Height = 23
    Date = 45785.000000000000000000
    Time = 0.863079768518218800
    Kind = dtkDateTime
    TabOrder = 3
  end
  object DateTimePicker2: TDateTimePicker
    Left = 247
    Top = 93
    Width = 186
    Height = 23
    Date = 45785.000000000000000000
    Time = 0.863079768518218800
    Kind = dtkDateTime
    TabOrder = 4
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 142
    Width = 460
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 5
    ExplicitTop = 142
    ExplicitWidth = 460
    inherited StatusBar1: TStatusBar
      Width = 460
      ExplicitWidth = 460
    end
    inherited Panel1: TPanel
      Width = 460
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 460
      inherited OKBtn: TBitBtn
        Left = 356
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 356
      end
    end
  end
end
