/* Generated by CIL v. 1.5.1 */
/* print_CIL_Input is true */
#include <gprolog.h>

#line 363 "/usr/include/stdio.h"
extern int printf(char const   * __restrict  __format  , ...) ;
#line 6 "fibonacci.c"
int Fibonacci(int n ) 
{ int return_value;
  return_value=FibonacciWrapper(n);
}

int FibonacciWrapper(int n){
//generate a return value if a function is not void,partial routine code
  int return_value;

//rountine code
  int func;
  PlTerm arg[10];
  PlBool res;

//routine code, register a predicate,fibonacci is not routine
  func = Pl_Find_Atom("fibonacci"); 
  printf("func is %d\n", func);

//routine code 
  Pl_Query_Begin(PL_FALSE);

//prepare parameters
//partial routine code, pass in parameter
  arg[0] = Pl_Mk_Integer(n);
//routine code, reserve a place for return value
  arg[1] = Pl_Mk_Variable();

//partial routine code, 2 is not routine.
  res = Pl_Query_Call(func, 2, arg);

//get return value, partial routine code, 1 is not routine
  return_value = Pl_Rd_Integer(arg[1]);

//routine code
  Pl_Query_End(PL_KEEP_FOR_PROLOG);

//routine code
  return return_value;

}



#line 19
extern int ( /* missing proto */  atoi)() ;
#line 17 "fibonacci.c"
int main(int argc , char **argv ) 
{ 
  Pl_Start_Prolog(argc, argv);
  int input ;
  int tmp ;
  int fib ;
  int tmp___0 ;
  char **mem_7 ;
  int __retres8 ;

  {
#line 19
  mem_7 = argv + 1;
#line 19
  tmp = atoi(*mem_7);
#line 19
  input = tmp;
#line 20
  tmp___0 = Fibonacci(input);
#line 20
  fib = tmp___0;
#line 22
  printf((char const   * __restrict  )"Fibonacci of input %d = %d\n", input, fib);
  printf("%s\n","prolog");
#line 23
  __retres8 = 0;
  Pl_Stop_Prolog();
#line 17
  return (__retres8);
}
}
