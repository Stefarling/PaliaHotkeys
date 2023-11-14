#Requires AutoHotkey v2.0
; Manages all scripts in a folder


/*
Use this script to manage all scripts in the folder.
*/


/* TODO
Make a scripts folder button.
Add green/red light when running.
Add ability to preview script content.
Add Test button.
Add most of this to context menu.
*/

; Settings
Persistent


; Hotkeys


; Variables
ProgramName             := "ScriptManager by Stef"
Resolutions             := ["1280x720", "1920x1080", "2560x1440"]
Scripts                 := []
Resolution              := ""


; Gui
MainGui                 := Gui()
MainGui.Title           := ProgramName

; Gui Controls
ResolutionGuiLabel      := MainGui.Add("Text", "Section","Resolution")
ResolutionComboBox      := MainGui.Add("ComboBox", "", Resolutions)

StartButton              := MainGui.Add("Button", "Y+40 r1", "Start Script")
StopButton               := MainGui.Add("Button", "YP r1", "Stop Script")


; Gui ListView
ListView                := MainGui.Add("ListView", "Section YS w300",["Running", "Script Name", "Path"])
ListView.ModifyCol()

; Gui Statusbar
StatusBar               := MainGui.Add("StatusBar",,)

; Gui OnEvents
ResolutionComboBox.OnEvent("Change", UpdateResolution )


; Functions
UpdateResolution(obj, info){
    if ( obj.Value > 0){
        global Resolution := Resolutions[obj.Value]
    }

    ListScripts()

}

ListScripts(){
    scriptsUniversalPath    := A_ScriptDir "\Scripts\Palia\Universal"
    scriptsResolutionPath   := A_ScriptDir "\Scripts\Palia\" Resolution

    ListView.Delete()

    Loop Files, scriptsUniversalPath "\*.ahk"
        ListView.Add(,, A_LoopFileName, A_LoopFilePath)

    Loop Files, scriptsResolutionPath "\*ahk"
        ListView.Add(,, A_LoopFileName, A_LoopFilePath)
    
    ListView.ModifyCol()
    
}


; Button Events


; Run the script
ListScripts()
MainGui.Show()