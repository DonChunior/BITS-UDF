; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include-once

#include "BITSConstants.au3"
#include <StructureConstants.au3>
#include <Date.au3>

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
Global Const $__BITSCONSTANT_sIID_IBackgroundCopyError = "{19C613A0-FCB8-4F28-81AE-897C3D078F81}"
Global Const $__BITSCONSTANT_sIID_IBackgroundCopyFile = "{01B7BD23-FB88-4A77-8490-5891D3E4653A}"
Global Const $__BITSCONSTANT_sIID_IBackgroundCopyJob = "{37668D37-507E-4160-9316-26306D150B12}"
Global Const $__BITSCONSTANT_sIID_IBackgroundCopyManager = "{5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C}"
Global Const $__BITSCONSTANT_sIID_IEnumBackgroundCopyFiles = "{CA51E165-C365-424C-8D41-24AAA4FF3C40}"
Global Const $__BITSCONSTANT_sIID_IEnumBackgroundCopyJobs = "{1AF4F612-3B71-466F-8F58-7B6F73AC57AD}"
Global Const $__BITSCONSTANT_sTagIBackgroundCopyError = _
		"GetError hresult(int_ptr*;hresult*);" & _
		"GetFile hresult(ptr*);" & _
		"GetErrorDescription hresult(dword;wstr*);" & _
		"GetErrorContextDescription hresult(dword;wstr*);" & _
		"GetProtocol hresult(wstr*);"
Global Const $__BITSCONSTANT_sTagIBackgroundCopyFile = _
		"GetRemoteName hresult(wstr*);" & _
		"GetLocalName hresult(wstr*);" & _
		"GetProgress hresult(struct*);"
Global Const $__BITSCONSTANT_sTagIBackgroundCopyJob = _
		"AddFileSet hresult(ulong;struct*);" & _
		"AddFile hresult(wstr;wstr);" & _
		"EnumFiles hresult(ptr*);" & _
		"Suspend hresult();" & _
		"Resume hresult();" & _
		"Cancel hresult();" & _
		"Complete hresult();" & _
		"GetId hresult(clsid*);" & _
		"GetType hresult(int_ptr*);" & _
		"GetProgress hresult(struct*);" & _
		"GetTimes hresult(struct*);" & _
		"GetState hresult(int_ptr*);" & _
		"GetError hresult(ptr*);" & _
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
		"SetProxySettings hresult(int;struct*;struct*);" & _
		"GetProxySettings hresult(int_ptr*;wstr*;wstr*);" & _
		"TakeOwnership hresult();"
Global Const $__BITSCONSTANT_sTagIBackgroundCopyManager = _
		"CreateJob hresult(wstr;int;clsid*;ptr*);" & _
		"GetJob hresult(clsid;ptr*);" & _
		"EnumJobs hresult(dword;ptr*);" & _
		"GetErrorDescription hresult(hresult;dword;wstr*);"
Global Const $__BITSCONSTANT_sTagIEnumBackgroundCopyFiles = _
		"Next hresult(ulong;ptr*;ulong_ptr*);" & _ ; to-do
		"Skip hresult(ulong);" & _
		"Reset hresult();" & _
		"Clone hresult(ptr*);" & _
		"GetCount hresult(ulong_ptr*);"
