#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "glist.h"

#define CAPACIDAD 10

// 1

GArray listToArray (GList lista, FuncionCopia c) {
  int capacidad = CAPACIDAD;
  int n = 0;
  GArray garr = malloc(sizeof(void*)*capacidad);
  
  for (GNode* temp = lista ; temp != NULL ; temp = temp->next){
    if (n == capacidad) {
        capacidad = capacidad*2;
        garr = realloc(garr,sizeof(void*)*capacidad);
    }
    garr[n] = c(temp->data);
    n++;
  }
  return garr;
}

// 2

void* retorno (void *data) {
  return data;
}

GArray listToArrayPersona (GList lista) {
  return listToArray(lista, retorno);
}

// 3

int mayorA18 (void *data) {
    Persona *persona = (Persona*)data;
    return persona->edad > 18;
}

int contieneAa (void *data) {
  Persona *persona = (Persona*)data;
  int bandera = 0;
  for (int i = 0 ; persona->direccion[i] != '\0' && !bandera ; i++) {
    if (persona->direccion[i] == 'A' || persona->direccion[i] == 'a')
      bandera = 1;
  }
  return bandera;
}

int personaMayorConA(void *data){
  return mayorA18(data) && contieneAa(data);
}

GList personaCopia (Persona *persona) {
  Persona *copiaPersona = malloc(sizeof(Persona));
  strcpy(copiaPersona->direccion,persona->direccion);
  strcpy(copiaPersona->nombre,persona->nombre);
  strcpy(copiaPersona->dni,persona->dni);
  copiaPersona->edad = persona->edad;

  return copiaPersona;
}

GList mayores18conA (GList lista) {
  return glist_filtrar(lista, personaCopia, personaMayorConA);
}