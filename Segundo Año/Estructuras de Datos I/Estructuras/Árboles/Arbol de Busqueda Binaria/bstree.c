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

void bstree_recorrer (BSTree arbol, BSTreeRecorrido orden, FuncionVisitanteExtra visit, void *extra) {
  if (arbol == NULL)
    return;

  if (orden == BTREE_RECORRIDO_PRE)
    visit(arbol->dato, extra);

  bstree_recorrer(arbol->izq, orden, visit, extra);

  if (orden == BTREE_RECORRIDO_IN)
  visit(arbol->dato, extra);

  bstree_recorrer(arbol->der, orden, visit, extra);

  if (orden == BTREE_RECORRIDO_POST)
    visit(arbol->dato, extra);
}

BSTree bstree_eliminar(BSTree arbol, void *dato, FuncionComparadora comp, FuncionDestructora destroy, FuncionCopiadora copy) {
  if (arbol == NULL) return NULL;

  int comparacion = comp(dato, arbol->dato);

  if (comparacion < 0) 
    bstree_eliminar(arbol->izq, dato, comp, destroy, copy);
  else if (comparacion > 0)
    bstree_eliminar(arbol->der, dato, comp, destroy, copy);
  else if (comparacion == 0) {
    // Sin hijos.
    if (arbol->izq == NULL && arbol->der == NULL){
      destroy(arbol->dato);
      free(arbol);
      return NULL;
    }
    // Un solo hijo.
    if (arbol->izq == NULL) {
      BSTree temp = arbol->der;
      destroy(arbol->dato);
      free(arbol);
      return temp;
    }
    if (arbol->der == NULL) {
      BSTree temp = arbol->izq;
      destroy(arbol->dato);
      free(arbol);
      return temp;
    }

    // Dos hijos.
    BSTree suc = arbol->der;
    while(suc->izq != NULL)
      suc = suc->izq;

    destroy(arbol->dato);
    arbol->dato = copy(suc->dato);

    arbol->der = bstree_eliminar(arbol->dato, suc->dato, comp, destroy, copy);
  }

  return arbol;
}

// typedef struct {
//   int k;
//   void *dato;
// } K_esimo;

// void visitar_k_esimo(void* dato, void *extra) {
//   K_esimo *info = (K_esimo*)extra;
//   if(info->dato != NULL) return;

//   info->k--;
//   if (info->k == 0)
//     info->dato = dato;
// }

// void* bstree_k_esimo_menor(BSTree arbol, int k) {
//   K_esimo info;
//   info.dato = NULL;
//   info.k = k;
//   bstree_recorrer(arbol, BTREE_RECORRIDO_IN, visitar_k_esimo, &info);
//   return info.dato;
// }

void* bstree_k_esimo_menor_aux (BSTree arbol, int *k) {
  if (arbol == NULL) return NULL;

  void *izq = bstree_k_esimo_menor_aux(arbol->izq, k);
  if (izq != NULL) return izq;

  (*k)--;
  if (*k == 0) return arbol->dato;

  return bstree_k_esimo_menor_aux(arbol->der, k);
}

void *bstree_k_esimo_menor(BSTree arbol, int k) {
  return bstree_k_esimo_menor_aux(arbol, &k);
}

BSTree bstree_validar_aux (BSTree arbol, FuncionComparadora comp, void* ant, int* validar) {
  if(arbol == NULL || *validar == 0) return NULL;
  
  arbol->izq = bstree_validar_aux(arbol->izq, comp, ant, validar);

  if (comp(ant, arbol->dato) > 0)
    *validar = 0;
  
  ant = arbol->dato;

  arbol->der = bstree_validar_aux(arbol->der, comp, ant, validar);
}

int bstree_validar (BSTree arbol, FuncionComparadora comp) {
  int validar = 1;
  bstree_validar_aux(arbol, comp, NULL, &validar);
  return validar;
}