object DatabaseFrame: TDatabaseFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Align = alClient
  TabOrder = 0
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 0
    Width = 640
    Height = 65
    Align = alTop
    Caption = 'FireBIRD-Typ'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Embedded'
      'Externer Server')
    TabOrder = 0
    ExplicitLeft = 3
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 65
    Width = 640
    Height = 82
    Align = alTop
    Caption = 'Sysdba'
    TabOrder = 1
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Name'
      TabOrder = 0
      Text = 'sysdba'
    end
    object LabeledEdit2: TLabeledEdit
      Left = 208
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 47
      EditLabel.Height = 15
      EditLabel.Caption = 'Passwort'
      TabOrder = 1
      Text = ''
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 147
    Width = 640
    Height = 74
    Align = alTop
    Caption = 'Datenbank'
    TabOrder = 2
    object LabeledEdit3: TLabeledEdit
      Left = 16
      Top = 32
      Width = 313
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Name'
      TabOrder = 0
      Text = ''
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 221
    Width = 640
    Height = 80
    Align = alTop
    Caption = 'Externer Server'
    TabOrder = 3
    ExplicitTop = 233
    object LabeledEdit4: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 25
      EditLabel.Height = 15
      EditLabel.Caption = 'Host'
      TabOrder = 0
      Text = 'localhost'
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 301
    Width = 640
    Height = 72
    Align = alTop
    Caption = 'Aktionen'
    TabOrder = 4
    ExplicitTop = 307
    object BitBtn1: TBitBtn
      Left = 16
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Erstellen'
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 144
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Testen'
      TabOrder = 1
    end
  end
end
