#include <stdio.h>
#include <omp.h>

int main(int argc, char const *argv[]) {
	#pragma omp parallel
	{
		// Get thread Number
		int thread_id = omp_get_thread_num();
		printf("Thread id = %d\n", thread_id);
		printf("Sum till id is %d\n", thread_id*(thread_id+1)/2);

		if (thread_id == 0) {
			printf("Number of threads = %d\n", omp_get_num_threads());
		}
	}
	return 0;
}
