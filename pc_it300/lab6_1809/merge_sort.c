#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

void merge(int *x, int l, int m, int r) {
	int n1 = m-l+1;
	int n2 = r-m;
	int L[n1], R[n2], i,j,k;

	for (i = 0; i < n1; i++)
        L[i] = x[l + i];
    for (j = 0; j < n2; j++)
        R[j] = x[m+1 + j];
	i = j = k = 0;

	while (i < n1 && j < n2) {
		if (L[i] <= R[j])
			x[k++] = L[i++];
		else
			x[k++] = R[j++];
	}
	while (i < n1)
        x[k++] = L[i++];
    while (j < n2)
        x[k++] = R[j++];
}

void mergesort(int *x, int l, int r) {
	if (l < r) {
		int m = l + (r-l)/2;
		mergesort(x, l, m);
		mergesort(x, m+1, r);
		merge(x, l, m, r);
	}
}

int main(int argc, char const *argv[]) {

	if (argc != 2){
		printf("usage : use commmandline argument for size of array\n");
		exit(-1);
	}
	int i, n = strtol(argv[1], NULL, 10);

	int *array = calloc(n, sizeof(int));

	struct timeval tstart, tend;
	struct timezone temp;

	#pragma omp parallel for private(i) num_threads(4)
	for (i = 0; i < n; i++)
			array[i] = rand();

	gettimeofday(&tstart, &temp);
	#pragma omp parallel shared(array, n) num_threads(4)
	{
		mergesort(array, 0, n-1);
	}

	gettimeofday(&tend, &temp);

	printf("Time taken %lf\n",
		((tend.tv_sec * 1000000 + tend.tv_usec) - (tstart.tv_sec * 1000000 + tstart.tv_usec))/1000000.0
	);

	free(array);

	return 0;
}
