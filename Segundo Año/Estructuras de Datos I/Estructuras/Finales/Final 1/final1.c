#include <stdlib.h>
#include <stdio.h>

typedef struct _SNodo {
  int dato;
  struct _SNodo *sig;
} SNodo;

typedef SNodo *SList;

typedef struct {
  SList list;
} CasillaHash;

struct _TablaHash {
  CasillaHash *elems;
  unsigned capacidad;
};

typedef struct _TablaHash *TablaHash;

struct _MatrizEsparsa {
  TablaHash tabla;
  unsigned n;
};

typedef struct _MatrizEsparsa *MatrizEsparsa;

SList slist_crear() {
  return NULL;
}

TablaHash tablahash_crear (unsigned capacidad) {
  TablaHash tabla = malloc(sizeof(struct _TablaHash));
  tabla->elems = malloc(sizeof(CasillaHash) * capacidad);
  tabla->capacidad = capacidad;

  for (unsigned i = 0 ; i < tabla->capacidad ; ++i)
    tabla->elems[i].list = slist_crear();

  return tabla;
}

MatrizEsparsa matrizesparsa_crear (unsigned n) {
  MatrizEsparsa matriz = malloc(sizeof(struct _MatrizEsparsa));
  matriz->tabla = tablahash_crear(n);
  matriz->n = n;

  return matriz;
}

void slist_destruir(SList list) {
    SNodo *nodoAEliminar;
    while (list != NULL) {
        nodoAEliminar = list;
        list = list->sig;
        free(nodoAEliminar);
    }
}

void matrizesparsa_destruir(MatrizEsparsa matriz) {
    if (matriz == NULL) return;
    for (unsigned i = 0; i < matriz->tabla->capacidad; ++i) {
        slist_destruir(matriz->tabla->elems[i].list);
    }
    free(matriz->tabla->elems);
    free(matriz->tabla);
    free(matriz);
}

int slist_vacia (SList list) { return list == NULL; }

SList slist_agregar_inicio(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = lista;
  return nuevoNodo;
}

int slist_buscar (SList list, int dato) {
  int bandera = 0;
  for (SNodo* nodo = list ; nodo != NULL && !bandera ; nodo = nodo->sig)
    if (nodo->dato == dato) bandera = 1;
  return bandera;
}

void tablahash_insertar (TablaHash tabla, int nodo, int relacion) {
  if (nodo > tabla->capacidad || relacion > tabla->capacidad) return;

  unsigned idx = nodo % tabla->capacidad;

  if (slist_buscar(tabla->elems[idx].list, relacion)) return;

  if (slist_vacia(tabla->elems[idx].list))
    tabla->elems[idx].list = slist_agregar_inicio(tabla->elems[idx].list, relacion);
  else
    tabla->elems[idx].list = slist_agregar_inicio(tabla->elems[idx].list, relacion);
}

MatrizEsparsa matrizesparsa_insertar (MatrizEsparsa matriz, int nodo, int relacion) {
  tablahash_insertar(matriz->tabla, nodo, relacion);
}

int tablahash_buscar (TablaHash tabla, int nodo, int relacion) {
  if (nodo > tabla->capacidad || relacion > tabla->capacidad) return 0;

  unsigned idx = nodo % tabla->capacidad;

  if (slist_vacia(tabla->elems[idx].list)) return 0;

  if (slist_buscar(tabla->elems[idx].list, relacion)) return 1;

  return 0;
}

SList slist_eliminar (SList list, int dato) {
  if (slist_vacia(list)) return NULL;

  if (list->dato == dato) {
    SNodo *temp = list;
    list = list->sig;
    free(temp);
    return list;
  }

  SNodo *temp = list;
  for (; temp->sig != NULL && temp->sig->dato != dato ; temp = temp->sig);

  if (temp->sig != NULL) {
    SNodo *nodoAEliminar = temp->sig;
    temp->sig = nodoAEliminar->sig;
    free(nodoAEliminar);
  }

  return list;
}

