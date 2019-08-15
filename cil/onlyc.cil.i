# 1 "./onlyc.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./onlyc.cil.c"
# 339 "/usr/include/stdio.h"
extern int printf(char const * __restrict __format , ...) ;
# 16 "../test/yufeitest/onlyc.c"
extern int ( strcpy)() ;
# 17 "../test/yufeitest/onlyc.c"
extern int ( strlen)() ;
# 20 "../test/yufeitest/onlyc.c"
extern int ( atoi)() ;
# 4 "../test/yufeitest/onlyc.c"
int main(int argc , char **argv )
{
  char expression[1024] ;
  char *e ;
  char *program ;
  int n ;
  char *tmp ;
  int tmp___0 ;
  int input ;
  int tmp___1 ;
  char **mem_12 ;
  char **mem_13 ;
  int __retres14 ;

  {
# 6 "../test/yufeitest/onlyc.c"
  e = expression;
# 7 "../test/yufeitest/onlyc.c"
  mem_12 = argv + 0;
# 7 "../test/yufeitest/onlyc.c"
  program = *mem_12;
# 13 "../test/yufeitest/onlyc.c"
  n = 1;
  {
# 13 "../test/yufeitest/onlyc.c"
  while (1) {
    while_continue: ;
# 13 "../test/yufeitest/onlyc.c"
    if (n < argc) {

    } else {
# 13 "../test/yufeitest/onlyc.c"
      goto while_break;
    }
# 14 "../test/yufeitest/onlyc.c"
    if (n != 1) {
# 15 "../test/yufeitest/onlyc.c"
      tmp = e;
# 15 "../test/yufeitest/onlyc.c"
      e ++;
# 15 "../test/yufeitest/onlyc.c"
      *tmp = (char )' ';
    } else {

    }
# 16 "../test/yufeitest/onlyc.c"
    mem_13 = argv + n;
# 16 "../test/yufeitest/onlyc.c"
    strcpy(e, *mem_13);
# 17 "../test/yufeitest/onlyc.c"
    tmp___0 = strlen(e);
# 17 "../test/yufeitest/onlyc.c"
    e += tmp___0;
# 13 "../test/yufeitest/onlyc.c"
    n ++;
  }
  while_break: ;
  }
# 20 "../test/yufeitest/onlyc.c"
  tmp___1 = atoi(expression);
# 20 "../test/yufeitest/onlyc.c"
  input = tmp___1;
# 21 "../test/yufeitest/onlyc.c"
  if (input > 10) {
# 22 "../test/yufeitest/onlyc.c"
    printf((char const * __restrict )"%d\n", 1);
  } else
# 23 "../test/yufeitest/onlyc.c"
  if (input <= 10) {
# 24 "../test/yufeitest/onlyc.c"
    printf((char const * __restrict )"%d\n", 0);
  } else {

  }
# 27 "../test/yufeitest/onlyc.c"
  __retres14 = 0;
# 4 "../test/yufeitest/onlyc.c"
  return (__retres14);
}
}
