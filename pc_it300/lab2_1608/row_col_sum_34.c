#include <stdio.h>
#include <omp.h>

int main() {
    int a[4][4] = {1,1,1,1,1,2,3,4,2,4,6,8,3,6,9,12};
    int rowsum[4] = {0};
    int colsum[4] = {0};
    int i, j, tid;

    #pragma omp parallel shared(rowsum, colsum, a) private(i,j,tid)
    {
        #pragma omp for collapse(2) schedule(static, 4)
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {
                tid = omp_get_thread_num();
                printf("Using thread %d at %d,%d\n",tid,i,j);
                rowsum[i] += a[i][j];
                colsum[j] += a[i][j];
            }
        }
    }
    for (i = 0; i < 4; i++) {
        printf("Row sum of %d = %d , Column sum of %d = %d\n",i,rowsum[i],i,colsum[i]);
    }
}
