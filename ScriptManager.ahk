#Requires AutoHotkey v2.0

; This is NOT functional yet

; Root folder for ScriptManager scripts
TreeRoot := A_ScriptDir "\Scripts"
TreeViewWidth := 280
ListViewWidth := A_ScreenWidth/2 - TreeViewWidth - 30

; Create the MyGui window and display the source directory (TreeRoot) in the title bar:
MyGui := Gui("+Resize", TreeRoot)  ; Allow the user to maximize or drag-resize the window.

; Create an ImageList and put some standard system icons into it:
ImageListID := IL_Create(5)
Loop 5 
    IL_Add(ImageListID, "shell32.dll", A_Index)
; Create a TreeView and a ListView side-by-side to behave like Windows Explorer:
TV := MyGui.Add("TreeView", "r20 w" TreeViewWidth " ImageList" ImageListID)
LV := MyGui.Add("ListView", "r20 w" ListViewWidth " x+10", ["Name","Modified"])

; Create a Status Bar to give info about the number of files and their total size:
SB := MyGui.Add("StatusBar")
SB.SetParts(60, 85)  ; Create three parts in the bar (the third part fills all the remaining width).

; Add folders and their subfolders to the tree. Display the status in case loading takes a long time:
M := Gui("ToolWindow -SysMenu Disabled AlwaysOnTop", "Loading the tree..."), M.Show("w200 h0")
DirList := AddSubFoldersToTree(TreeRoot, Map())
M.Hide()

; Call TV_ItemSelect whenever a new item is selected:
TV.OnEvent("ItemSelect", TV_ItemSelect)

; Call Gui_Size whenever the window is resized:
MyGui.OnEvent("Size", Gui_Size)

; Set the ListView's column widths (this is optional):
Col2Width := 70  ; Narrow to reveal only the YYYYMMDD part.
LV.ModifyCol(1, ListViewWidth - Col2Width - 30)  ; Allows room for vertical scrollbar.
LV.ModifyCol(2, Col2Width)

; Display the window. The OS will notify the script whenever the user performs an eligible action:
MyGui.Show

AddSubFoldersToTree(Folder, DirList, ParentItemID := 0)
{
    ; This function adds to the TreeView all subfolders in the specified folder
    ; and saves their paths associated with an ID into an object for later use.
    ; It also calls itself recursively to gather nested folders to any depth.
    Loop Files, Folder "\*.*", "D"  ; Retrieve all of Folder's sub-folders.
    {
        ItemID := TV.Add(A_LoopFileName, ParentItemID, "Icon4")
        DirList[ItemID] := A_LoopFilePath
        DirList := AddSubFoldersToTree(A_LoopFilePath, DirList, ItemID)
    }
    return DirList
}

TV_ItemSelect(thisCtrl, Item)  ; This function is called when a new item is selected.
{
    ; Put the files into the ListView:
    LV.Delete  ; Clear all rows.
    LV.Opt("-Redraw")  ; Improve performance by disabling redrawing during load.
    TotalSize := 0  ; Init prior to loop below.
    Loop Files, DirList[Item] "\*.*"  ; For simplicity, omit folders so that only files are shown in the ListView.
    {
        LV.Add(, A_LoopFileName, A_LoopFileTimeModified)
        TotalSize += A_LoopFileSize
    }
    LV.Opt("+Redraw")

    ; Update the three parts of the status bar to show info about the currently selected folder:
    SB.SetText(LV.GetCount() " files", 1)
    SB.SetText(Round(TotalSize / 1024, 1) " KB", 2)
    SB.SetText(DirList[Item], 3)
}

Gui_Size(thisGui, MinMax, Width, Height)  ; Expand/Shrink ListView and TreeView in response to the user's resizing.
{
    if MinMax = -1  ; The window has been minimized.  No action needed.
        return
    ; Otherwise, the window has been resized or maximized. Resize the controls to match.
    TV.GetPos(,, &TV_W)
    TV.Move(,,, Height - 30)  ; -30 for StatusBar and margins.
    LV.Move(,, Width - TV_W - 30, Height - 30)
}