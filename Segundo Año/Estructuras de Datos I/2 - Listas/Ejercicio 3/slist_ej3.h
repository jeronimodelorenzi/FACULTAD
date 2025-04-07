#ifndef __SLIST_H__
#define __SLIST_H__

#include <stddef.h>

typedef void (*FuncionVisitante) (int dato);

typedef struct _SNodo {
    int dato;
    struct _SNodo *sig;
} SNodo;

typedef struct SList {
    SNodo *primero;
    SNodo *ultimo;
} SList;

/*
* Devuelve una lista vacia.
*/
SList* slist_crear();

/*
* Agrega un elemento al comienzo de la lista.
*/
SList* slist_agregar_inicio(SList* lista, int dato);

/*
* Agrega un elemento al final de la lista.
*/
SList* slist_agregar_final(SList* lista, int dato);

/*
* Recorrido de la lista, utilizando la funcion pasada.
*/
void slist_recorrer(SList* lista, FuncionVisitante visit);

#endif /* __SLIST_H__ */
