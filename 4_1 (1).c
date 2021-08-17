#include <stdio.h>
#include <omp.h>
#include <stdlib.h>

typedef unsigned long long uL;

#define fi_x0 0
#define l 1
#define c 1

uL t_n = 10;
int N = 7;
double a = 0;
double b = 1;
double T = -1;
double tau = -1;
double h = -1;

double u_next(double left, double mid, double right)
{
    return mid + 0.3 * (right - 2 * mid + left);
}

int main(int argc, char const *argv[])
{

    int i = 1;
    FILE * out, * out_time;
    double t1 = omp_get_wtime(), t2, * u1, * u2;
    out = fopen("out.txt", "w");
    out_time = fopen("time.txt", "w");

    if (argc > 1) {
        N = atoi(argv[1]);
        T = atoi(argv[2]);
    }

    h = (double) l / N;
    tau = 0.3 * h * h / c;
    t_n = (uL) (T / tau);
    
    // u1 = (double * ) calloc((size_t) N + 1, sizeof(double));
    // u2 = (double * ) calloc((size_t) N + 1, sizeof(double));

    double ** u = (double ** ) calloc((size_t) 2, sizeof(double * ));
    u[0] = (double * ) calloc((size_t) N + 1, sizeof(double));
    u[1] = (double * ) calloc((size_t) N + 1, sizeof(double));

    for ( i = 0; i < N + 1; i++) {
        u[0][i] = fi_x0;
    }
    u[0][0] = a;
    u[0][N] = b;

    #pragma omp parallel
    {
        uL t;
        int j;
        for (t = 0; t < t_n + 1; t++) {
        #pragma omp for schedule (static)
            for (j = 1; j < N; j++) {
                u[1][j] = u_next(u[0][j - 1], u[0][j], u[0][j + 1]);
            }
            #pragma omp single
            {
                for (j = 1; j < N; j++) {
                    u[0][j] = u[1][j];
                }
            }
        }
    }

    for (i = 0; i < N + 1; i++) {
        fprintf(out, "%.5lf\n", u[0][i]);
    }
    t2 = omp_get_wtime();

    fprintf(out_time, "%.3lf\n", t2 - t1);

    fclose(out_time);
    fclose(out);
    free(u[0]);
    free(u[1]);
    free(u);
    return 0;
}