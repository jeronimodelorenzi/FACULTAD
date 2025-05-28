#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "timing.h"
#define N 1000

int A[N][N], B[N][N], C[N][N];

void mult(int A[N][N], int B[N][N], int C[N][N]) {
  
  int i, j, k;
  #pragma omp parallel 
  {
    #pragma omp for private(i,j,k)
    for (i = 0; i < N; i++)
      for (j = 0; j < N; j++)
        for (k = 0; k < N; k++)
          C[i][j] += A[i][k] * B[k][j];
  }
}

void multsec(int A[N][N], int B[N][N], int C[N][N]) {
  int i, j, k;
  
  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
      for (k = 0; k < N; k++)
        C[i][j] += A[i][k] * B[k][j];
}

int main() {
  int i, j;
  for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
      A[i][j] = random() % 2;
      B[i][j] = random() % 2;
    }
  }
  omp_set_num_threads(4);

  mult(A, B, C);

  float fv;
  TIME_void(mult(A,B,C), &fv);

//   for (i = 0 ; i < N ; i++) {
//     for (j = 0 ; j < N ; j++) {
//       printf("C[%d][%d] = %d\n", i, j, C[i][j]);
//     }
//   }

  return 0;
}