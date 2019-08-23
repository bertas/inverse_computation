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

  unsigned int mem = (unsigned int) memory_address;
  printf("%u\n",mem);
  char** str=(char**) mem;
  
  *res= atoi(*str);

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


//word in '' in prolog would be regarded as str.
/*PlBool atoi_wrapper(PlLong input, PlLong* res){
  *res=input;
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}*/

