
#SingleInstance, force
SetCapsLockState, Off

IfWinExist, ahk_exe RobloxPlayerBeta.exe
{
    WinActivate
    WinWaitActive
}
else
{
    MsgBox, Roblox is not running. Please open the game and try again.
    ExitApp
}

WinMove, ahk_exe RobloxPlayerBeta.exe,, 0, 0, 100, 100
List := ["w","a","s","d"]
TimerReset := A_TickCount
Send g ; Start fishing (Start KEY)
Timer := A_TickCount

Loop
{
	if (Paused)
    {
        Sleep 1000  ; Avoid consuming too much CPU while paused
        Continue
    }
	
    If (A_TickCount - Timer > 60000) {
        Send g
        Sleep 1000
        Timer := A_TickCount
    }
	
	; Display tooltip for debugging
    ToolTip, Waiting to start
	
    ImageSearch,,, 208, 173, 260, 212, *20 Image/Space.png
    If (ErrorLevel = 0) { ; Image Found
		ToolTip, Start fishing
        Send {Space}
        Sleep 300
        Loop, ; Start pressing keys
        {
            Temp := 0
            Temp2 := 9999
            Err := 0
            for i, v in List {
                ImageSearch, Xpos,, 10, 180, 800, 210, *10 *TransBlack Image/%v%.bmp 
                If (ErrorLevel = 0) { ; Image found
                    Temp := Xpos
                    If (Temp < Temp2) {
                        Temp2 := Temp
                        Key := v
                    }
                } Else if (ErrorLevel = 1) {
                    Err++ ; Image not found
                } else {
                    Msgbox Image not in the folder
                }

            }
            if (Err >= 4) {
                Break
            }
            Send %Key% ; Pressing right buttons
            Sleep 100
        }
        Sleep 200
        Send g
        Timer := A_TickCount
    }

}
Return

; Hotkey to pause the Script "Ctrl+F7"
^F7::
Paused := !Paused  ; Toggle between True and False
if (Paused)
    ToolTip, Script Paused
else
    ToolTip, Script Resumed
Return

; Hotkey to exit the script with Ctrl + F8
^F8::ExitApp