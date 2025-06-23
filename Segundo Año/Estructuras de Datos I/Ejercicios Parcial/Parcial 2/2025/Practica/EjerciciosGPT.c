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

// #define LEFT(i) ((2*i)+1)
// #define RIGTH(i) (2*(i+1))

// void swap (void **a, void **b) {
//   void *temp = *a;
//   *a = *b;
//   *b = temp;
// }

// void hundir (BHeap heap, int pos, FuncionComparadora comp) {
//   int mayorPos = pos;
//   if (RIGTH(pos) <= heap->ultimo && comp(heap->arr[RIGTH(pos)], heap->arr[mayorPos]) > 0) mayorPos = RIGTH(pos);
//   if (LEFT(pos) <= heap->ultimo && comp(heap->arr[LEFT(pos)], heap->arr[mayorPos]) > 0) mayorPos = LEFT(pos);
//   if (mayorPos != pos) {
//     swap(&heap->arr[pos], &heap->arr[mayorPos]);
//     hundir(heap, mayorPos, comp);
//   }
// }

void heap_sort (void **arr, int n, FuncionComparadora comp) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = arr;
  heap->capacidad = n;
  heap->ultimo = n-1;

  for (int j = heap->ultimo/2 ; j >= 0 ; j--)
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
      raiz = rebalancear_izq(raiz);
    }
    raiz->altura = 1 + nodo_altura_max(raiz);
    return raiz;
  }

  else if (comp(dato, raiz->dato) < 0) {
    raiz->izq = insertar_avl(raiz->izq, dato, comp, copy);

    if (factor_balance(raiz) == -2) {
      if (factor_balance(raiz->izq) == 1)
        raiz->izq = rebalancear_izq(raiz->izq);
      raiz = rebalancear_der(raiz);
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

// Repaso funciones AVL BSTREE HEAP ALGORITMOS

// AVL

typedef void (*FuncionDestructora)(void *dato);

AVL avl_crear () {
  return NULL;
}

void avl_destruir (AVL raiz, FuncionDestructora destroy) {
  if (raiz != NULL) {
    avl_destruir(raiz->izq, destroy);
    avl_destruir(raiz->der, destroy);
    destroy(raiz->dato);
    free(raiz);
  }
}

int avl_buscar (AVL raiz, void *dato, FuncionComparadora comp) {
  if (raiz == NULL) 
    return 0;
  else if (comp(dato, raiz->dato) == 0) 
    return 1;
  else if (comp(dato, raiz->dato) > 0)
    return avl_buscar(raiz->der, dato, comp);
  else if (comp(dato, raiz->dato) < 0)
    return avl_buscar(raiz->izq, dato, comp);
}

int avl_nodo_altura (AVL raiz) {
  return (raiz == NULL ? -1 : raiz->altura);
}

int avl_altura_max_hijos (AVL raiz) {
  if (raiz == NULL) return -1;
  int altIzq = avl_altura(raiz->izq);
  int altDer = avl_altura(raiz->der);
  return (altIzq > altDer ? altIzq : altDer);
}

int avl_factor_balance (AVL raiz) {
  if (raiz == NULL) return;
  int factor = avl_altura_max_hijos(raiz->der) - avl_altura_max_hijos(raiz->izq);
  return factor;
}

AVL avl_nodo_rotacion_simple_izq (AVL raiz) {
  if (raiz == NULL) return NULL;
  AVL hijoDer = raiz->der;
  raiz->der = hijoDer->izq;
  hijoDer->izq = raiz;
  raiz->altura = 1 + avl_altura_max_hijos(raiz);
  hijoDer->altura = 1 + avl_altura_max_hijos(hijoDer);
  return hijoDer;
}

AVL avl_nodo_rotacion_simple_der (AVL raiz) {
  if (raiz == NULL) return NULL;
  AVL hijoIzq = raiz->izq;
  raiz->izq = hijoIzq->der;
  hijoIzq->der = raiz;
  raiz->altura = 1 + avl_altura_max_hijos(raiz);
  hijoIzq->altura = 1 + avl_altura_max_hijos(hijoIzq);
  return hijoIzq;
}

AVL avl_rebalancear (AVL raiz) {
  if (avl_factor_balance(raiz) == -2) {
    if (avl_factor_balance(raiz->izq) == 1)
      raiz->izq = avl_nodo_rotacion_simple_izq(raiz->izq);
    raiz = avl_nodo_rotacion_simple_der(raiz);
  }
  else if (avl_factor_balance(raiz == 2)) {
    if (avl_factor_balance(raiz->der) == -1)
      raiz->der = avl_nodo_rotacion_simple_der(raiz->der);
    raiz = avl_nodo_rotacion_simple_izq(raiz);
  }
  return raiz;
}

AVL avl_crear_nodo (void *dato, FuncionCopiadora copy) {
  AVL nodo = malloc(sizeof(AVL_Nodo));
  nodo->dato = copy(dato);
  nodo->altura = 0;
  nodo->izq = NULL;
  nodo->der = NULL;
  return nodo;
}

AVL avl_insertar (AVL raiz, void *dato, FuncionCopiadora copy, FuncionComparadora comp) {
  if (raiz == NULL)
    return avl_crear_nodo (dato, copy);
  else if (comp(dato, raiz->dato) > 0)
    raiz->der = avl_insertar(raiz->der, dato, copy, comp);
  else if (comp(dato, raiz->dato) < 0)
    raiz->izq = avl_insertar(raiz->izq, dato, copy, comp);
  else return raiz;

  raiz->altura = 1 + avl_altura_max_hijos(raiz);
  raiz = avl_rebalancear(raiz);
  return raiz;
}

AVL avl_eliminar (AVL raiz, void *dato, FuncionComparadora comp, FuncionDestructora destroy, FuncionCopiadora copy) {
  if (raiz == NULL) return NULL;
  if (comp(dato, raiz->dato) < 0)
    raiz->izq = avl_eliminar(raiz->izq, dato, comp, destroy, copy);
  else if (comp(dato, raiz->dato) > 0)
    raiz->der = avl_eliminar(raiz->der, dato, comp, destroy, copy);
  else if (comp(dato, raiz->dato) == 0) {
    if (raiz->izq == NULL && raiz->der == NULL) {
      destroy(raiz->dato);
      free(raiz);
      return NULL;
    }
    if (raiz->izq == NULL) {
      AVL temp = raiz->der;
      destroy(raiz->dato);
      free(raiz);
      return temp;
    }
    if (raiz->der == NULL) {
      AVL temp = raiz->izq;
      destroy(raiz->dato);
      free(raiz);
      return temp;
    }
    AVL suc = raiz->der;
    while (suc->izq != NULL)
      suc = suc->izq;

    raiz->dato = copy(suc->dato);
    raiz->der = avl_eliminar(raiz->der, suc->dato, comp, destroy, copy);
  }

  raiz->altura = 1 + avl_altura_max_hijos(raiz);
  raiz = avl_rebalancear(raiz);
  return raiz;
}

int avl_validar_bst (AVL raiz, void *min, void *max, FuncionComparadora comp) {
  if (raiz == NULL) return 1;
  if (min != NULL && comp(raiz->dato, min) <= 0) return 0;
  if (max != NULL && comp(raiz->dato, max) >= 0) return 0;
  return (avl_validar_bst(raiz->izq, min, raiz->dato, comp) && avl_validar_bst(raiz->der, raiz->dato, max, comp));
}

int avl_validar_altura_balance (AVL raiz) {
  if (raiz == NULL) return 1;
  int ret1 = avl_validar_altura_balance(raiz->izq);
  int ret2 = avl_validar_altura_balance(raiz->der);
  if (ret1 && ret2) {
    int altura = 1 + avl_altura_max_hijos(raiz);
    int balance = avl_factor_balance(raiz);
    if ((raiz->altura == altura) && (balance >= -1) && (balance <= 1))
      return 1;
  }
  return 0;
}

void *avl_k_esimo_menor_aux (AVL raiz, int *k) {
  if (raiz == NULL) return NULL;

  void *izq = avl_k_esimo_menor_aux(raiz->izq, k);

  if (izq != NULL) return izq;
  (*k)--;
  if (*k == 0) return raiz->dato;

  return avl_k_esimo_menor_aux(raiz->der, k);
}

void *avl_k_esimo_menor (AVL raiz, int k) {
  return avl_k_esimo_menor_aux(raiz, &k);
}

typedef void (*FuncionVisitante)(void *);

typedef enum {
  IN,
  PRE,
  POST
} AVLRecorrido;

void avl_recorrer (AVL raiz, AVLRecorrido recorrido, FuncionVisitante visit) {
  if (raiz == NULL) return;

  if (recorrido == PRE)
    visit(raiz->dato);
  
  avl_recorrer(raiz->izq, recorrido, visit);

  if (recorrido == IN)
    visit(raiz->dato);
  
  avl_recorrer(raiz->der, recorrido, visit);
  
  if (recorrido == POST)
    visit(raiz->dato);
}

// HEAP

#define LEFT(i) ((2*i)+1)
#define RIGTH(i) (2*(i+1))
#define PARENT(i) ((i-1)/2)

void swap (void **a, void **b) {
  void *temp = *a;
  *a = *b;
  *b = temp;
}

void hundir (BHeap heap, int pos, FuncionComparadora comp) {
  int mayorPos = pos;
  if (LEFT(pos) <= heap->ultimo && comp(heap->arr[LEFT(pos)], heap->arr[mayorPos]) > 0) 
    mayorPos = LEFT(pos);
  if (RIGTH(pos) <= heap->ultimo && comp(heap->arr[RIGTH(pos)], heap->arr[mayorPos]) > 0)
    mayorPos = RIGTH(pos);
  if (mayorPos != pos) {
    swap(&heap->arr[pos], &heap->arr[mayorPos]);
    hundir(heap, mayorPos, comp);
  }
}

void flotar (BHeap heap, int pos, FuncionComparadora comp) {
  if (pos == 0) return;
  int posPadre = PARENT(pos);
  if (comp(heap->arr[pos], heap->arr[posPadre]) > 0) {
    swap(&heap->arr[pos], &heap->arr[posPadre]);
    flotar(heap, posPadre, comp);
  }
}

BHeap bheap_crear (int capacidad) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->capacidad = capacidad;
  heap->arr = malloc(sizeof(void*)*capacidad);
  heap->ultimo = -1;
  return heap;
}


BHeap bheap_crear_desde_array (void **arr, int n, FuncionComparadora comp) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = arr;
  heap->capacidad = n;
  heap->ultimo = n-1;

  for (int i = heap->ultimo/2 ; i >= 0 ; i--) {
    hundir(heap, i, comp);
  }

  return heap;
}

