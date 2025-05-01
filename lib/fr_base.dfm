object BaseFrame: TBaseFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 60
  Align = alBottom
  AutoSize = True
  TabOrder = 0
  object StatusBar1: TStatusBar
    Left = 0
    Top = 41
    Width = 640
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      640
      41)
    object CancelBtn: TBitBtn
      Left = 16
      Top = 10
      Width = 89
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
    end
    object OKBtn: TBitBtn
      Left = 536
      Top = 10
      Width = 91
      Height = 25
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
