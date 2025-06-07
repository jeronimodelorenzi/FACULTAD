#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char *nombre, *club;
  int posicionJugador, edad;
} _Jugador;

typedef _Jugador* Jugador;

typedef struct nodo {
  Jugador jug;
  struct nodo *izquierda, *derecha;
} Nodo;

Jugador crearJugador (char *nombre, char *club, int posicion, int edad) {
  Jugador j = malloc(sizeof(_Jugador));
  j->nombre = strdup(nombre);
  j->club = strdup(club);
  j->posicionJugador = posicion;
  j->edad = edad;
  return j;
}

Nodo* agregaJugador (Nodo* inicio, Jugador j){
  if (inicio == NULL) {
    Nodo *nuevoNodo = malloc(sizeof(Nodo));
    nuevoNodo->jug = j;
    nuevoNodo->derecha = NULL;
    nuevoNodo->izquierda = NULL;
    return nuevoNodo;
  }

  if (j->posicionJugador < inicio->jug->posicionJugador)
    inicio->izquierda = agregaJugador(inicio->izquierda, j);
  else
    inicio->derecha = agregaJugador(inicio->derecha, j);

  return inicio;
}

Nodo* recuperaJugadoresPorPosicion (Nodo* inicio, int posicionMax, int posicionMin) {
  if (inicio == NULL || posicionMax < posicionMin)
    return NULL;

  if (inicio->jug->posicionJugador > posicionMax)
    return recuperaJugadoresPorPosicion(inicio->izquierda, posicionMax, posicionMin);
  if (inicio->jug->posicionJugador < posicionMin)
    return recuperaJugadoresPorPosicion(inicio->derecha, posicionMax, posicionMin);
  
  Nodo* nuevoNodo = malloc(sizeof(Nodo));
  Jugador copia = crearJugador(inicio->jug->nombre, inicio->jug->club, inicio->jug->posicionJugador, inicio->jug->edad);
  
  nuevoNodo->jug = copia;
  nuevoNodo->derecha = recuperaJugadoresPorPosicion(inicio->derecha, posicionMax, posicionMin);
  nuevoNodo->izquierda = recuperaJugadoresPorPosicion(inicio->izquierda, posicionMax, posicionMin);

  return nuevoNodo;
}

void mostrarJugador (Jugador j) {
  printf("Nombre: %s | Club: %s | Posición: %d | Edad: %d\n", j->nombre, j->club, j->posicionJugador, j->edad);
}

void mostrarArbol (Nodo* raiz) {
 if (raiz == NULL) return;
 mostrarJugador(raiz->jug);
 mostrarArbol(raiz->izquierda);
 mostrarArbol(raiz->derecha);
}

void destruirJugador (Jugador j) {
  if (j == NULL) return;
  free(j->nombre);
  free(j->club);
  free(j);
}

void destruirArbol (Nodo *raiz) {
  if (raiz == NULL) return;

  destruirArbol(raiz->izquierda);
  destruirArbol(raiz->derecha);
  destruirJugador(raiz->jug);
  free(raiz);
}

int main () {
  Nodo* raiz = NULL;

  Nodo *res = recuperaJugadoresPorPosicion(NULL, 5, 3);
  if (res == NULL) printf("Prueba 1 -> OK\n");

  res = recuperaJugadoresPorPosicion(raiz, 3, 5);
  if (res == NULL) printf("Prueba 2 -> OK\n");

  raiz = agregaJugador(raiz, crearJugador("Ignacio Malcorra", "Rosario Central", 10, 37));
  raiz = agregaJugador(raiz, crearJugador("Emiliano Martinez", "Aston Villa", 1, 30));
  raiz = agregaJugador(raiz, crearJugador("Lautaro Martinez", "Inter de Milan", 9, 26));
  raiz = agregaJugador(raiz, crearJugador("Angel Di Maria", "Rosario Central", 11, 37));
  raiz = agregaJugador(raiz, crearJugador("Cristian Romero", "Tottenham", 2, 24));
  raiz = agregaJugador(raiz, crearJugador("Giovani Lo Celso", "Real Betis", 7, 29));

  printf("Arbol completo\n");
  mostrarArbol(raiz);

  res = recuperaJugadoresPorPosicion(raiz, 10,7);

  printf("Arbol filtrado\n");
  mostrarArbol(res);

  destruirArbol(raiz);
  destruirArbol(res);

  return 0;
}