#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 
CapsLock::
	run, C:\Projects\rep\LunchBox\Autohotkey\MacKeysOff.ahk
	SoundPlay, %A_WinDir%\media\Speech Off.wav
	TrayTip, , Mac Off
	Suspend, On
    Sleep 800
    ExitApp
    return
    return

; Test hotkey:
KeyHistory


; Eject Key
F20::SendInput {Delete}
F12::SendInput {Delete}



/**
 * Adapted from scripts by Chris Dhanaraj, Pavel Pevnitskiy, and Taran Van Hemert
 *
 * https://medium.com/@chrisdhanaraj/mapping-your-macos-keybinds-to-windows-b6009c50065b
 * https://gist.github.com/fljot/58e46c92e99e7072ab56
* https://github.com/TaranVH/2nd-keyboard/blob/master/Taran's_Windows_Mods/Alt_menu_acceleration_DISABLER.ahk
 *
 * This script assumes some keys have been remapped in the Windows registry
 * to behave closer to a macOS keyboard layout. This key remapping can be
 * done using SharpKeys or a similar program.
 * https://www.randyrants.com/category/sharpkeys/
 *
 * Specifically, I remapped the following keys:
 * Left Alt -> Right Control
 * Right Alt -> Right Control
 * Left Windows -> Left Alt
 *
 * I remapped both Alt keys to Right Control to differentiate between the
 * remapped Control key and the regular Left Control key. For instance,
 * RightControl-Tab is remapped to Alt-Tab so you can switch windows like
 * Command-Tab in macOS. But LeftControl-Tab still retains its normal behavior,
 * such as switching tabs in Chrome or another web browser.
 *
 * Normally, AutoHotkey uses the following shorthands for modifier keys.
 *
 * ! = Alt
 * ^ = Control
 * + = Shift
 * # = Windows
 *
 * So, ^q is the same as pressing Control-Q. However, since we remapped the Alt
 * and Windows keys in the registry, the shorthand might not match the key you're
 * actually pressing on your keyboard. For instance, in the case of ^q, you
 * would actually be pressing Alt-Q on your keyboard since we remapped
 * Left Alt to Right Control. If we apply the key remapping, then AutoHotkey's
 * shorthand should translate to this on your keyboard.
 *
 * ! = Windows
 * ^ = Alt (or Left Control since we didn't remap that)
 * + = Shift
 * # = Right Windows (if your keyboard has one)
 *
 * If you're using an Apple Keyboard, it should translate to this.
 *
 * ! = Option
 * ^ = Command (or Left Control)
 * + = Shift
 * # = Nothing
 *
 * TODO: Voiceover/NVDA modifier key
 * TODO: Command-Backspace delete selected file (when Explorer is active)
 */


#NoEnv  ; Recommended for performance and compatibility
SendMode Input  ; Better speed and reliability
SetWorkingDir %A_ScriptDir%  ; Ensure consistent starting directory
#SingleInstance force


/**
 * Disable Alt key acceleration.
 * These next two lines are very important. You have to change the "menu mask
 * key" away from being Control, to something that won't result in cross-talk.
 * https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
 */
#MenuMaskKey vk07 ; vk07 is unassigned
#UseHook

; Re-assign alt to scan code of an unassigned key
~LAlt::
  Sendinput {Blind}{sc0E9}
  KeyWait, LAlt
  Sendinput {Blind}{sc0EA}
return

~RAlt::
  Sendinput {Blind}{sc0E9}
  KeyWait, RAlt
  Sendinput {Blind}{sc0EA}
return


; Command-H - Minimize active window
^h::WinMinimize, A
; Command-Q - Close active window
^q::WinClose, A
; F3 - Mission control (Win-Tab is the closest thing Windows has)
; Magic Keyboard Utilities remaps F3 to Alt-Tab
!Tab::Send {LWin down}{Tab}{LWin up}
; Option-Command-Eject - Put to sleep
!^Del::DllCall("LockWorkStation")

; Command-Tab - Switch windows
; Reference: https://autohotkey.com/board/topic/148298-ctrl-tab-ctrl-shift-tab-for-alttabshiftalttab-task-switching-windows-10/
>^Tab::Send {Alt down}{Tab}
>^+Tab::Send {Alt down}{Shift down}{Tab}{Shift up}
#If WinExist("ahk_class MultitaskingViewFrame")
  Ctrl Up::Send {Alt up}
#If

; Command-arrow navigation
^Left::Send {Home}
^Right::Send {End}
^Up::Send {Control down}{Home}{Control up}
^Down::Send {Control down}{End}{Control up}

; Command-Shift-arrow navigation + highlight
^+Left::Send {Shift down}{Home}{Shift up}
^+Right::Send {Shift down}{End}{Shift down}
^+Up::Send {Control down}{Shift down}{Home}{Shift up}{Control up}
^+Down::Send {Control down}{Shift down}{End}{Shift up}{Control up}

; Option-arrow navigation
!Left::Send {Control down}{Left}{Control up}
!Right::Send {Control down}{Right}{Control up}

; Option-Shift-arrow navigation + highlight
!+Left::Send {Control down}{Shift down}{Left}{Shift up}{Control up}
!+Right::Send {Control down}{Shift down}{Right}{Shift up}{Control up}

; Command-D - Delete forward
^d::Send {Delete}
; Command-Delete - Delete line
^Backspace::Send {Shift down}{Home}{Shift up}{Delete}
; Command-Shift-Delete - Delete line forward
^+Backspace::Send {Shift down}{End}{Shift up}{Delete}
; Option-Delete - Delete word
!Backspace::Send {Control down}{Backspace}{Control up}
; Option-Shift-Delete - Delete word forward
!+Backspace::Send {Control down}{Delete}{Control up}

; Command-Shift-5 - Screenshot
^+5::Send {LWin down}{Shift down}s{Shift up}{LWin up}

; Option-Command-C - View clipboard history (this is the default shortcut in Alfred)
^!c::Send {LWin down}v{LWin up}

; Chrome shortcuts
#IfWinActive ahk_exe chrome.exe
  ; Command-[ - Browser back
  ^[::Send {Browser_Back}
  ; Command-] - Browser forward
  ^]::Send {Browser_Forward}
  ; Command-Option-I - Developer tools
  ^!i::Send {F12}
  ; Command-Y - History
  ^y::Send {Control down}h{Control up}
#IfWinActive