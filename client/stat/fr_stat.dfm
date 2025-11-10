object StatFrame: TStatFrame
  Left = 0
  Top = 0
  Width = 382
  Height = 746
  Align = alClient
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 177
    Width = 382
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 155
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 300
    Width = 382
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 152
  end
  object Splitter3: TSplitter
    Left = 0
    Top = 408
    Width = 382
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 149
  end
  object Splitter4: TSplitter
    Left = 0
    Top = 516
    Width = 382
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 230
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 382
    Height = 177
    Align = alTop
    Caption = 'W'#228'hler'
    TabOrder = 0
    object Chart1: TChart
      Left = 2
      Top = 17
      Width = 378
      Height = 158
      Title.Text.Strings = (
        'Wahlberechtigte')
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 32
      ExplicitTop = 40
      ExplicitWidth = 400
      ExplicitHeight = 250
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: THorizBarSeries
        HoverElement = []
        BarBrush.Gradient.Direction = gdLeftRight
        Marks.Visible = False
        Gradient.Direction = gdLeftRight
        XValues.Name = 'Bar'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loAscending
        Data = {
          06030000000000000000804A40FF008000FF0600000046726175656E00000000
          00C0504000000020FF060000004DE46E6E65720000000000005E4000FF0000FF
          0500000053756D6D65}
        Detail = {0000000000}
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 180
    Width = 382
    Height = 120
    Align = alTop
    Caption = 'Gremium'
    TabOrder = 1
    ExplicitTop = 177
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 42
      Height = 15
      Caption = 'Gr'#246#223'e :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Gremium: TLabel
      Left = 188
      Top = 24
      Width = 6
      Height = 15
      Caption = '0'
    end
    object Label2: TLabel
      Left = 16
      Top = 45
      Width = 82
      Height = 15
      Caption = 'Freistellungen:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Freistellungen: TLabel
      Left = 187
      Top = 45
      Width = 6
      Height = 15
      Caption = '0'
    end
    object Label3: TLabel
      Left = 16
      Top = 66
      Width = 165
      Height = 15
      Caption = 'Geschlecht in der Minderheit:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Minderheit: TLabel
      Left = 187
      Top = 66
      Width = 32
      Height = 15
      Caption = 'Aliens'
    end
    object Label4: TLabel
      Left = 16
      Top = 87
      Width = 86
      Height = 15
      Caption = 'Pl'#228'tze f G. i.M. :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MinderheitnSitze: TLabel
      Left = 187
      Top = 87
      Width = 6
      Height = 15
      Caption = '0'
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 303
    Width = 382
    Height = 105
    Align = alTop
    Caption = 'Wahllisten'
    TabOrder = 2
    ExplicitLeft = 56
    ExplicitTop = 312
    ExplicitWidth = 185
    object Wahllisten: TListView
      Left = 2
      Top = 17
      Width = 378
      Height = 86
      Align = alClient
      Columns = <
        item
          Caption = 'Kurz'
        end
        item
          Caption = 'Name'
          Width = 200
        end
        item
          Caption = 'Anzahl'
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitLeft = 1
      ExplicitTop = 13
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 411
    Width = 382
    Height = 105
    Align = alTop
    Caption = 'Wahllokale'
    TabOrder = 3
    ExplicitLeft = 72
    ExplicitTop = 424
    ExplicitWidth = 185
    object Wahllokale: TListView
      Left = 2
      Top = 17
      Width = 378
      Height = 86
      Align = alClient
      Columns = <
        item
          Caption = 'Geb'#228'ude'
          Width = 75
        end
        item
          Caption = 'Stockwerk'
          Width = 75
        end
        item
          Caption = 'Raum'
        end
        item
          Caption = 'Helfer'
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitTop = 16
    end
  end
  object GroupBox5: TGroupBox
    Left = 0
    Top = 519
    Width = 382
    Height = 227
    Align = alClient
    Caption = 'Wahlphasen'
    TabOrder = 4
    ExplicitLeft = 56
    ExplicitTop = 568
    ExplicitWidth = 185
    ExplicitHeight = 105
    object Wahlphasen: TListView
      Left = 2
      Top = 17
      Width = 378
      Height = 208
      Align = alClient
      Columns = <
        item
          Caption = 'Phase'
          Width = 150
        end
        item
          Caption = 'Start'
        end
        item
          Caption = 'Ende'
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
