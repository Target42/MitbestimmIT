@echo off
setlocal

if "%1"=="" (
	echo Es wurd keine 
    echo Beispiel: %~nx0 password
    exit /b 1
)

REM === Konfigurierbare Werte ===
set OPENSSL_BIN=%1
set KEY_FILE=key.pem
set CERT_FILE=cert.pem
set CSR_FILE=csr.pem
set DAYS_VALID=365
set SUBJECT=/C=DE/ST=Niedersachsen/L=Hemmingen/O=MitbestimmIT/OU=IT/CN=example.com
set PASSWORD=%2
echo %PASSWORD%

echo Generiere privaten Schlüssel (mit Passwortschutz) und selbstsigniertes Zertifikat...
%OPENSSL_BIN% genpkey -algorithm RSA -out %KEY_FILE% -aes256 -pkeyopt rsa_keygen_bits:2048 -pass pass:%PASSWORD%
IF ERRORLEVEL 1 GOTO error

echo Optional: Generiere eine Zertifikatsanforderung (CSR)...
%OPENSSL_BIN% req -new -key %KEY_FILE% -out %CSR_FILE% -subj "%SUBJECT%" -passin pass:%PASSWORD%
IF ERRORLEVEL 1 GOTO error

echo Generiere das selbstsignierte Zertifikat...
%OPENSSL_BIN% x509 -req -in %CSR_FILE% -signkey %KEY_FILE% -out %CERT_FILE% -days %DAYS_VALID% -passin pass:%PASSWORD%
IF ERRORLEVEL 1 GOTO error

echo.
echo Fertig! Dateien wurden erstellt:
echo   - %KEY_FILE% (mit Passwortschutz)
echo   - %CERT_FILE%
echo   - %CSR_FILE%
GOTO end

:error
echo.
echo [FEHLER] Es ist ein Problem aufgetreten. Ist OpenSSL korrekt installiert?
GOTO end

:end
pause
