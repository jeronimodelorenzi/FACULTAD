#include <stdio.h>
#include <stdlib.h>

typedef int(*Operacion)(int, int);

typedef struct _Nodo {
  int dato;
  struct _Nodo *izq, *der;
} Nodo;

typedef Nodo* Conjunto;

Conjunto conjunto_crear () {return NULL;}

Conjunto conjunto_insertar (Conjunto conjunto, int dato) {
  if (conjunto == NULL) {
    Nodo *nuevoNodo = malloc(sizeof(Nodo));
    nuevoNodo->izq = NULL;
    nuevoNodo->der = NULL;
    nuevoNodo->dato = dato;
    return nuevoNodo;
  }

  if (dato < conjunto->dato) conjunto->izq = conjunto_insertar(conjunto->izq, dato);
  if (dato > conjunto->dato) conjunto->der = conjunto_insertar(conjunto->der, dato);

  return conjunto;
}

int pertece_conjunto (Conjunto conjunto, int dato) {
  if (conjunto == NULL) return 0;
  if (dato == conjunto->dato) return 1;
  if (dato < conjunto->dato ) return pertece_conjunto(conjunto->izq, dato);
  return pertece_conjunto(conjunto->der, dato);
}

int es_neutro (Conjunto conjunto, int e, Operacion op) {
  if (conjunto == NULL) return 1;

  if (op(e, conjunto->dato) != conjunto->dato) return 0;
  if (op(conjunto->dato, e) != conjunto->dato) return 0;

  return es_neutro (conjunto->izq, e, op) && es_neutro (conjunto->der, e, op);
}

int x_tiene_inverso (Conjunto conjunto, int x, int e, Operacion op) {
  if (conjunto == NULL) return 0;

  if (op(x, conjunto->dato) == e && op(conjunto->dato, x) == e)
    return 1;
  
  return x_tiene_inverso (conjunto->izq, x, e, op) || x_tiene_inverso (conjunto->der, x, e, op);
}

int tienen_inversos_aux (Conjunto nodo_actual, Conjunto raiz, int e, Operacion op) {
    if (nodo_actual == NULL) return 1;

    if (!x_tiene_inverso(raiz, nodo_actual->dato, e, op)) return 0;

    return tienen_inversos_aux(nodo_actual->izq, raiz, e, op) && tienen_inversos_aux(nodo_actual->der, raiz, e, op);
}


int tienen_inversos (Conjunto conjunto, int e, Operacion op) {
    return tienen_inversos_aux(conjunto, conjunto, e, op);
}

int es_grupo (Conjunto conjunto, int e, Operacion op) {
  return es_neutro(conjunto, e, op) && tienen_inversos(conjunto,e, op);
};

void conjunto_destruir(Conjunto conjunto) {
    if (conjunto == NULL) return;
    conjunto_destruir(conjunto->izq);
    conjunto_destruir(conjunto->der);
    free(conjunto);
}

// PRUEBAS
int suma_mod5(int a, int b) { return (a + b) % 5; }
int suma(int a, int b) { return a + b; }
int mult_mod8(int a, int b) { return (a * b) % 8; }

Conjunto generar_conjunto(int* arr, int n) {
    Conjunto c = conjunto_crear();
    for (int i = 0; i < n; i++)
        c = conjunto_insertar(c, arr[i]);
    return c;
}

int main() {

    printf("======== CASO 1: (Z5, +_mod5) ES GRUPO ========\n");
    int A1[] = {0,1,2,3,4};
    Conjunto C1 = generar_conjunto(A1, 5);

    printf("¿Es grupo? %s\n",
        es_grupo(C1, 0, suma_mod5) ? "SI" : "NO");

    conjunto_destruir(C1);

    printf("\n======== CASO 2: (Z+, +) NO ES GRUPO ========\n");
    int A2[] = {1,2,3,4};
    Conjunto C2 = generar_conjunto(A2, 4);

    printf("¿Es grupo? %s\n",
        es_grupo(C2, 0, suma) ? "SI" : "NO");

    conjunto_destruir(C2);

    printf("\n======== CASO 3: Multiplicar mod 8 ========\n");

    int A3[] = {1,3,5,7};
    Conjunto C3 = generar_conjunto(A3, 4);

    printf("¿Es grupo? %s\n",
        es_grupo(C3, 1, mult_mod8) ? "SI" : "NO");

    conjunto_destruir(C3);


    printf("\n======== CASO 4: Z,0 + ========\n");
    int A4[1000];
    int j = 0;
    for (int i = -499; j < 500 ; j++, i++)
      A4[j] = i;
    for (int i = 0; j < 1000 ; j++, i++)
      A4[j] = i;

    Conjunto C4 = generar_conjunto(A4, 1000);

    printf("¿Es grupo? %s\n",
        es_grupo(C4, 0, suma) ? "SI" : "NO");

    conjunto_destruir(C4);

    return 0;
}