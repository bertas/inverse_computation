# 1 "./fibonacci.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./fibonacci.cil.c"
# 363 "/usr/include/stdio.h"
extern int printf(char const * __restrict __format , ...) ;
# 6 "fibonacci.c"
int Fibonacci(int n )
{
  int fib ;
  int tmp ;
  int tmp___0 ;

  {
# 7 "fibonacci.c"
  fib = 0;
# 8 "fibonacci.c"
  if (n == 1) {
# 9 "fibonacci.c"
    fib = 1;
  } else
# 8 "fibonacci.c"
  if (n == 2) {
# 9 "fibonacci.c"
    fib = 1;
  } else {
# 11 "fibonacci.c"
    tmp = Fibonacci(n - 1);
# 11 "fibonacci.c"
    tmp___0 = Fibonacci(n - 2);
# 11 "fibonacci.c"
    fib = tmp + tmp___0;
  }
# 14 "fibonacci.c"
  return (fib);
}
}
# 19 "fibonacci.c"
extern int ( atoi)() ;
# 17 "fibonacci.c"
int main(int argc , char **argv )
{
  int input ;
  int tmp ;
  int fib ;
  int tmp___0 ;
  char **mem_7 ;
  int __retres8 ;

  {
# 19 "fibonacci.c"
  mem_7 = argv + 1;
# 19 "fibonacci.c"
  tmp = atoi(*mem_7);
# 19 "fibonacci.c"
  input = tmp;
# 20 "fibonacci.c"
  tmp___0 = Fibonacci(input);
# 20 "fibonacci.c"
  fib = tmp___0;
# 22 "fibonacci.c"
  printf((char const * __restrict )"Fibonacci of input %d = %d\n", input, fib);
# 23 "fibonacci.c"
  __retres8 = 0;
# 17 "fibonacci.c"
  return (__retres8);
}
}
