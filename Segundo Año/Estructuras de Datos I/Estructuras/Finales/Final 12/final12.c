#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define UMBRAL 3

typedef void *(*FuncionCopiadora)(void *dato);
typedef int (*FuncionComparadora)(void *, void *);
typedef void (*FuncionDestructora)(void *dato);
typedef void (*FuncionVisitante)(void *dato);
typedef unsigned (*FuncionHash)(void*);

typedef struct _GNode {
  void *data;
  struct _GNode *next;
} GNode;

typedef struct _GNode *GList;

typedef struct _AVL_Nodo {
  void* dato;
  struct _AVL_Nodo* izq, * der;
  int altura;
} AVL_Nodo;

void visitar_entero (void *dato) {
  printf("%d ", *(int*)dato);
}

//typedef struct AVL_Nodo *AVL;

typedef struct {
  AVL_Nodo *raiz;
  GList nodo;
  unsigned T;
} CasillaHash;

struct _TablaHash {
  CasillaHash *elems;
  unsigned numElems;
  unsigned capacidad;
  FuncionCopiadora copia;
  FuncionComparadora comp;
  FuncionDestructora destr;
  FuncionHash hash;
};

typedef struct _TablaHash *HybridHash;

/*=================================*/

// LISTA

GList glist_crear() { 
  return NULL; 
}

GList glist_agregar_inicio(GList list, void *data, FuncionCopiadora copy) {
  GNode *newNode = malloc(sizeof(GNode));
  assert(newNode != NULL);
  newNode->next = list;
  newNode->data = copy(data);
  return newNode;
}

void* glist_buscar(GList list, void* data, FuncionComparadora comp){
  int found = 0;
  void *datoEncontrado = NULL;
  for(GNode *node = list; found == 0 && node != NULL; node = node->next)
    if (comp(node->data, data) == 0) {
      found = 1;
      datoEncontrado = node->data;
    }
  return datoEncontrado;
}

void glist_destruir(GList list, FuncionDestructora destroy) {
  GNode *nodeToDelete;
  while (list != NULL) {
    nodeToDelete = list;
    list = list->next;
    destroy(nodeToDelete->data); 
    free(nodeToDelete);
  }
}

GList glist_eliminar (GList list, void *dato, FuncionComparadora comp, FuncionDestructora destr, int *eliminado) {
  if (list == NULL) {
    return NULL;
    *eliminado = 0;
  }

  if (comp(list->data, dato) == 0) {
    GNode* temp = list->next;
    destr(list->data);
    free(list);
    *eliminado = 1;
    return temp;
  }

  GNode *temp = list;
  for (; temp->next != NULL && comp(dato, temp->data) != 0 ; temp = temp->next);

  if (temp->next != NULL) {
    list = temp->next;
    destr(temp->data);
    free(temp);
    *eliminado = 1;
    return list;
  }

  *eliminado = 0;
  return list;
}

void glist_recorrer(GList list, FuncionVisitante visit) {
  for (GNode *node = list; node != NULL; node = node->next)
    visit(node->data);
}

// AVL

int avl_nodo_altura(AVL_Nodo* raiz) {
  return (raiz == NULL ? -1 : raiz->altura);
}

unsigned int avl_nodo_max_altura_hijos(AVL_Nodo* raiz) {
  assert(raiz != NULL);
  int alturaIzq = avl_nodo_altura(raiz->izq);
  int alturaDer = avl_nodo_altura(raiz->der);
  return (alturaIzq < alturaDer ? alturaDer : alturaIzq);
}

int avl_nodo_factor_balance(AVL_Nodo* raiz) {
  assert(raiz != NULL);
  int factor = avl_nodo_altura(raiz->der) - avl_nodo_altura(raiz->izq);
  assert(-2 <= factor || factor <= 2);
  return factor;
}

AVL_Nodo* avl_nodo_rotacion_simple_izq(AVL_Nodo* raiz) {
  AVL_Nodo* hijoDer = raiz->der;
  assert(hijoDer != NULL);
  // actualizar punteros
  raiz->der = hijoDer->izq;
  hijoDer->izq = raiz;
  // actualizar alturas
  raiz->altura = 1 + avl_nodo_max_altura_hijos(raiz);
  hijoDer->altura = 1 + avl_nodo_max_altura_hijos(hijoDer);
  return hijoDer;
}

