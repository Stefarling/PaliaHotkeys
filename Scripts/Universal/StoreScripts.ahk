#Requires AutoHotkey v2.0
; TITLE Store Scripts
; SCRIPTVERSION 1.0.3
; TARGETAPP Palia
; TARGETVERSION 0.173.0
; TARGETRESOLUTION Universal
; AUTHOR Stefarling
; DESCRIPTION Improves the UI in stores.
; MAINCATEGORY Trade
; SUBCATEGORY Enhancement
; RELEASE Experimental

; BEGINHELPSCRIPT
+F1::
Help(*){

    MsgBox "
    (
    This script improves the UI at stores.
    Press SHIFT+2 to sell everything in bar 2.
    Press SHIFT+3 to sell everything in bar 3.
    Press SHIFT+4 to sell everything in bar 4.
    Press SHIFT+5 to sell everything in bar 5.
    Press purchase to buy once.
    Press CTRL and purchase to buy 10 times.
    Press SHIFT and purchase to buy 50 times.
    )"
}
; ENDHELPSCRIPT

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
BarFiveX        := "1173"                      ; X coordinate of top left item
BarFiveY        := "333"                       ; Y coordinate of top left item
ItemSize        := "80"                        ; Item size
ItemSpacingX    := "40"                        ; Space between items horizontally
ItemSpacingY    := "26"                        ; Space between items vertically
ButtonSellStack := "1733 1280"                 ; Button to sell stack
ItemColumns     := [1, 2, 3, 4, 5, 6, 7, 8]    ; Array because AHKv2 is daft

; Don't edit below this line

; Settings
CoordMode "Mouse", "Client" ; Move mouse relative to screen


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