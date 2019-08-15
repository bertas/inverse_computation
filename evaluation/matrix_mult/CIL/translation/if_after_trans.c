#include <stdio.h>
#include <gprolog.h>


int bar(char [],int,int);

int  __Babel_bar( char** argv, int x, int y){
  //pl init
  int return_value;
  int func;
  PlTerm arg[10];
  PlBool res;

//register a predicate
  func = Pl_Find_Atom("bar");
  printf("func is %d\n", func);
  
  Pl_Query_Begin(PL_FALSE);

  arg[0] = Pl_Mk_String(input);
  arg[1] = Pl_Mk_Integer(x);
  arg[2] = Pl_Mk_Integer(y);
  arg[3] = Pl_Mk_Variable();

  //nb_sol = 0;
  res = Pl_Query_Call(func, 4, arg);
  return_value = Pl_Rd_Integer(arg[3]);
  /*while (res){
    res = Pl_Query_Next_Solution();
    return_value = Pl_Rd_Integer(arg[3]);
  }*/
  Pl_Query_End(PL_KEEP_FOR_PROLOG);
//stop prolog
  
  return return_value;
}

int main(int argc, char **argv)
{
  Pl_Start_Prolog(argc, argv);
  int x=0;
  int y=10;
  int z;
  char input[100];

  scanf("%s", input);
  
  z=bar(input,x,y);

  printf("%d\n", z);
  Pl_Stop_Prolog();

  return 0;
}

int bar(char input[],int x,int y){
    
  int ret= __Babel_bar(input,x,y);
  return ret;
}

