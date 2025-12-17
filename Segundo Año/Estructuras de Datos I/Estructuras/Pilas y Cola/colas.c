#include <stdio.h>
#include <stdlib.h>
#include "colas.h"

GList* glist_crear () {
  GList *list = malloc(sizeof(GList));
  list->inicio = NULL;
  list->final = NULL;
  return list;
}

Cola cola_crear () {
  return glist_crear();
}

void glist_destruir (GList* list, FuncionDestructora d) {
  GNode *nodeToDelete;
  GNode *temp = list->inicio;
  while (temp != NULL) {
    nodeToDelete = temp;
    temp = temp->next;
    d(nodeToDelete->data);
    free(nodeToDelete);
  }
  free(list);
}

void cola_destruir (Cola cola, FuncionDestructora d) {
  glist_destruir(cola, d);
}

int glist_vacia (GList *list) {
  return list->inicio == NULL;
}

int cola_es_vacia (Cola cola) {
  return glist_vacia(cola);
}

void *cola_inicio (Cola cola) {
  return cola->inicio->data;
}

GList* glist_agregar_final (GList *list, void *data, FuncionCopia c) {
  GNode* newNode = malloc(sizeof(GNode));
  newNode->data = c(data);
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

void cola_encolar (Cola cola, void *data, FuncionCopia c) {
  glist_agregar_final(cola, data, c);
}

void cola_desencolar (Cola cola, FuncionDestructora d) {
  GNode *nodeToDelete = cola->inicio;

  if (cola->inicio->next == NULL) {
    cola->inicio = NULL;
    cola->final = NULL;
  } else {
    cola->inicio = cola->inicio->next;
  }

  d(nodeToDelete->data);
  free(nodeToDelete);
}

void glist_recorrer (GList *list, FuncionVisitante v) {
  for (GNode *temp = list->inicio ; temp != NULL ; temp = temp->next)
    v(temp->data);
}

//void cola_imprimir (Cola cola, FuncionVisitante v) {
//  glist_recorrer (cola, v);
//}

// Funciones auxiliares para enteros
// void *copiar_int(void *dato) {
//     int *nuevo = malloc(sizeof(int));
//     *nuevo = *(int*)dato;
//     return nuevo;
// }

// void destruir_int(void *dato) {
//     free(dato);
// }

// void imprimir_int(void *dato) {
//     printf("%d -> ", *(int*)dato);
// }

// int main() {
//     printf("=== TEST COLA ===\n");
//     Cola c = cola_crear();
    
//     int v1 = 10, v2 = 20, v3 = 30;

//     printf("Encolando...\n");
//     cola_encolar(c, &v1, copiar_int);
//     cola_encolar(c, &v2, copiar_int);
//     cola_encolar(c, &v3, copiar_int);

//     // Esperado: 10 -> 20 -> 30 ->
//     cola_imprimir(c, imprimir_int);
//     printf("NULL\n");

//     printf("Inicio: %d\n", *(int*)cola_inicio(c));

//     printf("Desencolando uno...\n");
//     cola_desencolar(c, destruir_int);
    
//     // Esperado: 20 -> 30 ->
//     cola_imprimir(c, imprimir_int);
//     printf("NULL\n");

//     printf("Desencolando el resto...\n");
//     cola_desencolar(c, destruir_int);
//     cola_desencolar(c, destruir_int);
    
//     if (cola_es_vacia(c)) printf("La cola esta vacia correctamente.\n");

//     cola_destruir(c, destruir_int);
    
//     printf("Memoria liberada.\n");
//     return 0;
// }