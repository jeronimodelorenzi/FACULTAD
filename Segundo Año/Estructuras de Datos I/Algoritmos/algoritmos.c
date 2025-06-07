#include "algoritmos.h"
#include <stdlib.h>

static void swap (int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}

/*
BÚSQUEDA BINARIA.
*/
int binsearch (int a[], int len, int v) {
  int inicio = 0, final = len-1, posicion = -1, medio;
  while (inicio <= final && posicion == -1) {
    medio = (inicio + final) / 2;

    if (v == a[medio]) posicion = medio;
    else if (v > a[medio]) inicio = medio+1;
    else final = medio-1;
  }
  return posicion;
}

int binsearch_rec (int a[], int inicio, int final, int v) {
  if (inicio <= final) {
    int medio = (inicio + final) / 2;

    if (a[medio] == v) return medio;
    if (a[medio > v]) return binsearch_rec(a, medio+1, final, v);
    if (a[medio] < v) return binsearch_rec(a, inicio, medio-1, v);
  }
  return -1;
}

/*
BUBBLE SORT
*/
void bubble_sort (int a[], int len) {
  int bandera = 1;
  while (bandera) {
    bandera = 0;
    for (int i = 0 ; i < len-1 ; i++) {
      if (a[i] > a[i+1]) {
        swap(a[i], a[i+1]);
        bandera = 1;
      }
    }
  }
}

/*
SELECTION SORT
*/
void selection_sort (int a[], int len) {
  for (int i = 0 ; i < len - 2 ; i++) {
    int minPos = i;
    for (int j = i+1 ; i < len - 1 ; j++) 
      if (a[j] < a[minPos])
        minPos = j;
    swap(a[i], a[minPos]);
  }
}

/*
INSERTION SORT.
*/
void insertion_sort (int a[], int len) {
  for (int i =  1 ; i < len ; i++) {
    int valor = a[i];
    int j = i - 1;

    for ( ; j>= 0 && a[j] > valor; j--) 
      a[j+1] = a[j];

    a[j+1] = valor;
  }
}

/*
MERGE SORT.
*/
int* merge (int a[], int len_a, int b[], int len_b) {
  int *resultado = malloc(sizeof(int) * (len_a + len_b));
  int i = 0, j = 0, k = 0;

  for (; i < len_a && j < len_b; k++) {
    if (a[i] <= b[j]) {
      resultado[k] = a[i];
      i++;
    } else {
      resultado[k] = b[j];
      j++;
    }
  }

  // Si faltan meter elementos de a.
  for (; i < len_a ; k++, i++)
    resultado[k] = a[i];

  // Si faltan meter elementos de b.
  for (; j < len_b ; k++, j++)
    resultado[k] = b[j];

  return resultado;
}

int* merge_sort (int a[], int len) {
  if (len < 2) {
    int *copia = malloc(sizeof(int));
    copia[0] = a[0];
    return copia;
  }

  int medio = len / 2;

  int* a1 = a;
  int* a2 = a + medio;

  int* b1 = merge_sort(a1, medio);
  int* b2 = merge_sort(a2, len - medio);

  int *resultado = merge(b1, medio, b2, len - medio);

  free(b1);
  free(b2);
  
  return resultado;
}

/*
QUICK SORT
*/

int particion_de_lomuto (int a[], int len, int pvt) {
  int j = 0;

  for (int i = 0; i < len ; i++)
    if (a[i] <= pvt) {
      swap(a[i], a[j]);
      j++;
    }

  return j;
}

void quick_sort (int a[], int len) {
  if (len < 2) return;

  int pvt = a[0];

  int n_izq = particion_de_lomuto(a + 1, len-1, pvt);
  
  swap(a[0], a[n_izq]);

  quick_sort(a, n_izq);
  quick_sort(a+n_izq+1, len-n_izq-1);
}