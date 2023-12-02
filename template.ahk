#Requires AutoHotkey v2.0
; TITLE Template Script
; SCRIPTVERSION 0.0.0
; TARGETAPP Palia
; TARGETVERSION 0.173.0
; TARGETRESOLUTION xxxxXyyyy
; AUTHOR Kilroy
; DESCRIPTION Improves the UI in some way.
; MAINCATEGORY Awesomeness
; SUBCATEGORY Enhancement
; RELEASE Experimental
; https://raw.githubusercontent.com/Stefarling/PaliaHotkeys/main/template.ahk

; #ANCHOR - ENDHEADER

; BEGINHELPSCRIPT
+F1::
Help(*){

    MsgBox "
    (
        This is a function that can open a small descriptive help text.
    )"
}
; ENDHELPSCRIPT

; #ANCHOR - Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
; None, except for the above Help hotkey


; #ANCHOR - Variables
VariableA := "Nothing"


; #ANCHOR - Settings
CoordMode "Mouse", "Client" ; Move mouse relative to screen


; #ANCHOR - Functions
GreatFunction() { ; This is a great function!
    ; It does nothing!
}