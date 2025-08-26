@powershell Start -File "net 'start MitbestimmITSrv'" -Verb RunAs -Wait
net start | find "Archiv"
pause