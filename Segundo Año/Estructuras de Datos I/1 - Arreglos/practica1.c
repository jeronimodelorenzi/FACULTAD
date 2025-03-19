#include <stdio.h>
#include <stdlib.h>

// Ejercico 1

/*void cargar_array (float* arreglo, int longitud) {
  for (int i = 0 ; i < longitud ; i++) {
    printf("Ingrese un valor para la posicion %d: ",i);
    scanf("%f", arreglo+i); 
  }
}

void copiar_array (float* arreglo1, float* arreglo2, int longitud) {
    for (int i = 0 ; i < longitud ; i++) {
        *(arreglo2 + i) = *(arreglo1 + i);
    }
}

void bubble_sort (float arreglo[], int longitud) {
  for (int iter = 0 ; iter < longitud - 1 ; iter++) {
    for (int i = 0 ; i < longitud - iter - 1; i++) {
      if (arreglo[i] > arreglo[i + 1]) {
        float aux = arreglo[i];
        arreglo[i] = arreglo[i + 1];
        arreglo[i + 1] = aux;
      }
    }
  }
}

float mediana (float* arreglo, int longitud) {
  float med = 0.0;
  float* arrCop = malloc(sizeof(float) * longitud);
  
  if (arrCop == NULL) {
    perror("Error");
    return 1;
  }

  copiar_array(arreglo, arrCop, longitud);
  bubble_sort(arrCop, longitud);

  if (longitud % 2 == 1) {
    med = *(arrCop + (longitud / 2));
  } else {
    float prom = (*(arrCop + (longitud / 2)) + *(arrCop + ((longitud / 2) - 1))) / 2;
    med = prom;
  }

  free(arrCop);

  return med;
}

int main () {

  int longitud;
  printf("Ingrese la cantidad de elementos del arreglo: ");
  scanf("%d",&longitud);

  float arreglo[longitud];
  cargar_array(arreglo,longitud);

  float med = mediana(arreglo, longitud);

  printf("La mediana del arreglo ingresado es %.2f\n", med);

  return 0;
}*/

// Ejercicio 2

int string_len (char *str) {
  int contador = 0;
  while (*(str + contador) != '\0'){
    contador++;
  }

  return contador;
}

void string_reversa (char* str) {
  int length = string_len(str);
  for (int i = 0 ; i < length / 2; i++) {
    char temp = *(str+i);
    *(str + i) = *(str + (length-1) - i);
    *(str + (length-1) - i) = temp;
  }
}

int main () {
  char string[] = "hola";
  printf("Cantidad de elementos: %d\n", string_len(string));
  string_reversa(string);
  printf("String reversa: %s\n",string);
  return 0;
}