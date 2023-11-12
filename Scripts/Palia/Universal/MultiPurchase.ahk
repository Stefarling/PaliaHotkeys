#Requires AutoHotkey v2.0
; Universal

/* 
Perform multi purchases at stores with this script. 
Click the purchase button to purchae once.
Shift+Click the purchase button to purchase 50 times.
CTRL+Click the purchase button to purchase 10 times.
*/

; Hotkeys
; https://www.autohotkey.com/docs/v2/KeyList.htm
+LButton::Click 50 ; Clicks 50 times
^LButton::Click 10 ; Clicks 10 times
