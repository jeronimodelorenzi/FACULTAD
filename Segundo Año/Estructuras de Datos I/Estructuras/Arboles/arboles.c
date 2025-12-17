#include <stdio.h>
#include <stdlib.h>
#include "arboles.h"
#include "../Pilas y Cola/colas.h"

struct _GBTNodo {
  void *dato;
  struct _GBTNodo *left;
  struct _GBTNodo *right;
};

GBTree gbtree_crear () { return NULL; }

void gbtree_destruir (GBTree node, FuncionDestructora d) {
  if (node != NULL) {
    gbtree_destruir(node->left, d);
    gbtree_destruir(node->right, d);
    d(node->dato);
    free(node);
  }
}

int gbtree_empty (GBTree node) { return node == NULL; }

GBTree gbtree_unir (void *dato, GBTree left, GBTree right, FuncionCopia c) {
  GBTree newNode = malloc(sizeof(struct _GBTNodo));
  newNode->dato = c(dato);
  newNode->left = left;
  newNode->right = right;
  return newNode;
}

void gbtree_recorrer (GBTree tree, GBTreeOrdenDeRecorrido orden, FuncionVisitante v) {
  if (tree == NULL) return;

  if (orden == GBTREE_RECORRIDO_PRE)
    v(tree->dato);

  gbtree_recorrer(tree->left, orden, v);

  if (orden == GBTREE_RECORRIDO_IN)
    v(tree->dato);

  gbtree_recorrer(tree->right, orden, v);

  if (orden == GBTREE_RECORRIDO_POST)
    v(tree->dato);
}

void gbtree_recorrer_extra (GBTree tree, GBTreeOrdenDeRecorrido orden, FuncionVisitanteExtra v, void *extra) {
  if (tree == NULL) return;

  if (orden == GBTREE_RECORRIDO_PRE)
    v(tree->dato, extra);

  gbtree_recorrer_extra(tree->left, orden, v, extra);

  if (orden == GBTREE_RECORRIDO_IN)
    v(tree->dato, extra);

  gbtree_recorrer_extra(tree->right, orden, v, extra);

  if (orden == GBTREE_RECORRIDO_POST)
    v(tree->dato, extra);
}

int gbtree_nnodos (GBTree tree) {
  if (tree == NULL) return 0;

  return 1 + gbtree_nnodos(tree->left) + gbtree_nnodos(tree->right);
}

int gbtree_buscar (GBTree tree, void *data) {
  if (tree == NULL) return 0;

  if (tree->dato == data) return 1;

  int inL = gbtree_buscar(tree->left, data);
  int inR = gbtree_buscar(tree->right, data);

  return inL || inR;
}

GBTree gbtree_copia(GBTree tree, FuncionCopia c) {
  if (tree == NULL) return NULL;
  GBTree newNode = malloc(sizeof(struct _GBTNodo));
  newNode->dato = c(tree->dato);
  newNode->left = gbtree_copia(tree->left, c);
  newNode->right = gbtree_copia(tree->right, c);
  return newNode;
}

int gbtree_altura(GBTree tree) {
  if (tree == NULL) return 0;
  
  int treeL = 1 + gbtree_altura(tree->left);
  int treeR = 1 + gbtree_altura(tree->right);

  if (treeL < treeR) return treeR;
  return treeL;
}

int gbtree_nnodos_profundidad (GBTree tree, int depth) {
  if (tree == NULL) return 0;
  if (depth == 0) return 1;

  return gbtree_nnodos_profundidad(tree->left, depth-1) + gbtree_nnodos_profundidad(tree->right, depth-1);
}

static int gbtree_profundidad_aux (GBTree tree, void *data, int depth) {
  if (tree == NULL) return -1;
  if (tree->dato == data) return depth;

  int treeL = gbtree_profundidad_aux(tree->left, data, depth+1);
  if (treeL != -1) return treeL;

  return gbtree_profundidad_aux(tree->right, data, depth+1);
}

int gbtree_profundidad (GBTree tree, void *data) {
  return gbtree_profundidad_aux(tree, data, 0);
}

void gbtree_recorrer_bfs_aux (GBTree tree, int depth, FuncionVisitante v) {
  if (tree == NULL) return;

  if (depth == 0)
    v(tree->dato);
  else {
    gbtree_recorrer_bfs_aux (tree->left, depth-1, v);
    gbtree_recorrer_bfs_aux (tree->right, depth-1, v);
  }
}

void gbtree_recorrer_bfs (GBTree tree, FuncionVisitante v) {
  int height = gbtree_altura(tree);
  for (int i = 0 ; i < height ; i++)
    gbtree_recorrer_bfs_aux(tree, i, v);
}

void* identidad_nodo(void *dato) {
    return dato;
}

void no_op_destruir(void *dato) {
    return; 
}

