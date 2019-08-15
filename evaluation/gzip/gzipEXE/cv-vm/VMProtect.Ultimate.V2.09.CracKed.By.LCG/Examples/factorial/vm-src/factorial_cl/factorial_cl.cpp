// factorial_cl.cpp : Defines the entry point for the console application.
//
#include <stdio.h>
#include "stdafx.h"
#include <stdlib.h>
#include <string.h>
#include <windows.h>
#include "VMProtectSDK.h"

int main(int argc, char *argv[])
{
VMProtectBegin("main");	
	int i;
	int input = atoi(argv[1]);
	int fac = 1;


	for(i = 1; i <= input; i++) {
		fac *= i;
	}


	printf("%d! = %d\n", input, fac);
	return 0;
VMProtectEnd();   
}