void bheap_destruir (BHeap heap, FuncionDestructora destroy) {
  for (int i = 0 ; i <= heap->ultimo ; i++)
    destroy(heap->arr[i]);
  free(heap->arr);
  free(heap);
}

int bheap_es_vacio (BHeap heap) {
  return heap->ultimo == -1;
}

void bheap_recorrer (BHeap heap, FuncionVisitante visit) {
  for (int i = 0 ; i <= heap->ultimo ; i++)
    visit(heap->arr[i]);
}

BHeap bheap_insertar (BHeap heap, void *dato, FuncionCopiadora copy, FuncionComparadora comp) {
  if (heap->ultimo == heap->capacidad-1) {
    heap->capacidad = heap->capacidad*2;
    heap->arr = realloc(heap->arr, sizeof(void*)*heap->capacidad);
  }

  heap->ultimo++;
  heap->arr[heap->ultimo] = copy(dato);

  flotar(heap, heap->ultimo, comp);

  return heap;
}

BHeap bheap_eliminar (BHeap heap, int pos, FuncionComparadora comp,FuncionDestructora destroy) {
  if (bheap_es_vacio(heap) || pos < 0) return NULL;

  void *elem = heap->arr[pos];
  heap->arr[pos] = heap->arr[heap->ultimo]; 
  heap->ultimo--;

  destroy(elem);

  if (comp(heap->arr[pos], heap->arr[PARENT(pos)]) > 0)
    flotar(heap, pos, comp);
  else
    hundir(heap, pos, comp);

  return heap;
}

