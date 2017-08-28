#include <stdio.h>
#include <omp.h>

int main(int argc, char const *argv[]) {
	int n, thread_id;
	#pragma omp parallel private(n, thread_id)
	{
		// Get thread Number
		thread_id = omp_get_thread_num();
		printf("Hello world from thread = %d\n", thread_id);
		if (thread_id == 0) {
			n = omp_get_num_threads();
			printf("Number of threads = %d\n", n);
		}
	}
	return 0;
}
