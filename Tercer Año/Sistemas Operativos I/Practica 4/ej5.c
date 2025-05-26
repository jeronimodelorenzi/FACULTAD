#include <stdio.h>
#include <stdlib.h>
#include "timing.h"
#define N 1000

int A[N][N], B[N][N], C[N][N];

void mult(int A[N][N], int B[N][N], int C[N][N]) {
  int i, j, k;
  
  #pragma omp parallel private(i,j,k)
  {
  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
      #pragma omp for
        for (k = 0; k < N; k++)
        C[i][j] += A[i][k] * B[k][j];
  }
}

void mult_sec(int A[N][N], int B[N][N], int C[N][N]) {
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
      A[i][j] = random() % 1000;
      B[i][j] = random() % 1000;
    }
  }

  mult(A, B, C);
  mult_sec(A,B,C);
  float fv;
  TIME_void(mult(A,B,C), &fv);
  // TIME_void(mult_sec(A,B,C), &fv);

//   for (i = 0 ; i < N ; i++) {
//     for (j = 0 ; j < N ; j++) {
//       printf("C[%d][%d] = %d\n", i, j, C[i][j]);
//     }
//   }

  return 0;
}