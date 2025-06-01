#ifndef __AVL_H__
#define __AVL_H__

typedef void *(*FuncionCopiadora)(void *dato);
typedef int (*FuncionComparadora)(void *, void *);
typedef void (*FuncionDestructora)(void *dato);
typedef void (*FuncionVisitanteExtra)(void *dato, void *extra);

typedef enum {
  AVL_RECORRIDO_IN,  
  AVL_RECORRIDO_PRE, 
  AVL_RECORRIDO_POST
} AVLRecorrido;

typedef struct _AVL *AVL;

/**
 * Retorna un árbol AVL vacío.
 */
AVL avl_crear(FuncionCopiadora copy, FuncionComparadora comp, FuncionDestructora destroy);

/**
 * Destruye el árbol y sus datos.
 */
void avl_destruir(AVL arbol);

/**
 * Retorna 1 si el dato se encuentra y 0 en caso contrario.
 */
int avl_buscar(AVL arbol, void * dato);

/**
 * Inserta un dato no repetido en el árbol, manteniendo la propiedad de los
 * árboles AVL.
 */
void avl_insertar(AVL arbol, void * dato);

/**
 * Elimina un dato del árbol, manteniendo la propiedad de los árboles AVL.
 */
void avl_eliminar(AVL, void *);

/**
 * Retorna 1 si el árbol cumple la propiedad de los árboles AVL, y 0 en caso
 * contrario.
 */
int avl_validar(AVL arbol);

/**
 * Recorrido DSF del árbol.
 */
void avl_recorrer(AVL arbol, AVLRecorrido orden, FuncionVisitanteExtra visitextra, void *dato);

#endif /* __AVL_H__*/