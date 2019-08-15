#include <string.h>
#include <gprolog.h>
#include <stdio.h>



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


//word in '' in prolog would be regarded as str.
/*PlBool atoi_wrapper(PlLong input, PlLong* res){
  *res=input;
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}*/


