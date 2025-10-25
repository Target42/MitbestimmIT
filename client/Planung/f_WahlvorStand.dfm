object WahlVorstandForm: TWahlVorstandForm
  Left = 0
  Top = 0
  Caption = 'Wahlvorstand'
  ClientHeight = 434
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inline WahlVorstandFrame1: TWahlVorstandFrame
    Left = 0
    Top = 0
    Width = 967
    Height = 415
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 967
    ExplicitHeight = 415
    inherited GroupBox1: TGroupBox
      Width = 967
      Height = 415
      ExplicitWidth = 967
      ExplicitHeight = 415
      inherited LV: TListView
        Width = 963
        Height = 355
        ExplicitWidth = 963
        ExplicitHeight = 355
      end
      inherited Panel1: TPanel
        Top = 372
        Width = 963
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 372
        ExplicitWidth = 963
        inherited btnDelete: TBitBtn
          Left = 871
          ExplicitLeft = 871
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 415
    Width = 967
    Height = 19
    Panels = <>
  end
end
