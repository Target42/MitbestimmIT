@echo "Installiere den Service"
@powershell Start -File "MitbestimmITServer.service.exe /install" -Verb RunAs -Wait
pause