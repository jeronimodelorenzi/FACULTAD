#include <stdio.h>
#include <stdlib.h>

/*dadas dos listas enlazadas, encontrar la intersecci´on de las mismas, es decir, el nodo a
partir del cual las dos listas siguen igual (o la direcci´on nula en caso de no tener nodos en com´un)*/

typedef struct _SNodo {
    int dato;
    struct _SNodo *sig;
} SNodo;

typedef SNodo *SList;

SNodo* interseccion (SList lista1, SList lista2) {
  int encontrado = 0;
  SNodo* inter = NULL;
  for (SNodo* temp1 = lista1 ; temp1 != NULL && !encontrado ; temp1 = temp1->sig) {
    for (SNodo *temp2 = lista2 ; temp2 != NULL && !encontrado; temp2 = temp2->sig) {
        if (temp1 == temp2) {
            inter = temp1;
            encontrado = 1;
        }
    }
  }
  return inter;
}
