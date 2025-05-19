/*
Escriba utilizando OpenMP un algoritmo que calcule la suma de un arreglo
de N = 5 × 10^8 doubles. Compare la performance con la implementaci´on secuencial usando distintos
n´umeros de hilos. Compare tambi´en con una versi´on paralela que usa un mutex para proteger la variable
que lleva la suma.
*/

#include <stdio.h>
#include <omp.h>
#include "timing.h"

#define SIZE 500000

int arr[SIZE];
long int suma = 0;

void sumar_arreglo_omp() {
  #pragma omp parallel for reduction(+:suma)// también se puede usar reduction(+:suma);
    for (int i = 0 ; i < SIZE ; i++){
      //#pragma omp atomic
      suma += arr[i];
      printf("Thread %d: suma = %ld\n", omp_get_thread_num(), suma);
    }
  printf("Suma total: %ld", suma);
}

void sumar_arreglo

int main () {

  for ( int i = 0 ; i < SIZE ; i++)
    arr[i] = 3;

  float fv;
  TIME_void(sumar_arreglo_omp(), &fv);
  return 0;
}
