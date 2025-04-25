#include "pilas.h"
#include <stdio.h>
#include <stdlib.h>

Pila pila_crear (int capacidad) {
  Pila pila = malloc(sizeof(struct _Pila));
  pila->arr = arreglo_enteros_crear(capacidad);
  pila->ultimo = -1;
  return pila; 
}

void pila_destruir (Pila pila) {
  arreglo_enteros_destruir(pila->arr);
  free(pila);
}

int pila_es_vacia (Pila pila) {
  return (pila->ultimo == -1);
}

int pila_tope (Pila pila) {
  return pila->arr->direccion[pila->ultimo];
}

void pila_apilar(Pila pila, int elemento) {
  if (pila->ultimo + 1 >= arreglo_enteros_capacidad(pila->arr))
    arreglo_enteros_ajustar(pila->arr, (pila->ultimo + 1) * 2);
  pila->ultimo++;
  arreglo_enteros_escribir(pila->arr, pila->ultimo, elemento);

}

void pila_desapilar(Pila pila) {
  if(!pila_es_vacia(pila))
    pila->ultimo = pila->ultimo-1;
}

void pila_imprimir(Pila pila) {
  for (int i = 0; i <= pila->ultimo; i++) {
    printf("%d ", arreglo_enteros_leer(pila->arr, i));
  }
  printf("\n");
}

