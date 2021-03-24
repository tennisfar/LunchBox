#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 
;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================

; --------------------------------------------------------------
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.

#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input

;F13::SendInput {PrintScreen}
;F14::SendInput {ScrollLock}
;F15::SendInput {Pause}

F13::
Run, C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --incognito "https://web.develop.danskespil.dk/sitecore/shell/Applications/Content Editor.aspx?sc_bw=1&fo={A769E385-F12A-4B16-9458-7A64ECF9ACFA}"
WinWaitActive, ahk_class Chrome_WidgetWin_0,, 2
return

F14::Run "https://town21editdli.danskespil.dk/sitecore/shell/Applications/Content Editor.aspx?sc_bw=1&fo={A769E385-F12A-4B16-9458-7A64ECF9ACFA}"
F15::Run "https://town21editdlo.danskespil.dk/sitecore/shell/Applications/Content Editor.aspx?sc_bw=1&fo={A769E385-F12A-4B16-9458-7A64ECF9ACFA}"

;F16-19 custom app launchers, see http://www.autohotkey.com/docs/Tutorial.htm for usage info
F16::Run https://jira.danskespil.dk/secure/RapidBoard.jspa?rapidView=256&projectKey=IU&quickFilter=921
F17::Run http://stash.danskespil.dk/projects/SIT/repos/danskespil.website/pull-requests
F18::Run "https://editdli.danskespil.dk/sitecore/shell/Applications/Content Editor.aspx?sc_bw=1&fo={A769E385-F12A-4B16-9458-7A64ECF9ACFA}"
F19::Run "https://editdlo.danskespil.dk/sitecore/shell/Applications/Content Editor.aspx?sc_bw=1&fo={A769E385-F12A-4B16-9458-7A64ECF9ACFA}"