Global Const $__BITSCONSTANT_sTagIEnumBackgroundCopyJobs = _
		"Next hresult(ulong;ptr*;ulong_ptr*);" & _ ; to-do
		"Skip hresult(ulong);" & _
		"Reset hresult();" & _
		"Clone hresult(ptr*);" & _
		"GetCount hresult(ulong_ptr*);"
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;$tagBG_FILE_PROGRESS
;$tagBG_JOB_PROGRESS
;$tagBG_JOB_TIMES
;_BITS_BackgroundCopyError_GetError
;_BITS_BackgroundCopyError_GetErrorContextDescription
;_BITS_BackgroundCopyError_GetErrorDescription
;_BITS_BackgroundCopyError_GetFile
;_BITS_BackgroundCopyError_GetProtocol
;_BITS_BackgroundCopyFile_GetLocalName
;_BITS_BackgroundCopyFile_GetProgress
;_BITS_BackgroundCopyFile_GetRemoteName
;_BITS_BackgroundCopyJob_AddFile
;_BITS_BackgroundCopyJob_AddFileSet
;_BITS_BackgroundCopyJob_Cancel
;_BITS_BackgroundCopyJob_Complete
;_BITS_BackgroundCopyJob_EnumFiles
;_BITS_BackgroundCopyJob_GetDescription
;_BITS_BackgroundCopyJob_GetDisplayName
;_BITS_BackgroundCopyJob_GetError
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
;_BITS_BackgroundCopyJob_GetTimes
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
;_BITS_BackgroundCopyManager_EnumJobs
;_BITS_BackgroundCopyManager_GetErrorDescription
;_BITS_BackgroundCopyManager_GetJob
;_BITS_Connect
;_BITS_EnumBackgroundCopyFiles_Clone
;_BITS_EnumBackgroundCopyFiles_GetCount
;_BITS_EnumBackgroundCopyFiles_Reset
;_BITS_EnumBackgroundCopyFiles_Skip
;_BITS_EnumBackgroundCopyJobs_Clone
;_BITS_EnumBackgroundCopyJobs_GetCount
;_BITS_EnumBackgroundCopyJobs_Reset
;_BITS_EnumBackgroundCopyJobs_Skip
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ===============================================================================================================================

