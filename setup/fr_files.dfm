object FilesFrame: TFilesFrame
  Left = 0
  Top = 0
  Width = 849
  Height = 373
  Align = alClient
  TabOrder = 0
  OnResize = FrameResize
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 849
    Height = 81
    Align = alTop
    Caption = 'Zielpfad'
    TabOrder = 0
    DesignSize = (
      849
      81)
    object SpeedButton1: TSpeedButton
      Left = 807
      Top = 35
      Width = 23
      Height = 22
      Action = BrowseForFolder1
      Anchors = [akTop, akRight]
      ImageIndex = 4
      Images = ResMod.PngImageList1
    end
    object Edit1: TEdit
      Left = 16
      Top = 35
      Width = 777
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      Text = 'Edit1'
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 81
    Width = 849
    Height = 292
    Align = alClient
    Caption = 'Log'
    TabOrder = 1
    ExplicitTop = 83
    ExplicitHeight = 337
    object Memo1: TMemo
      Left = 2
      Top = 17
      Width = 845
      Height = 273
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitHeight = 318
    end
  end
  object ActionList1: TActionList
    Images = ResMod.PngImageList1
    Left = 152
    Top = 152
    object BrowseForFolder1: TBrowseForFolder
      Category = 'Datei'
      Caption = '...'
      DialogCaption = 'BrowseForFolder1'
      BrowseOptions = []
      BrowseOptionsEx = []
      ImageIndex = 0
      OnAccept = BrowseForFolder1Accept
    end
  end
end
