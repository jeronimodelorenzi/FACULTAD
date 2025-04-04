#ifndef __SLIST_H__
#define __SLIST_H__

#include <stddef.h>

typedef void (*FuncionVisitante) (int dato);

typedef struct _SNodo {
  int dato;
  struct _SNodo *sig;
} SNodo;

typedef SNodo *SList;

/**
 * Devuelve una lista vacía.
 */
SList slist_crear();

/**
 * Destruccion de la lista.
 */
void slist_destruir(SList lista);

/**
 * Determina si la lista es vacía.
 */
int slist_vacia(SList lista);

/**
 * Agrega un elemento al final de la lista.
 */
SList slist_agregar_final(SList lista, int dato);

/**
 * Agrega un elemento al inicio de la lista.
 */
SList slist_agregar_inicio(SList lista, int dato);

/**
 * Recorrido de la lista, utilizando la funcion pasada.
 */
void slist_recorrer(SList lista, FuncionVisitante visit);

/*
* Devuelve la longitud de la lista. 
*/
int slist_longitud(SList lista);

/*
* Devuelve la concatenación de dos listas, modificando la primera.
*/
void slist_concatenar (SList* lista1, SList* lista2);

/*
* slist_insertar que inserta un dato en una lista en una posición arbitraria.
*/
void slist_insertar(SList* lista, int dato, int pos);

#endif /* __SLIST_H__ */
