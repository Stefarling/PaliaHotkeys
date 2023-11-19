#Requires AutoHotkey v2.0
; TITLE Store Scripts
; VERSION 1.0.2-alpha1
; TARGET 0.172.0
; AUTHOR Stefarling
; DESCRIPTION Improves the UI in stores.
; CATEGORY Palia Trade 1280x720 BROKEN

; USE WITH CARE! THIS CANNOT BE UNDONE!

/* 
This script improves the UI at stores.
Press SHIFT+F1 to test the script.
Press SHIFT+2 to sell everything in bar 2.
Press SHIFT+3 to sell everything in bar 3.
Press SHIFT+4 to sell everything in bar 4.
Press SHIFT+5 to sell everything in bar 5.
Press purchase to buy once.
Press CTRL and purchase to buy 10 times.
Press SHIFT and purchase to buy 50 times.
*/


; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
+2::SellBar2      ; Sells bar 2
+3::SellBar3      ; Sells bar 3
+4::SellBar4      ; Sells bar 4
+5::SellBar5      ; Sells bar 5
^LButton::Buy10   ; Purchases 10 times
+LButton::Buy50   ; Purchases 50 times


; Variables
SleepTimer      := 10                          ; Milliseconds
BarFiveX        := "880"                       ; X coordinate of top left item
BarFiveY        := "250"                       ; Y coordinate of top left item
ItemSize        := "60"                        ; Item size
ItemSpacingX    := "30"                        ; Space between items horizontally
ItemSpacingY    := "20"                        ; Space between items vertically
ButtonSellStack := "1300 960"                  ; Button to sell stack
ItemColumns     := [1, 2, 3, 4, 5, 6, 7, 8]    ; Array because AHKv2 is daft


; Settings
CoordMode "Mouse", "Screen" ; Move mouse relative to screen


; Functions
SellBar2() {                                                ; All the sell scripts are identical, except the BarY
    local BarX := BarFiveX                                  ; Fist, get the X coordinate of the first item
    local BarY := BarFiveY + 3*(ItemSize+ItemSpacingY)      ; Then the Y coordinate. Add ItemSize+ItemSpace times row

    For k, v in ItemColumns                                 ; For loop to iterate over items
        {
        Click BarX+(ItemSize+ItemSpacingX)*(v-1), BarY      ; Click item based on coordiantes
        Sleep SleepTimer                                    ; Delay
        Click ButtonSellStack                               ; Click the Sell Stack button
        Sleep SleepTimer                                    ; Delay
        }

}

SellBar3() {
    local BarX := BarFiveX
    local BarY := BarFiveY + 2*(ItemSize+ItemSpacingY)

    For k, v in ItemColumns
        {
        Click BarX+(ItemSize+ItemSpacingX)*(v-1), BarY
        Sleep SleepTimer
        Click ButtonSellStack
        Sleep SleepTimer
        }

}

SellBar4() {
    local BarX := BarFiveX
    local BarY := BarFiveY + 1*(ItemSize+ItemSpacingY)

    For k, v in ItemColumns
        {
        Click BarX+(ItemSize+ItemSpacingX)*(v-1), BarY
        Sleep SleepTimer
        Click ButtonSellStack
        Sleep SleepTimer
        }

}

SellBar5() {
    local BarX := BarFiveX
    local BarY := BarFiveY

    For k, v in ItemColumns
        {
        Click BarX+(ItemSize+ItemSpacingX)*(v-1), BarY
        Sleep SleepTimer
        Click ButtonSellStack
        Sleep SleepTimer
        }
}

Buy10() {       ; Simple purchase script
    Click 10    ; Clicks 10 times
}

Buy50() {       ; Simple purchase script
    Click 50    ; Clicks 50 times
}