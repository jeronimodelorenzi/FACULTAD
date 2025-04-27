#ifndef __COLAS_H__
#define __COLAS_H__

#include "glist.h"

typedef GList *Cola;

/**
 * Crea una cola
 */
Cola cola_crear();

/**
 * Destruye la cola.
 */
void cola_destruir(Cola cola, FuncionDestructora destroy);

/**
 * Retorna 1 si la cola es vacía, 0 en caso contrario.
 */
int cola_es_vacia(Cola cola);

/**
 * Retorna el elemento que se encuentra al inicio de la cola.
 */
void* cola_inicio(Cola cola);

/**
 * Agrega un elemento a la cola.
 */
void cola_encolar(Cola cola, void *data, FuncionCopia copy);

/**
 * Elimina un elemento de la cola.
 */
//void cola_desencolar(Cola cola, FuncionDestructora destroy);
void* cola_desencolar(Cola cola);

/**
 * Muestra en pantalla la cola.
 */
void cola_imprimir(Cola cola, FuncionVisitante visit);

#endif