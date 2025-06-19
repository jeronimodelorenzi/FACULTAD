#include <stdlib.h>

/*
Defina una función:
BHeap bst_to_heap (BSTree arbol, FuncionComparadora comp);
que dado un árbol binario de búsqueda general y una función comparadora, construya un heap
con los datos presentes en el árbol. El heap resultante no debe tener copia física de los datos.
*/

#define SZ 100

typedef struct _BSTNodo {
  void *dato;
  struct _BSTNodo *izq;
  struct _BSTNodo *der;
} BSTNodo;

typedef BSTNodo *BSTree;

typedef int (*FuncionComparadora) (void *dato1, void* dato2);
typedef void* (*FuncionCopiadora) (void *dato);
typedef void (*FuncionDestructora) (void *dato);

typedef struct _BHeap {
  void **arr;
  int capacidad;
  int ultimo
} *BHeap;

void bst_to_heap_aux (BSTree arbol, BHeap *heap) {
  if (arbol == NULL) return NULL;
  bst_to_heap_aux (arbol->der, heap);
  (*heap)->arr[(*heap)->ultimo] = arbol->dato;
  bst_to_heap_aux (arbol->izq, heap);
}

BHeap bst_to_heap (BSTree arbol, FuncionComparadora comp) {
  if (arbol == NULL) return NULL;
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->capacidad = SZ;
  heap->arr = malloc(sizeof(void*)*heap->capacidad);
  heap->ultimo = -1;
  bst_to_heap_aux(arbol, &heap);
  return heap;
}
