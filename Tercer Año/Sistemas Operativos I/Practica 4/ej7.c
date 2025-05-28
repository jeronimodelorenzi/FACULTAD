/*
Siguiendo la misma idea del ejercicio anterior, implemente un mergesort (sobre
enteros) paralelo y compare su performance con la versi´on secuencial. Puede usar tasks, o escribir una
versi´on bottom-up usando solamente parallel for. Su soluci´on deber´ıa manejar arreglos de 500 millones
de enteros sin problema, y ser lo m´as eficiente posible.
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