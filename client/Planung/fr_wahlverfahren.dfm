object WahlverfahrenFrame: TWahlverfahrenFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 666
  Align = alClient
  TabOrder = 0
  object RadioButton1: TRadioButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 634
    Height = 25
    Align = alTop
    Caption = 'Vereinfachtes Verfahren'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 0
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    AlignWithMargins = True
    Left = 3
    Top = 352
    Width = 634
    Height = 32
    Align = alTop
    Caption = 'Normales Verfahren'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 1
    OnClick = RadioButton2Click
  end
  object RichEdit1: TRichEdit
    AlignWithMargins = True
    Left = 3
    Top = 34
    Width = 634
    Height = 312
    Align = alTop
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      ''
      'Ein vereinfachtes Verfahren ist m'#246'glich, wenn:'
      '    '#8226' es zwischen 5 und 100 Mitarbeiter sind.'
      
        '    '#8226' Es zwischen 101 und 200 Mitarbeiter sind und sich der Wahl' +
        'ausschuss und '
      'der Arbeitgeber auf dieses Verfahren geeinigt haben.'
      ''
      'Das Verfahren ist schneller und unkomplizierter:'
      '    '#8226' K'#252'rzere Fristen'
      '    '#8226' Nur ein Wahlgang'
      '    '#8226' Direktwahl der Kandidaten ohne Listenwahl')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object RichEdit2: TRichEdit
    AlignWithMargins = True
    Left = 3
    Top = 390
    Width = 634
    Height = 273
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      ''
      'Ab 201 Mitarbeitern ist das normale Wahlverfahren zu benutzen')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
