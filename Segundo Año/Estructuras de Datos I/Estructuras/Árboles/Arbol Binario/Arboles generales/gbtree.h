#ifndef __BTREE_H__
#define __BTREE_H__

typedef void (*FuncionVisitante)(void* dato);
typedef void (*FuncionVisitanteExtra)(void* dato, void *extra);
typedef void* (*FuncionCopia)(void *dato);
typedef void (*FuncionDestructora)(void *dato);

typedef enum {
  GBTREE_RECORRIDO_IN,
  GBTREE_RECORRIDO_PRE,
  GBTREE_RECORRIDO_POST
} GBTreeOrdenDeRecorrido;

typedef struct _GBTNodo *GBTree;

/**
 * Devuelve un árbol vacío.
 */
GBTree gbtree_crear();

/**
 * Destrucción del árbol.
 */
void gbtree_destruir(GBTree nodo, FuncionDestructora destroy);

/**
 * Indica si el árbol es vacío.
 */
int gbtree_empty(GBTree nodo);

/**
 * Crea un nuevo árbol, con el dato dado en el nodo raíz, y los subárboles dados
 * a izquierda y derecha.
 */
GBTree gbtree_unir(void *dato, GBTree left, GBTree right, FuncionCopia copy);

/**
 * Recorrido del árbol, utilizando la función pasada.
 */
void gbtree_recorrer(GBTree arbol, GBTreeOrdenDeRecorrido orden, FuncionVisitante visit);

/**
 * Recorrido del árbol, utilizando la función extra.
 */
void gbtree_recorrer_extra(GBTree arbol, GBTreeOrdenDeRecorrido orden, FuncionVisitanteExtra visit, void *extra);

/**
 * Recorrido del árbol, utilizando la función pasada. Utiliza busqueda por extensión.
 */
int gbtree_recorrer_bfs(GBTree arbol, FuncionVisitante visit);

/**
 * Retorna el número de nodos del árbol.
 */
int gbtree_nnodos(GBTree arbol);

/**
 * Retorna 1 si el número está en el árbol, 0 en caso contrario.
 */
int gbtree_buscar(GBTree arbol, void *dato);

/**
 * Retorna un nuevo árbol que es la copia del árbol dado.
 */
GBTree gbtree_copia(GBTree arbol, FuncionCopia copy);

/**
 * Retorna la altura del árbol.
 */
int gbtree_altura(GBTree arbol);

/**
 * Retorna el número de nodos que se encuentran a la profundidad dada.
 */
int gbtree_nnodos_profundidad(GBTree arbol, int profundidad);

/**
 * Retorna la profundidad del nodo que contiene el número dado, 
 * si el número no se encuentra en el árbol retorna -1.
 */
int gbtree_profundidad(GBTree arbol, void *dato);


#endif 
