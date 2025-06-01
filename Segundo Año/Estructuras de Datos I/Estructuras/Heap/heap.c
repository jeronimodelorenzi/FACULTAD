#include "heap.h"
#include <stdlib.h>

BHeap bheap_crear(int capacidad, FuncionComparadora comp) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = malloc(sizeof(void*)*capacidad);
  heap->capacidad = capacidad;
  heap->ultimo = -1;
  heap->comp = comp;
  return heap;
}