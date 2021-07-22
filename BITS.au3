; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include-once

#include "BITSConstants.au3"
#include <WinAPIDiag.au3>

; #INDEX# =======================================================================================================================
; Title .........: BITS (Background Intelligent Transfer Service)
; Version .......: 1.0.0-alpha
; AutoIt Version : 3.3.14.5
; Language ......: English
; Author(s) .....: Domenic Laritz
; Modifiers .....:
; Description ...: Download or upload files using Background Intelligent Transfer Service.
; Links .........: https://docs.microsoft.com/en-us/windows/win32/bits/background-intelligent-transfer-service-portal
; Dll ...........:
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $__BITSCONSTANT_sIID_IBackgroundCopyJob = "{37668D37-507E-4160-9316-26306D150B12}"
Global Const $__BITSCONSTANT_sIID_IBackgroundCopyManager = "{5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C}"
Global Const $__BITSCONSTANT_sTagIBackgroundCopyJob = _
		"AddFileSet hresult(ulong;struct*);" & _
		"AddFile hresult(wstr;wstr);" & _
		"EnumFiles hresult(ptr*);" & _ ; to-do
		"Suspend hresult();" & _
		"Resume hresult();" & _
		"Cancel hresult();" & _
		"Complete hresult();" & _
		"GetId hresult(clsid*);" & _
		"GetType hresult(int_ptr*);" & _
		"GetProgress hresult(struct*);" & _
		"GetTimes hresult(struct*);" & _ ; to-do
		"GetState hresult(int_ptr*);" & _
		"GetError hresult(ptr*);" & _ ; to-do
		"GetOwner hresult(wstr*);" & _
		"SetDisplayName hresult(wstr);" & _
		"GetDisplayName hresult(wstr*);" & _
		"SetDescription hresult(wstr);" & _
		"GetDescription hresult(wstr*);" & _
		"SetPriority hresult(int);" & _
		"GetPriority hresult(int_ptr*);" & _
		"SetNotifyFlags hresult(ulong);" & _
		"GetNotifyFlags hresult(ulong_ptr*);" & _
		"SetNotifyInterface hresult(ptr);" & _ ; to-do
		"GetNotifyInterface hresult(ptr*);" & _ ; to-do
		"SetMinimumRetryDelay hresult(ulong);" & _
		"GetMinimumRetryDelay hresult(ulong_ptr*);" & _
		"SetNoProgressTimeout hresult(ulong);" & _
		"GetNoProgressTimeout hresult(ulong_ptr*);" & _
		"GetErrorCount hresult(ulong_ptr*);" & _
		"SetProxySettings hresult(int;str*;str*);" & _
		"GetProxySettings hresult(int_ptr*;wstr*;wstr*);" & _
		"TakeOwnership hresult();"

Global Const $__BITSCONSTANT_sTagIBackgroundCopyManager = _
		"CreateJob hresult(wstr;int;clsid*;ptr*);" & _
		"GetJob hresult(clsid;ptr*);" & _
		"EnumJobs hresult(dword;ptr*);" & _ ; to-do
		"GetErrorDescription hresult(hresult;dword;wstr*);" ; to-do
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;$tagBG_FILE_INFO
;$tagBG_JOB_PROGRESS
;_BITS_BackgroundCopyJob_AddFile
;_BITS_BackgroundCopyJob_AddFileSet
;_BITS_BackgroundCopyJob_Cancel
;_BITS_BackgroundCopyJob_Complete
;_BITS_BackgroundCopyJob_GetDescription
;_BITS_BackgroundCopyJob_GetDisplayName
;_BITS_BackgroundCopyJob_GetErrorCount
;_BITS_BackgroundCopyJob_GetId
;_BITS_BackgroundCopyJob_GetMinimumRetryDelay
;_BITS_BackgroundCopyJob_GetNoProgressTimeout
;_BITS_BackgroundCopyJob_GetNotifyFlags
;_BITS_BackgroundCopyJob_GetOwner
;_BITS_BackgroundCopyJob_GetPriority
;_BITS_BackgroundCopyJob_GetProgress
;_BITS_BackgroundCopyJob_GetProxySettings
;_BITS_BackgroundCopyJob_GetState
;_BITS_BackgroundCopyJob_GetType
;_BITS_BackgroundCopyJob_Resume
;_BITS_BackgroundCopyJob_SetDescription
;_BITS_BackgroundCopyJob_SetDisplayName
;_BITS_BackgroundCopyJob_SetMinimumRetryDelay
;_BITS_BackgroundCopyJob_SetNoProgressTimeout
;_BITS_BackgroundCopyJob_SetNotifyFlags
;_BITS_BackgroundCopyJob_SetPriority
;_BITS_BackgroundCopyJob_SetProxySettings
;_BITS_BackgroundCopyJob_Suspend
;_BITS_BackgroundCopyJob_TakeOwnership
;_BITS_BackgroundCopyManager_CreateJob
;_BITS_BackgroundCopyManager_GetJob
;_BITS_Connect
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ===============================================================================================================================

