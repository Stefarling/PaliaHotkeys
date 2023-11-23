#Requires AutoHotkey v2.0
; TITLE Recipe Starter
; SCRIPTVERSION 1.0.3
; TARGETAPP Palia
; TARGETVERSION 0.173.0
; TARGETRESOLUTION 2560x1440
; AUTHOR Stefarling
; DESCRIPTION Use this script to select star ingredients and start any cooking recipe.
; MAINCATEGORY Cooking
; SUBCATEGORY Starter
; RELEASE Stable

; BEGINHELPSCRIPT
+F1::
Help(*){

    MsgBox "
    (
    Use this script to start Universal cooking recipe.
    This is a UI improvement to mitigate shenanigans.
    Follow the on-screen prompt to calibrate.
    )"
}
; ENDHELPSCRIPT


; Variables
ProgramName             := "ahk_exe PaliaClient-Win64-Shipping.exe"
ProgramWindowX          := 0
ProgramWindowY          := 0
ProgramWindowWidth      := 0
ProgramWindowHeight     := 0
SleepTimer              := 100          ; Milliseconds
ReferenceWidth          := 1920
ReferenceHeight         := 1080
ReferenceStarButtonX    := 618          ; Tick star ingredients
ReferenceStarButtonY    := 985          ; Tick star ingredients
ReferenceMakeButtonX    := 1200         ; Start Button
ReferenceMakeButtonY    := 975          ; Start Button
ReferenceControlColorX  := 500
ReferenceControlColorY  := 70
ReferenceAspectRatio    := ReferenceWidth/ReferenceHeight
AspectRatio2            := 0
StarButtonX             := 0
StarButtonY             := 0
MakeButtonX             := 0
MakeButtonY             := 0
ControlColorX           := 0
ControlColorY           := 0
HotKeyTime              := A_TickCount  ; Hotkey activation timestamp
AvailableHotkeyButtons  := ["XButton1", "XButton2"]
GuiWidth                := 175
ClickCount              := 0
RecipeNumber            := 0
ButtonTwoColor          := ""
ControlColor            := ""
ScriptHotkey            := "XButton2"
FontText                := "s10 Norm"
FontHeading             := "s11 Bold"
ScaleFactorX            := 0
ScaleFactorY            := 0




; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
#HotIf WinActivate(ProgramName)
Hotkey ScriptHotkey, PrimaryScript, "Off"
#HotIf


; Don't edit below this line

; Settings
CoordMode "Mouse", "Client" ; Move mouse relative to Palia window
CoordMode "Pixel", "Client" ; Check pixels relative to Palia window


; GUI
GuideGui        := Gui()
GuideGui.Opt("+AlwaysOnTop -Resize -SysMenu +OwnDialogs")

GuideGui.SetFont(FontHeading)
TextSection     :="Step 1:"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)
GuideGui.SetFont(FontText)
TextSection     :="Open your crafting station and click 'Calibrate'."
TutorialText    := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
ButtonCalibrate := GuideGui.Add("Button",,"Calibrate")

GuideGui.SetFont(FontHeading)
TextSection     :="Step 2:"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)

GuideGui.SetFont(FontText)
TextSection     :="Close your UI, then reopen, select your recipe and press 'Test'."
TutorialText        := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
ButtonTest          := GuideGui.Add("Button",,"Test")

GuideGui.SetFont(FontHeading)
TextSection     :="Step 3:"
TutorialText    := GuideGui.Add("Text","Section Left " GuiWidth,TextSection)

GuideGui.SetFont(FontText)
TextSection     :="
(
This script only works after re-opening the UI.

Test your hotkey now. `n'Make' is disabled while testing.
Default is MOUSE FORWARD.

If it works, click 'Yes'.
If not, click 'Quit' and rerun the script.
)"
TutorialText        := GuideGui.Add("Text","XP YP+15 Left " GuiWidth,TextSection)
ButtonConfirm       := GuideGui.Add("Button",,"Yes")
ButtonQuit          := GuideGui.Add("Button","XP+" GuiWidth+100 " YP", "Quit")

; GUI - Buttons
ButtonCalibrate.Enabled     := true
ButtonTest.Enabled          := false
ButtonConfirm.Enabled       := false
ButtonQuit.Enabled          := true


; GUI - OnEvent
ButtonCalibrate.OnEvent("Click", CalibrateScript)
ButtonTest.OnEvent("Click", TestScript)
ButtonConfirm.OnEvent("Click", StartScript)
ButtonQuit.OnEvent("Click", ExitScript)


; Functions
CalibrateScript(*){

    if WinExist(ProgramName){
        WinActivate ; Use the window found by WinExist.
        Sleep SleepTimer
        WinGetPos &x, &y, &w, &h, ProgramName
        global ProgramWindowX       := x
        global ProgramWindowY       := y
        global ProgramWindowWidth   := w
        global ProgramWindowHeight  := h

        global AspectRatio2 := (ProgramWindowWidth/ProgramWindowHeight)/(ReferenceWidth/ReferenceHeight)

        global ScaleFactorX := ProgramWindowWidth/ReferenceWidth
        global ScaleFactorY := ProgramWindowHeight/ReferenceHeight*AspectRatio2

        global ControlColorX := ReferenceControlColorX*ScaleFactorX
        global ControlColorY := ReferenceControlColorY*ScaleFactorY*AspectRatio2

        global StarButtonX := ReferenceStarButtonX*ScaleFactorX
        global StarButtonY := ReferenceStarButtonY*ScaleFactorY*AspectRatio2

        global MakeButtonX := ReferenceMakeButtonX*ScaleFactorX
        global MakeButtonY := ReferenceMakeButtonY*ScaleFactorY*AspectRatio2

        global ControlColor := PixelGetColor(ControlColorX, ControlColorY)
    }

        TryStarButton
        
        TryMakeButton
        
        ButtonTest.Enabled := true
    }


TestScript(*){
    uiIsClosed  := true
    attempts    := 0

    Hotkey ScriptHotkey, PrimaryScript, "On"

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

    TryStarButton

    TryMakeButton

    

    ButtonConfirm.Enabled   := true
    global ScriptEnabled    := true


}

TryStarButton(*){
    tickStarred := false
    attempts := 0
    
    while (tickStarred = false){
    
            If (PixelGetColor(StarButtonX, StarButtonY-5) = PixelGetColor(StarButtonX, StarButtonY)){
                Click StarButtonX, StarButtonY
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

    Click MakeButtonX, MakeButtonY, ClickCount
    Sleep SleepTimer

}

StartScript(*){
    global ClickCount := 1
    GuideGui.Destroy

}

PrimaryScript(*){  
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

            TryStarButton

            TryMakeButton
        }
    }
}

ExitScript(*){
    ; MsgBox "I'm sorry something went wrong. `nPlease open an issue at the webpage just opened. "
    ; Run "https://github.com/Stefarling/PaliaHotkeys/issues"
    GuideGui.Destroy
    ExitApp 0
}

GuideGui.Show("NoActivate")