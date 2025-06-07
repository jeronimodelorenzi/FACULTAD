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
  if (inicio == NULL || posicionMax < posicionMin) {
    return NULL;
  }
  Nodo *arbol = malloc(sizeof(Nodo));

  if (inicio->jug->posicionJugador > posicionMax)
    recuperaJugadoresPorPosicion(inicio->izquierda, posicionMax, posicionMin);
  else if (inicio->jug->posicionJugador < posicionMin)
    recuperaJugadoresPorPosicion(inicio->izquierda, posicionMax, posicionMin);
  else {
    arbol = inicio;
    arbol->izquierda = recuperaJugadoresPorPosicion(arbol->izquierda, posicionMax, posicionMin);
    arbol->derecha = recuperaJugadoresPorPosicion(arbol->derecha, posicionMax, posicionMin);
  }

  return arbol;
}

// void recuperaJugadoresPorPosicion_aux (Nodo* act, Nodo** res, int max, int min) {
//   if (act == NULL) return;

//   if (act->jug->posicionJugador > min)
//     recuperaJugadoresPorPosicion_aux(act->izquierda, res, max, min);

//   if (act->jug->posicionJugador >= min && act->jug->posicionJugador <= max) {
//     *res = agregaJugador(*res, crearJugador(act->jug->nombre, act->jug->club, act->jug->posicionJugador, act->jug->edad));
//   }

//   if (act->jug->posicionJugador < max)
//     recuperaJugadoresPorPosicion_aux(act->derecha, res, max, min);
// }

// Nodo* recuperaJugadoresPorPosicion (Nodo* inicio, int posicionMax, int posicionMin) {
//   if (inicio == NULL || posicionMax < posicionMin) return NULL;

//   Nodo* res = NULL;

//   recuperaJugadoresPorPosicion_aux(inicio, &res, posicionMax, posicionMin);
//   return res;
// }

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