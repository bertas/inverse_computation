// 

#include "stdio.h"
#include<gprolog.h>

int Fibonacci(int n) {
	int fib = 0;
	if((n == 1) || (n == 2)) {
		fib = 1;
	} else {
		fib = Fibonacci(n - 1) + Fibonacci(n - 2);
	}
	
	return (fib);
}

int main(int argc, char *argv[])
{
	Pl_Start_Prolog(argc, argv);
	int input = atoi(argv[1]);
	int fib = Fibonacci(input);

	printf("Fibonacci of input %d = %d\n", input, fib);
	Pl_Stop_Prolog();
	return 0;
	
}
