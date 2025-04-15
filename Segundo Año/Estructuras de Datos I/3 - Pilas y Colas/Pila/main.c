#include "arregloEnteros.h"
#include "pilas.h"
#include <stdio.h>

int main () {

  Pila pila = pila_crear(4);

  // esta vacía la pila?
  int esVacia = pila_es_vacia(pila);
  if (esVacia) {
    printf("Es vacía.\n");
  } else {
    printf("No es vacía");
  }
  // apilamos y preguntamos si es vacía.
  pila_apilar(pila,5);
  esVacia = pila_es_vacia(pila);
  if (esVacia) {
    printf("Es vacía.\n");
  } else {
    printf("No es vacía\n");
  }
  pila_imprimir(pila);

  // apilamos.
  pila_apilar(pila,6);
  pila_apilar(pila,2);
  pila_apilar(pila,1);

  // imprimimos en pantalla.
  pila_imprimir(pila);

  // desapilamos.
  pila_desapilar(pila);
  pila_desapilar(pila);

  // imprimimos en pantalla.
  pila_imprimir(pila);

  // apilamos.
  pila_apilar(pila,10);
  pila_apilar(pila,9);

  // como esta llena se va a redimensionar. Va a ser de tamaño 4.
  pila_apilar(pila,3);
  pila_apilar(pila,4);

  // imprimimos en pantalla la pila y el ultimo elemento.
  pila_imprimir(pila);
  int tope = pila_tope(pila);
  printf("Tope de la pila: %d\n", tope);

  // destruimos la pila.
  pila_destruir(pila);
  
  return 0;
}