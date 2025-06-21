#include <stdio.h>
#include <stdlib.h>

typedef struct _BSTNodo {
  void *dato;
  struct _BSTNodo *izq, *der;
} BSTNodo;

typedef BSTNodo *BSTree;

typedef int (*FuncionComparadora)(void *dato1, void *dato2);

typedef struct _BHeap {
  void **arr;
  int capacidad;
  int ultimo;
} *BHeap;

typedef struct _AVL_Nodo {
  void *dato;
  struct _AVL_Nodo *izq, *der;
  int altura;
} AVL_Nodo;

typedef AVL_Nodo *AVL;

// 1

int bst_cant_nodos (BSTree arbol) {
    if (arbol == NULL) return 0;
    return 1 + bst_cant_nodos(arbol->izq) + bst_cant_nodos(arbol->der);
}

void bst_to_heap_aux (BSTree arbol, BHeap *heap) {
  if (arbol == NULL) return;

  bst_to_heap_aux(arbol->der, heap);

  (*heap)->ultimo++;
  (*heap)->arr[(*heap)->ultimo] = arbol->dato;

  bst_to_heap_aux(arbol->izq, heap);
}

BHeap bst_to_heap (BSTree arbol, FuncionComparadora comp) {
  if (arbol == NULL) return NULL;

  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->capacidad = bst_cant_nodos(arbol);
  heap->arr = malloc(sizeof(void*)*heap->capacidad);
  heap->ultimo = -1;

  bst_to_heap_aux(arbol, &heap);
  
  return heap;
}

// 2

AVL sorted_arr_to_avl (void **arr, int n) {
  if (n == 0) return NULL;
  
  int mitad = n/2;

  AVL izq = sorted_arr_to_avl(arr,mitad);

  AVL nodo = malloc(sizeof(AVL_Nodo));
  nodo->dato = arr[mitad];
  nodo->izq = izq;

  nodo->der = sorted_arr_to_avl(arr + mitad + 1, n-mitad-1);

  int alt_izq = nodo->izq ? nodo->izq->altura : -1;
  int alt_der = nodo->der ? nodo->der->altura : -1;
  nodo->altura = 1 + (alt_izq > alt_der ? alt_izq : alt_der);
  return nodo;
}

// 3

#define LEFT(i) ((2*i)+1)
#define RIGTH(i) (2*(i+1))

void swap (void **a, void **b) {
  void *temp = *a;
  *a = *b;
  *b = temp;
}

void hundir (BHeap heap, int pos, FuncionComparadora comp) {
  int mayorPos = pos;
  if (RIGTH(pos) <= heap->ultimo && comp(heap->arr[RIGTH(pos)], heap->arr[mayorPos]) > 0) mayorPos = RIGTH(pos);
  if (LEFT(pos) <= heap->ultimo && comp(heap->arr[LEFT(pos)], heap->arr[mayorPos]) > 0) mayorPos = LEFT(pos);
  if (mayorPos != pos) {
    swap(&heap->arr[pos], &heap->arr[mayorPos]);
    hundir(heap, mayorPos, comp);
  }
}

void heap_sort (void **arr, int n, FuncionComparadora comp) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = arr;
  heap->capacidad = n;
  heap->ultimo = n-1;

  for (int j = heap->ultimo ; j >= 0 ; j--)
    hundir(heap, j, comp);

  for (int j = n-1 ; j >= 0; j-- ){
    swap(&heap->arr[0], &heap->arr[j]);
    heap->ultimo--;
    hundir(heap, 0, comp);
  }

  free(heap);
}

// 4

typedef void* (*FuncionCopiadora)(void *dato);

int nodo_altura(AVL_Nodo* raiz) {
  return (raiz == NULL ? -1 : raiz->altura);
}

int factor_balance (AVL_Nodo* raiz) {
  if (raiz == NULL) return 0;
  int factor = nodo_altura(raiz->der) - nodo_altura(raiz->izq);
  return factor;
}

int nodo_altura_max (AVL_Nodo* raiz) {
  int alt_izq = nodo_altura(raiz->izq);
  int alt_der = nodo_altura(raiz->der);
  return (alt_izq > alt_der ? alt_izq : alt_der);
}

AVL_Nodo* rebalancear_der (AVL_Nodo *raiz) {
  if (raiz == NULL) return NULL;
  AVL_Nodo *hijo_izq = raiz->izq;
  raiz->izq = hijo_izq->der;
  hijo_izq->der = raiz;
  raiz->altura = 1 + nodo_altura_max(raiz);
  hijo_izq->altura = 1 + nodo_altura_max(hijo_izq);
  return hijo_izq;
}

AVL_Nodo* rebalancear_izq (AVL_Nodo *raiz) {
  if (raiz == NULL) return NULL;
  AVL_Nodo *hijo_der = raiz->der;
  raiz->der = hijo_der->izq;
  hijo_der->izq = raiz;
  raiz->altura = 1 + nodo_altura_max(raiz);
  hijo_der->altura = 1 + nodo_altura_max(hijo_der);
  return hijo_der;
}

