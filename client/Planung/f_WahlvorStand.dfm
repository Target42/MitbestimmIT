object WahlVorstandForm: TWahlVorstandForm
  Left = 0
  Top = 0
  Caption = 'Wahlvorstand'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 381
    Width = 624
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 381
    ExplicitWidth = 624
    inherited StatusBar1: TStatusBar
      Width = 624
      ExplicitWidth = 624
    end
    inherited Panel1: TPanel
      Width = 624
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 624
      inherited OKBtn: TBitBtn
        Left = 520
        ExplicitLeft = 520
      end
    end
  end
  inline WahlVorstandFrame1: TWahlVorstandFrame
    Left = 0
    Top = 0
    Width = 624
    Height = 381
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 624
    ExplicitHeight = 381
    inherited GroupBox1: TGroupBox
      Width = 624
      Height = 381
      ExplicitWidth = 624
      ExplicitHeight = 381
      inherited LV: TListView
        Width = 620
        Height = 321
        ExplicitWidth = 620
        ExplicitHeight = 321
      end
      inherited Panel1: TPanel
        Top = 338
        Width = 620
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 338
        ExplicitWidth = 620
        inherited btnDelete: TBitBtn
          Left = 528
          ExplicitLeft = 528
        end
      end
    end
  end
end
