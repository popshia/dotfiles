#SingleInstance, force

global PreviousActiveWindow

; Requires windows terminal preview: https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701

!r::
DetectHiddenWindows, On
if (WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")) {
	if(WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")) {
		WinActivate, ahk_id %PreviousActiveWindow%
	} else {
		WinGet, PreviousActiveWindow, , A ; 'A' for currently active window
		WinActivate, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
	}
} else {
	TerminalLink = %localappdata%\Microsoft\WindowsApps\wt.exe
	if FileExist(TerminalLink) {
		WinGet, PreviousActiveWindow, , A ; 'A' for currently active window
		Run, %TerminalLink%
	} else {
		MsgBox, Windows Terminal not installed
	}
}
Return