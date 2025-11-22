cd d:\git_d12\MitbestimmIT

rsvars.bat

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