void* bheap_pop (BHeap heap, FuncionComparadora comp) { /*¿Cola de prioridad?*/
  void *temp = heap->arr[0];
  heap->arr[0] = heap->arr[heap->ultimo];
  heap->ultimo--;
  hundir(heap, 0, comp);
  return temp;
}

void bheap_sort (void **arr, int n, FuncionComparadora comp) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = arr;
  heap->capacidad = n;
  heap->ultimo = n-1;

  for (int i = heap->ultimo/2 ; i >= 0 ; i--) {
    hundir(heap, i, comp);
  }

  for (int i = heap->ultimo ; i >= 0 ; i--) {
    swap(&heap->arr[0], &heap->arr[i]);
    heap->ultimo--;
    hundir(heap, 0, comp);
  }
}

// ALGORITMOS

void bubble_sort (int a[], int len) {
  int bandera = 1;
  while (bandera) {
    bandera = 0;
    for (int i = 0 ; i < len-1 ; i++) {
      if (a[i] > a[i+1]){
        swap(&a[i], &a[i+1]);
        bandera = 1;
      }
    }
  }
}

void selection_sort (int a[], int len) { 
  for (int i = 0 ; i < len-1 ; i++) {
    int minPos = i;
    for (int j = i+1 ; j < len ; j++) 
      if (a[j] < a[minPos])
        minPos = j;
    swap(&a[i], &a[minPos]);
  }
}

