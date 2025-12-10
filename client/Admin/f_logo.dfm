object LogoForm: TLogoForm
  Left = 0
  Top = 0
  Caption = 'Wahl-Logo'
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
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 624
    Height = 320
    Align = alClient
    ExplicitLeft = 96
    ExplicitTop = 40
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 381
    Width = 624
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = 208
    inherited StatusBar1: TStatusBar
      Width = 624
    end
    inherited Panel1: TPanel
      Width = 624
      StyleElements = [seFont, seClient, seBorder]
      inherited OKBtn: TBitBtn
        Left = 520
        OnClick = BaseFrame1OKBtnClick
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 320
    Width = 624
    Height = 61
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Bild laden'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 224
    Top = 168
  end
end
