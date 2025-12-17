#include <stdio.h>
#include <stdlib.h>

typedef struct bstNodo_ {
  int dato;
  struct bstNodo_ *der, *izq;
} bstNodo;

typedef bstNodo *BSTSet;

BSTSet crearBST () { return NULL; }

BSTSet agregarBST (BSTSet set, int dato) {
  if (set == NULL) {
    bstNodo *nuevoNodo = malloc(sizeof(bstNodo));
    nuevoNodo->der = NULL;
    nuevoNodo->izq = NULL;
    nuevoNodo->dato = dato;
    return nuevoNodo;
  }

  if (dato > set->dato)
    set->der = agregarBST(set->der, dato);

  else if (dato < set->dato)
    set->izq = agregarBST(set->izq, dato);

  return set;
}

void imprimeBST (BSTSet set) {
  if (set == NULL) return;
  
  imprimeBST (set->izq);

  printf("%d ", set->dato);

  imprimeBST (set->der);
}

void destruirBST (BSTSet set) {
  if (set == NULL) return;
  destruirBST(set->izq);
  destruirBST(set->der);
  free(set);
}

int aux_buscarBST (BSTSet set, int dato) {
  if (set == NULL) return 0;
  if (dato == set->dato) return 1;
  if (dato < set->dato) return aux_buscarBST(set->izq, dato);
  return aux_buscarBST(set->der, dato);
}

BSTSet aux_unirBST (BSTSet set1, BSTSet set2) {
  if (set1 == NULL) return set2;

  set2 = aux_unirBST(set1->izq, set2);
  set2 = agregarBST(set2, set1->dato);
  set2 = aux_unirBST(set1->der, set2);
  
  return set2;
}

BSTSet interseccionBST (BSTSet set1, BSTSet set2) {
  if (set1 == NULL || set2 == NULL) return NULL;
  
  BSTSet interIzq = interseccionBST(set1->izq, set2);
  BSTSet interDer = interseccionBST(set1->der, set2);

  BSTSet setIntersección = crearBST();

  if (aux_buscarBST(set2, set1->dato))
    setIntersección = agregarBST(setIntersección, set1->dato);

  setIntersección = aux_unirBST(interIzq, setIntersección);
  setIntersección = aux_unirBST(interDer, setIntersección);

  destruirBST(interIzq);
  destruirBST(interDer);
  return setIntersección;
}

void dfs_interseccion (BSTSet set1, BSTSet set2, BSTSet *setInterseccion) {
  if (set1 == NULL) return;

  if (aux_buscarBST(set2, set1->dato))
    *setInterseccion = agregarBST(*setInterseccion, set1->dato);
  dfs_interseccion(set1->izq, set2, setInterseccion);
  dfs_interseccion(set1->der, set2, setInterseccion);
}

BSTSet interseccionBST2 (BSTSet set1, BSTSet set2) {
  BSTSet setInterseccion = crearBST();

  dfs_interseccion(set1, set2, &setInterseccion);
  return setInterseccion;
}

int abs (int x) {
  if (x < 0) return -x;
  return x;
}

int lejanoBST (BSTSet set, int k) {
  if (set == NULL) return 0;
  
  BSTSet setIzq = set;
  while (setIzq->izq != NULL) setIzq = setIzq->izq;
  int min = setIzq->dato;

  BSTSet setDer = set;
  while (setDer->der != NULL) setDer = setDer->der;
  int max = setDer->dato;

  if (abs(max-k) >= abs(min-k)) return max;
  return min;

}


int main() {
    BSTSet A = crearBST();
    BSTSet B = crearBST();

    A = agregarBST(A, 6);
    A = agregarBST(A, 4);
    A = agregarBST(A, 9);
    A = agregarBST(A, 2);

B = agregarBST(B, 50);
B = agregarBST(B, 30);
B = agregarBST(B, 70);
B = agregarBST(B, 20);
B = agregarBST(B, 40);
B = agregarBST(B, 60);
B = agregarBST(B, 80);
B = agregarBST(B, 10);
B = agregarBST(B, 25);
B = agregarBST(B, 35);
B = agregarBST(B, 45);
B = agregarBST(B, 55);
B = agregarBST(B, 65);
B = agregarBST(B, 75);
B = agregarBST(B, 85);
B = agregarBST(B, 5);
B = agregarBST(B, 15);
B = agregarBST(B, 33);
B = agregarBST(B, 68);
B = agregarBST(B, 73);


    printf("Conjunto A: ");
    imprimeBST(A);
    printf("\n");

    printf("Conjunto B: ");
    imprimeBST(B);
    printf("\n");

    BSTSet I = interseccionBST(A, B);

    printf("Intersección: ");
    imprimeBST(I);
    printf("\n");

    BSTSet I2 = interseccionBST2(A, B);

    printf("Intersección 2: ");
    imprimeBST(I2);
    printf("\n");

    int lejano = lejanoBST (B, 50);
    printf("Lejano: %d\n", lejano);

    destruirBST(A);
    destruirBST(B);
    destruirBST(I);
    destruirBST(I2);

    return 0;
}