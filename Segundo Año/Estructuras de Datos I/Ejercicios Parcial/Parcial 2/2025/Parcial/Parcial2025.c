#include <stdlib.h>
#include <stdio.h>

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
  if (arbol == NULL) return;
  bst_to_heap_aux (arbol->der, heap);
  (*heap)->arr[++(*heap)->ultimo] = arbol->dato;
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

/*
Defina una función
AVL sorted_arr_to_avl (void **arr, int n);
que, dado un arreglo ordenado de datos y un entero n que indica el largo del arreglo,
construya un árbol AVL que contenga los datos del arreglo (sin hacer copias fisicas).
No puede utilizarse la función insertar para arboles AVL.
*/

typedef struct _AVL_Nodo {
  int dato;
  struct _AVL_Nodo* izq, *der;
  int altura;
} AVL_Nodo;

typedef AVL_Nodo *AVL;

AVL sorted_arr_to_avl (int *arr, int n) {
  if (n <= 0) return NULL;

  int mitad = n/2;

  AVL izq = sorted_arr_to_avl(arr, mitad);

  AVL nodo = malloc(sizeof(AVL_Nodo));
  nodo->dato = arr[mitad];
  nodo->izq = izq;

  nodo->der = sorted_arr_to_avl(arr+mitad+1, n-mitad-1);

  int alt_izq = nodo->izq ? nodo->izq->altura : -1;
  int alt_der = nodo->der ? nodo->der->altura : -1;
  nodo->altura = 1 + (alt_izq > alt_der ? alt_izq : alt_der);

  return nodo;
}

void imprimir_arbol (AVL raiz){
  if (raiz == NULL) return;

  imprimir_arbol(raiz->izq);
  imprimir_arbol(raiz->der);
  printf("%d ", raiz->dato);
}

int main () {
  int arr[] = {1,2,3,4,5,6,7};

  AVL arbol = sorted_arr_to_avl(arr, 7);
  imprimir_arbol(arbol);
  puts("");

  return 0;
}