#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_HEAP 20

typedef struct {
  char *dni, *nombre, *descripcionCargo;
  int prioridad;
} _Invitado;

typedef _Invitado *Invitado;

typedef struct _Nodo {
  Invitado invitado;
  struct _Nodo *der, *izq;
} Nodo;

typedef Nodo *Arbol;


typedef struct