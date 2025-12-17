#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef void (*FuncionVisitante)(void*);
typedef int (*FuncionComparadora)(void*, void*);
typedef void (*FuncionDestructora)(void*);
typedef void* (*FuncionCopiadora)(void*); 
typedef unsigned (*FuncionHash)(void*);

typedef struct _CDNodo {
  void *dato;
  double grado;
  struct _CDNodo *sig;
} CDNodo;

typedef struct _CasillaHash {
  CDNodo *nodo;
} CasillaHash;

struct _CDHash {
  CasillaHash *elems;
  unsigned capacidad;
  unsigned numElems;
  FuncionComparadora comp;
  FuncionCopiadora copy;
  FuncionDestructora destr;
  FuncionVisitante visit;
  FuncionHash hash;
};

typedef struct _CDHash *CD;

CD cd_crear (unsigned capacidad, FuncionComparadora comp, FuncionCopiadora copy, FuncionDestructora destr, FuncionVisitante visit, FuncionHash hash) {
  CD cd = malloc(sizeof(struct _CDHash));
  cd->elems = malloc (sizeof(CasillaHash) * capacidad);
  cd->capacidad = capacidad;
  cd->numElems = 0;
  cd->comp = comp;
  cd->copy = copy;
  cd->destr = destr;
  cd->visit = visit;
  cd->hash = hash;

  for (unsigned i = 0 ; i < cd->capacidad ; ++i)
    cd->elems[i].nodo = NULL;

  return cd;
}

CDNodo *cdnodo_agregar_inicio(CDNodo* list, void *data, double grado, FuncionCopiadora copy) {
  CDNodo *newNode = malloc(sizeof(CDNodo));
  assert(newNode != NULL);
  newNode->sig = list;
  newNode->dato = copy(data);
  newNode->grado = grado;
  return newNode;
}

CD cd_agregar (CD cd, void *dato, double grado) {
  unsigned idx = cd->hash(dato) % cd->capacidad;

  CDNodo *nodo = cd->elems[idx].nodo;

  int bandera = 0;

  for (; nodo != NULL && !bandera ; nodo = nodo->sig) {
    if (cd->comp(dato, nodo->dato) == 0 && grado > 0) {
      cd->destr(nodo->dato);  
      nodo->dato = cd->copy(dato);
      nodo->grado = grado;
      bandera = 1;
    }
  }
  if (!bandera && grado > 0) {
    cd->elems[idx].nodo =
      cdnodo_agregar_inicio(cd->elems[idx].nodo, dato, grado, cd->copy);
    cd->numElems++;
  }
  
  return cd;
}

void cd_modificar_gp (CD cd, void *dato, double grado) {
  unsigned idx = cd->hash(dato) % cd->capacidad;
  CDNodo *nodo = cd->elems[idx].nodo;
  CDNodo *ant = NULL;
  int bandera = 0;

  while (nodo != NULL && !bandera) {
    if (cd->comp(dato, nodo->dato) == 0) {
      if (grado == 0) {
        CDNodo *temp = nodo;
        if (ant == NULL)
          cd->elems[idx].nodo = cd->elems[idx].nodo->sig;
        else
          ant->sig = nodo->sig;
        cd->destr(temp->dato);
        free(temp);
        cd->numElems--;
      } else 
          nodo->grado = grado;
      bandera = 1;
    } else {
      ant = nodo;
      nodo = nodo->sig;
    }
  }
}

int cd_subconjunto (CD A, CD B) {
  int bandera = 1;
  for (unsigned i = 0 ; i < A->capacidad ; ++i) {
    CDNodo *nodoA = A->elems[i].nodo;
    
    for (; nodoA != NULL && bandera ; nodoA = nodoA->sig) {
      unsigned iB = B->hash(nodoA->dato) % B->capacidad;
      CDNodo *nodoB = B->elems[iB].nodo;
      int encontrado = 0;
      
      for (; nodoB != NULL && !encontrado ; nodoB = nodoB->sig) {
        if (B->comp(nodoA->dato, nodoB->dato) == 0) {
          if (nodoA->grado <= nodoB->grado)
            encontrado = 1;
          else
            bandera = 0;
        }
      }
      if (!encontrado)
        bandera = 0;
    }
  }
  return bandera;
}

