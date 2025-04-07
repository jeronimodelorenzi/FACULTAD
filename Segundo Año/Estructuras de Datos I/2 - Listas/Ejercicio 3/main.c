#include <stdio.h>
#include <stdlib.h>
#include "slist_ej3.h"

static void imprimir_entero(int dato) {
    printf("%d ", dato);
  }

int main () {
  SList* lista = slist_crear();
  slist_recorrer(lista,imprimir_entero);
  slist_agregar_final(lista,5);
  slist_agregar_final(lista,6);
  slist_agregar_final(lista,7);
  slist_agregar_inicio(lista,10);
  slist_recorrer(lista,imprimir_entero);

  return 0;
}