AVL_Nodo* avl_nodo_rotacion_simple_der(AVL_Nodo* raiz) {
  AVL_Nodo* hijoIzq = raiz->izq;
  assert(hijoIzq != NULL);
  // actualizar punteros
  raiz->der = hijoIzq->der;
  hijoIzq->der = raiz;
  // actualizar alturas
  raiz->altura = 1 + avl_nodo_max_altura_hijos(raiz);
  hijoIzq->altura = 1 + avl_nodo_max_altura_hijos(hijoIzq);
  return hijoIzq;
}

AVL_Nodo* avl_rebalancear (AVL_Nodo *raiz) {
  if (avl_nodo_factor_balance(raiz) == -2) { // desbalanceado izquierda
    if (avl_nodo_factor_balance(raiz->izq) == 1) // desbalanceado derecha
      raiz->izq = avl_nodo_rotacion_simple_izq(raiz->izq);
    raiz = avl_nodo_rotacion_simple_der(raiz);
  }
  else if (avl_nodo_factor_balance(raiz) == 2) { // desbalanceado derecha
    if (avl_nodo_factor_balance(raiz->der) == -1) // desbalanceado izquierda
      raiz->der = avl_nodo_rotacion_simple_der(raiz->der);
    raiz = avl_nodo_rotacion_simple_izq(raiz);
  }
  return raiz;
}

AVL_Nodo* avl_nodo_crear(void* dato, FuncionCopiadora copia) {
  AVL_Nodo* nuevoNodo = malloc(sizeof(AVL_Nodo));
  assert(nuevoNodo != NULL);
  nuevoNodo->dato = copia(dato);
  nuevoNodo->izq = nuevoNodo->der = NULL;
  nuevoNodo->altura = 0;
  return nuevoNodo;
}

AVL_Nodo* avl_insertar (AVL_Nodo *raiz, void *dato, FuncionComparadora comp, FuncionCopiadora copy) {
  if (raiz == NULL) return avl_nodo_crear(dato, copy);

  if (comp(dato, raiz->dato) < 0)
    raiz->izq = avl_insertar(raiz->izq, dato, comp, copy);
  else if (comp(dato, raiz->dato) > 0)
    raiz->der = avl_insertar(raiz->der, dato, comp, copy);
  else return raiz;

  raiz = avl_rebalancear(raiz);
  raiz->altura = avl_nodo_max_altura_hijos(raiz);

  return raiz;
}

int avl_nodo_buscar(AVL_Nodo* raiz, FuncionComparadora comp, void* dato, void **datoEncontrado) {
  if (raiz == NULL)
    return 0;
  else if (comp(dato, raiz->dato) == 0) { // raiz->dato == dato
    *datoEncontrado = raiz->dato;
    return 1;
  }
  else if (comp(dato, raiz->dato) < 0) // dato < raiz->dato
    return avl_nodo_buscar(raiz->izq, comp, dato, datoEncontrado);
  else // raiz->dato < dato
    return avl_nodo_buscar(raiz->der, comp, dato, datoEncontrado);
}

AVL_Nodo* avl_eliminar (AVL_Nodo* raiz, void *dato, FuncionComparadora comp, FuncionDestructora destr, FuncionCopiadora copy, int *eliminado) {
  if (raiz == NULL) {
    return NULL;
  }
  if (comp(dato, raiz->dato) < 0)
    raiz->izq = avl_eliminar(raiz->izq, dato, comp, destr, copy, eliminado);
  else if (comp(dato, raiz->dato) > 0)
    raiz->der = avl_eliminar(raiz->der, dato, comp, destr, copy, eliminado);
  else {
    if (raiz->izq == NULL && raiz->der == NULL) {
      destr(raiz->dato);
      free(raiz);
      return NULL;
      *eliminado = 1;
    }

    if (raiz->der == NULL) {
      AVL_Nodo* temp = raiz->izq;
      destr(raiz->dato);
      free(raiz);
      *eliminado = 1;
      return temp;
    }

    if (raiz->izq == NULL) {
      AVL_Nodo *temp = raiz->der;
      destr(raiz->dato);
      free(raiz);
      *eliminado = 1;
      return temp;  
    }

    AVL_Nodo *act = raiz->der;
    while (act->izq != NULL)
      act = act->izq;

    destr(raiz->dato);
    raiz->dato = copy(act->dato);

    raiz->der = avl_eliminar(raiz->der, act->dato, comp, destr, copy, eliminado);
    *eliminado = 1;
  }

  raiz = avl_rebalancear(raiz);
  raiz->altura = 1 + avl_nodo_max_altura_hijos(raiz);

  return raiz;
}

