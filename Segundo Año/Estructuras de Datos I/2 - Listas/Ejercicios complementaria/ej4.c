#include <stdio.h>
#include <stdlib.h>

/*Dada una lista enlazada, retornar el nodo donde comienza el ciclo, o la direcci´on nula en caso que
no haya ninguno. Por ejemplo, para la lista:
L : → 1 → 2 → 3 → 4
                ↖↙
Retornar la direcci´on correspondiente al nodo 3.*/

typedef struct _DNode {
  int data;
  struct _DNode *sig;
  struct _DNode *ant;
} DNode;

typedef DNode *DList;

DNode* ciclo (DList lista) {
  DList lento = lista;
  DList rapido = lista->sig;
  DNode* inicioBucle = NULL;
  int encontrado = 0;
  
  for (; rapido != NULL && rapido->sig != NULL && !encontrado ; lento = lento->sig, rapido = rapido->sig->sig)
    if (lento == rapido)
      encontrado = 1;
  
  if (encontrado) {
    inicioBucle = lista;
    for (; inicioBucle != lento ; inicioBucle = inicioBucle->sig, lento = lento->sig);
  }
  
  return inicioBucle;
}
