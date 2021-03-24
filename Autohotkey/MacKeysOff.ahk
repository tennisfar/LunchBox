#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 
CapsLock::
	run, C:\Projects\rep\LunchBox\Autohotkey\MacKeysOn.ahk
	SoundPlay, %A_WinDir%\media\Speech On.wav
	TrayTip, , Mac On
	Suspend, On
    Sleep 800
    ExitApp
    return
    return
