#include "bstree.h"
#include <assert.h>
#include <stdlib.h>

/**
 * Estructura del nodo del arbol de busqueda binaria.
 * Tiene un puntero al dato (dato),
 * un puntero al nodo raiz del subarbol izquierdo (izq),
 * y un puntero al nodo raiz del subarbol derecho (der).
 */
struct _BST_Nodo {
  void *dato;
  struct _BST_Nodo *izq, *der;
};

BSTree bstee_crear() { return NULL; }

void bstree_destruir(BSTree raiz, FuncionDestructora destr) {
  if (raiz != NULL) {
    bstree_destruir(raiz->izq, destr);
    bstree_destruir(raiz->der, destr);
    destr(raiz->dato);
    free(raiz);
  }
};

int bstree_buscar(BSTree raiz, void *dato, FuncionComparadora comp) {
  if (raiz == NULL)
    return 0;
  else if (comp(dato, raiz->dato) == 0) // raiz->dato == dato
    return 1;
  else if (comp(dato, raiz->dato) < 0) // dato < raiz->dato
    return bstree_buscar(raiz->izq, dato, comp);
  else // raiz->dato < dato
    return bstree_buscar(raiz->der, dato, comp);
}

BSTree bstree_insertar(BSTree raiz, void *dato, FuncionCopiadora copia, FuncionComparadora comp) {
  if (raiz == NULL) { // insertar el dato en un nuevo nodo
    struct _BST_Nodo *nuevoNodo = malloc(sizeof(struct _BST_Nodo));
    assert(nuevoNodo != NULL);
    nuevoNodo->dato = copia(dato);
    nuevoNodo->izq = nuevoNodo->der = NULL;
    return nuevoNodo;
  } else if (comp(dato, raiz->dato) < 0) // dato < raiz->dato
    raiz->izq = bstree_insertar(raiz->izq, dato, copia, comp);
  else if (comp(dato, raiz->dato) > 0) // raiz->dato < dato
    raiz->der = bstree_insertar(raiz->der, dato, copia, comp);
  // si el dato ya se encontraba, no es insertado
  return raiz;
}

/**
 * bstree_recorrer: Recorrido DSF del arbol
 */
void bstree_recorrer (BSTree arbol, BSTreeRecorrido orden, FuncionVisitanteExtra visit, void *extra) {
  if (arbol == NULL)
    return;

  if (orden == BTREE_RECORRIDO_PRE)
    visit(arbol->dato, extra);

  bstree_recorrer_extra(arbol->izq, orden, visit, extra);

  if (orden == BTREE_RECORRIDO_IN)
  visit(arbol->dato, extra);

  bstree_recorrer_extra(arbol->der, orden, visit, extra);

  if (orden == BTREE_RECORRIDO_POST)
    visit(arbol->dato, extra);
}
BSTree bstree_eliminar(BSTree arbol, void *dato, FuncionComparadora comp, FuncionDestructora destroy) {
  if (arbol == NULL) return NULL;

  if (comp(arbol->dato, dato) == 0) {

    if (arbol->izq == NULL && arbol->dato == NULL ){
      destroy(arbol->dato);
      free(arbol);
      return NULL;
    }
    if (arbol->izq == NULL) {
      destroy(arbol->dato);
      return 
    }
  }
}
