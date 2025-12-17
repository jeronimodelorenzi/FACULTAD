#ifndef PILAS_H
#define PILAS_H

#include <stdlib.h> // Necesario para size_t o NULL si fuera el caso

/* ==========================================
   PARTE 1: IMPLEMENTACIÓN CON ARREGLOS
   ========================================== */

typedef struct _ArregloEnteros {
    int* direccion;
    int capacidad;
} ArregloEnteros;

struct _PilaA {
    ArregloEnteros *arr;
    int ultimo;
};

typedef struct _PilaA *PilaA;

// Constructor y Destructor
PilaA pilaA_crear(int capacidad);
void pilaA_destruir(PilaA pila);

// Operaciones
int pilaA_es_vacia(PilaA pila);
int pilaA_tope(PilaA pila);
void pilaA_apilar(PilaA pila, int elemento);
void pilaA_desapilar(PilaA pila);
void pilaA_imprimir(PilaA pila);

/* ==========================================
   PARTE 2: IMPLEMENTACIÓN CON LISTAS (GENÉRICA)
   ========================================== */

// Tipos de punteros a función
typedef void (*FuncionDestructora)(void *dato);
typedef void *(*FuncionCopia)(void *dato);
typedef void (*FuncionVisitante)(void *dato);

// Nodo Genérico
typedef struct _GNode {
    void *data;
    struct _GNode *next;
} GNode;

typedef GNode *GList;

// La Pila es simplemente un puntero al inicio de la lista
typedef GList PilaL;

// Funciones de Listas (Auxiliares)
GList glist_crear();
void glist_destruir(GList lista, FuncionDestructora destruir);
int glist_es_vacia(GList lista); // Corregido nombre para consistencia
GList glist_agregar_inicio(GList lista, void *dato, FuncionCopia copiar);
void glist_recorrer(GList lista, FuncionVisitante visitar);

// Operaciones de Pila (Listas)
PilaL pilaL_crear();
void pilaL_destruir(PilaL pila, FuncionDestructora destroy);
int pilaL_es_vacia(PilaL pila);
void *pilaL_tope(PilaL pila);

// Nota: Pasan puntero a PilaL (PilaL*) porque la cabecera cambia
void pilaL_apilar(PilaL* pila, void *elemento, FuncionCopia copy);
void pilaL_desapilar(PilaL* pila, FuncionDestructora destroy);
void pilaL_imprimir(PilaL pila, FuncionVisitante visit);
PilaL pilaL_revertir_orden(PilaL pila, FuncionCopia copy);

#endif // PILAS_H