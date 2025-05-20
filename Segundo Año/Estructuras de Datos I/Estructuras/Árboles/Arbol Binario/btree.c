#include "btree.h"
#include <assert.h>
#include <stdlib.h>

struct _BTNodo {
  int dato;
  struct _BTNodo *left;
  struct _BTNodo *right;
};

BTree btree_crear () { return NULL; }

void btree_destruir (BTree nodo) {
  if (nodo != NULL) {
    btree_destruir(nodo->left);
    btree_destruir(nodo->right);
    free(nodo);
  }
}

int btree_empty (BTree nodo) { return nodo == NULL; }

BTree btree_unir (int dato, BTree left, BTree right) {
  BTree nuevoNodo = malloc(sizeof(struct _BTNodo));
  assert(nuevoNodo != NULL);
  nuevoNodo->dato = dato;
  nuevoNodo->left = left;
  nuevoNodo->right = right;
  return nuevoNodo;
}

void btree_recorrer (BTree arbol, BTreeOrdenDeRecorrido orden, FuncionVisitante visit) {
  if (arbol == NULL)
    return;

  if (orden == BTREE_RECORRIDO_PRE)
    visit(arbol->dato);

  btree_recorrer(arbol->left, orden, visit);

  if (orden == BTREE_RECORRIDO_IN)
    visit(arbol->dato);

  btree_recorrer(arbol->right, orden, visit);

  if (orden == BTREE_RECORRIDO_POST)
    visit(arbol->dato);
}

int btree_nnodos (BTree arbol) {
  if (arbol == NULL) return 0;

  return 1 + btree_nnodos(arbol->left) + btree_nnodos(arbol->right);
}

int btree_buscar (BTree arbol, int dato) {
  if (arbol == NULL) return 0;

  if (arbol->dato == dato) return 1;

  int estaIzq = btree_buscar(arbol->left, dato);
  int estaDer = btree_buscar(arbol->right, dato);

  return estaIzq || estaDer;
}

BTree btree_copia (BTree arbol) {
  BTree nuevoNodo = malloc(sizeof(struct _BTNodo));

  if(arbol == NULL) return NULL;

  nuevoNodo->dato = arbol->dato;
  nuevoNodo->left = btree_copia(arbol->left);
  nuevoNodo->right = btree_copia(arbol->right);

  return nuevoNodo;
}

int btree_altura (BTree arbol) {
  if (arbol == NULL) return 0;

  int altIzq = 1 + btree_altura(arbol->left);
  int altDer = 1 + btree_altura(arbol->right);

  if (altIzq < altDer)
    return altDer;
  
  return altIzq;
}

int btree_nnodos_profundidad (BTree arbol, int profundidad) {
  if (arbol == NULL) return 0;
  
  if (profundidad == 0) return 1;

  return btree_nnodos_profundidad(arbol->left, profundidad-1) + btree_nnodos_profundidad(arbol->right, profundidad-1);
}

int btree_profundidad_aux(BTree arbol, int dato, int profundidad) {
  if (arbol == NULL) return 0;
  if (arbol->dato == dato) return profundidad;

  return btree_profundidad_aux(arbol->left, dato, profundidad+1) + btree_profundidad_aux(arbol->right, dato, profundidad+1);
}

int btree_profundidad (BTree arbol, int dato) {
  int profundidad = btree_profundidad_aux(arbol, dato, 0);
  return btree_profundidad(arbol, profundidad);
}

int btree_suma(BTree arbol) {
  if (arbol == NULL )return 0;
  return arbol->dato + btree_suma(arbol->left) + btree_suma(arbol->right);
}