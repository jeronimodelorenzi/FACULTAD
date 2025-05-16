#include <stdio.h>
#include <stdlib.h>

typedef struct {
  char* dni, *nombre, *descripcionCargo;
  int prioridad;
} _Invitado;

typedef _Invitado *Invitado;

typedef struct _Nodo {
  Invitado invitado;
  struct _Nodo *sig, *ant;
} Nodo;

typedef Nodo* Lista;

int prioridad (Invitado invitado) {
  
}

Lista agregar(Invitado invitado, Lista listaDeInvitados) {
  Nodo *newNode = malloc(sizeof(Nodo));
  newNode->invitado = invitado;
  newNode->sig = NULL;
  newNode->ant = NULL;

  if (listaDeInvitados == NULL)
    return newNode;
  
  for(Nodo *temp = listaDeInvitados ; temp != NULL; temp = temp->sig) {
    if (temp->invitado->prioridad < temp->sig->invitado->prioridad) {
      
    }
  }
}