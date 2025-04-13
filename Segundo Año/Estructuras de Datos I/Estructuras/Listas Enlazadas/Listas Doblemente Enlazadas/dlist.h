#ifndef __DLIST_H__
#define __DLIST_H__

#include <stddef.h>

typedef void (*FuncionVisitante) (int dato);

typedef struct _DNodo {
  int dato;
  struct _DNodo* sig;
  struct _DNodo* ant;
} DNodo;

typedef struct {
  DNodo* primero;
  DNodo* ultimo;
} DList;

typedef enum {
    DLIST_RECORRIDO_HACIA_ADELANTE,
    DLIST_RECORRIDO_HACIA_ATRAS
} DListOrdenDeRecorrido;

DList* dlist_crear();

DList* dlist_agregar_inicio (DList* lista, int dato);

DList* dlist_agregar_final (DList* lista, int dato);

void dlist_destruir(DList* lista);

void dlist_recorrer(DList* lista, DListOrdenDeRecorrido direccion, FuncionVisitante visit);

#endif //__DLIST_H__