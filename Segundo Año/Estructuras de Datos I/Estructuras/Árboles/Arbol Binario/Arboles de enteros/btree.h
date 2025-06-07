#ifndef __BTREE_H__
#define __BTREE_H__

typedef void (*FuncionVisitante)(int dato);
typedef void (*FuncionVisitanteExtra)(int dato, void *extra);

typedef enum {
  BTREE_RECORRIDO_IN,
  BTREE_RECORRIDO_PRE,
  BTREE_RECORRIDO_POST
} BTreeOrdenDeRecorrido;

typedef struct _BTNodo *BTree;

/**
 * Devuelve un árbol vacío.
 */
BTree btree_crear();

/**
 * Destrucción del árbol.
 */
void btree_destruir(BTree nodo);

/**
 * Indica si el árbol es vacío.
 */
int btree_empty(BTree nodo);

/**
 * Crea un nuevo árbol, con el dato dado en el nodo raíz, y los subárboles dados
 * a izquierda y derecha.
 */
BTree btree_unir(int dato, BTree left, BTree right);

/**
 * Recorrido del árbol, utilizando la función pasada.
 */
void btree_recorrer(BTree arbol, BTreeOrdenDeRecorrido orden, FuncionVisitante visit);

/**
 * Recorrido del árbol, utilizando la función extra.
 */
void btree_recorrer_extra(BTree arbol, BTreeOrdenDeRecorrido orden, FuncionVisitanteExtra visit, void *extra);

/**
 * Recorrido del árbol, utilizando la función pasada. Utiliza busqueda por extensión.
 */
void btree_recorrer_bfs(BTree arbol, FuncionVisitante visit);

/**
 * Retorna el número de nodos del árbol.
 */
int btree_nnodos(BTree arbol);

/**
 * Retorna 1 si el número está en el árbol, 0 en caso contrario.
 */
int btree_buscar(BTree arbol, int dato);

/**
 * Retorna un nuevo árbol que es la copia del árbol dado.
 */
BTree btree_copia(BTree arbol);

/**
 * Retorna la altura del árbol.
 */
int btree_altura(BTree arbol);

/**
 * Retorna el número de nodos que se encuentran a la profundidad dada.
 */
int btree_nnodos_profundidad(BTree arbol, int profundidad);

/**
 * Retorna la profundidad del nodo que contiene el número dado, 
 * si el número no se encuentra en el árbol retorna -1.
 */
int btree_profundidad(BTree arbol, int dato);

/**
 * Retorna la suma total de los datos del árbol.
 */
int btree_suma(BTree arbol);

#endif 
