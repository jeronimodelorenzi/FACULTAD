#ifndef __COLA_DE_PRIORIDAD_H__
#define __COLA_DE_PRIORIDAD_H__

#include "heap.h"

typedef int (*FuncionComparadora)(void *, void*);
typedef void (*FuncionVisitante)(void *);

typedef BHeap ColaP;

/**
 * Crea una cola de prioridad.
 */
ColaP cola_prioridad_crear(int capacidad, FuncionComparadora comp);

/**
 * Destruye la cola de prioridad.
 */
void cola_prioridad_destuir(ColaP cola);

/**
 * Retorna 1 si la cola está vacía y 0 en caso contrario.
 */
int cola_prioridad_es_vacia(ColaP cola);

/**
 * Retorna l elemento prioritario de la cola.
 */
void* cola_prioridad_maximo(ColaP cola);

/**
 * Elimina el elemento prioritario de la cola.
 */
void cola_prioridad_eliminar_maximo(ColaP cola);

/**
 * Inserta un elemento en la cola con una prioridad determinada.
 */
void cola_prioridad_insertar(ColaP cola, void *dato);

#endif