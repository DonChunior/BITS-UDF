; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=Y
;~ #AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include-once

#include "BITSConstants.au3"

; Background Intelligent Transfer Control Class 10.3
Local Const $sCLSID_BackgroundCopyManager = "{5FD42AD5-C04E-4D36-ADC7-E08FF15737AD}"
Local Const $sIID_IBackgroundCopyManager = "{5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C}"
Local Const $sTagIBackgroundCopyManager = "CreateJob hresult(wstr;int;clsid*;ptr*);" & _
		"EnumJobs hresult(dword;ptr*);" & _
		"GetErrorDescription hresult(hresult;dword;wstr*);" & _
		"GetJob hresult(clsid;ptr*);"

Local Const $sIID_IBackgroundCopyJob = "{37668D37-507E-4160-9316-26306D150B12}"
Local Const $sTagIBackgroundCopyJob = "AddFile hresult(wstr;wstr);" & _
		"AddFileSet hresult(ulong;struct*);" & _
		"Cancel hresult();" & _
		"Complete hresult();" & _
		"EnumFiles hresult(ptr*);" & _
		"GetDescription hresult(wstr*);" & _
		"GetDisplayName hresult(wstr*);" & _
		"GetError hresult(ptr*);" & _
		"GetErrorCount hresult(ulong_ptr*);" & _
		"GetId hresult(clsid*);" & _
		"GetMinimumRetryDelay hresult(ulong_ptr*);" & _
		"GetNoProgressTimeout hresult(ulong_ptr*);" & _
		"GetNotifyFlags hresult(ulong_ptr*);" & _
		"GetNotifyInterface hresult(ptr*);" & _
		"GetOwner hresult(wstr*);" & _
		"GetPriority hresult(int*);" & _
		"GetProgress hresult(struct*);" & _
		"GetProxySettings hresult(int*;wstr*;wstr*);" & _
		"GetState hresult(int*);" & _
		"GetTimes hresult(struct*);" & _
		"GetType hresult(int*);" & _
		"Resume hresult();" & _
		"SetDescription hresult(wstr);" & _
		"SetDisplayName hresult(wstr);" & _
		"SetMinimumRetryDelay hresult(ulong);" & _
		"SetNoProgressTimeout hresult(ulong);" & _
		"SetNotifyFlags hresult(ulong);" & _
		"SetNotifyInterface hresult(ptr);" & _
		"SetPriority hresult(int);" & _
		"SetProxySettings hresult(int;str*;str*);" & _
		"Suspend hresult();" & _
		"TakeOwnership hresult();"

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

Local $oBackgroundCopyJob = ObjCreateInterface($pJob, $sIID_IBackgroundCopyJob, $sTagIBackgroundCopyJob)
If @error Then
	ConsoleWrite("@error = " & @error & @CRLF)
	Exit
EndIf
ConsoleWrite(VarGetType($oBackgroundCopyJob) & @CRLF)
Local $pJob2 = 0
Local $iHresult = $oBackgroundCopyManager.GetJob($sJobId, $pJob2)
ConsoleWrite("HRESULT = " & Hex($iHresult) & @CRLF)