; BG_FILE_PROGRESS structure (https://docs.microsoft.com/en-us/windows/win32/api/bits/ns-bits-bg_file_progress)
Global Const $tagBG_FILE_PROGRESS = "struct;uint64 BytesTotal;uint64 BytesTransferred;bool Completed;endstruct"
; BG_JOB_PROGRESS structure (https://docs.microsoft.com/en-us/windows/win32/api/bits/ns-bits-bg_job_progress)
Global Const $tagBG_JOB_PROGRESS = "struct;uint64 BytesTotal;uint64 BytesTransferred;ulong FilesTotal;ulong FilesTransferred;endstruct"
; BG_JOB_TIMES structure (https://docs.microsoft.com/en-us/windows/win32/api/bits/ns-bits-bg_job_times)
Global Const $tagBG_JOB_TIMES = $tagFILETIME & ";" & $tagFILETIME & ";" & $tagFILETIME

Func _BITS_BackgroundCopyError_GetError(Const ByRef $oBackgroundCopyError)
	Local $iContext = 0
	Local $iCode = 0
	Local $aError[2] = [0, 0]

	$oBackgroundCopyError.GetError($iContext, $iCode)
	$aError[0] = $iContext
	$aError[1] = $iCode

	Return $aError
EndFunc   ;==>_BITS_BackgroundCopyError_GetError

Func _BITS_BackgroundCopyError_GetErrorContextDescription(Const ByRef $oBackgroundCopyError, Const ByRef $iLanguageId)
	Local $sContextDescription = ""

	$oBackgroundCopyError.GetErrorContextDescription($iLanguageId, $sContextDescription)

	Return $sContextDescription
EndFunc   ;==>_BITS_BackgroundCopyError_GetErrorContextDescription

Func _BITS_BackgroundCopyError_GetErrorDescription(Const ByRef $oBackgroundCopyError, Const ByRef $iLanguageId)
	Local $sErrorDescription = ""

	$oBackgroundCopyError.GetErrorDescription($iLanguageId, $sErrorDescription)

	Return $sErrorDescription
EndFunc   ;==>_BITS_BackgroundCopyError_GetErrorDescription

Func _BITS_BackgroundCopyError_GetFile(Const ByRef $oBackgroundCopyError)
	Local $pFile = 0
	Local $oBackgroundCopyFile = 0

	$oBackgroundCopyError.GetFile($pFile)
	$oBackgroundCopyFile = ObjCreateInterface($pFile, $__BITSCONSTANT_sIID_IBackgroundCopyFile, $__BITSCONSTANT_sTagIBackgroundCopyFile)

	Return $oBackgroundCopyFile
EndFunc   ;==>_BITS_BackgroundCopyError_GetFile

Func _BITS_BackgroundCopyError_GetProtocol(Const ByRef $oBackgroundCopyError)
	Local $sProtocol = ""

	$oBackgroundCopyError.GetProtocol($sProtocol)

	Return $sProtocol
EndFunc   ;==>_BITS_BackgroundCopyError_GetProtocol

Func _BITS_BackgroundCopyFile_GetLocalName(Const ByRef $oBackgroundCopyFile)
	Local $sLocalName = ""

	$oBackgroundCopyFile.GetLocalName($sLocalName)

	Return $sLocalName
EndFunc   ;==>_BITS_BackgroundCopyFile_GetLocalName

Func _BITS_BackgroundCopyFile_GetProgress(Const ByRef $oBackgroundCopyFile)
	Local $tBG_FILE_PROGRESS = 0
	Local $aProgress[3] = [0, 0, 0]

	$tBG_FILE_PROGRESS = DllStructCreate($tagBG_FILE_PROGRESS)
	ConsoleWrite("File.GetProgress = " & $oBackgroundCopyFile.GetProgress($tBG_FILE_PROGRESS) & @CRLF)
	$aProgress[0] = DllStructGetData($tBG_FILE_PROGRESS, "BytesTotal")
	$aProgress[1] = DllStructGetData($tBG_FILE_PROGRESS, "BytesTransferred")
	$aProgress[2] = DllStructGetData($tBG_FILE_PROGRESS, "Completed")
	$tBG_FILE_PROGRESS = 0

	Return $aProgress
EndFunc   ;==>_BITS_BackgroundCopyFile_GetProgress

Func _BITS_BackgroundCopyFile_GetRemoteName(Const ByRef $oBackgroundCopyFile)
	Local $sRemoteName = ""

	$oBackgroundCopyFile.GetRemoteName($sRemoteName)

	Return $sRemoteName
EndFunc   ;==>_BITS_BackgroundCopyFile_GetRemoteName

Func _BITS_BackgroundCopyJob_AddFile(Const ByRef $oBackgroundCopyJob, Const ByRef $sRemoteUrl, Const ByRef $sLocalName)
	$oBackgroundCopyJob.AddFile($sRemoteUrl, $sLocalName)
EndFunc   ;==>_BITS_BackgroundCopyJob_AddFile

Func _BITS_BackgroundCopyJob_AddFileSet(Const ByRef $oBackgroundCopyJob, Const ByRef $aFileSet)
	Local $iFileCount = 0
	; BG_FILE_INFO structure (https://docs.microsoft.com/en-us/windows/win32/api/bits/ns-bits-bg_file_info)
	Local $tagBG_FILE_INFO = ""
	Local $tBG_FILE_INFO = 0
	Local $atRemoteNames[0]
	Local $atLocalNames[0]

	$iFileCount = UBound($aFileSet)
	For $i = 1 To $iFileCount
		$tagBG_FILE_INFO &= "ptr;ptr;"
	Next
	$tBG_FILE_INFO = DllStructCreate($tagBG_FILE_INFO)
	ReDim $atRemoteNames[$iFileCount]
	ReDim $atLocalNames[$iFileCount]
	For $i = 0 To $iFileCount - 1
		$atRemoteNames[$i] = DllStructCreate("wchar[" & StringLen($aFileSet[$i][0]) + 1 & "];")
		$atLocalNames[$i] = DllStructCreate("wchar[" & StringLen($aFileSet[$i][1]) + 1 & "];")
		DllStructSetData($atRemoteNames[$i], 1, $aFileSet[$i][0])
		DllStructSetData($atLocalNames[$i], 1, $aFileSet[$i][1])
		DllStructSetData($tBG_FILE_INFO, $i * 2 + 1, DllStructGetPtr($atRemoteNames[$i]))
		DllStructSetData($tBG_FILE_INFO, $i * 2 + 2, DllStructGetPtr($atLocalNames[$i]))
	Next
	$oBackgroundCopyJob.AddFileSet($iFileCount, $tBG_FILE_INFO)
	For $i = 0 To $iFileCount - 1
		$atRemoteNames[$i] = 0
		$atLocalNames[$i] = 0
	Next
	$tBG_FILE_INFO = 0
EndFunc   ;==>_BITS_BackgroundCopyJob_AddFileSet

Func _BITS_BackgroundCopyJob_Cancel(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.Cancel()
EndFunc   ;==>_BITS_BackgroundCopyJob_Cancel

Func _BITS_BackgroundCopyJob_Complete(Const ByRef $oBackgroundCopyJob)
	$oBackgroundCopyJob.Complete()
EndFunc   ;==>_BITS_BackgroundCopyJob_Complete

Func _BITS_BackgroundCopyJob_EnumFiles(Const ByRef $oBackgroundCopyJob)
	Local $pEnumFiles = 0
	Local $oEnumBackgroundCopyFiles = 0

	$oBackgroundCopyJob.EnumFiles($pEnumFiles)
	$oEnumBackgroundCopyFiles = ObjCreateInterface($pEnumFiles, $__BITSCONSTANT_sIID_IEnumBackgroundCopyFiles, $__BITSCONSTANT_sTagIEnumBackgroundCopyFiles)

	Return $oEnumBackgroundCopyFiles
EndFunc   ;==>_BITS_BackgroundCopyJob_EnumFiles

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

Func _BITS_BackgroundCopyJob_GetError(Const ByRef $oBackgroundCopyJob)
	Local $pError = 0
	Local $oBackgroundCopyError = 0

	$oBackgroundCopyJob.GetError($pError)
	$oBackgroundCopyError = ObjCreateInterface($pError, $__BITSCONSTANT_sIID_IBackgroundCopyError, $__BITSCONSTANT_sTagIBackgroundCopyError)

	Return $oBackgroundCopyError
EndFunc   ;==>_BITS_BackgroundCopyJob_GetError

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
	Local $aProgress[4] = [0, 0, 0, 0]

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

Func _BITS_BackgroundCopyJob_GetTimes(Const ByRef $oBackgroundCopyJob)
	Local $tBG_JOB_TIMES = 0
	Local $tFILETIME = 0
	Local $tSYSTEMTIME = 0
	Local $aTimes[3] = ["", "", ""]

	$tBG_JOB_TIMES = DllStructCreate($tagBG_JOB_TIMES)
	$oBackgroundCopyJob.GetTimes($tBG_JOB_TIMES)
	$tFILETIME = DllStructCreate($tagFILETIME)
	DllStructSetData($tFILETIME, 1, DllStructGetData($tBG_JOB_TIMES, 1))
	DllStructSetData($tFILETIME, 2, DllStructGetData($tBG_JOB_TIMES, 2))
	$tSYSTEMTIME = _Date_Time_FileTimeToSystemTime($tFILETIME)
	$aTimes[0] = _Date_Time_SystemTimeToDateTimeStr($tSYSTEMTIME, 1)
	DllStructSetData($tFILETIME, 1, DllStructGetData($tBG_JOB_TIMES, 3))
	DllStructSetData($tFILETIME, 2, DllStructGetData($tBG_JOB_TIMES, 4))
	$tSYSTEMTIME = _Date_Time_FileTimeToSystemTime($tFILETIME)
	$aTimes[1] = _Date_Time_SystemTimeToDateTimeStr($tSYSTEMTIME, 1)
	DllStructSetData($tFILETIME, 1, DllStructGetData($tBG_JOB_TIMES, 5))
	DllStructSetData($tFILETIME, 2, DllStructGetData($tBG_JOB_TIMES, 6))
	$tSYSTEMTIME = _Date_Time_FileTimeToSystemTime($tFILETIME)
	$aTimes[2] = _Date_Time_SystemTimeToDateTimeStr($tSYSTEMTIME, 1)
	$tFILETIME = 0
	$tBG_JOB_TIMES = 0

	Return $aTimes
EndFunc   ;==>_BITS_BackgroundCopyJob_GetTimes

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
	Local $tPROXYLIST = 0
	Local $tPROXYBYPASSLIST = 0

	$tPROXYLIST = DllStructCreate("wchar[" & StringLen($sProxyList) + 1 & "];")
	$tPROXYBYPASSLIST = DllStructCreate("wchar[" & StringLen($sProxyBypassList) + 1 & "];")
	DllStructSetData($tPROXYLIST, 1, $sProxyList)
	DllStructSetData($tPROXYBYPASSLIST, 1, $sProxyBypassList)
	$oBackgroundCopyJob.SetProxySettings($iProxyUsage, $tPROXYLIST, $tPROXYBYPASSLIST)
	$tPROXYLIST = 0
	$tPROXYBYPASSLIST = 0
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

Func _BITS_BackgroundCopyManager_EnumJobs(Const ByRef $oBackgroundCopyManager, Const ByRef $iFlags)
	Local $pEnumJobs = 0
	Local $oEnumBackgroundCopyJobs = 0

	$oBackgroundCopyManager.EnumJobs($iFlags, $pEnumJobs)
	$oEnumBackgroundCopyJobs = ObjCreateInterface($pEnumJobs, $__BITSCONSTANT_sIID_IEnumBackgroundCopyJobs, $__BITSCONSTANT_sTagIEnumBackgroundCopyJobs)

	Return $oEnumBackgroundCopyJobs
EndFunc   ;==>_BITS_BackgroundCopyManager_EnumJobs

Func _BITS_BackgroundCopyManager_GetErrorDescription(Const ByRef $oBackgroundCopyManager, Const ByRef $iHresult, Const ByRef $iLanguageId)
	Local $sErrorDescription = ""

	$oBackgroundCopyManager.GetErrorDescription($iHresult, $iLanguageId, $sErrorDescription)

	Return $sErrorDescription
EndFunc   ;==>_BITS_BackgroundCopyManager_GetErrorDescription

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

Func _BITS_EnumBackgroundCopyFiles_Clone(Const ByRef $oEnumBackgroundCopyFiles)
	Local $pEnumFilesClone = 0
	Local $oEnumBackgroundCopyFilesClone = 0

	$oEnumBackgroundCopyFiles.Clone($pEnumFilesClone)
	$oEnumBackgroundCopyFilesClone = ObjCreateInterface($pEnumFilesClone, $__BITSCONSTANT_sIID_IEnumBackgroundCopyFiles, $__BITSCONSTANT_sTagIEnumBackgroundCopyFiles)

	Return $oEnumBackgroundCopyFilesClone
EndFunc   ;==>_BITS_EnumBackgroundCopyFiles_Clone

Func _BITS_EnumBackgroundCopyFiles_GetCount(Const ByRef $oEnumBackgroundCopyFiles)
	Local $iCount = 0

	$oEnumBackgroundCopyFiles.GetCount($iCount)

	Return $iCount
EndFunc   ;==>_BITS_EnumBackgroundCopyFiles_GetCount

Func _BITS_EnumBackgroundCopyFiles_Reset(Const ByRef $oEnumBackgroundCopyFiles)
	$oEnumBackgroundCopyFiles.Reset()
EndFunc   ;==>_BITS_EnumBackgroundCopyFiles_Reset

Func _BITS_EnumBackgroundCopyFiles_Skip(Const ByRef $oEnumBackgroundCopyFiles, Const ByRef $iCelt)
	$oEnumBackgroundCopyFiles.Skip($iCelt)
EndFunc   ;==>_BITS_EnumBackgroundCopyFiles_Skip

Func _BITS_EnumBackgroundCopyJobs_Clone(Const ByRef $oEnumBackgroundCopyJobs)
	Local $pEnumJobsClone = 0
	Local $oEnumBackgroundCopyJobsClone = 0

	$oEnumBackgroundCopyJobs.Clone($pEnumJobsClone)
	$oEnumBackgroundCopyJobsClone = ObjCreateInterface($pEnumJobsClone, $__BITSCONSTANT_sIID_IEnumBackgroundCopyJobs, $__BITSCONSTANT_sTagIEnumBackgroundCopyJobs)

	Return $oEnumBackgroundCopyJobsClone
EndFunc   ;==>_BITS_EnumBackgroundCopyJobs_Clone

Func _BITS_EnumBackgroundCopyJobs_GetCount(Const ByRef $oEnumBackgroundCopyJobs)
	Local $iCount = 0

	$oEnumBackgroundCopyJobs.GetCount($iCount)

	Return $iCount
EndFunc   ;==>_BITS_EnumBackgroundCopyJobs_GetCount

Func _BITS_EnumBackgroundCopyJobs_Reset(Const ByRef $oEnumBackgroundCopyJobs)
	$oEnumBackgroundCopyJobs.Reset()
EndFunc   ;==>_BITS_EnumBackgroundCopyJobs_Reset

Func _BITS_EnumBackgroundCopyJobs_Skip(Const ByRef $oEnumBackgroundCopyJobs, Const ByRef $iCelt)
	$oEnumBackgroundCopyJobs.Skip($iCelt)
EndFunc   ;==>_BITS_EnumBackgroundCopyJobs_Skip
