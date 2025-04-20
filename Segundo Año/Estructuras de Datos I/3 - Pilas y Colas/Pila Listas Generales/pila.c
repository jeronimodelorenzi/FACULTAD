#include <stdlib.h>
#include "pila.h"


// Implemente pilas generales utilizando las listas simplemente enlazadas generales de la práctica 2.
// Utilice la siguiente declaración:
// typedef GList Pila;
// Defina las mismas operaciones que en el ejercicio anterior, ajustando los prototipos según lo requiera.
// Procure manipular la lista únicamente a través de las funciones declaradas en su interfaz.

Pila pila_crear() {
  Pila pila = malloc(sizeof(struct _Pila));
  pila->lista = glist_crear();
  return pila;
}

void pila_destruir (Pila pila, FuncionDestructora destroy) {
  glist_destruir(pila->lista, destroy);
  free(pila);
}

int pila_es_vacia (Pila pila) {
  return glist_vacia(pila->lista);
}

void* pila_tope (Pila pila) {
  if(pila_es_vacia(pila))
    return NULL;
  return pila->lista->data;
}

void pila_apilar (Pila pila, void *elemento, FuncionCopia copy) {
  pila->lista = glist_agregar_inicio(pila->lista, elemento, copy);
}

void pila_desapilar (Pila pila, FuncionDestructora destroy) {
  GNode* temp = pila->lista;
  pila->lista = pila->lista->next;
  destroy(temp->data);
  free(temp);
}

void pila_imprimir (Pila pila, FuncionVisitante visit) {
  glist_recorrer(pila->lista, visit);
}