#include "sglist.h"
#include <stdio.h>
#include <stdlib.h>

SGList* sglist_crear () {
  SGList* lista = malloc(sizeof(SGList));
  lista->inicio = NULL;
  lista->final = NULL;
  return lista;
}

void sglist_destruir (SGList* lista, FuncionDestructora destructora) {
  for (SGNode* nodo = lista->inicio ; nodo != NULL ;) {
    SGNode* siguiente = nodo->next;
    destructora(nodo->data);
    free(nodo);
    nodo = siguiente;
  }

  lista->inicio = NULL;
  lista->final = NULL;
}

int sglist_vacia (SGList* lista) {
  return lista->inicio == NULL;
}

void sglist_recorrer (SGList* lista, FuncionVisitante visitante) {
  for (SGNode* nodo = lista->inicio ; nodo != NULL ; nodo = nodo->next)
    visitante(nodo->data);
}

void sglist_insertar (SGList* lista, void *data, FuncionCopia copia, FuncionComparadora comparadora) {
  SGNode* nuevoNodo = malloc(sizeof(SGNode));
  nuevoNodo->data = copia(data);
  nuevoNodo->next = NULL;

  if (sglist_vacia(lista)) {
    lista->inicio = nuevoNodo;
    lista->final = nuevoNodo;
    return;
  }

  SGNode* nodo = lista->inicio;

  if (comparadora(data, nodo->data) <= 0) {
    nuevoNodo->next = lista->inicio;
    lista->inicio = nuevoNodo;
    return;
    
  }

  for (; nodo->next != NULL && comparadora(data, nodo->next->data) > 0 ; nodo = nodo->next);

  nuevoNodo->next = nodo->next;
  nodo->next = nuevoNodo;

  if (nuevoNodo->next == NULL) {
    lista->final = nuevoNodo;
  }
}

int sglist_buscar (SGList *lista, void *data, FuncionComparadora comparadora) {
  int encontrado = 0;
  
  if (sglist_vacia(lista)) return 0;

  if (comparadora(data, lista->inicio->data) < 0 || comparadora(data, lista->final->data) > 0) {
    return encontrado;
  }
  
  for(SGNode *nodo = lista->inicio ; nodo->next != NULL && !encontrado ; nodo = nodo->next) {
    if (comparadora(data, nodo->data) == 0) {
      encontrado = 1;
    }
    if (comparadora(data,nodo->data) < 0){
      nodo = NULL;
    }
  }

  return encontrado;
}

SGList* sglist_arr (void **arr, int longitud, FuncionCopia copia, FuncionComparadora comparadora) {
  SGList* lista = sglist_crear();
  
  for (int i = 0 ; i < longitud ; i++)
    sglist_insertar(lista, arr[i], copia, comparadora);

  return lista;
}

