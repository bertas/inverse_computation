# 1 "./factorial.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./factorial.cil.c"
# 363 "/usr/include/stdio.h"
extern int printf(char const * __restrict __format , ...) ;
# 8 "factorial.c"
extern int ( atoi)() ;
# 5 "factorial.c"
int main(int argc , char **argv )
{
  int i ;
  int input ;
  int tmp ;
  int fac ;
  char **mem_7 ;
  int __retres8 ;

  {
# 8 "factorial.c"
  mem_7 = argv + 1;
# 8 "factorial.c"
  tmp = atoi(*mem_7);
# 8 "factorial.c"
  input = tmp;
# 9 "factorial.c"
  fac = 1;
# 11 "factorial.c"
  i = 1;
  {
# 11 "factorial.c"
  while (1) {
    while_continue: ;
# 11 "factorial.c"
    if (i <= input) {

    } else {
# 11 "factorial.c"
      goto while_break;
    }
# 12 "factorial.c"
    fac *= i;
# 11 "factorial.c"
    i ++;
  }
  while_break: ;
  }
# 16 "factorial.c"
  printf((char const * __restrict )"%d! = %d\n", input, fac);
# 17 "factorial.c"
  __retres8 = 0;
# 5 "factorial.c"
  return (__retres8);
}
}
