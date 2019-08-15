#include <string.h>
#include "gprolog.h"
#include <stdio.h>
#include "Windows.h"
#include <shellapi.h>



PlBool strlen_wrapper(char* input,PlLong* length){
  
  *length=strlen(input);
  if(length==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool ptr_dereference(double memory_address, PlLong* res){
  printf("%s\n","ssssssssssssss");
  unsigned int mem = (unsigned int) memory_address;
  printf("%u\n",mem);
  char** str=(char**) mem;
  
  *res= atoi(*str);
  printf("%s\n","bbbbbbbbbbbbbb");
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool string_ptr_dereference(double memory_address, char* res){
  printf("%s\n","ssssssssssssss");
  unsigned int mem = (unsigned int) memory_address;
  printf("%u\n",mem);
  char** str=(char**) mem;
  res = *str;
  //*res= atoi(*str);
  printf("%s\n","bbbbbbbbbbbbbb");
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool char_ptr_dereference(double memory_address, PlLong* res){
  printf("%s\n","ssssssssssssss");
  unsigned int mem = (unsigned int) memory_address;
  printf("%u\n",mem);
  char* ch=(char*) mem;
  
  res=ch;
  printf("%s\n","bbbbbbbbbbbbbb");
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}


PlBool atoi_wrapper(char* input, PlLong* res){
  *res=atoi(input);
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool sprintf_wrapper(PlLong pid,char* res){
  char command[255] = {0};
  sprintf(command, "taskkill /F /PID %d", pid);
  res=command;
   
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool system_wrapper(char* cammand){
  system(cammand);
  
  char* res=cammand;
    if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool findprocessid_wrapper(char* task, PlLong* res){
  int pid=1000090;
  res=&pid;
  
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}



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
  ShellExecute(NULL,"open","\"C:\\Program Files\\Internet Explorer\\iexplore.exe\"",argv1,NULL,SW_SHOW); 
  

  if(argv1==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}


PlBool setfileattributes_wrapper(double argv1, PlLong file_attribute){
  unsigned int mem = (unsigned int)argv1;
  char* argv1_string = (char*)mem;
  SetFileAttributes(argv1_string,file_attribute);


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


