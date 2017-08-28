#include <stdio.h>
#include <omp.h>

int main() {
    int a,b,p,q,i,j,k;
    int x[100][100], y[100][100], z[100][100] = {0};
    printf("Enter the size of the matrix X[a][b] and Y[p][q] in (a b p q format): ");
    scanf("%d%d%d%d",&a,&b,&p,&q);
    if (b != p) {
        printf("Invalid sizes!\n");
        return 1;
    }
    printf("Enter the elements of the matrix X:\n");
    for (i = 0; i < a; i++) {
        for (j = 0; j < b; j++) {
            scanf("%d",&x[i][j]);
        }
    }
    printf("Enter the elements of the matrix Y:\n");
    for (i = 0; i < p; i++) {
        for (j = 0; j < q; j++) {
            scanf("%d",&y[i][j]);
        }
    }

    #pragma omp parallel shared(x,y,z) private(i,j,k)
    {
        #pragma omp for collapse(3) schedule(dynamic, p)
        for(i = 0; i < a; i++) {
            for (j = 0; j < q; j++) {
                for (k = 0; k < p; k++) {
                    z[i][j] += x[i][k] * y[k][j];
                }
            }
        }
    }

    printf("The final matrix:\n");

    for (i = 0; i < a; i++) {
        for (j = 0; j < q; j++) {
            printf("%d ", z[i][j]);
        }
        printf("\n");
    }

}
