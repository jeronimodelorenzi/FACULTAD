#include <stdlib.h>
#include "dlist.h"

DList* dlist_crear () {
  DList* lista = malloc(sizeof(DList));
  lista->primero = NULL;
  lista->ultimo = NULL;
  return lista;
}

DList* dlist_agregar_inicio (DList* lista, int dato) {
  DNodo* nuevoNodo = malloc(sizeof(DNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = lista->primero;
  nuevoNodo->ant = NULL;

  if (lista->primero != NULL)
    lista->primero->ant = nuevoNodo;
  if (lista->ultimo == NULL)
    lista->ultimo = nuevoNodo;
  lista->primero = nuevoNodo;
 
  return lista;

}

DList* dlist_agregar_final (DList* lista, int dato) {
  DNodo* nuevoNodo = malloc(sizeof(DNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;
  nuevoNodo->ant = lista->ultimo;
  
  if (lista->primero == NULL)
    lista->primero = nuevoNodo;
  if(lista->ultimo != NULL)
    lista->ultimo->sig = nuevoNodo;
  lista->ultimo = nuevoNodo;
    
  return lista;
}

void dlist_recorrer(DList* lista, DListOrdenDeRecorrido direccion, FuncionVisitante f) {
  if (direccion == 0) {
    for (DNodo* nodo = lista->primero ; nodo != NULL ; nodo = nodo->sig)
      f(nodo->dato);
  } else {
    for (DNodo* nodo = lista->ultimo ; nodo != NULL ; nodo = nodo->ant)
      f(nodo->dato);
  }
}

void dlist_destruir(DList* lista) {
  for (DNodo* nodo = lista->primero ; nodo != NULL ;) {
    DNodo* siguiente = nodo->sig;
    free(nodo);
    nodo = siguiente;
  }

  lista->primero = NULL;
  lista->ultimo = NULL;
}