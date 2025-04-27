#include <stdio.h>
#include <stdlib.h>
#include "XStack.h"

/*
Ya hemos visto c omo implementar colas y pilas desde cero,  
utilizando tanto arreglos como estructuras enlazadas.  
En este ejercicio, asumiremos que ud. ya ha implementado colas y deseaimplementar  pilas,  
pero  esta  vez  en  lugar  de  empezar  desde  cero,  utilizar a  las  colas  ya  implementadas:  
en concreto, utilizar a dos colas para implementar una pila (de manera posiblementeineficiente).
Si XQueuees la estructura utilizada para implementar las colas, ud. debe ́a dar una implementacíon
de xstackcreate, xstackpush, xstackpop y xstackisempty para la estructura:
typedef struct {
XQueue *q1;
XQueue *q2;
} XStack;
 de manera que XStack y las respectivas funciones implementen una pila 
 (las funciones xstacktop y xstackdestroy no es necesario hacerlas)
*/

XStack* xstack_create () {
  XStack *p = malloc(sizeof(XStack));
  p->q1 = cola_crear();
  p->q2 = cola_crear();
  return p;
}

int xstack_es_vacia (XStack *p) {
  return cola_es_vacia(p->q1) && cola_es_vacia(p->q2);
}

/*
Supongamos que estamos usando listas y tenemos: (p: primero, ult: ultimo)
1 -> 2 -> 3 -> NULL
pr       ult
Si queremos meter un elemento en la pila, encolamos, entonces:
1 -> 2 -> 3 -> 4 -> NULL
pr            ult
Ahora, si queremos sacar un elemento, como la pila es LIFO tenemos que eliminar el 4, que es el ultimo.
1 -> 2 -> 3 -> NULL
*/

void xstack_push (XStack *p, void *dato, FuncionCopia c) {
  cola_encolar(p->q1, dato, c);
}

void xstack_pop (XStack *p, FuncionDestructora d, FuncionCopia c) {
    while ((*p->q1)->inicio->next != NULL) {
    void *dato = cola_desencolar(p->q1);
    cola_encolar(p->q2, dato, c);        
  }

  void* dato = cola_desencolar(p->q1);
  d(dato);

  Cola temp = p->q1;
  p->q1 = p->q2;
  p->q2 = temp;
}