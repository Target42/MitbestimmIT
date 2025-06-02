object WaehlerListeForm: TWaehlerListeForm
  Left = 0
  Top = 0
  Caption = 'W'#228'hlerliste'
  ClientHeight = 441
  ClientWidth = 624
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
    Top = 381
    Width = 624
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
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
  object LV: TListView
    Left = 0
    Top = 0
    Width = 624
    Height = 381
    Align = alClient
    Columns = <
      item
        Caption = 'PersNr'
      end
      item
        Caption = 'Name'
        Width = 100
      end
      item
        Caption = 'Vorname'
        Width = 100
      end
      item
        Caption = 'Anrede'
        Width = 75
      end
      item
        Caption = 'Abteilung'
        Width = 100
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
