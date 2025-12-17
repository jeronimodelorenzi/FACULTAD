#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "algoritmos.h"


int binsearch (int arr[], int len, int valor) {
  int inicio = 0, final = len -1, pos = -1, medio;
  while (inicio <= final && pos == -1) {
    medio = (inicio + final) / 2;

    if (arr[medio] == valor) pos = medio;
    else if (valor > arr[medio]) inicio = medio+1;
    else final = medio-1;
  }
  return pos;
}

static void swap (int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}

void bubble_sort (int a[], int len) {
  int bandera = 1;
  while (bandera) {
    bandera = 0;
    for (int i = 0 ; i < len-1 ; i++) {
      if (a[i] > a[i+1]) {
        swap(&a[i], &a[i+1]);
        bandera = 1;
      }
    }
  }
}

void selection_sort (int a[], int len) {
  for (int i = 0 ; i < len -1 ; i++) {
    int minPos = i;
    for (int j = i+1 ; j < len ; j++)
      if (a[j] < a[minPos])
        minPos = j;
    swap(&a[i], &a[minPos]);
  }
}

void selection_Sort (int a[], int len) {
  for (int i = 0 ; i < len -1 ; i++) {
    int minPos = i;
    for (int j = i+1 ; i < len ; j++)
      if (a[j] < a[minPos])
        minPos = j;      
    swap(&a[i], &a[minPos]);
  }
}

void insertion_sort (int a[], int len) {
  for (int i = 1 ; i < len ; i++) {
    int valor = a[i];
    int j = i-1;

    for (; j >= 0 && a[j] > valor ; j--)
      a[j+1] = a[j];

    a[j+1] = valor;
  }
}

void insertion_Sort (int a[], int len) {
  for (int i = 1 ; i < len ; i++) {
    int valor = a[i];
    int j = i-1;
    for (; j >= 0 && a[j] > valor ; j--)
      a[j+1] = a[j];
    a[j+1] = valor;
  }
}

int* merge (int a[], int lenA, int b[], int lenB) {
  int *resultado = malloc(sizeof(int)* (lenA + lenB));
  int i = 0, j = 0, k = 0;

  for (; i < lenA && j < lenB ; k++) {
    if (a[i] <= b[j]) {
      resultado[k] = a[i];
      i++;
    } else {
      resultado[k] = b[j];
      j++;
    }
  }

  for (; i < lenA ; k++, i++)
    resultado[k] = a[i];
  
  for (; j < lenB ; k++, j++)
    resultado[k] = b[j];

  return resultado;
}

int* merge_sort (int a[], int len) {
  if (len < 2) {
    int *copia = malloc(sizeof(int));
    copia[0] = a[0];
    return copia;
  }

  int medio = len/2;

  int *a1 = a;
  int *a2 = a + medio;

  int *b1 = merge_sort(a1, medio);
  int *b2 = merge_sort(a2, len - medio);

  int *resultado = merge(b1, medio, b2 , len-medio);

  free(b1);
  free(b2);

  return resultado;
}

int particion_de_lomuto (int a[], int len, int pivot) {
  int j = 0;

  for (int i = 0 ; i < len ; i++)
    if (a[i] < pivot) {
      swap(&a[i], &a[j]);
      j++;
    }

  return j;
}

void quick_sort (int a[], int len) {
  if (len < 2) return;

  int pivot = a[0];

  int nIzq = particion_de_lomuto (a+1, len-1, pivot);

  swap(&a[0], &a[nIzq]);

  quick_sort(a, nIzq);
  quick_sort(a+nIzq+1, len-nIzq-1);
}

// --- 2. MAIN DE PRUEBAS ---

void imprimir_array(int a[], int len, const char *nombre) {
    printf("[%s]: ", nombre);
    for (int i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

// Función para clonar un array y tener datos frescos en cada test
int* clonar_array(int origen[], int len) {
    int *copia = malloc(sizeof(int) * len);
    if (copia == NULL) exit(1);
    // Copia memoria raw de un lugar a otro
    memcpy(copia, origen, sizeof(int) * len);
    return copia;
}

int main() {
    // Datos originales desordenados
    int datos_base[] = { 64, 34, 25, 12, 22, 11, 90, -5, 0 };
    int n = sizeof(datos_base) / sizeof(datos_base[0]);
    int *buffer = NULL;

    printf("=== INICIO DE TEST DE ORDENAMIENTO ===\n");
    imprimir_array(datos_base, n, "Original");
    printf("--------------------------------------\n");

    // 1. TEST BUBBLE SORT
    buffer = clonar_array(datos_base, n);
    bubble_sort(buffer, n);
    imprimir_array(buffer, n, "Bubble Sort");
    free(buffer); // Liberamos para Valgrind

    // 2. TEST SELECTION SORT
    buffer = clonar_array(datos_base, n);
    selection_sort(buffer, n);
    imprimir_array(buffer, n, "Selection Sort");
    free(buffer);

    // 3. TEST INSERTION SORT
    buffer = clonar_array(datos_base, n);
    insertion_sort(buffer, n);
    imprimir_array(buffer, n, "Insertion Sort");
    free(buffer);

    // 4. TEST QUICK SORT
    buffer = clonar_array(datos_base, n);
    quick_sort(buffer, n);
    imprimir_array(buffer, n, "Quick Sort");
    free(buffer);

    // 5. TEST MERGE SORT (Caso Especial)
    // Merge sort no ordena in-place, devuelve un puntero nuevo.
    // Le pasamos los datos base, pero no necesitamos clonar antes 
    // porque tu implementación interna de merge_sort ya hace copias (malloc).
    // PERO: Como tu primera llamada a merge_sort recibe un array y lo trata como const,
    // podemos pasarle el array base.
    
    int *resultado_merge = merge_sort(datos_base, n);
    imprimir_array(resultado_merge, n, "Merge Sort");
    free(resultado_merge); // ¡Muy importante liberar el resultado final!

    printf("--------------------------------------\n");
    printf("=== FIN DE TEST ===\n");

    return 0;
}