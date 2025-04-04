#include <stdio.h>
#include <stdlib.h>
#include "slist.h"

static void imprimir_entero(int dato) {
  printf("%d ", dato);
}

int main(int argc, char *argv[]) {

  SList lista1 = slist_crear();
  SList lista2 = slist_crear();
  SList lista3 = slist_crear();
  SList lista4 = slist_crear();

  lista1 = slist_agregar_inicio(lista1, 3);
  lista1 = slist_agregar_inicio(lista1, 2);
  lista1 = slist_agregar_inicio(lista1, 1);
  lista1 = slist_agregar_final(lista1, 4);

  lista2 = slist_agregar_inicio(lista2, 2);
  lista2 = slist_agregar_inicio(lista2, 3);
  lista2 = slist_agregar_inicio(lista2, 1);
  lista2 = slist_agregar_final(lista2, 4);

  lista4 = slist_agregar_inicio(lista4, 1);

  printf("Lista 1:")
  slist_recorrer(lista1, imprimir_entero);

  slist_destruir(lista);
  slist_destruir(lista3);

  return 0;
}
