@powershell Start -File "net 'start MitbestimmITSrv'" -Verb RunAs -Wait
net start | find "MitbestimmITSrv"
pause