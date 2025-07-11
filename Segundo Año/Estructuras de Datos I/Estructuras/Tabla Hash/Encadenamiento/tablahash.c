#include <stdlib.h>
#include <assert.h>
#include "tablahash.h"

typedef struct _NodoHash {
  void *dato;
  struct _NodoHash *next;
} NodoHash;

/**
 * Casillas donde se almacenan los datos en la tabla.
 */
typedef struct {
  NodoHash *cabeza;
} CasillaHash;

/**
 * Estructura de la tabla hash.
 */
struct _TablaHash {
  CasillaHash *elems;
  unsigned numElems;
  unsigned capacidad;
  FuncionCopiadora copia;
  FuncionComparadora comp;
  FuncionDestructora destroy;
  FuncionHash hash;
};

TablaHash tablahash_crear (unsigned capacidad, FuncionCopiadora copia,
                           FuncionComparadora comp, FuncionDestructora destroy,
                           FuncionHash hash) {
  TablaHash tabla = malloc(sizeof(struct _TablaHash));
  assert(tabla != NULL);
  tabla->elems = malloc(sizeof(CasillaHash) * capacidad);
  tabla->numElems = 0;
  tabla->capacidad = capacidad;
  tabla->copia = copia;
  tabla->comp = comp;
  tabla->destroy = destroy;
  tabla->hash = hash;

  for (unsigned i = 0 ; i < capacidad ; ++i)
    tabla->elems[i].cabeza = NULL;

  return tabla;
}

int tablahash_nelems (TablaHash tabla) { return tabla->numElems; }

int tablahash_capacidad (TablaHash tabla) { return tabla->capacidad; }

void tablahash_destruir (TablaHash tabla) {
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i){
    NodoHash *temp = tabla->elems[i].cabeza;
    while (temp != NULL) {
      NodoHash *sig = temp->next;
      tabla->destroy(temp->dato);  
      free(temp);                  
      temp = sig; 
    }
  }

  free(tabla->elems);
  free(tabla);
}

static float factor_carga(TablaHash tabla){
  return (float)tabla->numElems / tabla->capacidad; 
}

void tablahash_insertar (TablaHash tabla, void *dato) {
  unsigned i = tabla->hash(dato) % tabla->capacidad;
  NodoHash* nodo = tabla->elems[i].cabeza;

  int bandera = 0;

  for (; nodo != NULL ; nodo = nodo->next)
    if (tabla->comp(nodo->dato, dato) == 0) {
      tabla->destroy(nodo->dato);
      nodo->dato = tabla->copia(dato);
      bandera = 1;
    }
  
  if (!bandera) {
    NodoHash *nuevoNodo = malloc(sizeof(struct _NodoHash));
    nuevoNodo->dato = tabla->copia(dato);
    nuevoNodo->next = tabla->elems[i].cabeza;
    tabla->elems[i].cabeza = nuevoNodo;
    tabla->numElems++;
  }

  if (factor_carga(tabla) > 0.75f) {
    tablahash_redimensionar(tabla);
  }
}

void* tablahash_buscar (TablaHash tabla, void *dato) {
  unsigned i = tabla->hash(dato) % tabla->capacidad;

  NodoHash *nodo = tabla->elems[i].cabeza;
  void *datoEncontrado = NULL;
  int encontrado = 0;

  for (; nodo != NULL ; nodo = nodo->next) 
    if (tabla->comp(nodo->dato, dato) == 0) {
      datoEncontrado = tabla->copia(nodo->dato);
      encontrado = 1;
    }

  if (encontrado)
    return datoEncontrado;
  else
    return NULL;
}

void tablahash_eliminar (TablaHash tabla, void *dato) {
  unsigned i = tabla->hash(dato) % tabla->capacidad;

  NodoHash *nodo = tabla->elems[i].cabeza;
  NodoHash *ant = NULL;

  int eliminado = 0;

  while (nodo != NULL && !eliminado) {
    if (tabla->comp(nodo->dato, dato) == 0) {
      NodoHash *nodoAEliminar = nodo;
      if (ant == NULL)
        tabla->elems[i].cabeza = nodo->next;
      else
        ant->next = nodo->next;
      tabla->destroy(nodoAEliminar->dato);
      free(nodoAEliminar);
      tabla->numElems--;
      eliminado = 1;
    } else {
      ant = nodo;
      nodo = nodo->next;
    }
  }
}

void tablahash_redimensionar(TablaHash tabla) {
  unsigned nuevaCapacidad = tabla->capacidad * 2;
  CasillaHash *nuevoElems = malloc(sizeof(CasillaHash) * nuevaCapacidad);
  assert(nuevoElems != NULL);

  for (unsigned i = 0 ; i < nuevaCapacidad ; ++i)
    nuevoElems[i].cabeza = NULL;

  for (unsigned i = 0 ; i<tabla->capacidad ; ++i) {
    NodoHash *nodo = tabla->elems[i].cabeza;
    
    while (nodo != NULL) {
      NodoHash *next = nodo->next;
      unsigned nuevoIndice = tabla->hash(nodo->dato) % nuevaCapacidad;
      nodo->next = nuevoElems[nuevoIndice].cabeza;
      nuevoElems[nuevoIndice].cabeza = nodo;

      nodo = next;
    }
  }

  free(tabla->elems);
  tabla->elems = nuevoElems;
  tabla->capacidad = nuevaCapacidad;
}