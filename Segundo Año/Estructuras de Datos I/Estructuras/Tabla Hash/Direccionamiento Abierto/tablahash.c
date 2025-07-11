#include <stdlib.h>
#include <assert.h>
#include "tablahash.h"

/**
 * Estado de la casilla
 */
typedef enum {
  VACIA,
  OCUPADA,
  BORRADA
} EstadoCasilla;

/**
 * Casillas donde se almacenan los datos en la tabla.
 */
typedef struct {
  void *dato;
  EstadoCasilla estado;
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
  assert(tabla->elems != NULL);
  tabla->numElems = 0;
  tabla->capacidad = capacidad;
  tabla->copia = copia;
  tabla->comp = comp;
  tabla->destroy = destroy;
  tabla->hash = hash;

  for (unsigned i = 0 ; i < capacidad ; ++i) {
    tabla->elems[i].dato = NULL;
    tabla->elems[i].estado = VACIA;
  }

  return tabla;
}

int tablahash_nelems(TablaHash tabla) { return tabla->numElems; }

int tablahash_capacidad(TablaHash tabla) { return tabla->capacidad; }

void tablahash_destruir(TablaHash tabla) {
  for (unsigned i = 0 ; i < tabla->capacidad; ++i)
    if (tabla->elems[i].dato != NULL)
      tabla->destroy(tabla->elems[i].dato);
  
  free(tabla->elems);
  free(tabla);
}

/**
 * Función interna que calcula el factor de carga de la tabla
 */
static float factor_carga (TablaHash tabla) {
  return (float)tabla->numElems / tabla->capacidad;
}

void tablahash_insertar(TablaHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  int bandera = 0;

  for (unsigned i = 0 ; i < tabla->capacidad && !bandera; i++) {
    unsigned pos = (idx + i) % tabla->capacidad;

    if (tabla->elems[pos].estado == OCUPADA) {
      if (tabla->comp(tabla->elems[pos].dato, dato) == 0) {
        tabla->destroy(tabla->elems[pos].dato);
        tabla->elems[pos].dato = tabla->copia(dato);
        bandera = 1;
      }
    }

    else if (tabla->elems[pos].estado == VACIA || tabla->elems[pos].estado == BORRADA) {
      tabla->elems[pos].dato = tabla->copia(dato);
      tabla->elems[pos].estado = OCUPADA;
      tabla->numElems++;
      bandera = 1;
    }
  }
}

void *tablahash_buscar(TablaHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  void *datoEncontrado = NULL;
  int encontrado = 0;
  int vacio = 0;

  for (unsigned i = 0 ; i < tabla->capacidad && !encontrado && !vacio; ++i) {
    unsigned pos = (idx + i) % tabla->capacidad;

    if (tabla->elems[pos].estado == VACIA)
      vacio = 1;
    else if (tabla->elems[pos].estado == OCUPADA && 
             tabla->comp(tabla->elems[pos].dato, dato) == 0) {
      datoEncontrado = tabla->copia(tabla->elems[pos].dato);
      encontrado = 1;
    }
  }

  if(encontrado) 
    return datoEncontrado;
  else 
    return NULL;
}

void tablahash_eliminar(TablaHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  int eliminado = 0;
  int vacio = 0;

  for (unsigned i = 0 ; i < tabla->capacidad && !vacio && !eliminado ; ++i) {
    unsigned pos = (idx + i) % tabla->capacidad;

    if (tabla->elems[pos].estado == VACIA)
      vacio = 1;
    else if (tabla->elems[pos].estado == OCUPADA &&
             tabla->comp(tabla->elems[pos].dato, dato) == 0) {
      tabla->destroy(tabla->elems[pos].dato);
      tabla->elems[pos].dato = NULL;
      tabla->elems[pos].estado = BORRADA;
      tabla->numElems--;
      eliminado = 1;
    }
  }
}

TablaHash tablahash_redimensionar (TablaHash tabla) {
  unsigned nuevaCapacidad = tabla->capacidad * 2;
  TablaHash nuevaTabla = tablahash_crear(nuevaCapacidad, tabla->copia, tabla->comp,
                                        tabla->destroy, tabla->hash);
  
  for (unsigned i = 0 ; i < nuevaTabla->capacidad ; ++i)
    if (tabla->elems[i].estado == OCUPADA)
      tablahash_insertar(nuevaTabla, tabla->elems[i].dato);

  tablahash_destruir(tabla);
  return nuevaTabla;
}