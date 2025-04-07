#include "slist_ej3.h"
#include <stdlib.h>

SList* slist_crear() {
  SList* lista = malloc(sizeof(SList));
  lista->primero = NULL;
  lista->ultimo = NULL;
  return lista;
}

SList* slist_agregar_inicio (SList* lista, int dato) {
  SNodo* nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = lista->primero;
  
  lista->primero = nuevoNodo;  

  if (lista->ultimo == NULL)
    lista->ultimo = nuevoNodo;

  return lista;
}

SList* slist_agregar_final (SList* lista, int dato) {
  SNodo* nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;

  if (lista->primero == NULL) {
    lista->primero = nuevoNodo;
    lista->ultimo = nuevoNodo;
  } else {
    lista->ultimo->sig = nuevoNodo;
    lista->ultimo = nuevoNodo;
  }

  return lista;
}

void slist_recorrer(SList* lista, FuncionVisitante visit) {
  for (SNodo *nodo = lista->primero; nodo != NULL; nodo = nodo->sig)
    visit(nodo->dato);
}