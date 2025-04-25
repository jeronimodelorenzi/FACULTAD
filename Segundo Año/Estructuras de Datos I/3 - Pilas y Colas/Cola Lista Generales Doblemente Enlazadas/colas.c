#include <stdio.h>
#include <stdlib.h>
#include "colas.h"

Cola cola_crear () {
  return glist_crear();
}

void cola_destruir (Cola cola, FuncionDestructora destroy) {
  glist_destruir(cola, destroy);
}

int cola_es_vacia (Cola cola) {
  return glist_vacia(cola);
}

void* cola_inicio (Cola cola) {
  return cola->inicio->data;
}

void cola_encolar (Cola cola, void *data, FuncionCopia copy) {
  glist_agregar_final(cola, data, copy);
}

void cola_desencolar (Cola cola, FuncionDestructora destroy) {
  GNode *nodoToDelete = cola->inicio;

  if (cola->inicio->next == NULL) {
    cola->inicio = NULL;
    cola->final = NULL;
  } else {
    cola->inicio = cola->inicio->next;
  }

  destroy(nodoToDelete->data);
  free(nodoToDelete);
}

void cola_imprimir (Cola cola, FuncionVisitante visit) {
  for (GNode *temp = cola->inicio ; temp != NULL ; temp = temp->next) {
    visit(temp->data);
  }
}