#Requires AutoHotkey v2.0
; 1920x1080 Windowed Fullscreen V1.0

/* 
Use this script to start Chili Oil Dumplings.
This is a UI improvement to mitigate shenanigans.
Press FORWARD MOUSE BUTTON to run the script.
Press SHIFT+F1 to test the script.
*/


; Settings
CoordMode "Mouse", "Screen" ; Move mouse relative to screen


; Variables
SleepTimer  := 1            ; Milliseconds
ButtonOne   := "400 600"    ; Select recipe
ButtonTwo   := "620 975"    ; Tick star ingredients
ButtonThree := "1200 975"   ; Start Button


; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
XButton2::MainScript      ; Run main script
+F1::HelpScript           ; Run help script


; Functions
MainScript() {                  ; Starts the script
    Click ButtonOne             ; Selects Chili Oil Dumplings
    Sleep SleepTimer            ; Delay
    Click ButtonTwo             ; Tick Star Ingredients
    Sleep SleepTimer            ; Delay
    Click ButtonThree           ; Click Start
    Sleep SleepTimer            ; Delay
}


HelpScript() {              ; Shows where we'll click
    Click ButtonOne ", 0"   ; Move mouse but don't click
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


