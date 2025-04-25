#include "contacto.h"
#include "colas.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
  Cola cola = cola_crear();

  Contacto *contactos[7];
  contactos[0] = contacto_crear("Pepe Argento", "3412695452", 61);
  contactos[1] = contacto_crear("Moni Argento", "3412684759", 60); 
  contactos[2] = contacto_crear("Coqui Argento", "3415694286", 32);
  contactos[3] = contacto_crear("Paola Argento", "3416259862", 29);
  contactos[4] = contacto_crear("Maria Elena Fuseneco", "3416874594", 59);
  contactos[5] = contacto_crear("Dardo Fuseneco", "3416894526", 64);

  // Encolamos los contactos
  for (int i = 0; i < 6; ++i) {
    cola_encolar(cola, contactos[i], (FuncionCopia)contacto_copia);
    contacto_destruir(contactos[i]);
  }

  printf("\nContenido de la cola:\n");
  cola_imprimir(cola, (FuncionVisitante)contacto_imprimir);
  puts("");

  // Mostramos el inicio de la cola
  Contacto *inicio= (Contacto *)cola_inicio(cola);
  printf("Inicio de la cola:\n");
  contacto_imprimir(inicio);
  
  // Desencolamos 2 elementos
  cola_desencolar(cola, (FuncionDestructora)contacto_destruir);
  cola_desencolar(cola, (FuncionDestructora)contacto_destruir);

  // Imprimimos el contenido actual de la cola
  printf("\nContenido de la cola:\n");
  cola_imprimir(cola, (FuncionVisitante)contacto_imprimir);

  inicio= (Contacto *)cola_inicio(cola);
  printf("\nInicio de la cola:\n");
  contacto_imprimir(inicio);

  contactos[6] = contacto_crear("Jeronimo Delorenzi", "3413213223", 22);
  cola_encolar(cola, contactos[6], (FuncionCopia)contacto_copia);

  printf("\nContenido de la cola:\n");
  cola_imprimir(cola, (FuncionVisitante)contacto_imprimir);

  cola_desencolar(cola, (FuncionDestructora)contacto_destruir);
  cola_desencolar(cola, (FuncionDestructora)contacto_destruir);
  cola_desencolar(cola, (FuncionDestructora)contacto_destruir);
  cola_desencolar(cola, (FuncionDestructora)contacto_destruir);
  
  printf("\nContenido de la cola:\n");
  cola_imprimir(cola, (FuncionVisitante)contacto_imprimir);

  inicio= (Contacto *)cola_inicio(cola);
  printf("\nInicio de la cola:\n");
  contacto_imprimir(inicio);

  // Destruimos la cola
  cola_destruir(cola, (FuncionDestructora)contacto_destruir);

  return 0;
}
