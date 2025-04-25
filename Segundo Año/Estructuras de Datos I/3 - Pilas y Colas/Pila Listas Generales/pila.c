#include <stdlib.h>
#include "pila.h"
#include "glist.h"

// Implemente pilas generales utilizando las listas simplemente enlazadas generales de la práctica 2.
// Utilice la siguiente declaración:
// typedef GList Pila;
// Defina las mismas operaciones que en el ejercicio anterior, ajustando los prototipos según lo requiera.
// Procure manipular la lista únicamente a través de las funciones declaradas en su interfaz.

Pila pila_crear() {
  return glist_crear();
}

void pila_destruir (Pila pila, FuncionDestructora destroy) {
  glist_destruir(pila, destroy);
}

int pila_es_vacia (Pila pila) {
  return glist_vacia(pila);
}

void* pila_tope (Pila pila) {
  if(pila_es_vacia(pila))
    return NULL;
  return pila->data;
}

void pila_apilar (Pila* pila, void *elemento, FuncionCopia copy) {
  *pila = glist_agregar_inicio(*pila, elemento, copy);
}

void pila_desapilar (Pila* pila, FuncionDestructora destroy) {
  GNode* temp = *pila;
  *pila = (*pila)->next;
  destroy(temp->data);
  free(temp);
}

void pila_imprimir (Pila pila, FuncionVisitante visit) {
  glist_recorrer(pila, visit);
}

Pila pila_revertir_orden(Pila pila, FuncionCopia copy) {
  Pila nueva_pila = pila_crear();
  for (GNode *temp = pila ; temp != NULL ; temp = temp->next)
    pila_apilar(&nueva_pila, temp->data, copy);
  return nueva_pila;
}