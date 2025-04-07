#include <stdio.h>
#include <stdlib.h>
#include "slist.h"

static void imprimir_entero(int dato) {
  printf("%d ", dato);
}

int comparar(int a, int b) {
return a-b;
}

int main(int argc, char *argv[]) {

  // Crea listas.
  SList lista1 = slist_crear();
  SList lista2 = slist_crear();
  SList lista3 = slist_crear();
  SList lista4 = slist_crear();

  // Agrega valores a la lista.
  lista1 = slist_agregar_inicio(lista1, 3);
  lista1 = slist_agregar_inicio(lista1, 2);
  lista1 = slist_agregar_inicio(lista1, 1);
  lista1 = slist_agregar_final(lista1, 4);

  lista2 = slist_agregar_inicio(lista2, 2);
  lista2 = slist_agregar_inicio(lista2, 3);
  lista2 = slist_agregar_inicio(lista2, 1);
  lista2 = slist_agregar_final(lista2, 4);

  lista4 = slist_agregar_inicio(lista4, 1);

  // Muestra en pantalla de las listas.
  printf("Lista 1:\n");
  slist_recorrer(lista1, imprimir_entero);
  printf("\n");

  printf("Lista 2:\n");
  slist_recorrer(lista2, imprimir_entero);
  printf("\n");

  printf("Lista 3 es NULL.\n");

  printf("Lista 4:\n");
  slist_recorrer(lista4, imprimir_entero);
  printf("\n");

  // Muestra en pantalla longitudes.
  int longList1 = slist_longitud(lista1);
  int longList2 = slist_longitud(lista2);
  int longList3 = slist_longitud(lista3);
  int longList4 = slist_longitud(lista4);

  printf("Longitud lista1: %d\n",longList1);
  printf("Longitud lista2: %d\n",longList2);
  printf("Longitud lista3: %d\n",longList3);
  printf("Longitud lista4: %d\n",longList4);

  // Concatena
  slist_concatenar(&lista1,&lista2);
  slist_concatenar(&lista3,&lista4);
  
  printf("Lista 1-2:\n");
  slist_recorrer(lista1, imprimir_entero);
  printf("\n");

  printf("Lista 3-4:\n");
  slist_recorrer(lista3, imprimir_entero);
  printf("\n");
  
  // Agrega un dato en una posicion pasada.
  slist_insertar(&lista3, 4, 0);
  printf("Lista 3-4 con dato agregado:\n");
  slist_recorrer(lista3, imprimir_entero);
  printf("\n");

  // Elimina un dato de la posicion pasada.
  slist_eliminar(&lista1,0);
  printf("Lista 1-2 eliminando la posicion 1:\n");
  slist_recorrer(lista1, imprimir_entero);
  printf("\n");

  // Determina si un elemento esta en la lista.
  int contiene = slist_contiene(lista1, 0);
  if (contiene) {
    printf("La lista contiene al numero.\n");
  } else {
    printf("La lista no contiene al numero.\n");
  }

  // Determina la posicion de un elemento.
  int indice = slist_indice(lista1,4);
  printf("La posicion del numero en la lista es la %d.\n", indice);

  // Interseca lista.
  SList listaInterseca = slist_crear();
  listaInterseca = slist_intersecar(lista1, lista3);
  printf("Lista1 y Lista2 intersecada.\n");
  slist_recorrer(listaInterseca, imprimir_entero);
  printf("\n");

  // Ordena lista
  slist_ordenar(&lista1, comparar);
  printf("Lista1 ordenada.\n");
  slist_recorrer(lista1, imprimir_entero);
  printf("\n");

  // Inversa de la lista
  SList listaInversa = slist_crear();
  listaInversa = slist_reverso(lista1);
  printf("Lista1 ordenada inversa.\n");
  slist_recorrer(listaInversa, imprimir_entero);
  printf("\n");

  // Intercala lista
  SList listaIntercalada = slist_crear();
  listaIntercalada = slist_intercalar(lista3,lista1);
  printf("Lista1 y Lista3 intercaladas.\n");
  slist_recorrer(listaIntercalada, imprimir_entero);
  printf("\n");

  // Divide la lista a la mitad
  SList listaSegundaMitad = slist_crear();
  listaSegundaMitad = slist_partir(lista1);
  printf("Segunda mitad de Lista1.\n");
  slist_recorrer(listaSegundaMitad, imprimir_entero);
  printf("\n");

  // Destruir listas, se destruyen estas solas porque se les concatenan la lista2 a la lista1
  // y la lista4 a la lista3.
  slist_destruir(lista1);
  slist_destruir(lista3);
  slist_destruir(listaInterseca);
  slist_destruir(listaInversa);
  slist_destruir(listaIntercalada);
  slist_destruir(listaSegundaMitad);

  return 0;
}
