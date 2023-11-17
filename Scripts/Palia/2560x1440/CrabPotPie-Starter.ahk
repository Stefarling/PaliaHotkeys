#Requires AutoHotkey v2.0
; 2560x1440 Windowed Fullscreen V1.0.2

/* 
Use this script to start Crab Pot Pie.
This is a UI improvement to mitigate shenanigans.
Press FORWARD MOUSE BUTTON to run the script.
Press SHIFT+F1 to test the script.
*/


; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
XButton2::MainScript      ; Run main script


; Variables
SleepTimer  := 1            ; Milliseconds
ButtonOne   := "666 666"    ; Select recipe
ButtonTwo   := "823 1311"    ; Tick star ingredients
ButtonThree := "1600 1300"   ; Start Button
HotKeyTime      := A_TickCount  ; Miliseconds to deactivate hotkey
ClickCount      := 0
ButtonOneColor  := ""
ButtonTwoColor  := ""
ScriptEnabled   := false


; Settings
CoordMode "Mouse", "Screen" ; Move mouse relative to screen
CoordMode "Pixel", "Screen" ; Check pixels relative to screen


; GUI
GuideGui    := Gui()
GuideGui.Opt("+AlwaysOnTop +ToolWindow -Resize +MinSize150x150")
TutorialStep    := GuideGui.Add("Text", "Section w300", "Step 1")
TutorialText    := GuideGui.Add("Text","Section WP r6","Lockbox either: `nWheat, Sweet leaf, Apples or Spice Sprout`n`nOpen your UI, select your recipe, tick starred ingredients, then click below.")


; GUI - Buttons
ButtonSetup             := GuideGui.Add("Button","XS YS+80 WP","Click me!")
ButtonTest              := GuideGui.Add("Button","XS YS+80 WP","Click me!")
ButtonStart             := GuideGui.Add("Button","XS YS+80 WP","Click me!")
ButtonConfirm           := GuideGui.Add("Button","XS YS+80 50", "Yes")
ButtonAbort             := GuideGui.Add("Button","XP+50 YS+80 50", "No")
ButtonTest.Visible      := false
ButtonStart.Visible     := false
ButtonConfirm.Visible   := false
ButtonAbort.Visible     := false


; GUI - OnEvent
ButtonSetup.OnEvent("Click", PerformSetup)
ButtonTest.OnEvent("Click", PerformTest)
ButtonStart.OnEvent("Click", StartScript)
ButtonConfirm.OnEvent("Click", PrepareScript)
ButtonAbort.OnEvent("Click", KillScript)


; Functions
PerformSetup(*){
    coordsOne   := StrSplit(ButtonOne,' ')
    coordsTwo  := StrSplit(ButtonTwo, ' ')

    ButtonSetup.Visible := false
    
    global ButtonOneColor := PixelGetColor(coordsOne[1], coordsOne[2])
    global ButtonTwoColor := PixelGetColor(coordsTwo[1], coordsTwo[2])
    
    
    TutorialStep.Text   := "Step 2"
    TutorialText.Text   := "Close and reopen your UI, then click below."

    ButtonTest.Visible  := true
}

PerformTest(*){
    ButtonTest.Visible := false

    AttemptButtonOne    

    AttemptButtonTwo

    AttemptButtonThree

    TutorialStep.Text   := "Step 3"
    TutorialText.Text   := "Did I correctly select the recipe,`ntick starred ingredients`nand hover over make?"

    ButtonConfirm.Visible := true
    ButtonAbort.Visible := true


}

PrepareScript(*){

    ButtonConfirm.Visible   := false
    ButtonAbort.Visible     := false

    global ScriptEnabled := true
    TutorialStep.Text   := "Step 4"
    TutorialText.Text   := "You are now ready to run the script!`nClick the button below to hide this prompt.`nYou can also practice your hotkey,`nas the Make click is disabled while this prompt is open.`nGood luck and have fun!`n-Stef"

    ButtonStart.Visible  := true


}

MainScript() {
    if((A_TickCount - HotKeyTime) > 250){
        global HotKeyTime := A_TickCount    

        if(ScriptEnabled){

        AttemptButtonOne

        AttemptButtonTwo

        AttemptButtonThree
        }
    }

}

AttemptButtonOne(*){
    buttonCoords   := StrSplit(ButtonOne,' ')
    recipeFound := false
    attempts := 0

    while (recipeFound = false){
        Sleep SleepTimer
        Click ButtonOne

        If (PixelGetColor(buttonCoords[1], buttonCoords[2]) = ButtonOneColor){
            recipeFound := true
        }

        if (attempts > 9){
            MsgBox "Couldn't find the recipe button. Terminating script."  
            KillScript         
        }else{
            attempts++
        }
    }

}

AttemptButtonTwo(*){
    buttonCoords  := StrSplit(ButtonTwo, ' ')
    tickStarred := false
    attempts := 0
    
    while (tickStarred = false){
    
            If (PixelGetColor(buttonCoords[1], buttonCoords[2]) = ButtonTwoColor){
                tickStarred := true
            }else{
                Click ButtonTwo
                Sleep SleepTimer 
            }
    
            if (attempts > 9){
                MsgBox "Couldn't find the star button. Terminating script."  
                KillScript         
            }else{
                attempts++
            }
        }
    
}

AttemptButtonThree(*){

    Sleep SleepTimer
    Click ButtonThree  "," ClickCount

}

KillScript(*){
    MsgBox "I'm sorry something went wrong. `nPlease open an issue at https://github.com/Stefarling/PaliaHotkeys/issues "
    Run "https://github.com/Stefarling/PaliaHotkeys/issues"
    GuideGui.Destroy
    ExitApp 0
}

StartScript(*){
    global ClickCount := 1
    GuideGui.Destroy
}

GuideGui.Show("NoActivate")