#include <stdio.h>
#include <gprolog.h>


int bar(int,int, int);

int
main(int argc, char **argv)
{

  Pl_Start_Prolog(argc, argv);
  int x=0;
  int input;
  int y=10;

 
  scanf("%d",&input);

  int z;
  z=bar(input,x,y);
  printf("%d\n",z);
  Pl_Stop_Prolog();

  return 0;

}

int bar(int input,int x,int y){
    int ret;
    if(input<5){
	ret=x+1;
    }else{
	ret=y+1;	
    } 
    return ret; 
}