GList avl_to_list (AVL_Nodo *raiz, FuncionCopiadora copy) {
  if (raiz == NULL) return NULL;
  GList list = glist_agregar_inicio(NULL, raiz->dato, copy);
  list->next = avl_to_list(raiz->izq, copy);
  list->next = avl_to_list(raiz->der, copy);
  return list;
}

void avl_nodo_destruir(AVL_Nodo* raiz, FuncionDestructora destr) {
  if (raiz != NULL) {
    avl_nodo_destruir(raiz->izq, destr);
    avl_nodo_destruir(raiz->der, destr);
    destr(raiz->dato);
    free(raiz);
  }
}

void avl_nodo_recorrer(AVL_Nodo* raiz, FuncionVisitante visita) {
  if (raiz != NULL) { 
    visita(raiz->dato);
    avl_nodo_recorrer(raiz->izq, visita);
    avl_nodo_recorrer(raiz->der, visita);
  }
}

/*=================================*/

HybridHash hybrid_hash_crear (unsigned capacidad, FuncionComparadora comp, FuncionCopiadora copy, FuncionDestructora destroy, FuncionHash hash) {
  HybridHash tabla = malloc(sizeof(struct _TablaHash));
  tabla->elems = malloc(sizeof(CasillaHash) * capacidad);
  tabla->capacidad = capacidad;
  tabla->numElems = 0;
  tabla->comp = comp;
  tabla->copia = copy;
  tabla->destr = destroy;
  tabla->hash = hash;

  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    tabla->elems[i].nodo = NULL;
    tabla->elems[i].raiz = NULL;
    tabla->elems[i].T = 0;
  }
  return tabla;
}

void hybrid_hash_insertar (HybridHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;
  
  int bandera = 0;

  if (tabla->elems[idx].nodo != NULL) {
    for (GNode *nodo = tabla->elems[idx].nodo; nodo != NULL && !bandera ; nodo = nodo->next) {
      if (tabla->comp(dato, nodo->data) == 0) {
        tabla->destr(nodo->data);
        nodo->data = tabla->copia(dato);
        bandera = 1;
      }
    }

    if (!bandera) { 
      tabla->elems[idx].nodo = glist_agregar_inicio(tabla->elems[idx].nodo, dato, tabla->copia);

      tabla->elems[idx].T++;
      if (tabla->elems[idx].T++ > UMBRAL) {
        for (GNode *nodo = tabla->elems[idx].nodo ; nodo != NULL ; nodo = nodo->next) {
          tabla->elems[idx].raiz = avl_insertar(tabla->elems[idx].raiz, nodo->data, tabla->comp, tabla->copia);

          }
        glist_destruir(tabla->elems[idx].nodo, tabla->destr);
        tabla->elems[idx].nodo = NULL;
      }
    }
  }

  else if (tabla->elems[idx].raiz != NULL) {
    AVL_Nodo *act = tabla->elems[idx].raiz;

    while(act != NULL && !bandera) {
        int comparacion = tabla->comp(dato, act->dato);
        if (comparacion == 0) {
          tabla->destr(act->dato);
          act->dato = tabla->copia(dato);
          bandera = 1;
        }
      act = comparacion < 0 ? act->izq : act->der;
    }

    if (!bandera) {
      tabla->elems[idx].raiz = avl_insertar(tabla->elems[idx].raiz, dato, tabla->comp, tabla->copia);
      tabla->elems[idx].T++;
    }
  }
  
  else {
    tabla->elems[idx].nodo = glist_agregar_inicio(tabla->elems[idx].nodo, dato, tabla->copia);
    tabla->elems[idx].T++;
    }
}

void* hybrid_hash_buscar (HybridHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;
  
  void *datoEncontrado = NULL;

  if (tabla->elems[idx].nodo != NULL)
    datoEncontrado = glist_buscar(tabla->elems[idx].nodo, dato, tabla->comp);
  else if (tabla->elems[idx].raiz != NULL)
    avl_nodo_buscar(tabla->elems[idx].raiz, tabla->comp, dato, &datoEncontrado);
  else
    return datoEncontrado;
  
  return datoEncontrado;
}

