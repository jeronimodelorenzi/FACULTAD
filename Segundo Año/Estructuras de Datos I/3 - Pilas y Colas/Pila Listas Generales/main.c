#include "contacto.h"
#include "pila.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
  Pila pila = pila_crear();

  Contacto *contactos[6];
  contactos[0] = contacto_crear("Pepe Argento", "3412695452", 61);
  contactos[1] = contacto_crear("Moni Argento", "3412684759", 60); 
  contactos[2] = contacto_crear("Coqui Argento", "3415694286", 32);
  contactos[3] = contacto_crear("Paola Argento", "3416259862", 29);
  contactos[4] = contacto_crear("Maria Elena Fuseneco", "3416874594", 59);
  contactos[5] = contacto_crear("Dardo Fuseneco", "3416894526", 64);

  // Apilamos los contactos
  for (int i = 0; i < 6; ++i) {
    pila_apilar(&pila, contactos[i], (FuncionCopia)contacto_copia);
    contacto_destruir(contactos[i]);
  }

  printf("\nContenido de la pila:\n");
  pila_imprimir(pila, (FuncionVisitante)contacto_imprimir);
  puts("");

  // Mostramos el tope de la pila
  Contacto *tope = (Contacto *)pila_tope(pila);
  printf("Tope de la pila:\n");
  contacto_imprimir(tope);
  
  // Desapilamos 2 elementos
  pila_desapilar(&pila, (FuncionDestructora)contacto_destruir);
  pila_desapilar(&pila, (FuncionDestructora)contacto_destruir);

  // Imprimimos el contenido actual de la pila
  printf("\nContenido de la pila:\n");
  pila_imprimir(pila, (FuncionVisitante)contacto_imprimir);

  // Revertimos pila
  printf("\nContenido de la pila revertido:\n");
  Pila pila_revertir = pila_crear();
  pila_revertir = pila_revertir_orden(pila, (FuncionCopia)contacto_copia);
  pila_imprimir(pila_revertir, (FuncionVisitante)contacto_imprimir);


  // Destruimos la pila
  pila_destruir(pila_revertir, (FuncionDestructora)contacto_destruir);
  pila_destruir(pila, (FuncionDestructora)contacto_destruir);

  return 0;
}
