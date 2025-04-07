#ifndef __CDLIST_H_
#define __CDLIST_H_

#include <stddef.h>

typedef void (*FuncionVisitante) (int dato);

typedef struct _DNodo {
  int dato;
  struct _DNodo *sig;
  struct _DNodo *ant;
} DNodo;

typedef DNodo* CDList;

typedef enum {
    DLIST_RECORRIDO_HACIA_ADELANTE,
    DLIST_RECORRIDO_HACIA_ATRAS
} DListOrdenDeRecorrido;

CDList cdlist_crear();

CDList cdlist_agregar_inicio(CDList lista, int dato);

CDList cdlist_agregar_final(CDList lista, int dato);

void cdlist_recorrer(CDList lista, DListOrdenDeRecorrido recorrido, FuncionVisitante f);

void cdlist_destruir(CDList lista);

#endif //__CDLIST_H__
