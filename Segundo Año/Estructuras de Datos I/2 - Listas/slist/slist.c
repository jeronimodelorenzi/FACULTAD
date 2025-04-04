#include "slist.h"
#include <stdlib.h>

SList slist_crear() {
  return NULL;
}

void slist_destruir(SList lista) {
  SNodo *nodoAEliminar;
  while (lista != NULL) {
    nodoAEliminar = lista;
    lista = lista->sig;
    free(nodoAEliminar);
  }
}

int slist_vacia(SList lista) {
  return lista == NULL;
}

SList slist_agregar_final(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;

  if (lista == NULL)
    return nuevoNodo;

  SList nodo = lista;
  for (;nodo->sig != NULL;nodo = nodo->sig);
  /* ahora 'nodo' apunta al ultimo elemento en la lista */

  nodo->sig = nuevoNodo;
  return lista;
}

SList slist_agregar_inicio(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = lista;
  return nuevoNodo;
}

void slist_recorrer(SList lista, FuncionVisitante visit) {
  for (SNodo *nodo = lista; nodo != NULL; nodo = nodo->sig)
    visit(nodo->dato);
}

// a) slist_longitud que devuelve la longitud de una lista.

int slist_longitud (SList inicio /* SNodo* inicio */) {
  int cont = 0;
  for (SNodo* temp = inicio ; temp != NULL ; temp = temp->sig)
    cont ++;
  return cont;
}

// b) slist_concatenar que devuelve la concatenación de dos listas, modificando la primera.

void slist_concatenar (SList* lista1, SList* lista2) {
  SNodo* temp = *lista1; 
  for(; temp != NULL ; temp = temp->sig);
  temp = *lista2;
}

// slist_insertar que inserta un dato en una lista en una posición arbitraria.

void slist_insertar(SList* lista, int dato, int pos) {
  SNodo* nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;
  
  if (*lista == NULL) {
    *lista = nuevoNodo;
  } else {
    SNodo* temp = *lista;
    SNodo* temp2 = (*lista)->sig;
    int contador = 0;
    for (; contador < pos && temp2 != NULL ; contador++) {
      temp = temp->sig;
      temp2 = temp2->sig;
    }
    temp->sig = nuevoNodo;
    nuevoNodo->sig = temp2;
  }
}