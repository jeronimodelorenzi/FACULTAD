#ifndef __pilaL_H__
#define __pilaL_H__

#include "glist.h"

typedef GList Pila;

/**
 * Crea e inicializa una pila vacía.
 */
Pila pilaL_crear();

/**
 * Libera la memoria requerida para la pila.
 */
void pilaL_destruir(Pila pila, FuncionDestructora destroy);

/**
 * Retorna 1 si la pila está vacía, y 0 en caso contrario.
 */
int pilaL_es_vacia(Pila pila);

/**
 * Retorna el elemento que se encuentra en el tope de la pila sin eliminarlo.
 */
void *pilaL_tope(Pila pila);

/**
 * Inserta un elemento en el tope de la pila, en caso de estar llena, se aumenta el doble la capacidad.
 */
void pilaL_apilar(Pila* pila, void *elemento, FuncionCopia copy);

/**
 * Elimina el elemento que se encuentra en el tope de la pila.
 */
void pilaL_desapilar(Pila* pila, FuncionDestructora destroy);

/**
 * Imprime en orden los elementos de la pila.
 */
void pilaL_imprimir(Pila pila, FuncionVisitante visit);

/**
 * Revierte el orden de la pila.
 */
GList pilaL_revertir_orden(GList lista, FuncionCopia copy);


#endif