#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_HEAP 20

typedef struct {
  char *dni, *nombre, *descripcionCargo;
  int prioridad;
} _Invitado;

typedef _Invitado *Invitado;

typedef struct _Nodo {
  Invitado invitado;
  struct _Nodo *der, *izq;
} Nodo;

typedef Nodo *Arbol;


typedef struct {
  Invitado datos[MAX_HEAP];
  int nelems;
} _BHeap;

typedef _BHeap *BHeap;

Arbol construirArbolDesdeHeap (BHeap heap, int i) {
  if (i >= heap->nelems) return NULL;

  Arbol arbol = malloc(sizeof(Nodo));
  arbol->invitado = heap->datos[i];
  arbol->izq = construirArbolDesdeHeap(heap, 2*i+1);
  arbol->der = construirArbolDesdeHeap(heap, 2*i+2);

  return arbol;
}

Arbol convierteHeapEnArbol (BHeap heap) {
  if (heap == NULL || heap->nelems == 0) return NULL;
  return construirArbolDesdeHeap(heap, 0);
}

void recorrerArbolYAgregarEnHeap (Arbol inicio, BHeap heap, int pos) {
  if (inicio == NULL || pos >= MAX_HEAP) return;

  heap->datos[pos] = inicio->invitado;
  if(heap->nelems <= pos) heap->nelems++;

  recorrerArbolYAgregarEnHeap(inicio->izq, heap, 2*pos + 1);
  recorrerArbolYAgregarEnHeap(inicio->der, heap, 2*pos+2);

}

BHeap convierteArbolEnHeap (Arbol inicio) {
  if (inicio == NULL) return NULL;

  BHeap heap = malloc(sizeof(_BHeap));
  heap->nelems = 0;

  recorrerArbolYAgregarEnHeap(inicio, heap, 0);

  return heap;
}

Invitado crearInvitado (char* dni, char* nombre, char *cargo, int prioridad) {
  Invitado i = malloc(sizeof(_Invitado));
  i->dni = strdup(dni);
  i->nombre = strdup(nombre);
  i->descripcionCargo = strdup(cargo);
  i->prioridad = prioridad;
  return i;
}

void destruirInvitado (Invitado i) {
  free(i->dni);
  free(i->nombre);
  free(i->descripcionCargo);
  free(i);
}

void mostrarInvitado (Invitado i) {
  printf("DNI: %s | Nombre: %s | Cargo: %s | Prioridad: %d\n", i->dni, i->nombre, i->descripcionCargo, i->prioridad);
}

void recorrerArbol (Arbol inicio) {
  if (inicio == NULL) return;
  mostrarInvitado(inicio->invitado);
  recorrerArbol(inicio->izq);
  recorrerArbol(inicio->der);
}

void destruirArbol (Arbol inicio) {
  if (inicio == NULL) return;
  destruirArbol(inicio->izq);
  destruirArbol(inicio->der);
  destruirInvitado(inicio->invitado);
  free(inicio);
}

void recorrerHeap (BHeap heap) {
  for (int i = 0 ; i < heap->nelems ; i++)
    mostrarInvitado(heap->datos[i]);
}

void destruirHeap (BHeap heap) {
  for (int i = 0 ; i < heap->nelems ; i++)
    destruirInvitado(heap->datos[i]);
  free(heap);
}

int main () {
  BHeap heap = malloc(sizeof(_BHeap));
  heap->nelems = 0;

  heap->datos[heap->nelems++] = crearInvitado("123", "Jero", "Hola",1);
  heap->datos[heap->nelems++] = crearInvitado("456", "Rocio", "Chau",2);
  heap->datos[heap->nelems++] = crearInvitado("789", "Paco", "Hello",3);
  heap->datos[heap->nelems++] = crearInvitado("101112", "Manolo", "Bye",4);

  printf("Mostrar Heap\n");
  recorrerHeap(heap);

  Arbol arbol = convierteHeapEnArbol(heap);
  printf("Mostrar Arbol\n");
  recorrerArbol(arbol);

  BHeap heap2 = convierteArbolEnHeap(arbol);
  printf("Mostrar heap2\n");
  recorrerHeap(heap2);

  destruirArbol(arbol);
  destruirHeap(heap);
  destruirHeap(heap2);

  return 0;
}