void tablahash_eliminar (TablaHash tabla, int nodo, int relacion) {
  if (nodo > tabla->capacidad || relacion > tabla->capacidad) return;

  unsigned idx = nodo % tabla->capacidad;

  if (slist_vacia(tabla->elems[idx].list)) return;

  if (slist_buscar(tabla->elems[idx].list, relacion))
    tabla->elems[idx].list = slist_eliminar(tabla->elems[idx].list, relacion);
}

MatrizEsparsa matrizesparsa_eliminar (MatrizEsparsa matriz, int nodo, int relacion) {
  tablahash_eliminar(matriz->tabla, nodo, relacion);
}

int es_simetrica (MatrizEsparsa matriz) {
  if (matriz == NULL || matriz->tabla == NULL || matriz->tabla->elems == NULL) return 1;

  int bandera = 1;
  for (int i = 0 ; i < matriz->n && bandera ; i++) {
    SNodo *nodo = matriz->tabla->elems[i].list;
    while (!slist_vacia(nodo)) {
        int j = nodo->dato;
        if (j != i && !slist_buscar(matriz->tabla->elems[j].list, i))
          bandera = 0;
        nodo = nodo->sig;
    }
  }
  return bandera;
}

SList slist_eliminar_inicio(SList list) {
  if (slist_vacia(list)) return NULL;
  SNodo *temp = list;
  list = list->sig;
  free(temp);
  return list;
}

int r_kleen(MatrizEsparsa matriz, int nodo_inicio) {
  if (nodo_inicio >= matriz->n || matriz == NULL) return 0;

  int *visitados = calloc(matriz->n, sizeof(int));
  SList pila = slist_crear();
    
  pila = slist_agregar_inicio(pila, nodo_inicio);
  visitados[nodo_inicio] = 1; 
    
  int contador = 0;

  while (!slist_vacia(pila)) {
    int actual = pila->dato;
    pila = slist_eliminar_inicio(pila);
        
    contador++;

    SList vecinos = matriz->tabla->elems[actual].list;
        
    while (vecinos != NULL) {
      int vecino_idx = vecinos->dato;
      if (vecino_idx < matriz->n && !visitados[vecino_idx]) {
        visitados[vecino_idx] = 1; 
        pila = slist_agregar_inicio(pila, vecino_idx);
      }

    vecinos = vecinos->sig;
    }
  }

  free(visitados);
  return (contador > 0) ? contador - 1 : 0;
}

void slist_recorrer(SList lista) {
  for (SNodo *nodo = lista; nodo != NULL; nodo = nodo->sig)
    printf(" %d ", nodo->dato);
}
int main() {
    // 1. Crear matriz 'm'
    MatrizEsparsa m = matrizesparsa_crear(6); 

    printf("--- Test Simetria ---\n");
    matrizesparsa_insertar(m, 0, 1);
    matrizesparsa_insertar(m, 1, 0);
    // Ahora debería dar 1
    printf("Es simetrica (0<->1)? %d (Esperado: 1)\n", es_simetrica(m));

    matrizesparsa_insertar(m, 0, 2); 
    // Ahora debería dar 0
    printf("Es simetrica (0->2)? %d (Esperado: 0)\n", es_simetrica(m));

    // IMPORTANTE PARA VALGRIND: Liberar 'm' antes de terminar o reutilizar
    matrizesparsa_destruir(m);

    // 2. Crear matriz 'red'
    MatrizEsparsa red = matrizesparsa_crear(5);
    
    matrizesparsa_insertar(red, 0, 1);
    matrizesparsa_insertar(red, 1, 0);
    
    matrizesparsa_insertar(red, 2, 0);
    matrizesparsa_insertar(red, 2, 1);
    matrizesparsa_insertar(red, 2, 2);
    matrizesparsa_insertar(red, 2, 3);
    matrizesparsa_insertar(red, 2, 4);

    matrizesparsa_insertar(red, 3, 2);

    printf("\n--- Test r-kleen ---\n");
    int alcanzables = r_kleen(red, 3);
    printf("r-kleen(Dalma): %d (Esperado: 4)\n", alcanzables);

    int ana_alcanza = r_kleen(red, 0);
    printf("r-kleen(Ana): %d (Esperado: 1)\n", ana_alcanza);

    // IMPORTANTE PARA VALGRIND: Liberar 'red' al final
    matrizesparsa_destruir(red);

    return 0;
}



