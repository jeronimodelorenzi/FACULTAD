#include "matriz.h"
#include <stdio.h>
#include <stdlib.h>

/*
** Implementacion utilizando un arreglo bidimensional (arreglo de punteros a arreglo)
*/

struct Matriz_ {
  double** datos;
  size_t filas;
  size_t columnas;
};


Matriz* matriz_crear(size_t numFilas, size_t numColumnas) {
  if (numFilas == 0 || numColumnas == 0) {
    perror("ERROR. Tamaños invalido.\n");
    return NULL;
  }

  Matriz* matriz = malloc(sizeof(Matriz));
  if (matriz == NULL){
    perror("ERROR. Problemas al generar matriz.\n");
    return NULL;
  }

  matriz->filas = numFilas;
  matriz->columnas = numColumnas;

  matriz->datos = malloc(sizeof(double*)*numFilas);
  if (matriz->datos == NULL) {
    perror("ERROR. Problemas al generar filas.\n");
    return NULL;
  }

  for (size_t i = 0 ; i < numFilas ; i++) {
    *(matriz->datos + i) = malloc(sizeof(double)*numColumnas);
    // matriz->datos[i]
    if (*(matriz->datos + i) == NULL) {
      perror("ERROR. Problemas al generar columnas.\n");
    }

    for (size_t j = 0 ; j < numColumnas ; j++) {
      *(*(matriz->datos + i) + j ) = 0;
      // matriz->datos[i][j]
    }
  }

  return matriz;
}

void matriz_destruir(Matriz* matriz) {
  for (size_t i = 0 ; i < matriz->filas ; i++) {
    free(*(matriz->datos + i));
        // matriz->datos[i]
  }
  free(matriz->datos);
  free(matriz);
}

double matriz_leer(Matriz* matriz, size_t fil, size_t col) {

  if (fil >= matriz->filas || col >= matriz->columnas) {
    perror("ERROR. Numero de fila o columna incorrecto.\n");
    return 0.0;
  }

  return *(*(matriz->datos + fil) + col);
          // matriz->datos[fil][col]
}

void matriz_escribir(Matriz* matriz, size_t fil, size_t col, double val) {

  if (fil >= matriz->filas || col >= matriz->columnas) {
    perror("ERROR. Numero de fila o columna incorrecto.\n");
    return;
  }

  *(*(matriz->datos + fil) + col) = val;
   // matriz->datos[fil][col]
}

size_t matriz_num_filas(Matriz* matriz) {
  return matriz->filas;
}

size_t matriz_num_columnas(Matriz* matriz) {
  return matriz->columnas;
}

void matriz_intercambiar_filas(Matriz* matriz, size_t fil1, size_t fil2) {
  size_t columnas = matriz_num_columnas(matriz);
  size_t filas = matriz_num_filas(matriz);

  if (fil1 >= filas || fil2 >= filas) {
    perror("ERROR. Numero de fila1 o fila2 incorrecto.\n");
    return;
  }

  double* temp = *(matriz->datos + fil1);
                // matriz->datos[fil1]
  *(matriz->datos + fil1) = *(matriz->datos + fil2); 
 // matriz->datos[fil1]       matriz->datos[fil2]
  *(matriz->datos + fil2) = temp;
 // matriz->datos[fil2]
}

void matriz_insertar_filas(Matriz* matriz, size_t pos) {
  size_t filas = matriz_num_filas(matriz) + 1;
  size_t columnas = matriz_num_columnas(matriz);

  if (pos > filas - 1) {
    perror("ERROR. Posicion incorrecta.\n");
    return;
  }

  matriz->datos = realloc(matriz->datos, sizeof(double*) * filas);
  if (matriz->datos == NULL) {
    perror("ERROR. Problemas al realocar tamaño.\n");
    return;
  }
  *(matriz->datos + filas - 1) = malloc(sizeof(double)* columnas);
 // matriz->datos[i]
  if (*(matriz->datos + pos) == NULL) {
    perror("ERROR. Problemas al generar columna.\n");
    return;
  }

  for (size_t i = filas - 1 ; i > pos ; i--) {
    *(matriz->datos + i) = *(matriz->datos + i - 1);
  }
  
  for (size_t j = 0; j < columnas; j++) {
    *(*(matriz->datos + (filas - 1) + j)) = 0.0;
  }

} //MAL

int main () {
  size_t filas = 3 , columnas = 3;
  Matriz* matriz = matriz_crear(filas, columnas);

  printf("Creando matriz.\n");
  for (size_t i = 0 ; i < filas ; i++) {
    for (size_t j = 0 ; j < columnas ; j++) {
      matriz_escribir(matriz, i, j, (j+1)*(i+1));
    }
  }

  printf("Mostrar matriz.\n");
  for (size_t i = 0 ; i < filas ; i++) {
    for (size_t j = 0 ; j < columnas ; j++) {
      printf("%0.2f ", matriz_leer(matriz, i, j));
    }
    printf("\n");
  }

  printf("Intercambiamos fila 2 por la 3.\n");
  matriz_intercambiar_filas(matriz,1,2);

  printf("Valores matriz filas intercambiadas: \n");
  for (size_t i = 0 ; i < filas ; i++) {
    for (size_t j = 0 ; j < columnas ; j++) {
      printf("%.2f ", matriz_leer(matriz, i, j));
    }
    printf("\n");
  }

  // matriz_insertar_filas(matriz,2);
  // printf("Insertamos fila en la posicion 2.\n");
  // for (size_t i = 0 ; i < filas + 1 ; i++) {
  //   for (size_t j = 0 ; j < columnas ; j++) {
  //     printf("%.2f ", matriz_leer(matriz, i, j));
  //   }
  //   printf("\n");
  // }

  matriz_destruir(matriz);

  return 0;
}
