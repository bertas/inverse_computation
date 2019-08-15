#include <stdio.h>
#include <gprolog.h>



void byteReverse(unsigned char *buf, unsigned longs)
{  
    //pl init
  int return_value;
  int func;
  PlTerm arg[10];
  PlBool res;

//register a predicate
  func = Pl_Find_Atom("byte_reverse");
  printf("func is %d\n", func);
  
  Pl_Query_Begin(PL_FALSE);

  arg[0] = Pl_Mk_Float((unsigned int)buf);
  arg[1] = Pl_Mk_Positive(longs);

  //nb_sol = 0;
  res = Pl_Query_Call(func, 2, arg);
  /*while (res){
    res = Pl_Query_Next_Solution();
    return_value = Pl_Rd_Integer(arg[3]);
  }*/
  Pl_Query_End(PL_KEEP_FOR_PROLOG);
//stop prolog
}

int main(int argc, char **argv)
{
  Pl_Start_Prolog(argc, argv);

  unsigned char input[]="abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz";
  unsigned int longs=16;
  
  byteReverse(input,longs);
  //printf("%s\n",input);
  Pl_Stop_Prolog();

  return 0;
}
