#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cdlist.h"

Nodo* agregaObjetivo (Nodo *inicio, Objetivo o) {
  Nodo* newNode = malloc(sizeof(Nodo));
  newNode->dato = o;

  if (inicio == NULL) {
    newNode->sig = newNode;
    newNode->ant = newNode;
    return newNode;
  }

  int bandera = 0;

  if (o.importancia <= inicio->dato.importancia) {
    newNode->ant = inicio->ant;
    newNode->sig = inicio;
    inicio->ant->sig = newNode;
    inicio->ant = newNode;
    return newNode;
  }
  for (Nodo *temp = inicio->sig ; temp != inicio && !bandera; temp = temp->sig) {
    if (o.importancia <= temp->dato.importancia) {
      newNode->ant = temp->ant;
      newNode->sig = temp;
      temp->ant->sig = newNode;
      temp->ant = newNode;
      bandera = 1;
    }
  }

  if(!bandera) {

    newNode->ant = inicio->ant;
    newNode->sig = inicio;
    inicio->ant->sig = newNode;
    inicio->ant = newNode;
  }
  return inicio;
}

void muestraCantidadHabitantesPorPais (Nodo *inicio, char *pais) {
  if (inicio == NULL) {
    printf("No hay objetivos en la lista");
    return;
  }

  int totalHabitantes = 0;
  if(strcmp(inicio->dato.pais, pais) == 0)
    totalHabitantes += inicio->dato.cantidadHabitantes;
  for(Nodo *temp = inicio->sig ; temp != inicio ; temp = temp->sig) {
    if(strcmp(temp->dato.pais, pais) == 0)
    totalHabitantes += temp->dato.cantidadHabitantes;
  }

  if (totalHabitantes) {
    printf("Cantidad total de habitantes en %s es %d\n", pais, totalHabitantes);
  } else {
    printf("No hay objetivos previstos en %s", pais);
  }

}

Objetivo crearObjetivo(const char* pais, const char* ciudad, int cantHab, int importancia) {
  Objetivo o;
  o.pais = strdup(pais);
  o.ciudad = strdup(ciudad);
  o.cantidadHabitantes = cantHab;
  o.importancia = importancia;
  return o;
}

void imprimirLista(Nodo* inicio) {
  if (inicio == NULL) {
    printf("Lista vacía.\n");
    return;
  }

  Nodo* temp = inicio;
  do {
    printf("Pais: %s | Ciudad: %s | Habitantes: %d | Importancia: %d\n",
           temp->dato.pais,
           temp->dato.ciudad,
           temp->dato.cantidadHabitantes,
           temp->dato.importancia);
    temp = temp->sig;
  } while (temp != inicio);
}

void liberarLista(Nodo* inicio) {
  if (inicio == NULL) return;

  Nodo* temp = inicio->sig;
  while (temp != inicio) {
    Nodo* a_borrar = temp;
    temp = temp->sig;
    free(a_borrar->dato.pais);
    free(a_borrar->dato.ciudad);
    free(a_borrar);
  }
  free(inicio->dato.pais);
  free(inicio->dato.ciudad);
  free(inicio);
}


int main () {

  Nodo *lista = NULL;

  lista = agregaObjetivo(lista, crearObjetivo("Argentina", "Buenos Aires", 0, 1));
  lista = agregaObjetivo(lista, crearObjetivo("Argentina", "Rosario", 0, 1));
  lista = agregaObjetivo(lista, crearObjetivo("Brasil", "Rio de Janeiro", 2000000, 3));
  lista = agregaObjetivo(lista, crearObjetivo("Chile", "Santiago", 1000000, 3));

  imprimirLista(lista);

  muestraCantidadHabitantesPorPais(lista, "Argentina");

  liberarLista(lista);

  return 0;
}