#include "heap.h"
#include <stdlib.h>

#define RIGHT(i) (2*(i+1))
#define LEFT(i) ((2*i)+1)
#define PARENT(i) ((i-1)/2);

static void swap(void **a, void **b) {
  void *temp = *a;
  *a = *b;
  *b = temp;
}

static void hundir(BHeap heap, int pos) {
  int mayor = pos;
  if (LEFT(pos) <= heap->ultimo && heap->comp(heap->arr[LEFT(pos)], heap->arr[mayor]) > 0) mayor = LEFT(pos);
  if (RIGHT(pos) <= heap->ultimo && heap->comp(heap->arr[RIGHT(pos)], heap->arr[mayor]) > 0) mayor = RIGHT(pos);
  if (mayor != pos) {
    swap(&heap->arr[pos], &heap->arr[mayor]);
    hundir(heap, mayor);
  }
}

static void flotar(BHeap heap, int pos) {
  if (pos == 0) return;
  int pos_padre = PARENT(pos);
  if (heap->arr[pos] > heap->arr[pos_padre]) {
    swap(&heap->arr[pos], &heap->arr[pos_padre]);
    flotar(heap, pos_padre);
  }
}

BHeap bheap_crear(int capacidad, FuncionComparadora comp, FuncionCopiadora copy, FuncionDestructora destroy) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = malloc(sizeof(void*) * capacidad);
  heap->capacidad = capacidad;
  heap->ultimo = -1;
  heap->comp = comp;
  heap->copy = copy;
  heap->destroy = destroy;

  return heap;
}

BHeap bheap_crear_desde_arr(void **arr, int n, FuncionCopiadora copy, FuncionComparadora comp, FuncionDestructora destroy) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = arr;
  heap->capacidad = n;
  heap->ultimo = n-1;
  heap->comp = comp;
  heap->copy = copy;
  heap->destroy = destroy;

  for (int i = n/2 ; i >= 0 ; i--)
    hundir(heap, i);

  return heap;
}

void bheap_destruir(BHeap heap) {
  bheap_recorrer(heap, heap->destroy);
  free(heap->arr);
  free(heap);
}

void bheap_recorrer(BHeap heap, FuncionVisitante visit) {
  for (int i = 0 ; i < heap->ultimo ; i++)
    visit(heap->arr[i]);
}

int bheap_es_vacio (BHeap heap) {
  return heap->ultimo == -1;
}

BHeap bheap_insertar (BHeap heap, void *dato) {
  if (heap->ultimo + 1 == heap->capacidad) {
    heap->capacidad = heap->capacidad*2;
    heap = realloc(heap, sizeof(void*) * heap->capacidad);
  }

  heap->ultimo++;
  heap->arr[heap->ultimo] = heap->copy(dato);

  flotar(heap, heap->ultimo);

  return heap;
}

BHeap bheap_eliminar(BHeap heap, int pos) {
  if (bheap_es_vacio(heap)) return NULL;

  void *elem = heap->arr[pos];
  heap->arr[pos] = heap->arr[heap->ultimo];
  heap->ultimo--;

  heap->destroy(elem);

  int pos_padre = PARENT(pos);
  if (pos > 0 && heap->comp(heap->arr[pos], heap->arr[pos_padre]) > 0)
    flotar(heap,pos);
  else
    hundir(heap,pos);

  return heap;
}

void* bheap_pop (BHeap heap) {
  void *max = heap->arr[0];
  heap->arr[0] = heap->arr[heap->ultimo];
  heap->ultimo--;
  hundir(heap,0);
  return max;
}

static void no_copia (void *dato){
  return dato;
}

static void no_destruye (void *dato) {
  (void)dato;
  return;
}

void bheap_sort(void **arr, int n, FuncionComparadora comp) {
  BHeap heap = bheap_crear_desde_arr(arr, n, no_copia, comp, no_destruye);
  for (int i = n-1 ; i >= 0 ; i--) {
    void *max = bheap_pop(heap);
    heap->arr[i] = max;
  }
  free(heap);
}

