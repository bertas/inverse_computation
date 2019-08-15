#include <string.h>
#include <gprolog.h>
#include <stdio.h>

PlBool bit_move1_wrapper(double mem5double,double mem6double,double* tmpdouble){
  unsigned int mem5_addr=mem5double;
  unsigned int mem6_addr=mem6double;
  unsigned char* mem_5=(unsigned char*)mem5_addr;
  unsigned char* mem_6=(unsigned char*)mem6_addr;
  unsigned int tmp = (unsigned int)(((unsigned int )*mem_5 << 8) | (unsigned int )*mem_6);
  *tmpdouble=(double)tmp;
  if(tmpdouble==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}




PlBool bit_move2_wrapper(double tmpdouble,double mem7double,double mem8double,
double* tdouble){
  unsigned int tmp=tmpdouble;
  unsigned int mem7_addr=mem7double;
  unsigned int mem8_addr=mem8double;
  unsigned char* mem_7=(unsigned char*)mem7_addr;
  unsigned char* mem_8=(unsigned char*)mem8_addr;
  unsigned int t=(unsigned int )(tmp << 16) | (((unsigned int )*mem_7 << 8) | (unsigned int )*mem_8);
  *tdouble=(double)t;
  if(tdouble==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}

PlBool clear_bufs_ptr_assign(double outcntdouble, double inptrdouble, double insizedouble, double bytesoutdouble, double bytesindouble){
  unsigned int* outcnt_ptr = (unsigned int)outcntdouble;
  unsigned int* inptr_ptr= (unsigned int)inptrdouble;
  unsigned int* insize_ptr=(unsigned int)insizedouble;
  long* bytesout_ptr=(unsigned int)bytesoutdouble;
  long* bytesin_ptr=(unsigned int)bytesindouble;

  *outcnt_ptr=0U;
  *inptr_ptr=0U;
  *insize_ptr=*inptr_ptr;
  *bytesout_ptr=0L;
  *bytesin_ptr=*bytesout_ptr;

  if(bytesin_ptr==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}


PlBool ptr_dereference_update(double bufdouble ,double tdouble){
  unsigned int buf_addr=(unsigned int)bufdouble;
  unsigned int* mem9=(unsigned int*)buf_addr;
  unsigned int t= (unsigned int)tdouble;
  *mem9=t;

  //unsigned char* buf=(unsigned char*)buf_addr;
  //printf("%s\n",buf);

  if(mem9==NULL){
    return PL_FALSE;
  }else{
    return PL_TRUE;
  }
}



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