AVL_Nodo* insertar_avl(AVL_Nodo* raiz, void *dato, FuncionComparadora comp, FuncionCopiadora copy) {
  if (raiz == NULL) {
    AVL_Nodo* nodo = malloc(sizeof(AVL_Nodo));
    nodo->dato = copy(dato);
    nodo->altura = 0;
    nodo->izq = NULL;
    nodo->der = NULL;
    return nodo;
  }

  else if (comp(dato, raiz->dato) > 0) {
    raiz->der = insertar_avl(raiz->der, dato, comp, copy);

    if (factor_balance(raiz) == 2){
      if (factor_balance(raiz->der) == -1)
        raiz->der = rebalancear_der(raiz->der);
      raiz = rebalancear_der(raiz);
    }
    raiz->altura = 1 + nodo_altura_max(raiz);
    return raiz;
  }

  else if (comp(dato, raiz->dato) < 0) {
    raiz->izq = insertar_avl(raiz->izq, dato, comp, copy);

    if (factor_balance(raiz) == -2) {
      if (factor_balance(raiz->izq) == 1)
        raiz->izq = rebalancear_izq(raiz->izq);
      raiz = rebalancear_izq(raiz);
    }
    raiz->altura = 1 + nodo_altura_max(raiz);
    return raiz;
  }

  else 
    return raiz;
}

// 5

#define PADRE(i) ((i-1)/2)

void* heap_pop (BHeap heap, FuncionComparadora comp) {
  void* max = heap->arr[0];
  heap->arr[0] = heap->arr[heap->ultimo];
  heap->ultimo--;
  hundir(heap, 0, comp);
  return max;
}

void* cp_desencolar(BHeap cp, FuncionComparadora comp) {
  if (cp->ultimo == -1) return NULL;

  void *dato = heap_pop(cp, comp);
  return dato;
}

BHeap cp_encolar(BHeap cp, void* elem, FuncionComparadora comp) {
  if (cp->ultimo == cp->capacidad-1) {
    cp->capacidad = cp->capacidad*2;
    cp->arr = realloc(cp->arr, sizeof(void*) * cp->capacidad);
  }

  cp->ultimo++;
  cp->arr[cp->ultimo] = elem;

  for (int nodo = cp->ultimo; nodo > 0 && comp(cp->arr[nodo], cp->arr[PADRE(nodo)]) > 0 ; nodo = PADRE(nodo))
    swap(&cp->arr[nodo], &cp->arr[PADRE(nodo)]);

  return cp;
}

// 6

BSTree intervalo_bst (BSTree raiz, int posMin, int posMax, FuncionComparadora comp, FuncionCopiadora copy) {
  if (raiz == NULL || posMin > posMax) return NULL;

  if (comp(raiz->dato, posMax) > 0)
    return intervalo_bst(raiz->izq, posMin, posMax, comp, copy);
  if (comp(raiz->dato, posMin) < 0)
    return intervalo_bst(raiz->der, posMin, posMax, comp, copy);
    
  BSTNodo *nodo = malloc(sizeof(BSTNodo));
  nodo->dato = copy(raiz->dato);
  nodo->izq = intervalo_bst(raiz->izq, posMin, posMax, comp, copy);
  nodo->der = intervalo_bst(raiz->der, posMin, posMax, comp, copy);

  return nodo;
}

int main () {
  return 0;
}

// 7

typedef struct _RangeBST {
  int min;
  int max;
  struct _RangeBST* izq, *der;
} *RangeBST;

RangeBST insertar_rango (RangeBST arbol, int dato) {
  if (arbol == NULL) {
    RangeBST nodo = malloc(sizeof(struct _RangeBST));
    nodo->min = dato;
    nodo->max = dato;
    nodo->izq = NULL;
    nodo->der = NULL;
    return nodo;
  }

  if (dato >= arbol->min && dato <= arbol->max) {
    return arbol;
  }

  if (dato == arbol->min-1) {
    arbol->min = dato;
    return arbol;
  }

  if (dato == arbol->max+1) {
    arbol->max = dato;
    return arbol;
  }

  if (dato < arbol->min) {
    arbol->izq = insertar_rango(arbol->izq, dato);
    return arbol;
  }

  if(dato > arbol->max) {
    arbol->der = insertar_rango(arbol->der, dato);
    return arbol;
  }

  return arbol;
}

int pertenece_rango (RangeBST arbol, int dato) {
  if (arbol == NULL) return 0;

  if (dato >= arbol->min && dato <= arbol->max)
    return 1;

  if (dato < arbol->min)
    return pertenece_rango(arbol->izq, dato);

  return pertenece_rango(arbol->der, dato);
}

RangeBST filtrar_rango (RangeBST arbol, int a, int b) {
  if (arbol == NULL) return NULL;

  if (arbol->max < a)
    return filtrar_rango(arbol->der, a, b);

  if (arbol->min > b)
    return filtrar_rango(arbol->izq, a, b);
    
  int nuevoMin = (arbol->min < a) ? a : arbol->min;
  int nuevoMax = (arbol->max > b) ? b : arbol->max;

  RangeBST nodo = malloc(sizeof(struct _RangeBST));
  nodo->min = nuevoMin;
  nodo->max = nuevoMax;
  nodo->izq = filtrar_rango(arbol->izq, a, b);
  nodo->der = filtrar_rango(arbol->der, a, b);

  return nodo;
}
