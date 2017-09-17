#include <stdio.h>
#include <omp.h>
#include <stdlib.h>
#include <sys/time.h>

int main(int argc, char const *argv[]) {

	if (argc != 2){
		printf("usage : use commmandline argument for size of matrix\n");
		exit(-1);
	}
	int n = strtol(argv[1], NULL, 10);
	int i,j,k;
	int x[500][500], y[500][500], z[500][500];

	struct timeval tstart, tend;
	struct timezone temp;

	long startTime, endTime;
	double overhead;

	#pragma omp parallel for private(i,j) collapse(2)
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            x[i][j] = rand();
            y[i][j] = rand();
        }
    }

	gettimeofday(&tstart, &temp);
    #pragma omp parallel for schedule(static) collapse(2) private(i,j,k)
	for(i=0; i<n; i++){
        for (k=0; k<n; k++){
            for (j=0; j<n; j++){
                z[i][k] += x[i][j]*y[j][k];
            }
        }
    }
	gettimeofday(&tend, &temp);

	startTime = tstart.tv_sec * 1000000 + tstart.tv_usec;
	endTime = tend.tv_sec * 1000000 + tend.tv_usec;
	overhead = (endTime - startTime)/1000000.0;

	printf("Time for %d : %lf\n", n, overhead);

	return 0;
}
