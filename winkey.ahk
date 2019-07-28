#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ActivateNextWindow() {
    WinGet, CurrentExe, ProcessName, A
    WinGetClass, CurrentClass, A
    WinGet, Instances, Count, ahk_class %CurrentClass% ahk_exe %CurrentExe%
    if (Instances > 1) {
        WinSet, Bottom,, A
    }
    WinActivate, ahk_class %CurrentClass% ahk_exe %CurrentExe%
}

ActivatePrevWindow() {
    WinGet, CurrentExe, ProcessName, A
    WinGetClass, CurrentClass, A
    WinGet, Instances, Count, ahk_class %CurrentClass% ahk_exe %CurrentExe%
    if (Instances > 1) {
        WinActivateBottom, ahk_class %CurrentClass% ahk_exe %CurrentExe%
    }
}

ActivateOrLaunch(query, exe) {
    if WinActive(query)
        ActivateNextWindow()
    else if WinExist(query)
        WinActivate
    else
        Run %exe%
}

ChromePath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
VimPath := "C:\Program Files\vim\vim81\gvim.exe"
CmdPath := "C:\Windows\System32\cmd.exe"
ExplorerPath := "C:\Windows\explorer.exe"
SnippingToolPath := "C:\Windows\System32\SnippingTool.exe"
PowershellPath := "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

#i::
ActivateOrLaunch("ahk_class Chrome_WidgetWin_1", ChromePath)
return

#+i::
Run %ChromePath%
return

#v::
ActivateOrLaunch("ahk_class Vim", VimPath)
return

#+v::
Run %VimPath%
return

#^+v::
Run *RunAs %VimPath%
return

#c::
ActivateOrLaunch("ahk_exe cmd.exe", CmdPath)
return

#+c::
Run %CmdPath%
return

#^+c::
Run *RunAs %CmdPath%
return

#p::
ActivateOrLaunch("ahk_exe powershell.exe", PowershellPath)
return

#+p::
Run %PowershellPath%
return

#^+p::
Run *RunAs %PowershellPath%
return

#d::#p ; change display projection
#Space::#^d ; create a new virtual desktop
#+Space::#^F4 ; halt the virtual desktop
#n::#^Right ; switch to next virtual desktop
#+n::#^Left ; switch to previous virtual desktop

#e::
ActivateOrLaunch("ahk_class CabinetWClass", ExplorerPath)
return

#+e::
Run %ExplorerPath%
return

#s::
ActivateOrLaunch("ahk_class Microsoft-Windows-SnipperToolbar", SnippingToolPath)
return

#+s::
Run %SnippingToolPath%
return

#j::
ActivateNextWindow()
return

#k::
ActivatePrevWindow()
return

#q::
WinClose A
return

#+q::
CloseAllSimilar() {
    WinGet, CurrentExe, ProcessName, A
    WinGetClass, CurrentClass, A
    GroupAdd, CloseGroup, ahk_class %CurrentClass% ahk_exe %CurrentExe%
    WinClose, ahk_group CloseGroup
}
return

#^+q::
CloseAll() {
    WinGet, windowList, List
    MsgBox % windowList
    Loop % windowList {
        WinGetClass, cls, % "ahk_id " windowList%A_Index%
        WinGet, name, ProcessName, % "ahk_id " windowList%A_Index%
        if (name != "explorer.exe") || (cls != "Progman" && cls != "Shell_TrayWnd") {
            WinClose, % "ahk_id " windowList%A_Index%
        }
    }
}
return

;#j::
;WinGet, CurrentActive, ProcessName, A
;WinGet, Instances, Count, ahk_exe %CurrentActive%
;if Instances > 1
;    WinSet, Bottom,, A
;WinActivate, ahk_exe %CurrentActive%
;return
;
;#k::
;WinGet, CurrentActive, ProcessName, A
;WinGet, Instances, Count, ahk_exe %CurrentActive%
;if Instances > 1
;    WinActivateBottom, ahk_exe %CurrentActive%
;return

;#j::
;WinGetClass, CurrentActive, A
;WinGet, Instances, Count, ahk_class %CurrentActive%
;if Instances > 1
;    WinSet, Bottom,, A
;WinActivate, ahk_class %CurrentActive%
;return
;
;#k::
;WinGetClass, CurrentActive, A
;WinGet, Instances, Count, ahk_class %CurrentActive%
;if Instances > 1
;    WinActivateBottom, ahk_class %CurrentActive%
;return
