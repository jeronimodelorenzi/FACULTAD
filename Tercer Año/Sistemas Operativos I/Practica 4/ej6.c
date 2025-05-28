/*
Dado que las llamadas recursivas para ordenar las “mitades” del arreglo son independientes, son un claro
candidato para paralelizar.
Como primer intento, escriba una versi´on que use pthread_create para paralelizar las llamadas
recursivas. Compare el rendimiento con la versi´on secuencial para distintos tama˜nos del array. ¿Hay
alg´un problema? Explique.
Escriba una versi´on que paralelice las llamadas usando sections de OpenMP. ¿Mejora la perfor-
mance? ¿Cu´anto? Puede usar el servidor labdcc para probar en un quad-core.
Escriba una versi´on usando tasks de OpenMP y mida el cambio en rendimiento.
*/

#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include "timing.h"

#define N 1000000
int A[N];

void swap(int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}

int particionar(int a[], int n) {
  int i, j = 0;
  int p = a[0];

  swap(&a[0], &a[n - 1]);
  for (i = 0; i < n - 1; i++) {
    if (a[i] <= p)
      swap(&a[i], &a[j++]);
  }
  swap(&a[j], &a[n - 1]);
  return j;
}

void quicksort_par(int a[], int n) {
  if (n < 2)
    return;
  int p = particionar(a, n);
    
  #pragma omp parallel sections
  {
    #pragma omp section
    quicksort_par(a, p);

    #pragma omp section
    quicksort_par(a + p + 1, n - p - 1);
  }
}

void quicksort_sec(int a[], int n) {
  if (n < 2)
    return;
  int p = particionar(a, n);
  quicksort_sec(a, p);
  quicksort_sec(a + p + 1, n - p - 1);
}

void quicksort_task(int a[], int n) {
  if (n < 2)
    return;
  int p = particionar(a,n);

  #pragma omp task
  quicksort_task(a,p);

  #pragma omp task
  quicksort_task(a+p+1, n-p-1);

  #pragma omp taskwait    
}

void fun() {
  #pragma omp parallel
  {
    #pragma omp single
    {
      quicksort_task(A,N);
    }    
  }
}

int main() {

  long int i;
  for (i = 0; i < N; i++) {
    A[i] = random() % 1000;
  }

  omp_set_num_threads(4);

  // for (long int j = 0 ; j < N ; j++)
  //     printf("A[%ld] = %d\n", j, A[j]);

  float fv;
  TIME_void(fun(), &fv);

  //for (long int j = 0 ; j < N ; j++)
  //     printf("A[%ld] = %d\n", j, A[j]);

  return 0;
}