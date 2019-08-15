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

PlBool str_pointer_dereference_wrapper(PlLong memory_address, char* res){
  res= memory_address;
  if(res==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}
