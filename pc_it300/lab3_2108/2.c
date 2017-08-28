#include <stdio.h>
#include <sys/time.h>
#include <omp.h>
#include <stdlib.h>

int main() {
    struct timeval TimeValue_Start;
    struct timezone TimeZone_Start;
    struct timeval TimeValue_Final;
    struct timezone TimeZone_Final;

    long time_start, time_final;
    double time_overhead;

    double pi, x;
    int i, N;
    pi = 0.0;
    N = 1000;

    gettimeofday(&TimeValue_Start, &TimeZone_Start);

    #pragma omp parallel for private(x) reduction(+:pi)
    for (i = 0; i < N; i++) {
        x = (double) i / N;
        pi += 4 / (1 + x*x);
    }
    gettimeofday(&TimeValue_Final, &TimeZone_Final);
    time_start = TimeValue_Start.tv_sec * 1000000 + TimeValue_Start.tv_usec;
    time_final = TimeValue_Final.tv_sec * 1000000 + TimeValue_Final.tv_usec;
    time_overhead = (time_final - time_start) / 1000000.0;

    printf("Time in seconds: %lf\n", time_overhead);
    pi /= N;
    printf("Pi is %f\n",pi);
}
