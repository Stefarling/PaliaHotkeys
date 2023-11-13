#Requires AutoHotkey v2.0
; Version 1.0
; It is what it is
; Stef is not responsible for your tinkering!


; HotKeys
F1::ActivateStart()
F2::ActivateExport()
F3::ActivateLap()
F5::ToggleOSD()

; Variables
ProgramName := "StopWatch by Stef"
Running := false
StartTime := 0
StopTime := 0
LapNumber := 0
LapTime := 0
CurrentLapTime := 0
CurrentTotalTime := 0
TotalTime := 0
Locked := false

; Settings
Persistent

; Gui
MainGui             := Gui(, ProgramName)
MainGui.BackColor := "FFFFFF"
MainGui.SetFont("s10 Bold", "Courier New")
MainGui.Opt("+AlwaysOnTop")
StartButton         := MainGui.Add("Button", "Section w60 r2", "Start`nF1")
ExportButton        := MainGui.Add("Button", "YP w60 r2", "Export`nF2")
LapButton           := MainGui.Add("Button", "YP w60 r2", "Lap`nF3")
LockButton          := MainGui.Add("Button","YP w60 r2", "Lock`nF5")
LapTimeButton       := MainGui.Add("Button","vLapTime Section XS Y+m r1","00:00:00.000")
TotalTimeButton     := MainGui.Add("Button","vTotalTime Section","00:00:00.000")

LapView             := MainGui.Add("ListView", "Section w290 Count 200 NoSortHdr -LV0x10 -ReadOnly -WantF2", ["#", "Lap Time", "Total Time"])
LapView.ModifyCol
LapView.ModifyCol(1, "Integer Center AutoHdr")
LapView.ModifyCol(2, "Integer Center 110 ")
LapView.ModifyCol(3, "Integer Center 110 ")

; Button Events
StartButton.OnEvent("Click", (*) => ActivateStart())
LapButton.OnEvent("Click", (*) => ActivateLap())
ExportButton.OnEvent("Click", (*) => ActivateExport())

ToggleOSD(){
    programStyle := "+0x80"
    transparencyLevel := 225
    
    if(Locked){
        LapView.Opt("+Hdr +LV0x1000 +E0x200")
        MainGui.Opt("+Caption")

        WinSetTransparent "Off", ProgramName
        StartButton.Visible := true
        ExportButton.Visible := true
        LapButton.Visible := true
        LockButton.Visible := true
        LapView.Opt("BackgroundWhite")
        LapView.SetFont("s10 Bold")
        LapTimeButton.SetFont("s10 Bold")
        TotalTimeButton.SetFont("s10 Bold")

        global Locked := false

    }else{
        WinSetTransparent transparencyLevel, ProgramName

        WinSetTransColor(MainGui.BackColor " " transparencyLevel, MainGui)
        
        MainGui.Opt("-Caption")

        StartButton.Visible := false
        ExportButton.Visible := false
        LapButton.Visible := false
        LockButton.Visible := false
        LapView.Opt("BackgroundSilver")
        LapView.SetFont("s14 Bold")
        LapTimeButton.SetFont("s11 Bold")
        TotalTimeButton.SetFont("s11 Bold")

        LapView.Opt("-Hdr -LV0x1000 -E0x200")


        global Locked := true
    }
    



    WinSetStyle programStyle, ProgramName
    WinSetEnabled -1, ProgramName


}

ActivateStart() {
    if (Running){
        EndLap()
        StopTimers()
        AddLapToLapView()        
        StartButton.Text    := "Start`nF1"
        global Running              := false 
    }else{
        StartTimers()
        
        StartButton.Text    := "Stop`nF1"
        global Running := true
    }
}

ActivateLap(){
    if(Running){
    EndLap()
    AddLapToLapView()
    }
    StartTimers()

}

ActivateExport(){
    OutputString := ""

    OutputString .= "# Lap Total"

    Loop LapView.GetCount(){
        OutputString .= "`n" LapView.GetText(A_Index, 1) " " LapView.GetText(A_Index, 2) " " LapView.GetText(A_Index, 3)
    }


    OutputString .= "`n`n"

    CurrentTime := FormatTime() ".csv"
    FileName := A_ScriptDir "\" CurrentTime
    FileAppend OutputString, FileName

}

StartTimers(){
    global StartTime := A_TickCount
}

StopTimers(){
    global StopTime := A_TickCount
}

AddLapToLapView(){
    LapView.Insert(1,, LapNumber, TimeToString(CurrentLapTime), TimeToString(CurrentTotalTime))
}

EndLap(){    
    global LapNumber := LapNumber + 1
    global CurrentTotalTime += CurrentLapTime
}

TimeToString(time){

    ; Calculate hours, minutes, seconds, and milliseconds
    Hours := Floor(time / 3600000)
    Minutes := Floor(Mod(time, 3600000) / 60000)
    Seconds := Floor(Mod(time, 60000) / 1000)
    Milliseconds := Mod(time, 1000)

    ; Construct the time string based on the non-zero components
    if (Hours > 0)
        timeString := Format("{:02}:{:02}:{:02}.{:03}", Hours, Minutes, Seconds, Milliseconds)
    else if (Minutes > 0)
        timeString := Format("{:02}:{:02}.{:03}", Minutes, Seconds, Milliseconds)
    else
        timeString := Format("{:02}.{:03}", Seconds, Milliseconds)

    return timeString

}

SetTimer(UpdateGui, 1)
UpdateGui()
MainGui.Show("NoActivate")


UpdateGui() {
    if (Running){
        global CurrentLapTime := A_TickCount - StartTime


        LapTimeButton.Text      := TimeToString(CurrentLapTime)
        TotalTimeButton.Text    := TimeToString(CurrentTotalTime + CurrentLapTime)
        
    }
}