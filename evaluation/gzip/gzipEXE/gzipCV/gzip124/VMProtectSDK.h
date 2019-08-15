#include <wchar.h>
#include <stdio.h>
#include <process.h>
#include "stdafx.h"
#include <windows.h>

#pragma once



#ifdef _WIN64
	#pragma comment(lib, "VMProtectSDK64.lib")
#else
	#pragma comment(lib, "VMProtectSDK32.lib")
#endif

#ifdef __cplusplus
extern "C" {
#endif

// protection
__declspec(dllimport) void __stdcall VMProtectBegin(const char *);
__declspec(dllimport) void __stdcall VMProtectBeginVirtualization(const char *);
__declspec(dllimport) void __stdcall VMProtectBeginMutation(const char *);
__declspec(dllimport) void __stdcall VMProtectBeginUltra(const char *);
__declspec(dllimport) void __stdcall VMProtectBeginVirtualizationLockByKey(const char *);
__declspec(dllimport) void __stdcall VMProtectBeginUltraLockByKey(const char *);
__declspec(dllimport) void __stdcall VMProtectEnd(void);
//__declspec(dllimport) bool __stdcall VMProtectIsDebuggerPresent(bool);
//__declspec(dllimport) bool __stdcall VMProtectIsVirtualMachinePresent(void);
//__declspec(dllimport) bool __stdcall VMProtectIsValidImageCRC(void);
__declspec(dllimport) char * __stdcall VMProtectDecryptStringA(const char *value);
__declspec(dllimport) wchar_t * __stdcall VMProtectDecryptStringW(const wchar_t *value);

// licensing
enum VMProtectSerialStateFlags
{
	SERIAL_STATE_FLAG_CORRUPTED			= 0x00000001,
	SERIAL_STATE_FLAG_INVALID			= 0x00000002,
	SERIAL_STATE_FLAG_BLACKLISTED		= 0x00000004,
	SERIAL_STATE_FLAG_DATE_EXPIRED		= 0x00000008,
	SERIAL_STATE_FLAG_RUNNING_TIME_OVER	= 0x00000010,
	SERIAL_STATE_FLAG_BAD_HWID			= 0x00000020,
	SERIAL_STATE_FLAG_MAX_BUILD_EXPIRED	= 0x00000040,
};
#pragma pack(push, 1)
typedef struct
{
	unsigned short			wYear;
	unsigned char			bMonth;
	unsigned char			bDay;
} VMProtectDate;
typedef struct
{
	int				nState;				// VMProtectSerialStateFlags
	wchar_t			wUserName[256];		// user name
	wchar_t			wEMail[256];		// email
	VMProtectDate	dtExpire;			// date of serial number expiration
	VMProtectDate	dtMaxBuild;			// max date of build, that will accept this key
	int				bRunningTime;		// running time in minutes
	unsigned char			nUserDataLength;	// length of user data in bUserData
	unsigned char			bUserData[255];		// up to 255 bytes of user data
} VMProtectSerialNumberData;

#pragma pack(pop)
__declspec(dllimport) int  __stdcall VMProtectSetSerialNumber(const char * SerialNumber);
__declspec(dllimport) int  __stdcall VMProtectGetSerialNumberState();
//__declspec(dllimport) bool __stdcall VMProtectGetSerialNumberData(VMProtectSerialNumberData *pData, unsigned int nSize);
__declspec(dllimport) int  __stdcall VMProtectGetCurrentHWID(char * HWID, unsigned int nSize);

#ifdef __cplusplus
}
#endif
