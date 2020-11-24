; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=Y
;~ #AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include-once

#include "BITSConstants.au3"

; Background Intelligent Transfer Control Class 10.3
Local Const $sCLSID_BackgroundCopyManager = "{5FD42AD5-C04E-4D36-ADC7-E08FF15737AD}"
Local Const $sIID_IBackgroundCopyManager = "{5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C}"
Local Const $sTagIBackgroundCopyManager = "CreateJob hresult(wstr;int;clsid*;object*); EnumJobs hresult(dword;ptr*); GetErrorDescription hresult(hresult;dword;wstr*); GetJob hresult(clsid;ptr*)"

Local $oBackgroundCopyManager = ObjCreateInterface($sCLSID_BackgroundCopyManager, $sIID_IBackgroundCopyManager, $sTagIBackgroundCopyManager)
If @error Then
	ConsoleWrite("@error = " & @error & @CRLF)
	Exit
EndIf
ConsoleWrite(IsObj($oBackgroundCopyManager) & @CRLF)

Local $sJobId = ""
Local $pJob = 0
$oBackgroundCopyManager.CreateJob("DonChuniorTestJob", $__BITSCONSTANT_BG_JOB_TYPE_DOWNLOAD, $sJobId, $pJob)
ConsoleWrite(VarGetType($sJobId) & @CRLF)
ConsoleWrite(VarGetType($pJob) & @CRLF)
ConsoleWrite(IsObj($pJob) & @CRLF)

$pJob.AddFile("file:///S:\Programme\PTC\Creo Parametric 7.0.2.0\MED-100WIN-CD-440_7-0-2-0_HelpCenter.zip", "C:\Temp\MED-100WIN-CD-440_7-0-2-0_HelpCenter.zip")