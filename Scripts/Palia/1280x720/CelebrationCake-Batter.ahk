﻿#Requires AutoHotkey v2.0
; TITLE Batter Script
; SCRIPTVERSION 1.0.3
; TARGETAPP Palia
; TARGETVERSION 0.173.0
; TARGETRESOLUTION 1280x720
; AUTHOR Stefarling
; DESCRIPTION Use this script to select batter for Celebration Cake.
; MAINCATEGORY Cooking
; SUBCATEGORY Celebration Cake
; RELEASE Stable

; BEGINHELPSCRIPT
+F1::
HelpScript(*){

    MsgBox "
    (
    Use this script to select Batter when creating a Celebration Cake.
    This is to avoid fighting the UI when multiple people make batter.
    Press FORWARD MOUSE BUTTON to run the script.
    Press SHIFT+F1 to test the script.
    )"
}

; ENDHELPSCRIPT



; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
XButton2::MainScript
+F2::TestScript


; Variables
SleepTimer  := 1            ; Milliseconds
ButtonOne   := "333 276"    ; First button to try
ButtonTwo   := "333 333"    ; Second button to try
ButtonThree  := "800 586"  ; Make button


; Settings
CoordMode "Mouse", "Client" ; Move mouse relative to client


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

TestScript() {              ; Shows where we'll click
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
