#include <stdio.h>
#include "algoritmos.h"

int main() {
  int a[] = {4,2,3,1};

  printf("Arreglo sin ordenar.\n");
  for(int i = 0 ; i < 4 ; i++)
    printf("a[%d] = %d\n", i, a[i]);

  merge_sort(a,4);

  printf("Arreglo odenador (Merge Sort)\n");
  for(int i = 0 ; i < 4 ; i++)
    printf("a[%d] = %d\n", i, a[i]);
}