void hybrid_hash_eliminar (HybridHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  int eliminado = 0;

  if (tabla->elems[idx].nodo != NULL) {
    tabla->elems[idx].nodo = glist_eliminar(tabla->elems[idx].nodo, dato, tabla->comp, tabla->destr, &eliminado);
    if (eliminado)
      tabla->elems[idx].T--;
  }

  else if (tabla->elems[idx].raiz != NULL) {
    tabla->elems[idx].raiz = avl_eliminar(tabla->elems[idx].raiz, dato, tabla->comp, tabla->destr, tabla->copia, &eliminado);
    if (eliminado)
      tabla->elems[idx].T--;

    if (eliminado && tabla->elems[idx].T > UMBRAL/2) {
      tabla->elems[idx].nodo = avl_to_list(tabla->elems[idx].raiz, tabla->copia);
      avl_nodo_destruir(tabla->elems[idx].raiz, tabla->destr);
      tabla->elems[idx].raiz = NULL;
    }
  }
}

void hybrid_hash_destruir(HybridHash tabla) {

  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo != NULL) {
      glist_destruir(tabla->elems[i].nodo, tabla->destr);
    }

    else if (tabla->elems[i].raiz != NULL)
      avl_nodo_destruir(tabla->elems[i].raiz, tabla->destr);
  }
  free(tabla->elems);
  free(tabla);
}

/*=================================*/

void *copiar_entero (void *dato) {
  int *copia = malloc(sizeof(int));
  *copia = *(int*)dato;
  return copia;
}

void destruir_entero (void *dato) {
  free(dato);
}

int comparar_entero (void *dato1, void *dato2) {
  return *(int*)dato1 - *(int*)dato2;
}

unsigned hash_entero (void *dato) {
  return *(int*)dato;
}

int main () {

  HybridHash tabla = hybrid_hash_crear(3, comparar_entero, copiar_entero, destruir_entero, hash_entero);
  if (tabla != NULL)
    printf("Tabla creada correactamente\n\n");
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo == NULL) {
      printf("Lista vacía\n");
      printf("Casilla %d\n", i);
    }
    if (tabla->elems[i].raiz == NULL) {
      printf("Árbol vacío\n");
      printf("Casilla %d\n", i);
    }
    printf("\n");
  } 

  int arr[] = {7,1,4,10,2,5,3,9,11,20,32,53};
  for (unsigned i = 0 ; i < 12 ; i++) {
    hybrid_hash_insertar(tabla, &arr[i]);
  }

  printf("Insertó\n");
  printf("PRUEBA SI ES VACIO LUEGO DE INSERTAR\n");
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo == NULL) {
      printf("Lista vacía\n");
      printf("Casilla %d\n", i);
    }
    if (tabla->elems[i].raiz == NULL) {
      printf("Árbol vacío\n");
      printf("Casilla %d\n", i);
    }
    printf("\n");
  } 

  void* dato = hybrid_hash_buscar(tabla, &arr[3]);
  if (dato)
    printf("El dato fue encontrado y es %d\n", *(int*)dato);
  else
    printf("El dato no se encuentra\n");
  printf("\n");

  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo != NULL) {
      printf("Lista: ");
      glist_recorrer(tabla->elems[i].nodo, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
    else if (tabla->elems[i].raiz != NULL) {
      printf("Arbol: ");
      avl_nodo_recorrer(tabla->elems[i].raiz, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
  } 

  hybrid_hash_eliminar(tabla, &arr[3]);

  printf("Prueba de eliminación dato: %d\n", arr[3]);
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo != NULL) {
      printf("Lista: ");
      glist_recorrer(tabla->elems[i].nodo, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
    else if (tabla->elems[i].raiz != NULL) {
      printf("Arbol: ");
      avl_nodo_recorrer(tabla->elems[i].raiz, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
  }

  hybrid_hash_eliminar(tabla, &arr[2]);

  printf("Prueba de eliminación dato: %d para convertir en lista\n", arr[2]);
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo != NULL) {
      printf("Lista: ");
      glist_recorrer(tabla->elems[i].nodo, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
    else if (tabla->elems[i].raiz != NULL) {
      printf("Arbol: ");
      avl_nodo_recorrer(tabla->elems[i].raiz, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
  }

  hybrid_hash_eliminar(tabla, &arr[0]);

  printf("Prueba de eliminación dato: %d para desaparecer lista\n", arr[0]);
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    if (tabla->elems[i].nodo != NULL) {
      printf("Lista: ");
      glist_recorrer(tabla->elems[i].nodo, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
    else if (tabla->elems[i].raiz != NULL) {
      printf("Arbol: ");
      avl_nodo_recorrer(tabla->elems[i].raiz, visitar_entero);
      printf("Casilla %d\n", i);
      printf("\n");
    }
  }

  hybrid_hash_destruir(tabla);

  return 0;
}


