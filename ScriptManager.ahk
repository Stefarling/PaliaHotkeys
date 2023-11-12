#Requires AutoHotkey v2.0
; Manages all scripts in a folder

; STILL NOT FUNCTIONAL

/*

*/

; Settings


; Variables
Version                 := "0.0.2a"
WindowTitle             := "PaliaHotkeys v" Version
Resolutions             := ["1280x720", "1920x1080", "2560x1440"]
MainGui                 := Gui()
MainGui.Title           := WindowTitle
Resolution              := "Nothing selected."


; Hotkeys


; Function
UpdateResolution(obj, info) {
    if obj.Value < 1{
        ; The control returns an actual array, NOT an AHK array.
    }else{
    global Resolution := Resolutions[obj.Value]
    RPickerText.Text := Resolution
    }
}


; GUI

; GUI Resolution
MainGui.Add("GroupBox", "X10 Y10 r3 Section")
MainGui.Add("Text", "XS+10 YS+10", "Resolution:")
RPicker := MainGui.Add("ComboBox",, Resolutions)
RPicker.OnEvent("Change", UpdateResolution)
RPickerText := MainGui.Add("Text",, Resolution)

; GUI Buttons
MainGui.Add("GroupBox", "X10 r1 Section")
MainGui.Add("Button", "XS+5 YS+10", "Demonstrate")
MainGui.Add("Button", "YP vScriptToggle", "Start")

; GUI ListView
MainGui.Add("Text", "YM Section", "Scripts:")
LV := MainGui.Add("ListView","")


MainGui.Show()