#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "timing.h"
#define N 4

int A[N][N], B[N][N], C[N][N];
int BT[N][N];

void mult(int A[N][N], int B[N][N], int C[N][N]) {
  
  int i, j, k;
  #pragma omp parallel for private(i,j,k)
    for (i = 0; i < N; i++) {
      for (j = 0; j < N; j++) {
        C[i][j] = 0;
        for (k = 0; k < N; k++) {
          C[i][j] += A[i][k] * B[k][j];
        }
      }
    }
}

/*Más rápido porque se accede por filas ambas matrices. */
void mult_traspuesta(int A[N][N], int B[N][N], int C[N][N]) {
  int i, j, k;

  #pragma omp parallel for private(i,j,k)
    for (i = 0; i < N; i++) {
      for (j = 0; j < N; j++) {
        int sum = 0;
        for (k = 0; k < N; k++) {
          sum += A[i][k] * B[j][k];
        }
        C[i][j] = sum;
      }
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
      A[i][j] = i;
      B[i][j] = j;
    }
  }
  omp_set_num_threads(4);

  float fv;
  TIME_void(mult_traspuesta(A,B,C), &fv);

  for (i = 0 ; i < N ; i++) {
    for (j = 0 ; j < N ; j++) {
      printf("C[%d][%d] = %d\n", i, j, C[i][j]);
    }
  }

  return 0;
}