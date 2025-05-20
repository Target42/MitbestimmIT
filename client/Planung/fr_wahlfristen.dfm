object WahlfristenFrame: TWahlfristenFrame
  Left = 0
  Top = 0
  Width = 979
  Height = 599
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 979
    Height = 252
    Align = alTop
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = -6
    object Label1: TLabel
      Left = 88
      Top = 8
      Width = 71
      Height = 15
      Caption = 'Start Wahltag'
    end
    object Label2: TLabel
      Left = 32
      Top = 66
      Width = 127
      Height = 15
      Caption = 'Wahlvorstand bestimmt'
    end
    object Label3: TLabel
      Left = 63
      Top = 95
      Width = 96
      Height = 15
      Caption = 'Wahlausschreiben'
    end
    object Label4: TLabel
      Left = 41
      Top = 124
      Width = 118
      Height = 15
      Caption = 'Ende Vorschlagsfristen'
    end
    object Label5: TLabel
      Left = 31
      Top = 153
      Width = 129
      Height = 15
      Caption = 'Bekanntgabe Vorschl'#228'ge'
    end
    object Label6: TLabel
      Left = 40
      Top = 182
      Width = 114
      Height = 15
      Caption = 'Bekanntgabe Ergebns'
    end
    object Label7: TLabel
      Left = 42
      Top = 211
      Width = 117
      Height = 15
      Caption = 'Ende Anfechtungsfrist'
    end
    object Label8: TLabel
      Left = 357
      Top = 8
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label9: TLabel
      Left = 357
      Top = 66
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label10: TLabel
      Left = 357
      Top = 95
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label11: TLabel
      Left = 357
      Top = 124
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label12: TLabel
      Left = 357
      Top = 153
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label13: TLabel
      Left = 357
      Top = 182
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label14: TLabel
      Left = 357
      Top = 211
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label15: TLabel
      Left = 357
      Top = 37
      Width = 18
      Height = 15
      Caption = 'Mo'
    end
    object Label16: TLabel
      Left = 77
      Top = 37
      Width = 82
      Height = 15
      Caption = 'Letzter Wahltag'
    end
    object DateTimePicker1: TDateTimePicker
      Tag = 1
      Left = 165
      Top = 8
      Width = 186
      Height = 23
      Date = 46143.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 0
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker2: TDateTimePicker
      Tag = 2
      Left = 165
      Top = 66
      Width = 186
      Height = 23
      Date = 45774.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 1
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker3: TDateTimePicker
      Tag = 3
      Left = 165
      Top = 95
      Width = 186
      Height = 23
      Date = 45774.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 2
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker4: TDateTimePicker
      Tag = 4
      Left = 165
      Top = 124
      Width = 186
      Height = 23
      Date = 45774.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 3
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker5: TDateTimePicker
      Tag = 5
      Left = 165
      Top = 153
      Width = 186
      Height = 23
      Date = 45774.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 4
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker6: TDateTimePicker
      Left = 165
      Top = 182
      Width = 186
      Height = 23
      Date = 45774.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 6
      OnChange = DateTimePicker1Change
    end
    object DateTimePicker7: TDateTimePicker
      Tag = 7
      Left = 165
      Top = 211
      Width = 186
      Height = 23
      Date = 45774.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 5
      OnChange = DateTimePicker1Change
    end
    object Button1: TButton
      Left = 416
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Berechnen'
      TabOrder = 7
      OnClick = Button1Click
    end
    object BitBtn1: TBitBtn
      Left = 416
      Top = 62
      Width = 75
      Height = 25
      Caption = 'Pr'#252'fen'
      TabOrder = 8
      OnClick = BitBtn1Click
    end
    object DateTimePicker8: TDateTimePicker
      Tag = 8
      Left = 165
      Top = 37
      Width = 186
      Height = 23
      Date = 46143.000000000000000000
      Time = 0.643076203705277300
      TabOrder = 9
      OnChange = DateTimePicker1Change
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 252
    Width = 979
    Height = 347
    Title.Text.Strings = (
      'Wahlablauf')
    View3D = False
    Align = alClient
    TabOrder = 1
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TGanttSeries
      HoverElement = [heCurrent]
      Marks.Callout.ArrowHead = ahSolid
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      XValues.Name = 'Start'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Callout.Style = psRightTriangle
      Callout.Arrow.Visible = False
      StartValues.Name = 'Start'
      StartValues.Order = loAscending
      EndValues.Name = 'End'
      EndValues.Order = loNone
      NextTask.Name = 'NextTask'
      NextTask.Order = loNone
      Data = {
        040800000000000000205AE640FF0600000044657369676E00000000C05BE640
        000000000000F0BF00000000A05AE640FF0B00000050726F746F747970696E67
        00000000805DE640000000000000F0BF00000000C05AE640FF0B000000446576
        656C6F706D656E7400000000405DE640000000000000F0BF00000000205BE640
        FF0500000053616C657300000000805CE640000000000000F0BF00000000605B
        E640FF090000004D61726B6574696E6700000000805DE640000000000000F0BF
        00000000205CE640FF080000004D616E756661632E00000000805DE640000000
        000000F0BF00000000405CE640FF0700000054657374696E6700000000205EE6
        40000000000000F0BF00000000005DE640FF09000000446562756767696E6700
        000000405EE640000000000000F0BF}
      Detail = {0000000000}
    end
  end
end
