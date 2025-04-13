#include <stdio.h>
#include <stdlib.h>

/* Dada una lista enlazada de n´umeros enteros, eliminar todas las sub secuencias que sumen cero y
retornar la lista resultante. En los casos que se puedan elegir una subsecuencia que est´e contenida en
otra, elegir la m´as grande */

typedef struct _SNodo {
    int dato;
    struct _SNodo *sig;
} SNodo;

typedef SNodo *SList;


void eliminar_subzero (SList lista) {
  for(SNodo* temp1 = lista ; temp1 != NULL ; temp1 = temp1->sig) {
    int suma = temp1->dato;
    for (SNodo* temp2 = temp1->sig ; temp2 != NULL ; temp2 = temp1->sig) {
        suma += temp2->dato;
        if (suma == 0) {
           
        }
    }
  }
}