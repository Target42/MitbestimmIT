object AuswertungForm: TAuswertungForm
  Left = 0
  Top = 0
  Caption = 'Wahlauswertung'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 624
    Height = 89
    Align = alTop
    Caption = 'GroupBox1'
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 422
    Width = 624
    Height = 19
    Panels = <>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlMod'
    SQLConnection = GM.SQLConnection1
    Left = 96
    Top = 224
  end
end
