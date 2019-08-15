#include <string.h>
#include <stdio.h>
#include <gprolog.h>
PlBool strlen_wrapper(char* input,PlLong* length){
  printf("%s\n","great");
  *length=strlen(input);
  if(length==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}
