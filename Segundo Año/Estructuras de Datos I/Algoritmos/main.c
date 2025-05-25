#include "algoritmos.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
  int a[] = {4,2,3,1};

  printf("Arreglo sin ordenar.\n");
  for(int i = 0 ; i < 4 ; i++)
    printf("a[%d] = %d\n", i, a[i]);

  quick_sort(a,4);

  printf("Arreglo odenado (Merge Sort)\n");
  for(int i = 0 ; i < 4 ; i++)
    printf("a[%d] = %d\n", i, a[i]);

  return 0;
}