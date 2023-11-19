#Requires AutoHotkey v2.0
; TITLE Celebration Cake - Batter Script
; VERSION 1.0.2-alpha1
; TARGET 0.172.0
; AUTHOR Stefarling
; DESCRIPTION Use this script to select batter.
; CATEGORY Palia Cooking 'Celebration Cake' EXPERIMENTAL

/*
HELPBEGIN
Use this script to select Batter when creating a Celebration Cake.
This is to avoid fighting the UI when multiple people make batter.
Press FORWARD MOUSE BUTTON to run the script.
Press SHIFT+F1 to test the script.
HELPEND
*/

; Based on 2560x1440 Windowed Fullscreen V1.0



; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
XButton2::MainScript      ; Run main script
+F1::HelpScript           ; Run help script


; Variables
SleepTimer  := 1            ; Milliseconds
ButtonOne   := "690 550"    ; First button to try
ButtonTwo   := "690 700"    ; Second button to try
ButtonThree := "1600 1190"  ; Make button


; Settings
CoordMode "Mouse", "Screen" ; Move mouse relative to screen


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
