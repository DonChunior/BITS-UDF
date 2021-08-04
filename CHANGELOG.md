# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0-alpha] - 2021-08-04
### Added
- CHANGELOG, LICENSE and README created.
- Function _BITS_Connect created to establish a connection with BITS.
- Implementation of the IBackgroundCopyManager interface:
  - _BITS_BackgroundCopyManager_CreateJob
  - _BITS_BackgroundCopyManager_EnumJobs
  - _BITS_BackgroundCopyManager_GetErrorDescription
  - _BITS_BackgroundCopyManager_GetJob
- Implementation of the IBackgroundCopyJob interface:
  - _BITS_BackgroundCopyJob_AddFile
  - _BITS_BackgroundCopyJob_AddFileSet
  - _BITS_BackgroundCopyJob_Cancel
  - _BITS_BackgroundCopyJob_Complete
  - _BITS_BackgroundCopyJob_EnumFiles
  - _BITS_BackgroundCopyJob_GetDescription
  - _BITS_BackgroundCopyJob_GetDisplayName
  - _BITS_BackgroundCopyJob_GetError
  - _BITS_BackgroundCopyJob_GetErrorCount
  - _BITS_BackgroundCopyJob_GetId
  - _BITS_BackgroundCopyJob_GetMinimumRetryDelay
  - _BITS_BackgroundCopyJob_GetNoProgressTimeout
  - _BITS_BackgroundCopyJob_GetNotifyFlags
  - _BITS_BackgroundCopyJob_GetOwner
  - _BITS_BackgroundCopyJob_GetPriority
  - _BITS_BackgroundCopyJob_GetProgress
  - _BITS_BackgroundCopyJob_GetProxySettings
  - _BITS_BackgroundCopyJob_GetState
  - _BITS_BackgroundCopyJob_GetTimes
  - _BITS_BackgroundCopyJob_GetType
  - _BITS_BackgroundCopyJob_Resume
  - _BITS_BackgroundCopyJob_SetDescription
  - _BITS_BackgroundCopyJob_SetDisplayName
  - _BITS_BackgroundCopyJob_SetMinimumRetryDelay
  - _BITS_BackgroundCopyJob_SetNoProgressTimeout
  - _BITS_BackgroundCopyJob_SetNotifyFlags
  - _BITS_BackgroundCopyJob_SetPriority
  - _BITS_BackgroundCopyJob_SetProxySettings
  - _BITS_BackgroundCopyJob_Suspend
  - _BITS_BackgroundCopyJob_TakeOwnership
- Implementation of the IBackgroundCopyFile interface:
  - _BITS_BackgroundCopyFile_GetLocalName
  - _BITS_BackgroundCopyFile_GetProgress
  - _BITS_BackgroundCopyFile_GetRemoteName
- Implementation of the IEnumBackgroundCopyJobs interface:
  - _BITS_EnumBackgroundCopyJobs_Clone
  - _BITS_EnumBackgroundCopyJobs_GetCount
  - _BITS_EnumBackgroundCopyJobs_Next
  - _BITS_EnumBackgroundCopyJobs_Reset
  - _BITS_EnumBackgroundCopyJobs_Skip
- Implementation of the IEnumBackgroundCopyFiles interface:
  - _BITS_EnumBackgroundCopyFiles_Clone
  - _BITS_EnumBackgroundCopyFiles_GetCount
  - _BITS_EnumBackgroundCopyFiles_Next
  - _BITS_EnumBackgroundCopyFiles_Reset
  - _BITS_EnumBackgroundCopyFiles_Skip
- Implementation of the IBackgroundCopyError interface:
  - _BITS_BackgroundCopyError_GetError
  - _BITS_BackgroundCopyError_GetErrorContextDescription
  - _BITS_BackgroundCopyError_GetErrorDescription
  - _BITS_BackgroundCopyError_GetFile
  - _BITS_BackgroundCopyError_GetProtocol
