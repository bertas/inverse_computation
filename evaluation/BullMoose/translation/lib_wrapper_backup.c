#include "gprolog.h"
#include <string.h>

#include <stdio.h>
//#include <Windows.h>
//#include <ShellAPI.h>









PlBool fclose_wrapper(double file_address){
  unsigned int mem= (unsigned int) file_address;
  FILE* file= (FILE*)mem;
  fclose(file);
  if(file==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool fopen_wrapper(double file_name, char* at, double* res){
  unsigned int mem =(unsigned int) file_name;
  char* name = (char*) mem;
  FILE* file=fopen(name,at);
  unsigned int file_handler =(unsigned int)file;
  *res= (double)file_handler;
  

  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}


PlBool fputs_wrapper(double string_addr,double file_addr){
  unsigned int string_mem = (unsigned int)string_addr;
  unsigned int file_mem = (unsigned int)file_addr;
  char* inspect = (char*)string_mem;
  FILE* file =(FILE*) file_mem;
  fputs(inspect,file);


  if(file==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool shellexecute_wrapper(double addr){
  unsigned int mem = (unsigned int) addr;
  char* argv1 = (char*)mem;
  //ShellExecute(NULL,"open","\"C:\\Program Files\\Internet Explorer\\iexplore.exe\"",argv1,NULL,SW_SHOW); 
  printf("%s\n","\"C:\\Program Files\\Internet Explorer\\iexplore.exe\"");

  if(argv1==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}


PlBool setfileattributes_wrapper(double argv1, PlLong file_attribute){
  unsigned int mem = (unsigned int)argv1;
  char* argv1_string = (char*)mem;
  //SetFileAttributes(argv1_string,file_attribute);


  if(argv1_string==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

//word in '' in prolog would be regarded as str.
/*PlBool atoi_wrapper(PlLong input, PlLong* res){
  *res=input;
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}*/



