object WahlhelferForm: TWahlhelferForm
  Left = 0
  Top = 0
  Caption = 'Wahlhelfer'
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
  OnDestroy = FormDestroy
  TextHeight = 15
  object LV: TListView
    Left = 0
    Top = 0
    Width = 624
    Height = 312
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
        Width = 75
      end
      item
        Caption = 'Abteilung'
        Width = 100
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 312
    Width = 624
    Height = 69
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 1
    DesignSize = (
      624
      69)
    object btnAdd: TBitBtn
      Left = 24
      Top = 30
      Width = 89
      Height = 27
      Caption = 'Hinzuf'#252'gen'
      ImageIndex = 1
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnEdit: TBitBtn
      Left = 136
      Top = 30
      Width = 97
      Height = 27
      Caption = 'Bearbeiten'
      ImageIndex = 3
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TBitBtn
      Left = 520
      Top = 28
      Width = 75
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'L'#246'schen'
      ImageIndex = 2
      Images = ResMod.PngImageList1
      TabOrder = 2
      OnClick = btnDeleteClick
    end
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 381
    Width = 624
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 2
    ExplicitTop = 381
    ExplicitWidth = 624
    inherited StatusBar1: TStatusBar
      Width = 624
      ExplicitWidth = 624
    end
    inherited Panel1: TPanel
      Width = 624
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 624
      inherited OKBtn: TBitBtn
        Left = 520
        ExplicitLeft = 520
      end
    end
  end
end
