object WahllistenNameForm: TWahllistenNameForm
  Left = 0
  Top = 0
  Caption = 'Vorschlagslistenname'
  ClientHeight = 126
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 545
    Height = 66
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 32
      Width = 369
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Name'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 400
      Top = 32
      Width = 121
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'K'#252'rzel'
      TabOrder = 1
      Text = ''
    end
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 66
    Width = 545
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 66
    ExplicitWidth = 545
    inherited StatusBar1: TStatusBar
      Width = 545
      ExplicitWidth = 545
    end
    inherited Panel1: TPanel
      Width = 545
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 545
      inherited OKBtn: TBitBtn
        Left = 441
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 441
      end
    end
  end
end
