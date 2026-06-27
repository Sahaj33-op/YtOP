@echo off
echo Stopping yt-dlp Local Bridge Server...
powershell -Command "Get-CimInstance Win32_Process -Filter \"CommandLine Like '%%yt-dlp-server.py%%'\" | Invoke-CimMethod -MethodName Terminate"
echo Done.
timeout /t 3
