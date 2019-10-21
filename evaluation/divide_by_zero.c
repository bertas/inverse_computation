/*************************************************************************
	> File Name: dividebyzero.c
	> Author:
	> Mail:
	> Created Time: Tue Oct 15 14:35:33 2019
 ************************************************************************/

#include "stdio.h"

int main(int argc, char *argv[]){
    int j = 8;
    int i = 65535;
    int output;
    while(j > 0)
    {
        output = i / (j-1);
        --j;
    }

    return 0;

}