CD cd_union (CD A, CD B) {
  CD UNION = cd_crear(A->capacidad + B->capacidad, A->comp, A->copy, A->destr, A->visit, A->hash);

  for (unsigned i = 0 ; i < A->capacidad ; ++i) {
    CDNodo *nodoA = A->elems[i].nodo;

    for (; nodoA != NULL ; nodoA = nodoA->sig)
      cd_agregar(UNION, nodoA->dato, nodoA->grado);
  }

  for (unsigned i = 0 ; i < B->capacidad ; ++i) {
    CDNodo *nodoB = B->elems[i].nodo;

    for (; nodoB != NULL ; nodoB = nodoB->sig) {
      unsigned idx = UNION->hash(nodoB->dato) % B->capacidad;
      CDNodo *nodoUNION = UNION->elems[idx].nodo;
      int bandera = 0;

      for (; nodoUNION != NULL && !bandera ; nodoUNION = nodoUNION->sig) {
        if (UNION->comp(nodoUNION->dato, nodoB->dato) == 0) {
            if (nodoB->grado > nodoUNION->grado)
              nodoUNION->grado = nodoB->grado;
            bandera = 1;
        }

        if (!bandera)
          cd_agregar(UNION, nodoB->dato, nodoB->grado);

      }
    }
  }

  return UNION;
}

CD cd_diferencia (CD A, CD B) {
  CD DIFERENCIA = cd_crear(A->capacidad, A->comp, A->copy, A->destr, A->visit, A->hash);

  for (unsigned i = 0 ; i < A->capacidad ; ++i) {
    CDNodo *nodoA = A->elems[i].nodo;

    for (; nodoA != NULL ; nodoA = nodoA->sig) {
      unsigned idx = B->hash(nodoA->dato) % B->capacidad;
      CDNodo *nodoB = B->elems[idx].nodo;
      int bandera = 0;
      double nuevoGrado = nodoA->grado;

      for (; nodoB != NULL && !bandera ; nodoB = nodoB->sig) 
        if (B->comp(nodoA->dato, nodoB->dato) == 0) {
          nuevoGrado = nodoA->grado - nodoB->grado;
          bandera = 1;
        }
      if (nuevoGrado > 0)
        cd_agregar(DIFERENCIA, nodoA->dato, nuevoGrado);
    }
  }
  return DIFERENCIA;
}

void *copiar_entero (void *dato) {
  int *temp = malloc(sizeof(int));
  *temp = *(int*)dato;
  return temp;
}

void destruir_entero (void *dato) {
  free(dato);
}

unsigned hash_entero (void *dato) {
  return *(int*)dato;
}

int comparar_entero (void *dato1, void *dato2) {
  return *(int*)dato1 - *(int*)dato2;
}

void imprimir_entero (void *dato) {
  printf("%d ", *(int*)dato);
}

void imprimir_cd(CD cd, const char *nombre) {
    printf("%s = { ", nombre);
  
    for (unsigned i = 0 ; i < cd->capacidad ; ++i) {
      CDNodo *nodo = cd->elems[i].nodo;
  
      for (; nodo != NULL ; nodo = nodo->sig) {
        printf("(%d, %.2f) ",
          *(int*)nodo->dato,
          nodo->grado
        );
      }
    }
  
    printf("}\n");
  }

  void cd_destruir(CD cd) {
    for (unsigned i = 0 ; i < cd->capacidad ; ++i) {
      CDNodo *nodo = cd->elems[i].nodo;
  
      while (nodo != NULL) {
        CDNodo *sig = nodo->sig;
        cd->destr(nodo->dato);
        free(nodo);
        nodo = sig;
      }
    }
  
    free(cd->elems);
    free(cd);
  }
  
  
  int main(void) {

    /* Crear conjuntos difusos */
    CD A = cd_crear(10, comparar_entero, copiar_entero,
                    destruir_entero, imprimir_entero, hash_entero);
  
    CD B = cd_crear(10, comparar_entero, copiar_entero,
                    destruir_entero, imprimir_entero, hash_entero);
  
    /* Elementos */
    int x = 1, y = 2, z = 3, w = 4;
  
    /* Agregar elementos a A */
    cd_agregar(A, &x, 0.7);
    cd_agregar(A, &y, 0.5);
    cd_agregar(A, &z, 0.2);
  
    /* Agregar elementos a B */
    cd_agregar(B, &y, 0.8);
    cd_agregar(B, &z, 0.1);
    cd_agregar(B, &w, 0.6);
  
    imprimir_cd(A, "A");
    imprimir_cd(B, "B");
  
    /* Modificar grado */
    cd_modificar_gp(A, &z, 0.9);
    cd_modificar_gp(B, &y, 0.0); /* elimina y */
  
    printf("\nLuego de modificar grados:\n");
    imprimir_cd(A, "A");
    imprimir_cd(B, "B");
  
    /* Subconjunto */
    if (cd_subconjunto(A, B))
      printf("\nA es subconjunto de B\n");
    else
      printf("\nA NO es subconjunto de B\n");
  
    /* Unión */
    CD U = cd_union(A, B);
    imprimir_cd(U, "A ∪ B");
  
    /* Diferencia */
    CD D = cd_diferencia(A, B);
    imprimir_cd(D, "A - B");

    cd_destruir(A);
    cd_destruir(B);
    cd_destruir(U);
    cd_destruir(D);
  
    return 0;
  }
  