#include <stdio.h>
#include <stdlib.h>
#include "sglist.h"

// Función para imprimir enteros
void imprimir_entero(void *dato) {
    int *entero = dato;
    printf("%d ", *entero);
}

// Función para destruir enteros
void destruir_entero(void *dato) {
    free(dato);
}

// Función para copiar enteros
void* copiar_entero(void *dato) {
    int *origen = dato;
    int *copia = malloc(sizeof(int));
    *copia = *origen;
    return copia;
}

// Función comparadora para enteros
int comparar_enteros(void *a, void *b) {
    int *x = a;
    int *y = b;
    return *x - *y;  // orden ascendente
}

int main() {
    SGList *lista = sglist_crear();

    int datos[] = {5, 2, 8, 3, 1};

    for (int i = 0; i < 5; i++) {
        sglist_insertar(lista, &datos[i], copiar_entero, comparar_enteros);
    }

    printf("Lista ordenada: ");
    sglist_recorrer(lista, imprimir_entero);
    puts("");

    int encontrado = sglist_buscar(lista, 2, comparar_enteros);
    if (encontrado) {
        printf("El número 2 está en la lista.\n");
    } else {
        printf("El número 2 no está en la lista.\n");
    }

    sglist_destruir(lista, destruir_entero);
    return 0;
}
