object SelectWahlform: TSelectWahlform
  Left = 0
  Top = 0
  Caption = 'Wahl ausw'#228'hlen'
  ClientHeight = 321
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 261
    Width = 566
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = 192
    inherited StatusBar1: TStatusBar
      Width = 566
      ExplicitWidth = 566
    end
    inherited Panel1: TPanel
      Width = 566
      StyleElements = [seFont, seClient, seBorder]
      inherited OKBtn: TBitBtn
        Left = 462
      end
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 48
  end
end
