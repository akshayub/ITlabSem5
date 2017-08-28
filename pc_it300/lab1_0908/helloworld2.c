#include <stdio.h>
#include <omp.h>

int main(int argc, char const *argv[]) {
	int n, thread_id;
	int i=10;

	// Choose one of the below and compile
	// #pragma omp parallel private(n, thread_id) shared(i)
	// #pragma omp parallel private(n, thread_id, i)
	#pragma omp parallel private(n, thread_id) firstprivate(i)
	{
		// Get thread Number
		thread_id = omp_get_thread_num();
		printf("Hello world from thread = %d, i = %d\n", thread_id, i);
		i++;
		printf("Hello world from thread = %d, i = %d after i increment\n", thread_id, i);
		if (thread_id == 0) {
			n = omp_get_num_threads();
			printf("Number of threads = %d\n", n);
		}
	}
	return 0;
}
