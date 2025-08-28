object ServerFrame: TServerFrame
  Left = 0
  Top = 0
  Width = 909
  Height = 480
  Align = alClient
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 313
    Top = 0
    Height = 480
    ExplicitLeft = 9
    ExplicitTop = -8
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 313
    Height = 480
    Align = alLeft
    Caption = 'Dienste'
    TabOrder = 0
    object LV: TListView
      Left = 2
      Top = 17
      Width = 309
      Height = 461
      Align = alClient
      Columns = <
        item
          Caption = 'Dienst'
          Width = 200
        end
        item
          Caption = 'Status'
          Width = 75
        end>
      LargeImages = PngImageList1
      ReadOnly = True
      RowSelect = True
      SmallImages = PngImageList1
      StateImages = PngImageList1
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object GroupBox2: TGroupBox
    Left = 316
    Top = 0
    Width = 593
    Height = 480
    Align = alClient
    Caption = 'Aktionen'
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 2
      Top = 293
      Width = 589
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 17
      ExplicitWidth = 279
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 296
      Width = 589
      Height = 182
      Align = alBottom
      Caption = 'Log'
      TabOrder = 0
      object Memo1: TMemo
        Left = 2
        Top = 17
        Width = 585
        Height = 163
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 17
      Width = 589
      Height = 276
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      object BitBtn1: TBitBtn
        Left = 32
        Top = 40
        Width = 153
        Height = 25
        Caption = 'Dienst installieren'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 216
        Top = 40
        Width = 153
        Height = 25
        Caption = 'Dienst starten'
        TabOrder = 1
        OnClick = BitBtn2Click
      end
      object BitBtn3: TBitBtn
        Left = 32
        Top = 96
        Width = 153
        Height = 25
        Caption = 'Dienst deinstallieren'
        TabOrder = 2
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 216
        Top = 96
        Width = 153
        Height = 25
        Caption = 'Dienst stoppen'
        TabOrder = 3
        OnClick = BitBtn4Click
      end
      object BitBtn5: TBitBtn
        Left = 128
        Top = 152
        Width = 153
        Height = 25
        Caption = 'Start Console App'
        TabOrder = 4
        OnClick = BitBtn5Click
      end
    end
  end
  object DosCommand1: TDosCommand
    CommandLine = 'powershell -Command "Get-Service | Format-Table Status, Name"'
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCommand1NewLine
    OnTerminated = DosCommand1Terminated
    Left = 152
    Top = 88
  end
  object PngImageList1: TPngImageList
    PngImages = <
      item
        Background = clWindow
        Name = 'Ok_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA793000001734944415478DA6364A0
          1030A20B04AE0B14FBCDF83F13C8F4066279A8F043C6FF8C5BFEFC6199BE3D6C
          F56B9C06F86EF08FFAFF9F711690C98DC3C22F0C8CFF53B6046C5C896180F7BA
          C05046C6FF2BB1B90A0DFC075A12B23568FD3AB8019EAB424599597FDF0132F9
          F0FA9711A41BCCFCC0FA9F51657DD0FAB760037CD7073401C56BF16916E5E566
          0837D3665875FA2AC3AB4F5F41420D5B023734820DF059177811E8373D5C9AA5
          05791962ADF4191EBDFDC8B0EAD455863FFFFE8184CF030D308218B03EE03390
          E201B1D95898197839D818DE7EF90ED62CC1CFC31067ADCFF0E2E31786E527AE
          30FCFEFB1766EE67A0017C1806B86A2B3318C849302C3E7611ECE738A0CDCF3F
          7C615876F232C39FBFFF901D866400921758989818C2CDB5196404F981A1F69F
          E1C9BBCF0C2B4F5D41D78CEA05F440646662640831D502863823C3DA335719FE
          FEFB8F2D681081882D1A412E01016880A103D468A43821C10045491906D03293
          3654F82A5199891C000063E5AC11091138FA0000000049454E44AE426082}
      end
      item
        Background = clWindow
        Name = 'Question Mark_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA7930000015D4944415478DA6364A0
          103062136C60686092D6D00F67FCCFE0F29F81E93F90DEF3E4D6F95540F17F04
          0D98A3BD4A88E10FDB7620D30C4DE549E61FFF3D121F047EC06BC05CB58D3381
          56A601997719FF3376FE63FAC7C8F89FA99C81E1BF1250F9F4949BFE59F80D50
          DFF0F23F038318D01093D41B81674162F33536E8FEFDCF7009C87C9E7233400A
          BF17D4D63B333130323EBA75611FCCCF339556F133B3B2819CFE0568002FC140
          4406AB1856317F52675D00541AF39F91614FEA8D0057A20D8068665B0A648603
          F17B664606FBC41B01978936608EFA861620550DC49F18FEFF774DB915788A60
          34C2C0428D75C2BFFE333D062A6065FCFFCF31F956D0116CEA701A30577DA3E3
          7F86FFFB80CCFDC08073C2A50EA701B335375930FEFB57044C0B27926FF9F791
          6E80CA5A19466616CBFF4C8C8F53AFFB9D20D98039EA1B4381A96F1550C19AE4
          9B01A1647981E9DFBF6286FF8CC7C9F202B10000342180114945445400000000
          49454E44AE426082}
      end
      item
        Background = clWindow
        Name = 'Stop Sign_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA793000001704944415478DAAD924D
          28446114869FCF4F1648421A8922859458101AA128A529CD248D2D252552A32C
          90C9866CD46CC6828D909F89F13322C2CC60210B25A4AC6C652929D7B9914CEE
          346A7C5FB7F72CBEF39C73DE7B14511EF5EF00CDCC8C4897E16B0DB70AD01D16
          20C9152267F2C58429F82EB75205B9F805D0F4D84C50C2AA085D1F2B3F75BF01
          66DA4516FF38B8559DE0F906684D24F2C22D2D9DD964E5C1E33D94D5C3E521C4
          C5434E21EC2F80DD015701F0B81E48A258F978555FD5074526185F83A355F0AF
          C388240C5B616C19CE7D90922ECE8835E5021E68D24BF74B17D39F805A1AC484
          031A3BA0D10E4ED1A1B94F8073456CDD86D44C28A906AF1B4EB774D32CF24736
          7F7AB0416B8F858C6C981D055B1F2C4D2163416E11ECCD439A49BAD9D19FEF8A
          91CDA12656934F2CD7122644B0F04DB24AA5FD1BA33D9814714400B8A47AAFF1
          22D5902C2B7427A1294CF293CC5E20B33F1B02BE0C6D13B119A66B78A5FA7CE8
          4A4479A2067C002437611142ABAA880000000049454E44AE426082}
      end>
    Left = 152
    Top = 248
  end
  object DosCommand2: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCommand2NewLine
    OnTerminated = DosCommand2Terminated
    Left = 796
    Top = 72
  end
end
