# 1 "./matrix_mult.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./matrix_mult.cil.c"
# 363 "/usr/include/stdio.h"
extern int printf(char const * __restrict __format , ...) ;
# 19 "matrix_mult.c"
extern int ( atoi)() ;
# 6 "matrix_mult.c"
int main(int argc , char **argv )
{
  int i ;
  int j ;
  int k ;
  int input ;
  int m1[3][3] ;
  int m2[3][3] ;
  int prod[3][3] ;
  int tmp ;
  int tmp___0 ;
  char **mem_12 ;
  char **mem_13 ;
  int __retres14 ;

  {
# 9 "matrix_mult.c"
  input = 1;
# 14 "matrix_mult.c"
  if (argc != 19) {
# 14 "matrix_mult.c"
    printf((char const * __restrict )"Need 2 3x3 integer matrices\n");
  } else {

  }
# 17 "matrix_mult.c"
  i = 0;
  {
# 17 "matrix_mult.c"
  while (1) {
    while_continue: ;
# 17 "matrix_mult.c"
    if (i < 3) {

    } else {
# 17 "matrix_mult.c"
      goto while_break;
    }
# 18 "matrix_mult.c"
    j = 0;
    {
# 18 "matrix_mult.c"
    while (1) {
      while_continue___0: ;
# 18 "matrix_mult.c"
      if (j < 3) {

      } else {
# 18 "matrix_mult.c"
        goto while_break___0;
      }
# 19 "matrix_mult.c"
      tmp = input;
# 19 "matrix_mult.c"
      input ++;
# 19 "matrix_mult.c"
      mem_12 = argv + tmp;
# 19 "matrix_mult.c"
      m1[i][j] = atoi(*mem_12);
# 18 "matrix_mult.c"
      j ++;
    }
    while_break___0: ;
    }
# 17 "matrix_mult.c"
    i ++;
  }
  while_break: ;
  }
# 23 "matrix_mult.c"
  i = 0;
  {
# 23 "matrix_mult.c"
  while (1) {
    while_continue___1: ;
# 23 "matrix_mult.c"
    if (i < 3) {

    } else {
# 23 "matrix_mult.c"
      goto while_break___1;
    }
# 24 "matrix_mult.c"
    j = 0;
    {
# 24 "matrix_mult.c"
    while (1) {
      while_continue___2: ;
# 24 "matrix_mult.c"
      if (j < 3) {

      } else {
# 24 "matrix_mult.c"
        goto while_break___2;
      }
# 25 "matrix_mult.c"
      tmp___0 = input;
# 25 "matrix_mult.c"
      input ++;
# 25 "matrix_mult.c"
      mem_13 = argv + tmp___0;
# 25 "matrix_mult.c"
      m2[i][j] = atoi(*mem_13);
# 24 "matrix_mult.c"
      j ++;
    }
    while_break___2: ;
    }
# 23 "matrix_mult.c"
    i ++;
  }
  while_break___1: ;
  }
# 30 "matrix_mult.c"
  i = 0;
  {
# 30 "matrix_mult.c"
  while (1) {
    while_continue___3: ;
# 30 "matrix_mult.c"
    if (i < 3) {

    } else {
# 30 "matrix_mult.c"
      goto while_break___3;
    }
# 31 "matrix_mult.c"
    j = 0;
    {
# 31 "matrix_mult.c"
    while (1) {
      while_continue___4: ;
# 31 "matrix_mult.c"
      if (j < 3) {

      } else {
# 31 "matrix_mult.c"
        goto while_break___4;
      }
# 32 "matrix_mult.c"
      prod[i][j] = 0;
# 31 "matrix_mult.c"
      j ++;
    }
    while_break___4: ;
    }
# 30 "matrix_mult.c"
    i ++;
  }
  while_break___3: ;
  }
# 37 "matrix_mult.c"
  i = 0;
  {
# 37 "matrix_mult.c"
  while (1) {
    while_continue___5: ;
# 37 "matrix_mult.c"
    if (i < 3) {

    } else {
# 37 "matrix_mult.c"
      goto while_break___5;
    }
# 38 "matrix_mult.c"
    j = 0;
    {
# 38 "matrix_mult.c"
    while (1) {
      while_continue___6: ;
# 38 "matrix_mult.c"
      if (j < 3) {

      } else {
# 38 "matrix_mult.c"
        goto while_break___6;
      }
# 39 "matrix_mult.c"
      k = 0;
      {
# 39 "matrix_mult.c"
      while (1) {
        while_continue___7: ;
# 39 "matrix_mult.c"
        if (k < 3) {

        } else {
# 39 "matrix_mult.c"
          goto while_break___7;
        }
# 40 "matrix_mult.c"
        prod[i][j] += m1[i][k] * m2[k][j];
# 39 "matrix_mult.c"
        k ++;
      }
      while_break___7: ;
      }
# 38 "matrix_mult.c"
      j ++;
    }
    while_break___6: ;
    }
# 37 "matrix_mult.c"
    i ++;
  }
  while_break___5: ;
  }
# 46 "matrix_mult.c"
  i = 0;
  {
# 46 "matrix_mult.c"
  while (1) {
    while_continue___8: ;
# 46 "matrix_mult.c"
    if (i < 3) {

    } else {
# 46 "matrix_mult.c"
      goto while_break___8;
    }
# 47 "matrix_mult.c"
    j = 0;
    {
# 47 "matrix_mult.c"
    while (1) {
      while_continue___9: ;
# 47 "matrix_mult.c"
      if (j < 3) {

      } else {
# 47 "matrix_mult.c"
        goto while_break___9;
      }
# 48 "matrix_mult.c"
      printf((char const * __restrict )"%d ", prod[i][j]);
# 47 "matrix_mult.c"
      j ++;
    }
    while_break___9: ;
    }
# 50 "matrix_mult.c"
    printf((char const * __restrict )"\n");
# 46 "matrix_mult.c"
    i ++;
  }
  while_break___8: ;
  }
# 53 "matrix_mult.c"
  __retres14 = 0;
# 6 "matrix_mult.c"
  return (__retres14);
}
}
