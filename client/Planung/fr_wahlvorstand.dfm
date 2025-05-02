object WahlVorstandFrame: TWahlVorstandFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Align = alClient
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 640
    Height = 345
    Align = alTop
    Caption = 'Wahlvorstand'
    TabOrder = 0
    object LV: TListView
      Left = 2
      Top = 17
      Width = 636
      Height = 285
      Align = alClient
      Columns = <
        item
          Caption = 'Login'
        end
        item
          Caption = 'Name'
          Width = 150
        end
        item
          Caption = 'Vorname'
          Width = 100
        end
        item
          Caption = 'Anrede'
        end
        item
          Caption = 'Rolle'
        end
        item
          Caption = 'Stimmberechtigt'
          Width = 120
        end
        item
          Caption = 'eMail'
          Width = 300
        end>
      GroupView = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
    object Panel1: TPanel
      Left = 2
      Top = 302
      Width = 636
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        636
        41)
      object btnAdd: TBitBtn
        Left = 32
        Top = 6
        Width = 89
        Height = 27
        Caption = 'Hinzuf'#252'gen'
        ImageIndex = 1
        Images = DataModule1.PngImageList1
        TabOrder = 0
        OnClick = btnAddClick
      end
      object btnEdit: TBitBtn
        Left = 144
        Top = 6
        Width = 97
        Height = 27
        Caption = 'Bearbeiten'
        ImageIndex = 3
        Images = DataModule1.PngImageList1
        TabOrder = 1
        OnClick = btnEditClick
      end
      object btnDelete: TBitBtn
        Left = 544
        Top = 6
        Width = 75
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'L'#246'schen'
        ImageIndex = 2
        Images = DataModule1.PngImageList1
        TabOrder = 2
        OnClick = btnDeleteClick
      end
    end
  end
end
