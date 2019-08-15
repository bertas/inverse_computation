// ./factorial 6 
// output: 6! = 720
#include "stdio.h"
#include<gprolog.h>

int main(int argc, char *argv[])
{
	Pl_Start_Prolog(argc, argv);
	int i;
	int input = atoi(argv[1]);
	int fac = 1;

	for(i = 1; i <= input; i++) {
		fac *= i;
	}

//	cout << input << "! = " << fac << endl;
	printf("%d! = %d\n", input, fac);
	Pl_Stop_Prolog();
	return 0;
}

