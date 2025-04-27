#include "glist.h"
#include <assert.h>
#include <stdlib.h>

/**
 * Devuelve una lista vacía.
 */
GList glist_crear() { return NULL; }

/**
 * Destruccion de la lista.
 * destroy es una función que libera el dato almacenado.
 */
void glist_destruir(GList list, FuncionDestructora destroy) {
  GNode *nodeToDelete;
  while (list != NULL) {
    nodeToDelete = list;
    list = list->next;
    destroy(nodeToDelete->data);
    free(nodeToDelete);
  }
}

/**
 * Determina si la lista es vacía.
 */
int glist_vacia(GList list) { return (list == NULL); }

/**
 * Agrega un elemento al inicio de la lista.
 * copy es una función que retorna una copia física del dato.
 */
GList glist_agregar_inicio(GList list, void *data, FuncionCopia copy) {
  GNode *newNode = malloc(sizeof(GNode));
  assert(newNode != NULL);
  newNode->next = list;
  newNode->data = copy(data);
  return newNode;
}

GList glist_agregar_finalR(GList lista, void *dato, FuncionCopia copiar) {
  if (lista == NULL) {
    GNode * newNode = malloc(sizeof(GNode));
    newNode->data = copiar(dato);
    newNode->next = NULL;
    return newNode;
  }
  lista->next = glist_agregar_final(lista->next, dato, copiar);
  return lista;
}


/**
 * Recorrido de la lista, utilizando la funcion pasada.
 */
void glist_recorrer(GList list, FuncionVisitante visit) {
  for (GNode *node = list; node != NULL; node = node->next)
    visit(node->data);
}

GList glist_filtrarR(GList lista, FuncionCopia c, Predicado p) {
  GList nuevaLista = glist_crear();
  
  for(GNode* node = lista; node != NULL ; node = node->next)
    if (p(node->data))
      nuevaLista = glist_agregar_inicio(nuevaLista, node->data, c);

  return nuevaLista;
}

GList glist_filtrarR(GList lista, FuncionCopia c, Predicado p) {
  if (glist_vacia(lista)) return glist_crear();
  GList newList = glist_filtrarR(lista->next, c, p);

  if (p(lista->data))
    newList = glist_agregar_inicio(newList, lista->data, c);

  return newList;
}