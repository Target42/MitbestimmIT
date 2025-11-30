object WahlverfahrenFrame: TWahlverfahrenFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 666
  Align = alClient
  TabOrder = 0
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 0
    Width = 640
    Height = 57
    Align = alTop
    Caption = 'Wahlverfahren'
    Columns = 2
    Items.Strings = (
      'Regul'#228'res Verfahren'
      'Vereinfachtes Verfahren')
    TabOrder = 0
    OnClick = RadioGroup1Click
    ExplicitTop = -6
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 57
    Width = 640
    Height = 609
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    OnMouseWheel = RichEdit1MouseWheel
  end
end
