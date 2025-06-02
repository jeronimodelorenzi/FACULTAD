#ifndef __HEAP_H__
#define __HEAP_H__

typedef int (*FuncionComparadora)(void *, void*);
typedef void (*FuncionVisitante)(void *);

typedef struct _BHeap {
  void **arr;
  int capacidad;
  int ultimo;
  FuncionComparadora comp;
} *BHeap;

/**
 * Crea un heap vacío. 
 */
BHeap bheap_crear(int capacidad, FuncionComparadora comp);

/**
 * Destruye el heap.
 */
void bheap_destruir(BHeap heap);

/**
 * Retorna 1 si el heap está vacío y 0 en caso contrario.
 */
int bheap_es_vacio(BHeap heap);

/**
 * Recorre los nodos utilizando búsqueda por extensión.
 */
void bheap_recorrer(BHeap heap, FuncionVisitante visit);

/**
 * Agrega un elemento al heap, realocando el arreglo en caso de ser necesario.
 */
BHeap bheap_insertar(BHeap heap, void *dato);

/**
 * Elimina un elemento del heap.
 */
BHeap bheap_eliminar(BHeap heap, int index);
#endif 