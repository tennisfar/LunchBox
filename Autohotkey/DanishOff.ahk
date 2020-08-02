#Include C:\Users\ekmlpe\MySettings\Windows\Autohotkey\AutoHotkey.ahk
 
CapsLock::
	run, C:\Users\ekmlpe\MySettings\Windows\Autohotkey\DanishOn.ahk
	SoundPlay, %A_WinDir%\media\Speech On.wav
	TrayTip, , Danish On
	Suspend, On
    Sleep 1000
    ExitApp
    return
    return