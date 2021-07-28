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

; BG_ERROR_CONTEXT enumeration (https://docs.microsoft.com/en-us/windows/win32/api/bits/ne-bits-bg_error_context)
Global Enum _
		$BG_ERROR_CONTEXT_NONE, _
		$BG_ERROR_CONTEXT_UNKNOWN, _
		$BG_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER, _
		$BG_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION, _
		$BG_ERROR_CONTEXT_LOCAL_FILE, _
		$BG_ERROR_CONTEXT_REMOTE_FILE, _
		$BG_ERROR_CONTEXT_GENERAL_TRANSPORT, _
		$BG_ERROR_CONTEXT_REMOTE_APPLICATION, _
		$BG_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK

; BG_JOB_PRIORITY enumeration (https://docs.microsoft.com/en-us/windows/win32/api/bits/ne-bits-bg_job_priority)
Global Enum _
		$BG_JOB_PRIORITY_FOREGROUND, _
		$BG_JOB_PRIORITY_HIGH, _
		$BG_JOB_PRIORITY_NORMAL, _
		$BG_JOB_PRIORITY_LOW

; BG_JOB_PROXY_USAGE enumeration (https://docs.microsoft.com/en-us/windows/win32/api/bits/ne-bits-bg_job_proxy_usage)
Global Enum _
		$BG_JOB_PROXY_USAGE_PRECONFIG, _
		$BG_JOB_PROXY_USAGE_NO_PROXY, _
		$BG_JOB_PROXY_USAGE_OVERRIDE, _
		$BG_JOB_PROXY_USAGE_AUTODETECT

; BG_JOB_STATE enumeration (https://docs.microsoft.com/en-us/windows/win32/api/bits/ne-bits-bg_job_state)
Global Enum _
		$BG_JOB_STATE_QUEUED, _
		$BG_JOB_STATE_CONNECTING, _
		$BG_JOB_STATE_TRANSFERRING, _
		$BG_JOB_STATE_SUSPENDED, _
		$BG_JOB_STATE_ERROR, _
		$BG_JOB_STATE_TRANSIENT_ERROR, _
		$BG_JOB_STATE_TRANSFERRED, _
		$BG_JOB_STATE_ACKNOWLEDGED, _
		$BG_JOB_STATE_CANCELLED

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
