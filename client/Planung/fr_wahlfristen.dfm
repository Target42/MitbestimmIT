object WahlfristenFrame: TWahlfristenFrame
  Left = 0
  Top = 0
  Width = 979
  Height = 599
  Align = alClient
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 257
    Width = 979
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 273
    ExplicitWidth = 31
  end
  object Chart1: TChart
    Left = 0
    Top = 260
    Width = 979
    Height = 339
    Legend.LegendStyle = lsValues
    Legend.TextStyle = ltsPlain
    Legend.Visible = False
    Title.Text.Strings = (
      'Wahlablauf')
    BottomAxis.LabelsAngle = 45
    BottomAxis.Title.Angle = 45
    View3D = False
    Align = alClient
    TabOrder = 0
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 979
    Height = 257
    Align = alTop
    Caption = 'Wahlphasen'
    TabOrder = 1
    object LV: TListView
      Left = 2
      Top = 17
      Width = 975
      Height = 197
      Align = alClient
      Columns = <
        item
          Caption = 'Nr'
          Width = 75
        end
        item
          Caption = 'Titel'
          Width = 350
        end
        item
          Caption = 'Start'
          Width = 150
        end
        item
          Caption = 'Ende'
          Width = 150
        end>
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu1
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = LVDblClick
    end
    object Panel1: TPanel
      Left = 2
      Top = 214
      Width = 975
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      object BitBtn1: TBitBtn
        Left = 24
        Top = 12
        Width = 75
        Height = 25
        Action = ac_berechnen
        Caption = 'Berechnen'
        Images = ResMod.PngImageList1
        TabOrder = 0
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 328
    Top = 80
    object Bearbeiten1: TMenuItem
      Action = ac_edit
    end
  end
  object ActionList1: TActionList
    Left = 544
    Top = 96
    object ac_edit: TAction
      Caption = 'Bearbeiten'
      OnExecute = ac_editExecute
    end
    object ac_berechnen: TAction
      Caption = 'Berechnen'
      OnExecute = ac_berechnenExecute
    end
  end
end
