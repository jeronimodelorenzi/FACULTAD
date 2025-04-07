#include "cdlist.h"
#include <stdio.h>

void imprimir(int dato){
    printf("%d ", dato);
}

int main (){
    CDList lista = cdlist_crear();
    lista = cdlist_agregar_final(lista, 1);
    cdlist_recorrer(lista, DLIST_RECORRIDO_HACIA_ADELANTE, imprimir);
    puts("");
    lista = cdlist_agregar_final(lista, 2);
    cdlist_recorrer(lista, DLIST_RECORRIDO_HACIA_ADELANTE, imprimir);
    puts("");
    lista = cdlist_agregar_final(lista, 3);
    cdlist_recorrer(lista, DLIST_RECORRIDO_HACIA_ADELANTE, imprimir);
    puts("");
    lista = cdlist_agregar_final(lista, 4);
    cdlist_recorrer(lista, DLIST_RECORRIDO_HACIA_ADELANTE, imprimir);
    puts("");
    lista = cdlist_agregar_inicio(lista, 0);
    
    cdlist_recorrer(lista, DLIST_RECORRIDO_HACIA_ADELANTE, imprimir);
    puts("");
    cdlist_recorrer(lista, DLIST_RECORRIDO_HACIA_ATRAS, imprimir);
    puts("");

    cdlist_destruir(lista);
    return 0;
}