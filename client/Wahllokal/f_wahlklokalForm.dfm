object WahllokalForm: TWahllokalForm
  Left = 0
  Top = 0
  Caption = 'Wahllokale'
  ClientHeight = 521
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 177
    Width = 599
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 284
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 599
    Height = 177
    Align = alTop
    Caption = 'R'#228'ume'
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 128
      Width = 595
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        595
        47)
      object btnAdd: TBitBtn
        Left = 14
        Top = 16
        Width = 89
        Height = 27
        Caption = 'Hinzuf'#252'gen'
        ImageIndex = 1
        Images = ResMod.PngImageList1
        TabOrder = 0
      end
      object btnEdit: TBitBtn
        Left = 136
        Top = 14
        Width = 97
        Height = 27
        Caption = 'Bearbeiten'
        ImageIndex = 3
        Images = ResMod.PngImageList1
        TabOrder = 1
      end
      object btnDelete: TBitBtn
        Left = 509
        Top = 16
        Width = 75
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'L'#246'schen'
        ImageIndex = 2
        Images = ResMod.PngImageList1
        TabOrder = 2
      end
    end
    object RaumView: TListView
      Left = 2
      Top = 17
      Width = 595
      Height = 111
      Align = alClient
      Columns = <
        item
          Caption = 'Geb'#228'ude'
          Width = 75
        end
        item
          Caption = 'Raumnummer'
          Width = 90
        end
        item
          Caption = 'Stockwerk'
          Width = 75
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
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 180
    Width = 599
    Height = 281
    Align = alClient
    Caption = 'Wahlhelfer'
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 181
    object ListView1: TListView
      Left = 2
      Top = 17
      Width = 595
      Height = 215
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
          Caption = 'Geschlecht'
          Width = 100
        end
        item
          Caption = 'Abteilung'
          Width = 100
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitLeft = 3
      ExplicitTop = 16
      ExplicitHeight = 193
    end
    object Panel2: TPanel
      Left = 2
      Top = 232
      Width = 595
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 128
      DesignSize = (
        595
        47)
      object BitBtn1: TBitBtn
        Left = 14
        Top = 16
        Width = 89
        Height = 27
        Caption = 'Hinzuf'#252'gen'
        ImageIndex = 1
        Images = ResMod.PngImageList1
        TabOrder = 0
      end
      object BitBtn3: TBitBtn
        Left = 509
        Top = 16
        Width = 75
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'L'#246'schen'
        ImageIndex = 2
        Images = ResMod.PngImageList1
        TabOrder = 1
      end
    end
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 461
    Width = 599
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 2
    ExplicitTop = 461
    ExplicitWidth = 599
    inherited StatusBar1: TStatusBar
      Width = 599
      ExplicitWidth = 599
    end
    inherited Panel1: TPanel
      Width = 599
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 599
      inherited OKBtn: TBitBtn
        Left = 495
        ExplicitLeft = 495
      end
    end
  end
end
