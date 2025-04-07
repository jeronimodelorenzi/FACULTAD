#include <stdio.h>
#include <stdlib.h>
#include "dlist.h"

static void imprimir_entero(int dato) {
  printf("%d ", dato);
}

int main (){
  DList* lista = dlist_crear();
  dlist_agregar_final(lista,5);
  dlist_agregar_inicio(lista,1);
  dlist_agregar_final(lista,2);
  dlist_agregar_final(lista,3);
  dlist_agregar_final(lista,4);
  dlist_agregar_inicio(lista,0);
  dlist_recorrer(lista,DLIST_RECORRIDO_HACIA_ADELANTE,imprimir_entero);
  puts("");

  dlist_destruir(lista);

  return 0;
} 