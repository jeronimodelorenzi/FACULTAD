#ifndef __ALGORITMOS_H__
#define __ALGORITMOS_H__

/**
 * Algoritmo de búsqueda binaria.
 * Retorna el índice donde se encuentra el valor, 
 * o -1 si no aparece en el array.
 */
int binsearch(int* arreglo, int length, int valor);

/**
 * Algoritmo de ordenamiento: Insertion Sort.
 */
void insertion_sort(int *arreglo, int length);

/**
 * Algoritmo de ordenamiento: Merge Sort.
 */
int* merge_sort(int *arreglo, int length);

/**
 * Algoritmo de ordenamiento: Quick Sort.
 */
void quick_sort(int *arreglo, int length);



#endif