; BG_FILE_INFO structure (https://docs.microsoft.com/en-us/windows/win32/api/bits/ns-bits-bg_file_info)
Global Const $tagBG_FILE_INFO = "struct;wchar remoteName[2201];wchar localName[261];endstruct"
; BG_JOB_PROGRESS structure (https://docs.microsoft.com/en-us/windows/win32/api/bits/ns-bits-bg_job_progress)
Global Const $tagBG_JOB_PROGRESS = "struct;uint64 BytesTotal;uint64 BytesTransferred;ulong FilesTotal;ulong FilesTransferred;endstruct"

Func _BITS_BackgroundCopyJob_AddFile(Const ByRef $oBackgroundCopyJob, Const ByRef $sRemoteUrl, Const ByRef $sLocalName)
	$oBackgroundCopyJob.AddFile($sRemoteUrl, $sLocalName)
EndFunc   ;==>_BITS_BackgroundCopyJob_AddFile

Func _BITS_BackgroundCopyJob_AddFileSet(Const ByRef $oBackgroundCopyJob, Const ByRef $aFileSet)
	Local $sStructDef
	Local $tStruct
	Local $pStruct

	For $i = 0 To UBound($aFileSet) - 1
		$sStructDef &= "char r" & $i + 1 & "[" & StringLen($aFileSet[$i][0]) + 1 & "];char l" & $i + 1 & "[" & StringLen($aFileSet[$i][1]) + 1 & "];"
	Next

	ConsoleWrite($sStructDef & @CRLF)

	$tStruct = DllStructCreate($sStructDef)
	For $i = 0 To UBound($aFileSet) - 1
		DllStructSetData($tStruct, "r" & $i + 1, $aFileSet[$i][0])
		DllStructSetData($tStruct, "l" & $i + 1, $aFileSet[$i][1])
	Next

	_WinAPI_DisplayStruct($tStruct, $sStructDef)

	$pStruct = DllStructGetPtr($tStruct)

	$oBackgroundCopyJob.AddFileSet(UBound($aFileSet), $pStruct)
EndFunc   ;==>_BITS_BackgroundCopyJob_AddFileSet

Func _BITS_BackgroundCopyJob_Cancel(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.Cancel()
EndFunc   ;==>_BITS_BackgroundCopyJob_Cancel

Func _BITS_BackgroundCopyJob_Complete(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.Complete()
EndFunc   ;==>_BITS_BackgroundCopyJob_Complete

Func _BITS_BackgroundCopyJob_GetDescription(Const ByRef $oBackgroundCopyJob)
	Local $sVal = ""

	$oBackgroundCopyJob.GetDescription($sVal)

	Return $sVal
EndFunc   ;==>_BITS_BackgroundCopyJob_GetDescription

Func _BITS_BackgroundCopyJob_GetDisplayName(Const ByRef $oBackgroundCopyJob)
	Local $sDisplayName = ""

	$oBackgroundCopyJob.GetDisplayName($sDisplayName)

	Return $sDisplayName
EndFunc   ;==>_BITS_BackgroundCopyJob_GetDisplayName

Func _BITS_BackgroundCopyJob_GetErrorCount(Const ByRef $oBackgroundCopyJob)
	Local $iErrors = 0

	$oBackgroundCopyJob.GetErrorCount($iErrors)

	Return $iErrors
EndFunc   ;==>_BITS_BackgroundCopyJob_GetErrorCount

Func _BITS_BackgroundCopyJob_GetId(Const ByRef $oBackgroundCopyJob)
	Local $sId = ""

	$oBackgroundCopyJob.GetId($sId)

	Return $sId
EndFunc   ;==>_BITS_BackgroundCopyJob_GetId

Func _BITS_BackgroundCopyJob_GetMinimumRetryDelay(Const ByRef $oBackgroundCopyJob)
	Local $iSeconds = 0

	$oBackgroundCopyJob.GetMinimumRetryDelay($iSeconds)

	Return $iSeconds
EndFunc   ;==>_BITS_BackgroundCopyJob_GetMinimumRetryDelay

Func _BITS_BackgroundCopyJob_GetNoProgressTimeout(Const ByRef $oBackgroundCopyJob)
	Local $iSeconds = 0

	$oBackgroundCopyJob.GetNoProgressTimeout($iSeconds)

	Return $iSeconds
EndFunc   ;==>_BITS_BackgroundCopyJob_GetNoProgressTimeout

Func _BITS_BackgroundCopyJob_GetNotifyFlags(Const ByRef $oBackgroundCopyJob)
	Local $iVal = 0

	$oBackgroundCopyJob.GetNotifyFlags($iVal)

	Return $iVal
EndFunc   ;==>_BITS_BackgroundCopyJob_GetNotifyFlags

Func _BITS_BackgroundCopyJob_GetOwner(Const ByRef $oBackgroundCopyJob)
	Local $sVal = 0

	$oBackgroundCopyJob.GetOwner($sVal)

	Return $sVal
EndFunc   ;==>_BITS_BackgroundCopyJob_GetOwner

Func _BITS_BackgroundCopyJob_GetPriority(Const ByRef $oBackgroundCopyJob)
	Local $iVal = 0

	$oBackgroundCopyJob.GetPriority($iVal)

	Return $iVal
EndFunc   ;==>_BITS_BackgroundCopyJob_GetPriority

Func _BITS_BackgroundCopyJob_GetProgress(Const ByRef $oBackgroundCopyJob)
	Local $tBG_JOB_PROGRESS = 0
	Local $aProgress[4]

	$tBG_JOB_PROGRESS = DllStructCreate($tagBG_JOB_PROGRESS)
	$oBackgroundCopyJob.GetProgress($tBG_JOB_PROGRESS)
	$aProgress[0] = DllStructGetData($tBG_JOB_PROGRESS, "BytesTotal")
	$aProgress[1] = DllStructGetData($tBG_JOB_PROGRESS, "BytesTransferred")
	$aProgress[2] = DllStructGetData($tBG_JOB_PROGRESS, "FilesTotal")
	$aProgress[3] = DllStructGetData($tBG_JOB_PROGRESS, "FilesTransferred")
	$tBG_JOB_PROGRESS = 0

	Return $aProgress
EndFunc   ;==>_BITS_BackgroundCopyJob_GetProgress

Func _BITS_BackgroundCopyJob_GetProxySettings(Const ByRef $oBackgroundCopyJob)
	Local $iProxyUsage = 0
	Local $sProxyList = ""
	Local $sProxyBypassList = ""
	Local $aProxySettings[3]

	$oBackgroundCopyJob.GetProxySettings($iProxyUsage, $sProxyList, $sProxyBypassList)
	$aProxySettings[0] = $iProxyUsage
	$aProxySettings[1] = $sProxyList
	$aProxySettings[2] = $sProxyBypassList

	Return $aProxySettings
EndFunc   ;==>_BITS_BackgroundCopyJob_GetProxySettings

Func _BITS_BackgroundCopyJob_GetState(Const ByRef $oBackgroundCopyJob)
	Local $iVal = 0

	$oBackgroundCopyJob.GetState($iVal)

	Return $iVal
EndFunc   ;==>_BITS_BackgroundCopyJob_GetState

Func _BITS_BackgroundCopyJob_GetType(Const ByRef $oBackgroundCopyJob)
	Local $iVal = 0

	$oBackgroundCopyJob.GetType($iVal)

	Return $iVal
EndFunc   ;==>_BITS_BackgroundCopyJob_GetType

Func _BITS_BackgroundCopyJob_Resume(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.Resume()
EndFunc   ;==>_BITS_BackgroundCopyJob_Resume

Func _BITS_BackgroundCopyJob_SetDescription(Const ByRef $oBackgroundCopyJob, Const ByRef $sVal)
	$oBackgroundCopyJob.SetDescription($sVal)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetDescription

Func _BITS_BackgroundCopyJob_SetDisplayName(Const ByRef $oBackgroundCopyJob, Const ByRef $sVal)
	$oBackgroundCopyJob.SetDisplayName($sVal)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetDisplayName

Func _BITS_BackgroundCopyJob_SetMinimumRetryDelay(Const ByRef $oBackgroundCopyJob, Const ByRef $iSeconds)
	$oBackgroundCopyJob.SetMinimumRetryDelay($iSeconds)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetMinimumRetryDelay

Func _BITS_BackgroundCopyJob_SetNoProgressTimeout(Const ByRef $oBackgroundCopyJob, Const ByRef $iSeconds)
	$oBackgroundCopyJob.SetNoProgressTimeout($iSeconds)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetNoProgressTimeout

Func _BITS_BackgroundCopyJob_SetNotifyFlags(Const ByRef $oBackgroundCopyJob, Const $iVal)
	$oBackgroundCopyJob.SetNotifyFlags($iVal)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetNotifyFlags

Func _BITS_BackgroundCopyJob_SetPriority(Const ByRef $oBackgroundCopyJob, Const ByRef $iVal)
	$oBackgroundCopyJob.SetPriority($iVal)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetPriority

Func _BITS_BackgroundCopyJob_SetProxySettings(Const ByRef $oBackgroundCopyJob, Const ByRef $iProxyUsage, Const ByRef $sProxyList, Const ByRef $sProxyBypassList)
	$oBackgroundCopyJob.SetProxySettings($iProxyUsage, $sProxyList, $sProxyBypassList)
EndFunc   ;==>_BITS_BackgroundCopyJob_SetProxySettings

Func _BITS_BackgroundCopyJob_Suspend(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.Suspend()
EndFunc   ;==>_BITS_BackgroundCopyJob_Suspend

Func _BITS_BackgroundCopyJob_TakeOwnership(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.TakeOwnership()
EndFunc   ;==>_BITS_BackgroundCopyJob_TakeOwnership

Func _BITS_BackgroundCopyManager_CreateJob(Const ByRef $oBackgroundCopyManager, Const ByRef $sDisplayName, Const ByRef $iType)
	Local $sJobId = ""
	Local $pJob = 0
	Local $oBackgroundCopyJob = 0

	$oBackgroundCopyManager.CreateJob($sDisplayName, $iType, $sJobId, $pJob)
	$oBackgroundCopyJob = ObjCreateInterface($pJob, $__BITSCONSTANT_sIID_IBackgroundCopyJob, $__BITSCONSTANT_sTagIBackgroundCopyJob)

	Return $oBackgroundCopyJob
EndFunc   ;==>_BITS_BackgroundCopyManager_CreateJob

Func _BITS_BackgroundCopyManager_GetJob(Const ByRef $oBackgroundCopyManager, Const ByRef $sJobId)
	Local $pJob = 0
	Local $oBackgroundCopyJob = 0

	$oBackgroundCopyManager.GetJob($sJobId, $pJob)
	$oBackgroundCopyJob = ObjCreateInterface($pJob, $__BITSCONSTANT_sIID_IBackgroundCopyJob, $__BITSCONSTANT_sTagIBackgroundCopyJob)

	Return $oBackgroundCopyJob
EndFunc   ;==>_BITS_BackgroundCopyManager_GetJob

Func _BITS_Connect()
	Local $asBackgroundCopyManager_CLSIDs[] = [ _
			"{5FD42AD5-C04E-4D36-ADC7-E08FF15737AD}", _ ; BITS 10.3
			"{4575438F-A6C8-4976-B0FE-2F26B80D959E}", _ ; BITS 10.2
			"{4BD3E4E1-7BD4-4A2B-9964-496400DE5193}", _ ; BITS 10.1
			"{4D233817-B456-4E75-83D2-B17DEC544D12}", _ ; BITS 10.0
			"{1ECCA34C-E88A-44E3-8D6A-8921BDE9E452}", _ ; BITS 5.0
			"{BB6DF56B-CACE-11DC-9992-0019B93A3A84}", _ ; BITS 4.0
			"{659CDEA7-489E-11D9-A9CD-000D56965251}", _ ; BITS 3.0
			"{03CA98D6-FF5D-49B8-ABC6-03DD84127020}", _ ; BITS 2.5
			"{6D18AD12-BDE3-4393-B311-099C346E6DF9}", _ ; BITS 2.0
			"{F087771F-D74F-4C1A-BB8A-E16ACA9124EA}", _ ; BITS 1.5
			"{4991D34B-80A1-4291-83B6-3328366B9097}" _ ; BITS 1.0
			]
	Local $oBackgroundCopyManager = 0

	For $sBackgroundCopyManager_CLSID In $asBackgroundCopyManager_CLSIDs
		$oBackgroundCopyManager = ObjCreateInterface($sBackgroundCopyManager_CLSID, $__BITSCONSTANT_sIID_IBackgroundCopyManager, $__BITSCONSTANT_sTagIBackgroundCopyManager)
		If Not @error Then ExitLoop
	Next

	Return $oBackgroundCopyManager
EndFunc   ;==>_BITS_Connect
