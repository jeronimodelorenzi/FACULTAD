#include <stdio.h>
#include <stdlib.h>

/* Dada la lista enlazada:
L0 → L1 → . . . → Ln−1 → Ln
Reordenarla a la forma:
L0 → Ln → L1 → Ln−1 → L2 → Ln−2 → . . .
Se debe reutilizar los nodos de la lista dada. */

typedef struct _DNodo {
    int dato;
    struct _DNodo *sig;
    struct _DNodo *ant;
} DNodo;

typedef struct {
  DNodo* inicio;
  DNodo* final;
} DList;

void reordenar (DList* lista) {
  DNodo* tempInicio = lista->inicio;
  DNodo* tempFinal = lista->final;

  for (; tempInicio != tempFinal ; tempInicio = tempInicio->sig, tempFinal = tempFinal->ant){
    tempInicio->sig = tempFinal;
  }
}