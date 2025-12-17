#include <stdio.h>
#include <stdlib.h>
#include "pilas.h"

/* =========================================================
   IMPLEMENTACIÓN: ARREGLOS
   ========================================================= */

ArregloEnteros *arreglo_enteros_crear(int capacidad) {
    ArregloEnteros *arreglo = malloc(sizeof(ArregloEnteros));
    if (arreglo == NULL) return NULL;
    
    arreglo->direccion = malloc(sizeof(int) * capacidad);
    if (arreglo->direccion == NULL) {
        free(arreglo);
        return NULL;
    }
    
    arreglo->capacidad = capacidad;
    return arreglo;
}

void arreglo_enteros_destruir(ArregloEnteros *arreglo) {
    if (arreglo != NULL) {
        free(arreglo->direccion);
        free(arreglo);
    }
}

void arreglo_enteros_ajustar(ArregloEnteros* arreglo) {
    int nuevaCap = arreglo->capacidad * 2;
    int *temp = realloc(arreglo->direccion, sizeof(int) * nuevaCap);
    if (temp != NULL) {
        arreglo->direccion = temp;
        arreglo->capacidad = nuevaCap;
    }
}

PilaA pilaA_crear(int capacidad) {
    PilaA pila = malloc(sizeof(struct _PilaA));
    if (pila == NULL) return NULL;
    
    pila->arr = arreglo_enteros_crear(capacidad);
    pila->ultimo = -1;
    return pila;
}

void pilaA_destruir(PilaA pila) {
    if (pila != NULL) {
        arreglo_enteros_destruir(pila->arr);
        free(pila);
    }
}

int pilaA_es_vacia(PilaA pila) {
    return pila->ultimo == -1;
}

int pilaA_tope(PilaA pila) {
    if (pilaA_es_vacia(pila)) return -1; // Valor de error
    return pila->arr->direccion[pila->ultimo];
}

void pilaA_apilar(PilaA pila, int elemento) {
    if (pila->ultimo + 1 == pila->arr->capacidad)
        arreglo_enteros_ajustar(pila->arr);
    
    pila->ultimo++;
    pila->arr->direccion[pila->ultimo] = elemento;
}

void pilaA_desapilar(PilaA pila) {
    if (!pilaA_es_vacia(pila))
        pila->ultimo--;
}

void pilaA_imprimir(PilaA pila) {
    for (int i = 0; i <= pila->ultimo; i++) {
        printf("%d\n", pila->arr->direccion[i]);
    }
}

/* =========================================================
   IMPLEMENTACIÓN: LISTAS GENÉRICAS
   ========================================================= */

GList glist_crear() {
    return NULL;
}

void glist_destruir(GList list, FuncionDestructora d) {
    GNode *nodeToDestroy;
    while (list != NULL) {
        nodeToDestroy = list;
        list = list->next;
        if (d != NULL) d(nodeToDestroy->data);
        free(nodeToDestroy);
    }
}

int glist_es_vacia(GList list) {
    return list == NULL;
}

GList glist_agregar_inicio(GList list, void *data, FuncionCopia c) {
    GNode *newNode = malloc(sizeof(GNode));
    newNode->data = (c != NULL) ? c(data) : data;
    newNode->next = list;
    return newNode;
}

void glist_recorrer(GList list, FuncionVisitante v) {
    for (GNode *temp = list; temp != NULL; temp = temp->next)
        v(temp->data);
}

// --- Wrappers de PilaL ---

PilaL pilaL_crear() {
    return glist_crear();
}

void pilaL_destruir(PilaL pila, FuncionDestructora d) {
    glist_destruir(pila, d);
}

int pilaL_es_vacia(PilaL pila) {
    return glist_es_vacia(pila);
}

void *pilaL_tope(PilaL pila) {
    if (pilaL_es_vacia(pila)) return NULL;
    return pila->data;
}

void pilaL_apilar(PilaL *pila, void *data, FuncionCopia c) {
    *pila = glist_agregar_inicio(*pila, data, c);
}

void pilaL_desapilar(PilaL *pila, FuncionDestructora d) {
    if (pilaL_es_vacia(*pila)) return;

    GNode *temp = *pila;
    *pila = (*pila)->next;
    
    if (d != NULL) d(temp->data);
    free(temp);
}

void pilaL_imprimir(PilaL pila, FuncionVisitante v) {
    glist_recorrer(pila, v);
}

PilaL pilaL_revertir_orden(PilaL list, FuncionCopia c) {
    PilaL nuevaPila = pilaL_crear();
    for (GNode *temp = list; temp != NULL; temp = temp->next)
        pilaL_apilar(&nuevaPila, temp->data, c);
    return nuevaPila;
}

// --- AUXILIARES ---
void verificar(int condicion, const char *mensaje) {
    printf("[%s] %s\n", condicion ? "OK" : "ERROR", mensaje);
}

// Funciones para Pila Generica (Enteros)
void *copiar_int(void *dato) {
    int *nuevo = malloc(sizeof(int));
    *nuevo = *(int*)dato;
    return nuevo;
}

void destruir_int(void *dato) {
    free(dato);
}

void imprimir_int(void *dato) {
    printf("%d -> ", *(int*)dato);
}

// --- TESTS ---

void prueba_arr() {
    printf("\n=== PRUEBAS: PILA ARREGLO ===\n");
    PilaA p = pilaA_crear(2);
    
    pilaA_apilar(p, 10);
    pilaA_apilar(p, 20);
    verificar(pilaA_tope(p) == 20, "Tope inicial es 20");
    
    // Resize
    pilaA_apilar(p, 30);
    verificar(pilaA_tope(p) == 30, "Resize exitoso, tope 30");
    
    pilaA_desapilar(p);
    verificar(pilaA_tope(p) == 20, "Desapilar, tope 20");
    
    pilaA_destruir(p);
}

void prueba_list() {
    printf("\n=== PRUEBAS: PILA LISTA (GENERICA) ===\n");
    PilaL pila = pilaL_crear();
    int nums[] = {10, 20, 30};

    pilaL_apilar(&pila, &nums[0], copiar_int);
    pilaL_apilar(&pila, &nums[1], copiar_int);
    
    int *tope = (int*)pilaL_tope(pila);
    verificar(*tope == 20, "Tope Lista es 20");

    PilaL invertida = pilaL_revertir_orden(pila, copiar_int);
    printf("Invertida: ");
    pilaL_imprimir(invertida, imprimir_int);
    printf("NULL\n");

    pilaL_destruir(pila, destruir_int);
    pilaL_destruir(invertida, destruir_int);
}

int main() {
    prueba_arr();
    prueba_list();
    return 0;
}