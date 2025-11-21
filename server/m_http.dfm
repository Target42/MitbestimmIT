object HttpMod: THttpMod
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 48
    Top = 32
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 104
    Top = 144
  end
  object PageProducer1: TPageProducer
    HTMLDoc.Strings = (
      '<!DOCTYPE html>'
      '<html lang="de">'
      '<head>'
      '    <meta charset="UTF-8">'
      '    <title>MitbestimmIT-Client</title>'
      '    <style>'
      '        html, body {'
      '            height: 100%;'
      '            margin: 0;'
      '            padding: 0;'
      
        '            font-family: Arial, sans-serif; /* Eine lesbare Schr' +
        'iftart */'
      '        }'
      ''
      '        body {'
      '           background-color: #000000; /* Reines Schwarz */'
      '            background-image: url('#39'logo.png'#39');'
      '            background-repeat: no-repeat;'
      '            background-position: center center;'
      
        '            background-size: contain; /* Oder '#39'cover'#39', je nachde' +
        'm wie das Bild skalieren soll */'
      ''
      
        '            display: flex; /* Flexbox f'#252'r einfache Zentrierung d' +
        'er Box */'
      
        '            justify-content: center; /* Horizontale Zentrierung ' +
        'der Box */'
      
        '            align-items: center; /* Vertikale Zentrierung der Bo' +
        'x */'
      
        '            min-height: 100vh; /* Mindesth'#246'he des Bodys auf den ' +
        'Viewport setzen */'
      
        '            color: #333; /* Standard-Textfarbe f'#252'r die Lesbarkei' +
        't */'
      '        }'
      ''
      '        /* NEU: Styling f'#252'r die Content-Box */'
      '        .content-box {'
      
        '            background-color: rgba(255, 255, 255, 0.8); /* Wei'#223' ' +
        'mit 80% Deckkraft */'
      '            padding: 30px; /* Innenabstand der Box */'
      '            border-radius: 10px; /* Abgerundete Ecken */'
      
        '            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Leichte' +
        'r Schatten */'
      '            max-width: 600px; /* Maximale Breite der Box */'
      
        '            text-align: center; /* Text innerhalb der Box zentri' +
        'eren */'
      '            border: 2px solid #FF0000;'
      '        }'
      ''
      '        .content-box h1, .content-box h2 {'
      
        '            margin-top: 0; /* Abstand oben bei '#220'berschriften ent' +
        'fernen */'
      
        '            color: #1a1a1a; /* Dunklere Farbe f'#252'r '#220'berschriften ' +
        '*/'
      '        }'
      ''
      '        .content-box a {'
      
        '            color: #007bff;'#10'            text-decoration: none;'#10' ' +
        '           /* NEU: Schriftart auf Fett setzen */'#10'            fon' +
        't-weight: bold;'#10'        }'#10#10'        .content-box a:hover {'#10'      ' +
        '      text-decoration: underline;'#10'        }    </style>'
      '</head>'
      '<body>'
      ''
      '    <div class="content-box">'
      '        <h1>MitbestimmIT-Client</h1>'
      '        <h2>Verbindungsdaten</h2>'
      '        ds://<#hostname>:<#dsport><br>'
      '        http://<#hostname>:<#httpport><br>'
      '        https://<#hostname>:<#httpsport><br>'
      '        <br>'
      '        <h2>Download</h2>'
      
        '        <a href="client.zip" download>MitbestimmIT-client downlo' +
        'ad</a>'
      '        <p></p>'
      '    </div>'
      ''
      '</body>'
      '</html>')
    OnHTMLTag = PageProducer1HTMLTag
    Left = 168
    Top = 40
  end
end
