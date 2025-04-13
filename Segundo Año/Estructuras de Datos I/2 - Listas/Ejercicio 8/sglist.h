#ifndef __SGLIST_H__
#define __SGLIST_H__

typedef void (*FuncionDestructora)(void *data);
typedef void (*FuncionVisitante)(void *data);
typedef int (*FuncionComparadora)(void *data1, void *data2);
typedef void *(*FuncionCopia)(void *data);

typedef struct _SGNode {
  void *data;
  struct _SGNode *next;
} SGNode;

typedef struct GList {
    SGNode *inicio;
    SGNode *final;
} GList;

typedef GList SGList;

/**
 * Retorna una lista ordenada vacia
 */
SGList* sglist_crear();

/**
 * Destruye una lista ordenada.
 */
void sglist_destruir(SGList* lista, FuncionDestructora destructora);

/**
 * Determina si una lista ordenada es vacía.
 */
int sglist_vacia(SGList* lista);
/**
 * Aplica la funcion visitante a cada elemento de la lista ordenada.
 */
void sglist_recorrer(SGList* lista, FuncionVisitante visitante);

/**
 * Inserta un nuevo dato en la lista ordenada. La función comparadora determina el criterio de ordenación.
 */
void sglist_insertar(SGList* lista, void *data, FuncionCopia copia, FuncionComparadora comparadora);

/**
 * Busca un dato en la lista ordenada retornando 1 si lo encuentra y 0 en caso contrario.
 */
int sglist_buscar(SGList* lista, void *data, FuncionComparadora comparadora);

/**
 * Construye una lista ordenada a partir de un arreglo de elementos y su longitud.
 */
SGList* sglist_arr(void **arr, int longitud, FuncionCopia copia, FuncionComparadora comparadora);

#endif