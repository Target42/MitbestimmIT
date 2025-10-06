object WahlPhaseForm: TWahlPhaseForm
  Left = 0
  Top = 0
  Caption = 'Wahlphase'
  ClientHeight = 220
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 40
    Top = 56
    Width = 24
    Height = 15
    Caption = 'Start'
  end
  object Label3: TLabel
    Left = 240
    Top = 56
    Width = 26
    Height = 15
    Caption = 'Ende'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 160
    Width = 572
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = 296
    inherited StatusBar1: TStatusBar
      Width = 572
      ExplicitWidth = 573
    end
    inherited Panel1: TPanel
      Width = 572
      StyleElements = [seFont, seClient, seBorder]
      inherited OKBtn: TBitBtn
        Left = 468
      end
    end
  end
  object DateTimePicker1: TDateTimePicker
    Left = 40
    Top = 80
    Width = 186
    Height = 23
    Date = 45935.000000000000000000
    Time = 0.524358888891583800
    Kind = dtkDateTime
    TabOrder = 1
  end
  object DateTimePicker2: TDateTimePicker
    Left = 240
    Top = 77
    Width = 186
    Height = 23
    Date = 45935.000000000000000000
    Time = 0.524358888891583800
    Kind = dtkDateTime
    TabOrder = 2
  end
end
