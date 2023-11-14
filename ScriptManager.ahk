#Requires AutoHotkey v2.0
; Universal V1.0


/*
Use this script to manage all scripts in the folder.
*/


/* TODO
Add ability to preview script content.
Add Test button.
Add most of this to context menu.
*/

; Settings
Persistent


; Hotkeys


; Variables
ProgramName             := "ScriptManager by Stef"
Resolutions             := ["1920x1080", "2560x1440"]
Scripts                 := []
ScriptsRunning          := 0
Resolution              := ""
FocusedScript           := ""

Running                 := "✓"
Stopped                 := "X"
Unknown                 := "?"


; Gui
MainGui                 := Gui()
MainGui.Title           := ProgramName

; Gui Controls
ResolutionGuiLabel      := MainGui.Add("Text", "Section","Resolution")
ResolutionComboBox      := MainGui.Add("ComboBox", "", Resolutions)

StartButton             := MainGui.Add("Button", "Section Y+5 r2 w60", "Start`nScript")
ScriptsFolderButton     := MainGui.Add("Button","r2 w60","Scripts`nFolder")
StopButton              := MainGui.Add("Button", "YP r2 w60", "Stop`nScript")



; Gui ListView
ListView                := MainGui.Add("ListView", "Section XM+150 YM+0 h150 w300 -multi",["", "Script Name", "Path"])
ListView.ModifyCol()
ListView.ModifyCol(3, "150")


; Gui OnEvents
ResolutionComboBox.OnEvent("Change", UpdateResolution )
StartButton.OnEvent("Click", StartScript)
StopButton.OnEvent("Click", StopScript)
ScriptsFolderButton.OnEvent("Click", OpenScriptsFolder)
ListView.OnEvent("ItemFocus", ScriptFocused)


; Functions
UpdateResolution(obj, info){
    if ( obj.Value > 0){
        global Resolution := Resolutions[obj.Value]
    }

    ListScripts()

}

OpenScriptsFolder(*){
    try {
        Run "explore " A_ScriptDir "\Scripts"
        
    }
}

StartScript(*){
    if(FocusedScript = ""){
    }else{
        Run FocusedScript
    }

}

StopScript(*){
    if(FocusedScript = ""){
        ; DO NOTHING
    }else{
        DetectHiddenWindows "On"
        DetectHiddenText "On"

        scriptie := RegExReplace(FocusedScript, "^.*\\")

        WinClose(scriptie)

        DetectHiddenText "Off"
        DetectHiddenWindows "Off"
        
    }
    
}

ScriptFocused(obj, item){
       global FocusedScript := ListView.GetText(item, 3)
}

ListScripts(){
    scriptsUniversalPath    := A_ScriptDir "\Scripts\Palia\Universal"
    scriptsResolutionPath   := A_ScriptDir "\Scripts\Palia\" Resolution

    ListView.Delete()
    ListView.Opt("-Redraw")

    Loop Files, scriptsUniversalPath "\*.ahk"
        ListView.Add(,Unknown, A_LoopFileName, A_LoopFilePath)

    Loop Files, scriptsResolutionPath "\*ahk"
        ListView.Add(,Unknown, A_LoopFileName, A_LoopFilePath)
    
    ListView.ModifyCol()
    ListView.ModifyCol(2, "Sort")
    ListView.ModifyCol(3, "150")
    
    ListView.Opt("+Redraw")    
}

UpdateScriptsStatus(){
    DetectHiddenWindows "On"
    ListView.Opt("-Redraw")
    ScriptsRunning := 0
    ListView.Modify(0,, Stopped)
    ListView.ModifyCol(3, "150")

    runningScripts := WinGetList("ahk_class AutoHotkey")
    for k, v in  runningScripts{
        title := WinGetTitle(runningScripts[k])
        title := RegExReplace(title, " - AutoHotkey v[\.0-9]+$")
        Loop ListView.GetCount(){
            if (title == ListView.GetText(A_Index, 3)){
                ListView.Modify(A_Index,, Running )
                ScriptsRunning++
                ListView.ModifyCol(1,, ScriptsRunning)
            }
        }
    }
    
    DetectHiddenWindows "Off"
    ListView.ModifyCol(3, "150")
    ListView.Opt("+Redraw")  
}

UpdateGui(){
    UpdateScriptsStatus()


}


; Button Events


; Run the script
ListScripts()
SetTimer(UpdateGui, 1000)
MainGui.Show()