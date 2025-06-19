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
  int ultimo;
} *BHeap;

void bst_to_heap_aux (BSTree arbol, BHeap *heap) {
  if (arbol == NULL) return NULL;
  bst_to_heap_aux (arbol->der, heap);
  (*heap)->arr[(*heap)->ultimo++] = arbol->dato;
  bst_to_heap_aux (arbol->izq, heap);
}

BHeap bst_to_heap (BSTree arbol, FuncionComparadora comp) {
  if (arbol == NULL) return;
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->capacidad = SZ;
  heap->arr = malloc(sizeof(void*)*heap->capacidad);
  heap->ultimo = -1;
  bst_to_heap_aux(arbol, &heap);
  return heap;
}

/*
Defina una función
AVL sorted_arr_to_avl (void **arr, int n);
que, dado un arreglo ordenado de datos y un entero n que indica el largo del arreglo,
construya un árbol AVL que contenga los datos del arreglo (sin hacer copias fisicas).
No puede utilizarse la función insertar para arboles AVL.
*/

typedef struct _AVL_Nodo {
  void *dato;
  struct _AVL_Nodo* izq, *der;
  int altura;
} AVL_Nodo;

typedef struct AVL_Nodo *AVL;

AVL sorted_arr_to_avl (void **arr, int n) {
  if (n == 0) {
    AVL_Nodo *nuevoNodo = malloc(sizeof(AVL_Nodo));
    nuevoNodo->dato = arr[n];
    nuevoNodo->izq = NULL;
    nuevoNodo->der = NULL;
    nuevoNodo->altura = 0;
  }
  
  int mitad = n/2;
  void *elem_medio = arr[mitad];
  void *arr_der = arr+mitad+1; // no contamos el elemento medio. 

  sorted_arr_to_avl(elem_medio, 1);
  sorted_arr_to_avl(arr, mitad);
  sorted_arr_to_avl(arr_der, n-mitad-1);

}

