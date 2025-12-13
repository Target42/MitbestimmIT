object PortCheckFrame: TPortCheckFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Align = alClient
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 57
    Width = 640
    Height = 67
    Align = alTop
    Caption = 'Datasnap-Bin'#228'r'
    TabOrder = 0
    object Label1: TLabel
      Left = 240
      Top = 33
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
      ImageIndex = 5
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 185
    Width = 640
    Height = 56
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
      ImageIndex = 5
      Images = ResMod.PngImageList1
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
    object HttpsActive: TCheckBox
      Left = 8
      Top = 24
      Width = 18
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = HttpsActiveClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 124
    Width = 640
    Height = 61
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
      ImageIndex = 5
      Images = ResMod.PngImageList1
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
    object httpActive: TCheckBox
      Left = 8
      Top = 24
      Width = 18
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = httpActiveClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 241
    Width = 640
    Height = 66
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
      Caption = 'Label8'
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
      Tag = 4
      Left = 128
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Test'
      ImageIndex = 5
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object DnlActive: TCheckBox
      Left = 3
      Top = 32
      Width = 23
      Height = 17
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = DnlActiveClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 307
    Width = 640
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 4
    ExplicitTop = 303
    object BitBtn5: TBitBtn
      Left = 34
      Top = 14
      Width = 169
      Height = 25
      Caption = 'Alle Ports testen'
      ImageIndex = 5
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = BitBtn5Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 0
    Top = 0
    Width = 640
    Height = 57
    Align = alTop
    Caption = 'Hostname'
    TabOrder = 5
    object Edit1: TEdit
      Left = 34
      Top = 24
      Width = 346
      Height = 23
      TabOrder = 0
      Text = 'Edit1'
    end
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 211
    OnExecute = IdTCPServer1Execute
    Left = 456
    Top = 161
  end
  object PageProducer1: TPageProducer
    HTMLDoc.Strings = (
      '# OeffnePortsMulti.ps1'
      '#'
      
        '# Beschreibung: F'#252'gt Regeln f'#252'r eine Liste von TCP-Ports zur Win' +
        'dows-Firewall hinzu.'
      '#'
      
        '# ANWEISUNG: Dieses Skript MUSS mit Administratorrechten ausgef'#252 +
        'hrt werden.'
      ''
      '# --- KONFIGURATION START ---'
      '$PortsZumOeffnen = @(<#ports>)'
      '# Das Standardprotokoll (TCP oder UDP).'
      '$Protokoll = "TCP" '
      '# --- KONFIGURATION ENDE ---'
      ''
      ''
      
        'Write-Host "--- Windows Firewall Konfiguration Start f'#252'r $($Prot' +
        'okoll) Ports ---" -ForegroundColor Yellow'
      
        'Write-Host "Es werden folgende Ports verarbeitet: $($PortsZumOef' +
        'fnen -join '#39', '#39')" -ForegroundColor Cyan'
      'Write-Host "---"'
      ''
      
        '# Beginne Schleife: Jeder Port in der Liste wird einzeln verarbe' +
        'itet.'
      'foreach ($Port in $PortsZumOeffnen) {'
      '    '
      '    # Lokale Variablen f'#252'r die aktuelle Port-Regel'
      
        '    $RegelName = "MitbestimmIT Server - Port $($Port) $($Protoko' +
        'll)"'
      
        '    $Beschreibung = "Erlaubt eingehende $($Protokoll)-Verbindung' +
        'en auf Port $($Port)."'
      ''
      
        '    Write-Host "`n[PORT: $($Port)] Beginne Pr'#252'fung..." -Foregrou' +
        'ndColor Yellow'
      '    '
      '    # 1. '#220'berpr'#252'fen, ob die Regel bereits existiert'
      
        '    $BestehendeRegel = Get-NetFirewallRule -DisplayName $RegelNa' +
        'me -ErrorAction SilentlyContinue'
      ''
      '    if ($BestehendeRegel) {'
      '        '
      '        # Regel existiert bereits'
      
        '        Write-Host "   '#9989' Regel '#39'$($RegelName)'#39' existiert bereits' +
        '." -ForegroundColor Green'
      '        '
      
        '        # Optional: Regel aktivieren, falls sie deaktiviert wurd' +
        'e'
      '        if ($BestehendeRegel.Enabled -eq '#39'False'#39') {'
      
        '            Write-Host "   - Status: Deaktiviert. Aktiviere Rege' +
        'l..." -ForegroundColor Red'
      
        '            Set-NetFirewallRule -DisplayName $RegelName -Enabled' +
        ' True'
      
        '            Write-Host "   - Status: Aktiviert." -ForegroundColo' +
        'r Green'
      '        }'
      '        '
      '    } else {'
      '        '
      '        # Regel existiert nicht - Neue Regel hinzuf'#252'gen'
      
        '        Write-Host "   '#10060' Regel '#39'$($RegelName)'#39' existiert NICHT. ' +
        'Erstelle neue Regel..." -ForegroundColor Red'
      '        '
      '        try {'
      '            # Erstellung der neuen Firewall-Regel'
      '            New-NetFirewallRule `'
      '                -DisplayName $RegelName `'
      '                -Description $Beschreibung `'
      
        '                -Direction Inbound `       # Eingehende Verbindu' +
        'ng'
      '                -Action Allow `           # Erlauben'
      
        '                -Protocol $Protokoll `    # Protokoll (TCP oder ' +
        'UDP)'
      '                -LocalPort $Port `        # Der lokale Port'
      
        '                -Profile Any `            # Anwenden auf alle Pr' +
        'ofile (Domain, Private, Public)'
      '                -Enabled True             # Regel aktivieren'
      ''
      
        '            Write-Host "   '#55356#57225' Neue Firewall-Regel erfolgreich er' +
        'stellt und aktiviert f'#252'r Port $($Port)." -ForegroundColor Green'
      '        '
      '        } catch {'
      
        '            Write-Error "Ein Fehler ist beim Erstellen der Firew' +
        'all-Regel aufgetreten f'#252'r Port $($Port): $($_.Exception.Message)' +
        '"'
      
        '            Write-Host "   Stellen Sie sicher, dass das Skript a' +
        'ls Administrator ausgef'#252'hrt wird." -ForegroundColor Red'
      '        }'
      '    }'
      '}'
      ''
      
        'Write-Host "`n--- Konfiguration abgeschlossen ---" -ForegroundCo' +
        'lor Yellow')
    OnHTMLTag = PageProducer1HTMLTag
    Left = 272
    Top = 296
  end
end
