#include "gbtree.h"
#include <assert.h>
#include <stdlib.h>

struct _GBTNodo {
  void *dato;
  struct _BTNodo *left;
  struct _BTNodo *right;
};

GBTree gbtree_crear () { return NULL; }

void gbtree_destruir (GBTree nodo, FuncionDestructora destroy) {
  if (nodo != NULL) {
    gbtree_destruir(nodo->left, destroy);
    gbtree_destruir(nodo->right, destroy);
    destroy(nodo->dato);
    free(nodo);
  }
}

int gbtree_empty (GBTree nodo) { return nodo == NULL; }

GBTree gbtree_unir (void *dato, GBTree left, GBTree right, FuncionCopia copy) {
  GBTree nuevoNodo = malloc(sizeof(struct _GBTNodo));
  assert(nuevoNodo != NULL);
  nuevoNodo->dato = copy(dato);
  nuevoNodo->left = left;
  nuevoNodo->right = right;
  return nuevoNodo;
}

void gbtree_recorrer (GBTree arbol, GBTreeOrdenDeRecorrido orden, FuncionVisitante visit) {
  if (arbol == NULL)
    return;

  if (orden == GBTREE_RECORRIDO_PRE)
    visit(arbol->dato);

  gbtree_recorrer(arbol->left, orden, visit);

  if (orden == GBTREE_RECORRIDO_IN)
    visit(arbol->dato);

  gbtree_recorrer(arbol->right, orden, visit);

  if (orden == GBTREE_RECORRIDO_POST)
    visit(arbol->dato);
}

void gbtree_recorrer_extra (GBTree arbol, GBTreeOrdenDeRecorrido orden, FuncionVisitanteExtra visit, void *extra) {
  if (arbol == NULL)
    return;

  if (orden == GBTREE_RECORRIDO_PRE)
    visit(arbol->dato, extra);

  gbtree_recorrer_extra(arbol->left, orden, visit, extra);

  if (orden == GBTREE_RECORRIDO_IN)
  visit(arbol->dato, extra);

  gbtree_recorrer_extra(arbol->right, orden, visit, extra);

  if (orden == GBTREE_RECORRIDO_POST)
    visit(arbol->dato, extra);
}

int gbtree_nnodos (GBTree arbol) {
  if (arbol == NULL) return 0;

  return 1 + gbtree_nnodos(arbol->left) + gbtree_nnodos(arbol->right);
}

int gbtree_buscar (GBTree arbol, void *dato) {
  if (arbol == NULL) return 0;

  if (arbol->dato == dato) return 1;

  int estaIzq = gbtree_buscar(arbol->left, dato);
  int estaDer = gbtree_buscar(arbol->right, dato);

  return estaIzq || estaDer;
}

void gbtree_recorrer_bfs_aux (GBTree arbol, int profundidad, FuncionVisitante visit) {
  if (arbol == NULL) return;

  if (profundidad == 0) 
    visit(arbol->dato);
  else {
    gbtree_recorrer_bfs_aux (arbol->left, profundidad-1, visit);
    gbtree_recorrer_bfs_aux (arbol->right, profundidad-1, visit);
  }
}

void gbtree_recorrer_bfs (GBTree arbol, FuncionVisitante visit) {
  int altura = gbtree_altura(arbol);
  for (int i = 0 ; i < altura ; i++)
    gbtree_recorrer_bfs_aux(arbol, i, visit);
}

GBTree gbtree_copia (GBTree arbol, FuncionCopia copy) {
  
  if(arbol == NULL) return NULL;
  
  GBTree nuevoNodo = malloc(sizeof(struct _GBTNodo));
  nuevoNodo->dato = copy(arbol->dato);
  nuevoNodo->left = gbtree_copia(arbol->left, copy);
  nuevoNodo->right = gbtree_copia(arbol->right, copy);

  return nuevoNodo;
}

int gbtree_altura (GBTree arbol) {
  if (arbol == NULL) return 0;

  int altIzq = 1 + gbtree_altura(arbol->left);
  int altDer = 1 + gbtree_altura(arbol->right);

  if (altIzq < altDer)
    return altDer;
  
  return altIzq;
}

int gbtree_nnodos_profundidad (GBTree arbol, int profundidad) {
  if (arbol == NULL) return 0;
  
  if (profundidad == 0) return 1;

  return gbtree_nnodos_profundidad(arbol->left, profundidad-1) + gbtree_nnodos_profundidad(arbol->right, profundidad-1);
}

int gbtree_profundidad_aux(GBTree arbol, void *dato, int profundidad) {
  if (arbol == NULL) return -1;
  if (arbol->dato == dato) return profundidad;

  int izq = gbtree_profundidad_aux(arbol->left, dato, profundidad+1);
  if (izq != -1) return izq;

  return gbtree_profundidad_aux(arbol->right, dato, profundidad+1);
}

int gbtree_profundidad (GBTree arbol, void *dato) {
  return gbtree_profundidad_aux(arbol, dato, 0);
}
