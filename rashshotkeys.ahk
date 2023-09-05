#Requires AutoHotkey v2.0

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        A_IconHidden := true
        Sleep 200  ; It may be necessary to adjust this sleep.
        A_IconHidden := false
    }
}

; ALT + CTRL + F12

!^f12::{
;Save the state of clipboard
ClipSaved := ClipboardAll() 
A_ClipBoard := ""
;Program outputs, and copies to clipboard the default sound device
RunWait A_MyDocuments . "\ToolsNScripts\GetDefaultAudioDevice.exe",,'hide'
;Assign the default sound device to varieble
ActiveDevice := A_ClipBoard
;Restore the clipboard
A_Clipboard := ClipSaved

input1 := "CABLE Input"
input2 := "Speakers"
if(ActiveDevice = input1){
    newActive := input2
}else{
    newActive := input1
    }
RunWait A_MyDocuments . "\ToolsNScripts\nircmd.exe setdefaultsounddevice `"" . newActive . "`" 1",,'hide'
RunWait A_MyDocuments . "\ToolsNScripts\nircmd.exe setdefaultsounddevice `"" . newActive . "`" 2",,'hide'
TrayTip newActive, newActive,"Iconi Mute"
Sleep 1000   ; Let it display for 1 seconds.
HideTrayTip
}

; ALT + CTRL + M
!^m::{
    mic := "Microphone Array"
    RunWait A_MyDocuments . "\ToolsNScripts\svcl.exe /Disable `"" . mic . "`"",,"hide"
    sleep 200
    RunWait A_MyDocuments . "\ToolsNScripts\svcl.exe /Enable `"" . mic . "`"",,"hide"
}