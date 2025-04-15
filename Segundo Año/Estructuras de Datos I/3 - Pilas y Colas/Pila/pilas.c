#include "pilas.h"
#include <stdio.h>
#include <stdlib.h>

Pila pila_crear (int capacidad) {
  ArregloEnteros *arr = arreglo_enteros_crear(cantidad);
  Pila *pila = malloc(sizeof(Pila));
  pila->arr = arr;
  pila->ultimo = -1;
  return pila; 
}

void pila_destruir (Pila pila) {
  free(pila->arr->direccion)
  free(pila->arr);
  free(pila);
}