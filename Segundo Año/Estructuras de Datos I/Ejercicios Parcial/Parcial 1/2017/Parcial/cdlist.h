#ifndef __CDLIST_H_
#define __CDLIST_H_

#include <stddef.h>

typedef void (*FuncionVisitante) (int dato);

typedef struct {
  char *pais, *ciudad;
  int cantidadHabitantes, importancia;
} Objetivo;

typedef struct _DNodo {
  Objetivo dato;
  struct _DNodo *sig;
  struct _DNodo *ant;
} Nodo;


#endif //__CDLIST_H__
