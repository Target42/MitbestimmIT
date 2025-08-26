object PortCheckFrame: TPortCheckFrame
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
    Height = 73
    Align = alTop
    Caption = 'Datasnap-Bin'#228'r'
    TabOrder = 0
    object Label1: TLabel
      Left = 240
      Top = 29
      Width = 57
      Height = 15
      Caption = 'Ungetestet'
    end
    object Label4: TLabel
      Left = 344
      Top = 33
      Width = 34
      Height = 15
      Caption = 'Label4'
    end
    object SpinEdit1: TSpinEdit
      Left = 32
      Top = 30
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = SpinEdit1Change
    end
    object BitBtn1: TBitBtn
      Tag = 1
      Left = 128
      Top = 29
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 145
    Width = 640
    Height = 72
    Align = alTop
    Caption = 'HTTPS'
    TabOrder = 1
    object Label3: TLabel
      Left = 240
      Top = 24
      Width = 57
      Height = 15
      Caption = 'Ungetestet'
    end
    object Label6: TLabel
      Left = 344
      Top = 24
      Width = 34
      Height = 15
      Caption = 'Label6'
    end
    object BitBtn2: TBitBtn
      Tag = 3
      Left = 128
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object SpinEdit3: TSpinEdit
      Left = 32
      Top = 22
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = SpinEdit3Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 73
    Width = 640
    Height = 72
    Align = alTop
    Caption = 'HTTP'
    TabOrder = 2
    object Label2: TLabel
      Left = 240
      Top = 24
      Width = 57
      Height = 15
      Caption = 'Ungetestet'
    end
    object Label5: TLabel
      Left = 344
      Top = 24
      Width = 34
      Height = 15
      Caption = 'Label5'
    end
    object BitBtn3: TBitBtn
      Tag = 2
      Left = 128
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object SpinEdit2: TSpinEdit
      Left = 32
      Top = 24
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = SpinEdit2Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 217
    Width = 640
    Height = 72
    Align = alTop
    Caption = 'Clientdownload'
    TabOrder = 3
    object Label7: TLabel
      Left = 240
      Top = 32
      Width = 57
      Height = 15
      Caption = 'Ungetestet'
    end
    object Label8: TLabel
      Left = 344
      Top = 32
      Width = 34
      Height = 15
      Caption = 'Label6'
    end
    object SpinEdit4: TSpinEdit
      Tag = 4
      Left = 32
      Top = 30
      Width = 73
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = SpinEdit4Change
    end
    object BitBtn4: TBitBtn
      Tag = 3
      Left = 128
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 211
    OnExecute = IdTCPServer1Execute
    Left = 456
    Top = 161
  end
end