void gbtree_recorrer_bfs_cola (GBTree tree, FuncionVisitante v) {
  if (tree == NULL) return;

  Cola q = cola_crear();

  cola_encolar(q, tree, identidad_nodo);

  while(!cola_es_vacia(q)) {
    struct _GBTNodo *nodo = (struct _GBTNodo *)cola_inicio(q);

    cola_desencolar(q, no_op_destruir);

    v(nodo->dato);

    struct _GBTNodo *hijo = nodo->left;

    while(hijo != NULL) {
      cola_encolar(q, hijo, identidad_nodo);
      hijo = hijo->right;
    }
  }
  
  cola_destruir(q, no_op_destruir);
}

void *copiar_int(void *dato) {
    int *nuevo = malloc(sizeof(int));
    if (nuevo == NULL) return NULL;
    *nuevo = *(int*)dato;
    return nuevo;
}

// Libera la memoria del entero
void destruir_int(void *dato) {
    free(dato);
}

// Imprime el entero
void imprimir_int(void *dato) {
    printf("%d ", *(int*)dato);
}

int main() {
    printf("=== INICIO DE PRUEBAS: ARBOL GENERAL ===\n\n");

    // Variables locales (usaremos su dirección para copiar)
    int v1=1, v2=2, v3=3, v4=4, v5=5, v6=6;

    // 1. CONSTRUCCIÓN DEL ÁRBOL (De abajo hacia arriba)
    // Estructura deseada: 
    //      1
    //    / | 
    //   2  3  4
    //  / 
    // 5   6

    // Nivel más profundo (Hijos de 2): 5 y 6
    // 6 es el último hermano, no tiene hijos (L=NULL) ni más hermanos (R=NULL)
    GBTree nodo6 = gbtree_unir(&v6, NULL, NULL, copiar_int);
    
    // 5 tiene a 6 como hermano derecho (R=nodo6), y no tiene hijos (L=NULL)
    GBTree nodo5 = gbtree_unir(&v5, NULL, nodo6, copiar_int);

    // Nivel medio (Hijos de 1): 2, 3, 4
    // 4 es el último hermano
    GBTree nodo4 = gbtree_unir(&v4, NULL, NULL, copiar_int);
    
    // 3 tiene a 4 como hermano derecho
    GBTree nodo3 = gbtree_unir(&v3, NULL, nodo4, copiar_int);

    // 2 tiene a 5 como PRIMER HIJO (L=nodo5) y a 3 como HERMANO DERECHO (R=nodo3)
    GBTree nodo2 = gbtree_unir(&v2, nodo5, nodo3, copiar_int);

    // Raíz 1: Tiene a 2 como PRIMER HIJO (L=nodo2) y no tiene hermanos (R=NULL)
    GBTree arbol = gbtree_unir(&v1, nodo2, NULL, copiar_int);

    printf("Arbol construido correctamente.\n");

    // 2. PRUEBA DE RECORRIDO BFS (Cola)
    // Debería imprimir por niveles del árbol GENERAL: 1, 2 3 4, 5 6
    printf("\n--- Test BFS (Cola) ---\n");
    printf("Esperado: 1 2 3 4 5 6\n");
    printf("Obtenido: ");
    gbtree_recorrer_bfs_cola(arbol, imprimir_int);
    printf("\n");

    // 3. PRUEBA DE ESTADÍSTICAS
    printf("\n--- Estadísticas ---\n");
    // Nota: gbtree_nnodos cuenta nodos físicos, debe dar 6
    printf("Numero de nodos: %d (Esperado: 6)\n", gbtree_nnodos(arbol));
    
    // Nota: gbtree_altura usa lógica binaria en tu implementación (L vs R).
    // En estructura binaria, la profundidad sería mayor porque los hermanos suman altura.
    printf("Altura (logica binaria): %d\n", gbtree_altura(arbol));

    // 4. BÚSQUEDA
    // Tu función buscar compara punteros (tree->dato == data).
    // Como usamos copia, no podemos buscar &v5 directamente.
    // Tendríamos que buscar el puntero exacto o modificar la función buscar.
    // Probaremos buscar la raíz que sabemos el puntero por el acceso manual:
    printf("\n--- Búsqueda (Por puntero) ---\n");
    printf("Busco el dato del nodo 2: %s\n", 
            gbtree_buscar(arbol, nodo2->dato) ? "Encontrado" : "No encontrado");

    // 5. COPIA DEL ÁRBOL
    printf("\n--- Copia Profunda ---\n");
    GBTree copia = gbtree_copia(arbol, copiar_int);
    printf("BFS de la Copia: ");
    gbtree_recorrer_bfs_cola(copia, imprimir_int);
    printf("\n");

    // 6. DESTRUCCIÓN (Vital para Valgrind)
    printf("\n--- Destrucción ---\n");
    gbtree_destruir(arbol, destruir_int);
    gbtree_destruir(copia, destruir_int);
    
    printf("Arboles destruidos. Fin del programa.\n");
    return 0;
}