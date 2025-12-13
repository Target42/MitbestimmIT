cd d:\git_d12\MitbestimmIT\

call rsvars.bat

msbuild MitbestimmIT.groupproj /t:Clean /p:Configuration=Debug /p:Platform=Win32
msbuild MitbestimmIT.groupproj /t:Clean /p:Configuration=Release /p:Platform=Win32


msbuild server\MitbestimmITServer.dproj /t:Build /p:Configuration=Debug /p:Platform=Win32
msbuild server\MitbestimmITServer.dproj /t:Build /p:Configuration=Release /p:Platform=Win32
msbuild client\MitbestimmITClientVCL.dproj /t:Build /p:Configuration=Release /p:Platform=Win32

echo packen der Server datan

del setup\Data\Client.zip

"C:\Program Files\7-Zip\7z.exe" a -tzip setup\Data\Client.zip ..\..\DelphiBin\MitbestimmIT\Client\MitbestimmITClientVCL.exe
"C:\Program Files\7-Zip\7z.exe" a -tzip setup\Data\Client.zip ..\..\DelphiBin\MitbestimmIT\Client\libeay32.dll
"C:\Program Files\7-Zip\7z.exe" a -tzip setup\Data\Client.zip ..\..\DelphiBin\MitbestimmIT\Client\ssleay32.dll
"C:\Program Files\7-Zip\7z.exe" a -tzip setup\Data\Client.zip  testdaten

msbuild setup\ServerSetup.dproj /t:Build /p:Configuration=Release /p:Platform=Win32


copy "D:\DelphiBin\MitbestimmIT\Setup\ServerSetup.exe" "C:\Users\steph\Nextcloud\MitbestimmIT\" /Y
copy "D:\DelphiBin\MitbestimmIT\Server\MitbestimmITServer.exe" "C:\Users\steph\Nextcloud\MitbestimmIT\" /Y
copy "D:\DelphiBin\MitbestimmIT\Server\MitbestimmITServer.service.exe" "C:\Users\steph\Nextcloud\MitbestimmIT\" /Y
copy "D:\DelphiBin\MitbestimmIT\Client\MitbestimmITClientVCL.exe" "C:\Users\steph\Nextcloud\MitbestimmIT\" /Y

copy d:\git_d12\MitbestimmIT\setup\Data\Client.zip "C:\Users\steph\Nextcloud\MitbestimmIT\" /Y