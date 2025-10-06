object WahlDateform: TWahlDateform
  Left = 0
  Top = 0
  Caption = 'Wahltagdatum bestimmen'
  ClientHeight = 226
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 166
    Width = 689
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = 208
    inherited StatusBar1: TStatusBar
      Width = 689
      ExplicitWidth = 689
    end
    inherited Panel1: TPanel
      Width = 689
      StyleElements = [seFont, seClient, seBorder]
      inherited OKBtn: TBitBtn
        Left = 585
      end
    end
  end
  object MonthCalendar1: TMonthCalendar
    Left = 0
    Top = 0
    Width = 689
    Height = 166
    Align = alClient
    Date = 45935.000000000000000000
    TabOrder = 1
    ExplicitLeft = -16
    ExplicitTop = 8
    ExplicitWidth = 191
    ExplicitHeight = 160
  end
end
