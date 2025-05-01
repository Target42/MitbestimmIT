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
      ExplicitTop = 19
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
      object BitBtn1: TBitBtn
        Left = 32
        Top = 8
        Width = 75
        Height = 25
        Caption = 'BitBtn1'
        TabOrder = 0
      end
    end
  end
end
