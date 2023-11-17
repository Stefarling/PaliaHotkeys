#Requires AutoHotkey v2.0
; 1920x1080 Windowed Fullscreen V1.0.2

/* 
Use this script to start any cooking recipe.
This is a UI improvement to mitigate shenanigans.
Follow the on-screen prompt.
*/


; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
XButton2::
    MainScript(hk) {    
        uiIsClosed  := true
        attempts    := 0
    
    
        if WinExist(ProgramName){
            WinActivate ; Use the window found by WinExist.
            Sleep SleepTimer
        }
    
        while(uiIsClosed){
            if(PixelGetColor(ControlColorX, ControlColorY) = ControlColor){
                uiIsClosed := false
            }else{
                if (attempts > 59){
                    break
                }else{
                    attempts++
                }
            }
        }

        if((A_TickCount - HotKeyTime) > 50){
            global HotKeyTime := A_TickCount    

            if(ScriptEnabled){
                Sleep SleepTimer

                TryRecipeButton

                TryStarButton

                TryMakeButton
            }
        }

    }


; Variables
ProgramName     := "Palia" 
SleepTimer      := 100          ; Milliseconds
StarButton      := "618 985"    ; Tick star ingredients
MakeButton      := "1200 975"   ; Start Button
HotKeyTime      := A_TickCount  ; Hotkey activation timestamp
AvailableHotkeyButtons  := ["LButton", "RButton", "MButton", "XButton1", "XButton2"]
GuiWidth        := 175
ClickCount      := 0
RecipeNumber    := 0
ButtonTwoColor  := ""
ControlColor    := ""
ControlColorX   := 500
ControlColorY   := 70
ScriptEnabled   := false


; Settings
CoordMode "Mouse", "Screen" ; Move mouse relative to screen
CoordMode "Pixel", "Screen" ; Check pixels relative to screen


; GUI
GuideGui    := Gui()
GuideGui.Opt("+AlwaysOnTop -Resize +ToolWindow +OwnDialogs")

GuideGui.SetFont("s9 Bold")
TextSection     :="
(
Step 1:
)"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)
GuideGui.SetFont("s9 Norm")
TextSection     :="
(
Open your crafting station UI but touch or click nothing.
)"
TutorialText            := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)

GuideGui.SetFont("s9 Bold")
TextSection     :="
(
Step 2:
)"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)
GuideGui.SetFont("s9 Norm")
TextSection     :="
(
Select the recipe number from this dropdown.
)"
TutorialText    := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
RecipeComboBox  := GuideGui.Add("ComboBox",,[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 22, 23, 24, 25])

GuideGui.SetFont("s9 Bold")
TextSection     :="
(
Step 3:
)"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)
GuideGui.SetFont("s9 Norm")
TextSection     :="
(
Click "Calibrate" when the above steps are done. `nYour cursor will be jittery.
)"
TutorialText    := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
ButtonCalibrate := GuideGui.Add("Button",,"Calibrate")

GuideGui.SetFont("s9 Bold")
TextSection     :="
(
Step 4:
)"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)
GuideGui.SetFont("s9 Norm")
TextSection     :="
(
Close your UI, then reopen and press "Test". `nYour cursor will be jittery.
)"
TutorialText        := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
ButtonTest          := GuideGui.Add("Button",,"Test")

GuideGui.SetFont("s9 Bold")
TextSection     :="
(
Step 5:
)"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)
GuideGui.SetFont("s9 Norm")
TextSection     :="
(
You can now test your HotKey by pressing it. 
The default is MOUSE BUTTON FORWARD.
Don't worry, it won't make anything yet.

Click "yes" to start the script.
This indicates the script is working.
This will also hide this prompt.
You can later reopen or quit the script,
from the tray icon.

Click "no" to exit the script if it failed.
)"
TutorialText        := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
ButtonConfirm       := GuideGui.Add("Button",,"Yes")
ButtonCancel        := GuideGui.Add("Button","YP", "No")

; GUI - Buttons
ButtonCalibrate.Enabled     := false
ButtonTest.Enabled          := false
ButtonConfirm.Enabled       := false
ButtonCancel.Enabled        := false


; GUI - OnEvent
RecipeComboBox.OnEvent("Change", AssignRecipeNumber)
ButtonCalibrate.OnEvent("Click", CalibrateScript)
ButtonTest.OnEvent("Click", TestScript)
ButtonConfirm.OnEvent("Click", StartScript)
ButtonCancel.OnEvent("Click", ExitScript)


; Functions
AssignRecipeNumber(obj, info){

    global RecipeNumber := obj.Value
    ButtonCalibrate.Enabled := true
}

CalibrateScript(*){


    if WinExist(ProgramName){
        WinActivate ; Use the window found by WinExist.
        Sleep SleepTimer
        global ControlColor := PixelGetColor(ControlColorX, ControlColorY)
    }

        TryRecipeButton
        
        TryStarButton
        
        TryMakeButton
        
        ButtonTest.Enabled := true
    }


TestScript(*){
    uiIsClosed  := true
    attempts    := 0


    if WinExist(ProgramName){
        WinActivate ; Use the window found by WinExist.
        Sleep SleepTimer
    }

    while(uiIsClosed){
        if(PixelGetColor(ControlColorX, ControlColorY) = ControlColor){
            uiIsClosed := false
        }else{
            if (attempts > 59){
                ExitScript
            }else{
                attempts++
            }
        }
    }

    TryRecipeButton    

    TryStarButton

    TryMakeButton

    

    ButtonConfirm.Enabled   := true
    ButtonCancel.Enabled    := true
    global ScriptEnabled    := true


}

TryRecipeButton(*){
    if(RecipeNumber>0){
        Loop RecipeNumber - 1
        {
            Send "{Down down}"
            Sleep 20
            Send "{Down up}"
        }
    }
}

TryRecipeButtonAlternate(*){
    ; Fallback to coords
}

TryStarButton(*){
    buttonCoords  := StrSplit(StarButton, ' ')
    tickStarred := false
    attempts := 0
    
    while (tickStarred = false){
    
            If (PixelGetColor(buttonCoords[1], buttonCoords[2]-5) = PixelGetColor(buttonCoords[1], buttonCoords[2])){
                Click StarButton
                Sleep SleepTimer
            }else{
                tickStarred := true
            }
    
            if (attempts > 9){ 
                ExitScript         
            }else{
                attempts++
            }
        }
    
}

TryMakeButton(*){

    Click MakeButton  "," ClickCount
    Sleep SleepTimer

}

StartScript(*){
    global ClickCount := 1
    GuideGui.Destroy

}

ExitScript(*){
    MsgBox "I'm sorry something went wrong. `nPlease open an issue at the webpage just opened. "
    Run "https://github.com/Stefarling/PaliaHotkeys/issues"
    GuideGui.Destroy
    ExitApp 0
}

GuideGui.Show("NoActivate")