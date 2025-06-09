#include "algoritmos.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SZ 100000

int main() {

  srand(time(NULL));

  int a[SZ];

  printf("Arreglo sin ordenar.\n");
  for(int i = 0 ; i < SZ ; i++){
    a[i] = rand() % 1000;
    printf("a[%d] = %d\n", i, a[i]);
  }

  selection_sort(a,SZ);

  printf("Arreglo odenado \n");
  for(int i = 0 ; i < SZ ; i++)
    printf("a[%d] = %d\n", i, a[i]);

  return 0;
}