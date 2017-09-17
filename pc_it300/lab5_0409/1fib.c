#include <stdio.h>
#include <omp.h>

int fib(long long int n) {
    long long int i,j;
    if (n == 0 || n == 1) {
        return n;
    }
    else {
        #pragma omp task shared(i,n)
        i = fib(n-1);

        #pragma omp task shared(j,n)
        j = fib(n-2);

        #pragma omp taskwait
        return i + j;
    }
}


int main() {

    long long int ans, n;
    printf("Enter the index of fibonacci number to return: ");
    scanf("%lld",&n);

    #pragma omp parallel shared(n)
    {
        ans = fib(n);
    }

    printf("The answer: %lld\n",ans);

}