void insertion_sort (int a[], int len) {
  for (int i = 1 ; i < len ; i++) {
    int valor = a[i];
    int j = i -1;

    for (; j >= 0 && a[j] > valor ; j--)
      a[j+1] = a[j];

    a[j+1] = valor;
  }
}

int* merge (int a[], int len_a, int b[], int len_b) {
  int *resultado = malloc(sizeof(int)*(len_a+len_b));
  int i = 0, j = 0, k = 0;

  for (; i < len_a && j < len_b ; k++) {
    if (a[i] < b[j]) {
      resultado[k] = a[i];
      i++;
    }
    else {
      resultado[k] = b[j];
      j++;
    }
  }

  for (; i < len_a ; k++, i++)
    resultado[k] = a[i];

  for (; j < len_b ; k++, j++)
    resultado[k] = b[j];

  return resultado;
}

int* merge_sort (int a[], int len) {
  if (len == 1) {
    int *copia = malloc(sizeof(int));
    copia[0] = a[0];
    return copia;
  }

  int mitad = len/2;

  int *a1 = a;
  int *a2 = a+mitad;

  int *b1 = merge_sort(a1, mitad);
  int *b2 = merge_sort(a2, len - mitad);

  int *resultado = merge(b1, mitad, b2, len - mitad);

  free(b1);
  free(b2);

  return resultado;
}

int particion_de_lomuto (int a[], int len, int pvt) {
  int j = 0;

  for (int i = 0 ; i < len ; i++)
    if (a[i] <= pvt) {
      swap(&a[i], &a[j]);
      j++;
    }

  return j;
}

void quick_sort (int a[], int len) {
  if (len < 2) return;

  int pvt = a[0];

  int nIzq = particion_de_lomuto(a+1, len-1, pvt);

  swap(&a[0], &a[nIzq]);

  quick_sort(a, nIzq);
  quick_sort(a+nIzq+1, len-nIzq-1);
}