//

#include "stdio.h"


int main(int argc, char *argv[])
{
	int i, j, k;
	int input = 1;
	int m1 [3][3];
	int m2 [3][3];
	int prod [3][3];

	if(argc != 19) printf("Need 2 3x3 integer matrices\n");

	//load first 9 values into m1 matrix
	for(i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			m1[i][j] = atoi(argv[input++]);
		}
	}
	//load last 9 values into m2 matrix
	for(i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			m2[i][j] = atoi(argv[input++]);
		}
	}

	//initialize prod
	for(i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			prod[i][j] = 0;
		}
	}

	//calculate prod = m1 x m2
	for(i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			for(k = 0; k < 3; k++) {
				prod[i][j] += m1[i][k]*m2[k][j];
			}
		}
	}

	//print out product of m1 x m2
	for(i = 0; i < 3; i++) {
		for(j = 0; j < 3; j++) {
			printf("%d ", prod[i][j]);
		}
        printf("\n");
	}
        
	return 0;
}

