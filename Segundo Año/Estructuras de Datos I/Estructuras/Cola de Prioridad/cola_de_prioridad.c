#include "heap.h"
#include "cola_de_prioridad.h"
#include <stdlib.h>

ColaP cola_prioridad_crear (int capacidad, FuncionComparadora comp) {
  return bheap_crear(capacidad, comp);
}

void cola_prioridad_destruir (ColaP cola) {
  bheap_destruir(cola);
}

int cola_prioridad_es_vacia (ColaP cola) {
  return bheap_es_vacio(cola);
}

void* cola_prioridad_maximo (ColaP cola) {
  return cola->capacidad > -1 ? cola->arr[0] : NULL;
}

void cola_prioridad_eliminar_maximo (ColaP cola) {
  return bheap_eliminar(cola, 0);
}

void cola_prioridad_insertar (ColaP cola, void *dato) {
  return bheap_insertar(cola, dato);
}

