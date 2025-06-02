#include "heap.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SIZE 10

int comparar_entero (void *dato1, void *dato2) {
  int n1 = *(int*)dato1;
  int n2= *(int*)dato2;
  return n1-n2;
}

void imprimir_entero (void *dato) {
  printf("%d ", *(int*)dato);
}

int main () {
  srand(time(NULL));

  BHeap heap = bheap_crear(SIZE, comparar_entero);
  printf("Vacio: %d\n", bheap_es_vacio(heap));

  int arr[] = {86, 93, 83, 92, 86, 35, 77, 15, 49, 21};
//   for (int i = 0 ; i < SIZE ; i++)
//     arr[i] = rand() % 100;

  for (int i = 0 ; i < SIZE ; i++)
    heap = bheap_insertar(heap, &arr[i]);

  bheap_recorrer(heap, imprimir_entero);
  puts("");

  bheap_destruir(heap);

  return 0;
}