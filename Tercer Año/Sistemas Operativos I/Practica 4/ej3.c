/*
Escriba utilizando OpenMP un algoritmo que dado un arreglo de
N = 5 × 108 enteros busque el m´ınimo. Compare la performance con la implementaci´on secuencial con
distinto n´umero de hilos.
*/

#include <stdio.h>
#include <omp.h>
#include "timing.h"

#define SIZE 500000000

int arr[SIZE];

void fun() {
  int min = arr[0];
  #pragma omp parallel for shared(min)
  for (long int i = 1 ; i < SIZE ; i++)
    #pragma omp critical
    {
      if (arr[i] < min)
      min = arr[i];
    }
     printf("Minimo del arreglo: %d\n", min);
}

int main () {
  for (int long i = 0 ; i < SIZE ; i++)
    arr[i] = 100;

  arr[8000] = 50;
  
  float fv;
  TIME_void(fun(), &fv);
    
 return 0;
}