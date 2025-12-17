#include <stdio.h>
#include <stdlib.h>
#include "hash_enca.h"

typedef struct _NodoHash {
  void *dato;
  struct _NodoHash *sig;
} NodoHash;

typedef struct {
  NodoHash *nodo;
} CasillaHash;

struct _TablaHash {
  CasillaHash *elems;
  unsigned numElems;
  unsigned capacidad;
  FuncionCopiadora copy;
  FuncionComparadora comp;
  FuncionDestructora destroy;
  FuncionHash hash;
};

TablaHash tablahash_crear (unsigned capacidad, FuncionCopiadora copy, FuncionComparadora comp, FuncionDestructora destroy, FuncionHash fHash) {
  TablaHash tabla = malloc(sizeof(struct _TablaHash));
  tabla->elems = malloc(sizeof(CasillaHash)*capacidad);
  tabla->capacidad = capacidad;
  tabla->numElems = 0;
  tabla->copy = copy;
  tabla->comp = comp;
  tabla->destroy = destroy;
  tabla->hash = fHash;

  for (unsigned i = 0 ; i < capacidad ; ++i)
    tabla->elems[i].nodo = NULL;

  return tabla;
}

int tablahash_nelems (TablaHash tabla) { return tabla->numElems; }

int tablahash_capacidad (TablaHash tabla) { return tabla->capacidad; }

void tablahash_destruir (TablaHash tabla) {
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    NodoHash *temp = tabla->elems[i].nodo;
    while (temp != NULL) {
      NodoHash *sig = temp->sig;
      tabla->destroy(temp->dato);
      free(temp);
      temp = sig;
    }
  }
  free(tabla->elems);
  free(tabla);
}

void tablahash_insertar (TablaHash tabla, void *dato) {
  unsigned i = tabla->hash(dato) % tabla->capacidad;
  NodoHash *nodo = tabla->elems[i].nodo;

  int bandera = 0;

  for (; nodo != NULL && !bandera; nodo = nodo->sig) 
    if (tabla->comp(nodo->dato, dato) == 0) {
      tabla->destroy(nodo->dato);
      nodo->dato = tabla->copy(dato);
      bandera = 1;
    }
  
  if (!bandera) {
    NodoHash *nuevoNodo = malloc(sizeof(NodoHash));
    nuevoNodo->dato = tabla->copy(dato);
    nuevoNodo->sig = tabla->elems[i].nodo;
    tabla->elems[i].nodo = nuevoNodo;
    tabla->numElems++;
  }
}

void *tablahash_buscar (TablaHash tabla, void *dato) {
  unsigned i = tabla->hash(dato) % tabla->capacidad;

  NodoHash *nodo = tabla->elems[i].nodo;
  void *datoEncontrado = NULL;
  int bandera = 0;

  for (; nodo != NULL && !bandera ; nodo = nodo->sig)
    if (tabla->comp(nodo->dato, dato) == 0) {
      datoEncontrado = nodo->dato;
      bandera = 1;
    }

  return datoEncontrado;
}

void tablahash_eliminar (TablaHash tabla, void *dato) {
  unsigned i = tabla->hash(dato) % tabla->capacidad;
  NodoHash *nodo = tabla->elems[i].nodo;
  NodoHash *ant = NULL;

  int bandera = 0;

  while (nodo != NULL && !bandera) {
    if (tabla->comp(nodo->dato, dato) == 0) {
      NodoHash *nodoAEliminar = nodo;
      if (ant == NULL)
        tabla->elems[i].nodo = nodo->sig;
      else
        ant->sig = nodo->sig;
      tabla->destroy(nodoAEliminar->dato);
      free(nodoAEliminar);
      tabla->numElems--;
      bandera = 1;
    } else {
        ant = nodo;
        nodo = nodo->sig;
    }
  }
}

void tablahash_redimensionar (TablaHash tabla) {
  unsigned nuevaCapacidad = tabla->capacidad * 2;
  CasillaHash *nuevoElems = malloc(sizeof(CasillaHash)*nuevaCapacidad);

  for (unsigned i = 0 ; i < nuevaCapacidad ; ++i)
    nuevoElems[i].nodo = NULL;

  for (unsigned i = 0 ; i < tabla->capacidad ; ++i) {
    NodoHash *nodo = tabla->elems[i].nodo;
    while (nodo != NULL) {
      NodoHash *sig = nodo->sig;
      unsigned nuevoIndice = tabla->hash(nodo->dato) % nuevaCapacidad;
      nodo->sig = nuevoElems[nuevoIndice].nodo;
      nuevoElems[nuevoIndice].nodo = nodo;
      nodo = sig;
    }
  }

  free(tabla->elems);
  tabla->elems = nuevoElems;
  tabla->capacidad = nuevaCapacidad;
}


// === FUNCIONES AUXILIARES INT ===
unsigned hash_int(void *dato) {
    // Hash simple: retornamos el valor (bueno para probar colisiones con modulo)
    return (unsigned)(*(int*)dato); 
}

void *copiar_int(void *dato) {
    int *nuevo = malloc(sizeof(int));
    *nuevo = *(int*)dato;
    return nuevo;
}
int comp_int(void *a, void *b) { return (*(int*)a - *(int*)b); }
void dest_int(void *dato) { free(dato); }

// === MAIN ===
int main() {
    printf("--- TEST HASH ENCADENAMIENTO ---\n");
    // Capacidad 5 para forzar colisiones rápido
    TablaHash t = tablahash_crear(5, copiar_int, comp_int, dest_int, hash_int);

    int n1 = 10, n2 = 15, n3 = 20, n4 = 7;
    
    // 10, 15 y 20 caerán en la misma casilla (indice 0 porque x % 5 == 0)
    // Esto probará tu lista enlazada.
    tablahash_insertar(t, &n1);
    tablahash_insertar(t, &n2);
    tablahash_insertar(t, &n3);
    tablahash_insertar(t, &n4); // Indice 2

    printf("Elementos insertados: %d (Esperado: 4)\n", tablahash_nelems(t));

    // Búsqueda
    int *busc = tablahash_buscar(t, &n2);
    if(busc && *busc == 15) printf("[OK] Encontrado 15 (en medio de colision)\n");
    else printf("[ERROR] No se encontro 15\n");

    // Actualización (Reinsertar 15 con otro valor, conceptualmente)
    // En tu lógica, sobrescribe.
    tablahash_insertar(t, &n2); 
    printf("Elementos tras reinsercion: %d (Esperado: 4, no debe duplicar)\n", tablahash_nelems(t));

    // Eliminación (El del medio de la lista)
    tablahash_eliminar(t, &n2);
    if(!tablahash_buscar(t, &n2)) printf("[OK] Eliminado 15\n");
    else printf("[ERROR] 15 sigue ahi\n");

    // Eliminación (Cabeza de lista)
    tablahash_eliminar(t, &n3); // El ultimo insertado (20) suele quedar al principio
    if(!tablahash_buscar(t, &n3)) printf("[OK] Eliminado 20\n");

    tablahash_destruir(t);
    printf("Tabla destruida.\n");
    return 0;
}