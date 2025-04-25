#include "glist.h"
#include <assert.h>
#include <stdlib.h>

/**
 * Devuelve una lista vacía.
 */
GList* glist_crear() { 
  GList* lista = malloc(sizeof(GList));
  lista->inicio = NULL;
  lista->final = NULL;
  return lista;
}

/**
 * Destruccion de la lista.
 * destroy es una función que libera el dato almacenado.
 */
void glist_destruir(GList* list, FuncionDestructora destroy) {
  GNode *nodeToDelete;
  GNode *temp = list->inicio;
  while (temp != NULL) {
    nodeToDelete = temp;
    temp = temp->next;
    destroy(nodeToDelete->data);
    free(nodeToDelete);
  }
  free(list);
}

/**
 * Determina si la lista es vacía.
 */
int glist_vacia(GList* list) { return list->inicio == NULL; }

/**
 * Agrega un elemento al inicio de la lista.
 * copy es una función que retorna una copia física del dato.
 */
GList* glist_agregar_inicio(GList* list, void *data, FuncionCopia copy) {
  GNode *newNode = malloc(sizeof(GNode));
  assert(newNode != NULL);
  newNode->data = copy(data);
  newNode->next = list->inicio;

  if (glist_vacia(list))
    list->final = newNode;
    
  list->inicio = newNode;

  return list;
}

GList* glist_agregar_final(GList* list, void *data, FuncionCopia copy) {
  GNode *newNode = malloc(sizeof(GNode));
  newNode->data = copy(data);
  newNode->next = NULL;

  if (glist_vacia(list)) {
    list->inicio = newNode;
    list->final = newNode;
  } else {
    list->final->next = newNode;
    list->final = newNode;
  }

  return list;
}

/**
 * Recorrido de la lista, utilizando la funcion pasada.
 */
void glist_recorrer(GList* list, FuncionVisitante visit) {
  for (GNode *node = list->inicio; node != NULL; node = node->next)
    visit(node->data);
}

/*GList glist_filtrar(GList lista, FuncionCopia c, Predicado p) {
  GList nuevaLista = glist_crear();
  
  for(GNode* node = lista; node != NULL ; node = node->next)
    if (p(node->data))
      nuevaLista = glist_agregar_inicio(nuevaLista, node->data, c);

  return nuevaLista;
}*/
