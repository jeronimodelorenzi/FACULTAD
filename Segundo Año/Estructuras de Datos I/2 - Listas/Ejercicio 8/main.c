#include <stdio.h>
#include <stdlib.h>
#include "sglist.h"

// Función para imprimir enteros
void imprimir_entero(void *dato) {
    int* entero = (int*)dato;
    printf("%d ", *entero);
}

// Función para destruir enteros
void destruir_entero(void *dato) {
    free(dato);
}

// Función para copiar enteros
void* copiar_entero(void *dato) {
    int *origen = (int*)dato;
    int *copia = malloc(sizeof(int));
    *copia = *origen;
    return copia;
}

// Función comparadora para enteros
int comparar_enteros(void *a, void *b) {
    int *x = (int*)a;
    int *y = (int*)b;
    return *x - *y; 
}

int main() {
    SGList *lista = sglist_crear();

    int datos[] = {5, 2, 8, 3, 1};

    //lista = sglist_arr(datos,5,copiar_entero,comparar_enteros);

    printf("Lista ordenada: ");
    sglist_recorrer(lista, (FuncionVisitante)imprimir_entero);
    puts("");

    int buscado = 2;
    int encontrado = sglist_buscar(lista, &buscado, comparar_enteros);
    if (encontrado) {
        printf("El número %d está en la lista.\n", buscado);
    } else {
        printf("El número %d no está en la lista.\n", buscado);
    }

    sglist_destruir(lista, destruir_entero);
    return 0;
}
