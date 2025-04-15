#include "arregloEnteros.h"

struct _Pila {
  ArregloEnteros *arr;
  int ultimo;
};

typedef struct _Pila *Pila;

/**
 * Crea e inicializa una pila vacía con la capacidad dada.
 */
Pila pila_crear(int capacidad);
/**
 * Libera la memoria requerida para la pila.
 */
void pila_destruir(Pila pila);

/**
 * Retorna 1 si la pila está vacía, y 0 en caso contrario.
 */
int pila_es_vacia(Pila pila);

/**
 * Retorna el elemento que se encuentra en el tope de la pila sin eliminarlo.
 */
int pila_tope(Pila pila);

/**
 * Inserta un elemento en el tope de la pila, en caso de estar llena, se aumenta el doble la capacidad.
 */
void pila_apilar(Pila pila, int elemento);

/**
 * Elimina el elemento que se encuentra en el tope de la pila.
 */
void pila_desapilar(Pila pila);

/**
 * Imprime en orden los elementos de la pila.
 */
void pila_imprimir(Pila pila);
