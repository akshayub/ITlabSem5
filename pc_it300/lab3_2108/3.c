#include <sys/time.h>
#include <time.h>
#include <stdio.h>
#include <omp.h>
#include <limits.h>
#include <stdlib.h>

int main() {
    int min = INT_MAX;
    struct timeval TimeValue_Start;
    struct timezone TimeZone_Start;
    struct timeval TimeValue_Final;
    struct timezone TimeZone_Final;
    long time_start, time_end;
    double time_overhead;
    int i,n, a[100000];
    srand(time(NULL));

    printf("Enter the size of the array: ");
    scanf("%d",&n);

    for (i = 0; i < n; i++) {
        a[i] = rand();
    }
    gettimeofday(&TimeValue_Start, &TimeZone_Start);
    #pragma omp parallel private(i) shared(n)
    {
        #pragma omp for schedule(dynamic)
        for (i = 0; i < n; i++) {
            if (a[i] < min) {
                min = a[i];
            }
        }
    }
    gettimeofday(&TimeValue_Final, &TimeZone_Final);
    time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
    time_end = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
    time_overhead = (time_end - time_start)/1000000.0;
    printf("Time in Seconds (T) : %lf\n",time_overhead);
    // printf("The array: ");
    // for (i = 0; i < n; i++)
    //     printf("%d ",a[i]);
    // printf("\n");

    printf("The minimum element is %d\n", min);

}
