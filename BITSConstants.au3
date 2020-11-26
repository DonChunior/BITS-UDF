; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=Y
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#include-once

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

; BG_JOB_TYPE enumeration (https://docs.microsoft.com/en-us/windows/win32/api/bits/ne-bits-bg_job_type)
Global Enum _
		$BG_JOB_TYPE_DOWNLOAD, _
		$BG_JOB_TYPE_UPLOAD, _
		$BG_JOB_TYPE_UPLOAD_REPLY

; Notify flags (https://docs.microsoft.com/en-us/windows/win32/api/bits/nf-bits-ibackgroundcopyjob-setnotifyflags)
Global Const $BG_NOTIFY_JOB_TRANSFERRED = 0x0001
Global Const $BG_NOTIFY_JOB_ERROR = 0x0002
Global Const $BG_NOTIFY_DISABLE = 0x0004
Global Const $BG_NOTIFY_JOB_MODIFICATION = 0x0008
Global Const $BG_NOTIFY_FILE_TRANSFERRED = 0x0010
Global Const $BG_NOTIFY_FILE_RANGES_TRANSFERRED = 0x0020

; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ===============================================================================================================================
