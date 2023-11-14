#Requires AutoHotkey v2.0
; 1920x1080 Windowed Fullscreen 

/* 
Use this script to select Batter when creating a Celebration Cake.
This is to avoid fighting the UI when multiple people make batter.
Press SHIFT+z to run the script.
Press SHIFT+F1 to test the script.
*/


; Settings
CoordMode "Mouse", "Screen" ; Move mouse relative to screen


; Variables
SleepTimer  := 1            ; Milliseconds
ButtonOne   := "500 415"    ; First button to try
ButtonTwo   := "500 500"    ; Second button to try
ButtonThree  := "1200 880"  ; Make button


; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
+z::MainScript      ; Run main script
+F1::HelpScript     ; Run help script


; Functions
MainScript() {             ; Starts the script
    Click ButtonOne        ; Click Batter if it's higher on the list
    Sleep SleepTimer       ; Delay
    Click ButtonThree      ; Click Make
    Sleep SleepTimer       ; Delay

    Click ButtonTwo        ; Click Batter if it's lower on the list
    Sleep SleepTimer       ; Delay
    Click ButtonThree      ; Click Make
    Sleep SleepTimer       ; Delay
}

HelpScript() {              ; Shows where we'll click
    Click ButtonOne ", 0"   ; Move mouse but don't click
    ShowClickIndicator()    ; Show tooltip
    Sleep SleepTimer        ; Delay

    Click ButtonThree ", 0" ; Move mouse but don't click
    ShowClickIndicator()    ; Show tooltip
    Sleep SleepTimer        ; Delay

    Click ButtonTwo ", 0"   ; Move mouse but don't click
    ShowClickIndicator()    ; Show tooltip
    Sleep SleepTimer        ; Delay

    Click ButtonThree ", 0" ; Move mouse but don't click
    ShowClickIndicator()    ; Show tooltip
    Sleep SleepTimer        ; Delay
}

ShowClickIndicator() {          ; Tooltip for help script
    ToolTip("I'll click here!") ; Display tooltip
    Sleep 1500                  ; Adjust the duration the tooltip is displayed (in milliseconds)
    ToolTip                     ; Close the tooltip
}
