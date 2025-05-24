#ifndef __BSTREE_H__
#define __BSTREE_H__

typedef void *(*FuncionCopiadora)(void *dato);
typedef int (*FuncionComparadora)(void *, void *);
typedef void (*FuncionDestructora)(void *dato);
typedef void (*FuncionVisitanteExtra)(void *dato, void *extra);

typedef enum {
  BTREE_RECORRIDO_IN,  /** Inorden */
  BTREE_RECORRIDO_PRE, /** Preorden */
  BTREE_RECORRIDO_POST /** Postorden */
} BSTreeRecorrido;

typedef struct _BST_Nodo *BSTree;

/**
 * Retorna un árbol de busqueda binaria vacío.
 */
BSTree bstee_crear();

/**
 * Destruye el árbol y sus datos.
 */
void bstree_destruir(BSTree, FuncionDestructora);

/**
 * Retorna 1 si el dato se encuentra y 0 en caso contrario.
 */
int bstree_buscar(BSTree, void *, FuncionComparadora);

/**
 * Inserta un dato no repetido en el árbol, manteniendo la propiedad del árbol
 * de busqueda binaria.
 */
BSTree bstree_insertar(BSTree, void *, FuncionCopiadora, FuncionComparadora);

/**
 * Elimina un dato del árbol, manteniendo la propiedad del árbol de busqueda binaria.
 */
BSTree bstree_eliminar(BSTree, void *, FuncionComparadora, FuncionDestructora);

/**
 * Recorrido DSF del árbol
 */
void bstree_recorrer(BSTree, BSTreeRecorrido, FuncionVisitanteExtra, void *extra);

/**
 * Retorna el k-ésimo menor elemento del árbol.
 */
void* bstree_k_esimo_menor(BSTree, int);

/**
 * Retorna 1 si el árbol cumple con la propiedad de ABB, en caso contrario retorna 0.
 */
int bstree_validar(BSTree, FuncionComparadora);

#endif //__BSTREE_H__