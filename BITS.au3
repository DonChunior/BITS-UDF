; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include-once

#include <MsgBoxConstants.au3>

Local Const $sCLSID_BackgroundCopyManager = "{5FD42AD5-C04E-4D36-ADC7-E08FF15737AD}"
Local Const $sIID_IBackgroundCopyManager = "{5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C}"
Local Const $sTagIBackgroundCopyManager = "CreateJob hresult(wstr;); EnumJobs hresult(hwnd); DeleteTab hresult(hwnd); ActivateTab hresult(hwnd); SetActiveAlt hresult(hwnd);"

; Create the object.
Local $oTaskbarList = ObjCreateInterface($sCLSID_TaskbarList, $sIID_ITaskbarList, $sTagITaskbarList)

; Initialize the iTaskbarList object.
$oTaskbarList.HrInit()

; Run Notepad.
Run("notepad.exe")

; Wait for the Notepad window to appear and get a handle to it.
Local $hNotepad = WinWait("[CLASS:Notepad]")

; Tell the user what to look for.
MsgBox($MB_SYSTEMMODAL, "", "Look in the Taskbar and you should see an entry for Notepad." & @CRLF & @CRLF & "Press OK to continue.")

; Delete the Notepad entry from the Taskbar.
$oTaskbarList.DeleteTab($hNotepad)

; Tell the user to look again.
MsgBox($MB_SYSTEMMODAL, "", "Look in the Taskbar.  There should no longer be a Notepad entry but Notepad is still running." & @CRLF & @CRLF & "Press OK to continue.")

; Close Notepad.
WinClose($hNotepad)
