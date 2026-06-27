Set objFSO = CreateObject("Scripting.FileSystemObject")
strPath = objFSO.GetParentFolderName(WScript.ScriptPosition)
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "python """ & strPath & "\yt-dlp-server.py""", 0, False
