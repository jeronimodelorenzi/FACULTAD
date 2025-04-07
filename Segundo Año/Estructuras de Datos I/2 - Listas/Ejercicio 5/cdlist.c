#include <stdlib.h>
#include "cdlist.h"

CDList cdlist_crear() {
  return NULL;
}

CDList cdlist_agregar_inicio(CDList lista, int dato) {
  DNodo* nuevoNodo = malloc(sizeof(DNodo));
  nuevoNodo->dato = dato;
  
  if (lista == NULL) {
    nuevoNodo->sig = nuevoNodo;
    nuevoNodo->ant = nuevoNodo;
    return nuevoNodo;
  }

  nuevoNodo->sig = lista;
  nuevoNodo->ant = lista->ant;
  lista->ant->sig = nuevoNodo;
  lista->ant = nuevoNodo;
  
  return nuevoNodo;
}

CDList cdlist_agregar_final(CDList lista, int dato) {
  DNodo* nuevoNodo = malloc(sizeof(DNodo));
  nuevoNodo->dato = dato;

  if (lista == NULL) {
    nuevoNodo->sig = nuevoNodo;
    nuevoNodo->ant = nuevoNodo;
    return nuevoNodo;
  }

  nuevoNodo->sig = lista;
  nuevoNodo->ant = lista->ant;
  lista->ant->sig = nuevoNodo;
  lista->ant= nuevoNodo;

  return lista; // return cdlist_agregar_inicio(lista,dato)->sig
}

void cdlist_recorrer(CDList lista, DListOrdenDeRecorrido direccion, FuncionVisitante f) {
  if (direccion == 0){
    f(lista->dato);
    for (DNodo* nodo = lista->sig ; nodo != lista ; nodo = nodo->sig)
        f(nodo->dato);
  } else {
    DNodo* final = lista->ant;
    f(final->dato);
    for (DNodo* nodo = final->ant ; nodo != final ; nodo = nodo->ant)
        f(nodo->dato);
  }
}

void cdlist_destruir(CDList lista) {
  if (lista == NULL) return;
  
  lista->ant->sig = NULL;
  DNodo* nodoAEliminar;
  while (lista != NULL) {
    nodoAEliminar = lista;
    lista = lista->sig;
    free(nodoAEliminar);
  }
}