#Include C:\Users\ekmlpe\MySettings\Windows\Autohotkey\AutoHotkey.ahk
 
CapsLock::
    run, C:\Users\ekmlpe\MySettings\Windows\Autohotkey\DanishOff.ahk
    SoundPlay, %A_WinDir%\media\Speech Off.wav
    TrayTip, , Danish Off
    Suspend, On
    Sleep 1000
    ExitApp
    return
 
:?*:ae::
    if(GetKeyState("Shift"))
        Send {U+00C6}
    else
        Send {U+00E6}
    return
 
:?*:oe::
    if(GetKeyState("Shift"))
        Send {U+00D8}
    else
        Send {U+00F8}
    return
 
:?*:aa::
    if(GetKeyState("Shift"))
        Send {U+00C5}
    else
        Send {U+00E5}
    return