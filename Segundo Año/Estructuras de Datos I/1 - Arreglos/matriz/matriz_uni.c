#include "matriz.h"
#include <stdio.h>
#include <stdlib.h>

/*
** Implmentacion utilizando un unico arreglo unidimensional
*/

struct Matriz_ {
  double* dato;
  size_t fila;
  size_t columna;
};


Matriz* matriz_crear(size_t numFilas, size_t numColumnas) {
  if (numFilas < 0 || numColumnas < 0) {
    perror("ERROR.a");
  }

  Matriz* matriz = malloc(sizeof(Matriz));
  if (matriz == NULL) {
    perror("ERROR.b\n");
    return NULL;
  }

  matriz->fila = numFilas;
  matriz->columna = numColumnas;

  matriz->dato = malloc(sizeof(double)* numFilas * numColumnas);
  if (matriz->dato == NULL){
    perror("ERROR.c\n");
    free(matriz);
    return NULL;
  }

  for (size_t i = 0 ; i < numFilas * numColumnas; i++) {
    *(matriz->dato + i) = 0.0;
  }

  // o se puede tambien hacer un calloc (numFilas * numColumnas, sizeof(float));

  return matriz;
}

void matriz_destruir(Matriz* matriz) {
  free(matriz->dato);
  free(matriz);
}

double matriz_leer(Matriz* matriz, size_t fil, size_t col) {
  if (fil >= matriz->fila || col >= matriz->columna) {
    perror("ERROR.d");
    return 0.0;
  }

  return *(matriz->dato + fil * matriz->columna + col);
}

void matriz_escribir(Matriz* matriz, size_t fil, size_t col, double val) {

  if (fil >= matriz->fila || col >= matriz->columna ) {
    perror("ERROR.e");
  }

  *(matriz->dato + (fil * matriz->columna) + col) = val;

}

size_t matriz_num_filas(Matriz* matriz) {
  return matriz->fila;
}

size_t matriz_num_columnas(Matriz* matriz) {
  return matriz->columna;
}

void matriz_intercambiar_filas(Matriz* matriz, size_t fil1, size_t fil2) {
  size_t columnas = matriz_num_columnas(matriz);
  size_t filas = matriz_num_filas(matriz);

  if (fil1 >= filas || fil2 >= filas) {
    perror("ERROR.f");
    return;
  }

  for (size_t j = 0 ; j < columnas ; j++) {
    double temp = matriz_leer(matriz,fil1,j);
    matriz_escribir(matriz, fil1, j, matriz_leer(matriz,fil2,j));
    matriz_escribir(matriz,fil2,j,temp);
  }
}

void matriz_insertar_filas(Matriz* matriz, size_t pos) {
  size_t filas = matriz_num_filas(matriz) + 1;
  size_t columnas = matriz_num_columnas(matriz);

  if(pos > filas-1){
    perror("ERROR.g\n");
    return;
  }

  matriz->dato = realloc(matriz->dato, sizeof(double)*filas*columnas);
  if (matriz->dato == NULL) {
    printf("ERROR.h\n");
    return;
}
  
  for (size_t i = filas * columnas - 1; i >= (pos + 1) * columnas; i--) {
    *(matriz->dato + i) = *(matriz->dato + i - columnas);
  }
  
  for(size_t j = 0 ; j < columnas ; j++) {
    matriz_escribir(matriz, pos, j, 0.0);
  }

  matriz->fila = filas;
}

int main () {
  size_t fila = 3; size_t columna = 3;
  Matriz* matriz = matriz_crear(fila, columna);

  printf("Creando matriz.\n");
  for (size_t i = 0 ; i < fila ;i++) {
    for (size_t j = 0 ; j < columna ; j++) {
      matriz_escribir(matriz, i, j, (j+1)*(i+1));
    }
  }

  printf("Valores matriz: \n");
  for (size_t i = 0 ; i < fila ; i++) {
    for (size_t j = 0 ; j < columna ; j++) {
      printf("%.2f ", matriz_leer(matriz, i, j));
    }
    printf("\n");
  }

  printf("Intercambiamos fila 2 por la 3.\n");
  matriz_intercambiar_filas(matriz,1,2);

  printf("Valores matriz filas intercambiadas: \n");
  for (size_t i = 0 ; i < fila ; i++) {
    for (size_t j = 0 ; j < columna ; j++) {
      printf("%.2f ", matriz_leer(matriz, i, j));
    }
    printf("\n");
  }

  matriz_insertar_filas(matriz,2);
  printf("Insertamos fila en la posicion 2.\n");
  for (size_t i = 0 ; i < fila + 1 ; i++) {
    for (size_t j = 0 ; j < columna ; j++) {
      printf("%.2f ", matriz_leer(matriz, i, j));
    }
    printf("\n");
  }

  matriz_destruir(matriz);

  return 0;
}