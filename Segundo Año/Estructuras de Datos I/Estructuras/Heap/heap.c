#include "heap.h"
#include <stdlib.h>

BHeap bheap_crear (int capacidad, FuncionComparadora comp) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = malloc(sizeof(void*)*capacidad);
  heap->capacidad = capacidad;
  heap->ultimo = -1;
  heap->comp = comp;
  return heap;
}

void bheap_destruir (BHeap heap) {
  free(heap->arr);
  free(heap);
}

int bheap_es_vacio (BHeap heap) {
  return heap->ultimo == -1;
}

void bheap_recorrer (BHeap heap, FuncionVisitante visit) {
  for (int i = 0 ; i < heap->ultimo ; i++)
    visit(heap->arr[i]);
}

static int padre (int nodo) {
  return nodo/2;
}

BHeap bheap_insertar (BHeap heap, void *dato) {
  if (heap->ultimo == heap->capacidad-1) {
    heap->capacidad *= 2;
    heap->arr = realloc(heap->arr, sizeof(void*) * heap->capacidad);
  }

  heap->ultimo++;
  heap->arr[heap->ultimo] = dato;

  for (int nodo = heap->ultimo; nodo > 1 && heap->comp(heap->arr[nodo], heap->arr[padre(nodo)] > 0); nodo = padre(nodo)) {
    void* temp = heap->arr[nodo];
    heap->arr[nodo] = heap->arr[padre(nodo)];
    heap->arr[padre(nodo)] = temp;
  }

  return heap;
}

BHeap bheap_eliminar (BHeap heap, void* dato) {
  
}