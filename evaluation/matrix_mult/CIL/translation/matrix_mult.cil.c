/* Generated by CIL v. 1.5.1 */
/* print_CIL_Input is true */
#include<gprolog.h>

#line 363 "/usr/include/stdio.h"
extern int printf(char const   * __restrict  __format  , ...) ;
#line 19 "matrix_mult.c"
extern int ( /* missing proto */  atoi)() ;
#line 6 "matrix_mult.c"

int mainWrapper(int argc, char **argv){
  
  //pl init
  int return_value;
  int func;
  PlTerm arg[10];
  PlBool res;

//register a predicate
  func = Pl_Find_Atom("main");
  printf("%u\n",argv);
  printf("%d\n",argv);
  unsigned int a=argv+1;
  printf("%u\n",a);
  char** str =(char**)a;
  printf("%s\n",*str);
  //printf("%c\n",(char**)**a);
  //char* str=argv[1];
  //int input = atoi(str);
  Pl_Query_Begin(PL_FALSE);
  //unsigned int input = argv;
  
  arg[0] = Pl_Mk_Integer(argc);
  arg[1] = Pl_Mk_Float((unsigned int)argv);
  arg[2] = Pl_Mk_Variable();

  //nb_sol = 0;
  //should be modified
  res = Pl_Query_Call(func, 3, arg);
  //should be modified
  return_value = Pl_Rd_Integer(arg[2]);
  printf("%s\n","ririririri");
  /*while (res){
    res = Pl_Query_Next_Solution();
    return_value = Pl_Rd_Integer(arg[3]);
  }*/
  Pl_Query_End(PL_KEEP_FOR_PROLOG);
//stop prolog
  return_value=0;
  printf("%s\n","ririririri");
  return return_value;
}


int main(int argc , char **argv ) { 
  Pl_Start_Prolog(argc, argv);
  int return_value=mainWrapper(argc, argv);
  Pl_Stop_Prolog();
  return return_value;
}


