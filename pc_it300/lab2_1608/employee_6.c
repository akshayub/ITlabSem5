#include <stdio.h>
#include <math.h>
#include <omp.h>

int main(int argc, char const *argv[]) {

	int i,n;
	printf("Enter number of employees\n");
	scanf("%d", &n);
	int salaries[n];
	printf("Enter salaries of %d employees\n", n);
	for (size_t i = 0; i < n; i++) {
		scanf("%d", &salaries[i]);
	}
	int result = 0;
	double incr;
	#pragma omp parallel for private(i) reduction(+:result) schedule(static, 5)
		for(i=0;i<n;i++){
			double tax=0;
			incr = 0.06*(double)salaries[i];
			if ( (int)round(incr) > 5000 ){
				tax = 0.02*(double)(incr-5000);
			}
			incr -= tax;
			result += incr;
			printf("emp %d incr = %.2lf  tax = %.2lf\n", i, incr, tax);
		}

	printf("The total increase is %d\n", result);

	return 0;
}
