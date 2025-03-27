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

int string_concat (char* str1, char* str2, int max) {
  int lenStr1 = string_len(str1);
  int cont = 0;

  for (cont ; cont < max && *(str2+cont) != '\0' ; cont++) {
    *(str1 + lenStr1 + cont) = *(str2 + cont);
  }

  *(str1 + lenStr1 + cont) = '\0';

  return cont;

}

int string_compare (char* str1, char* str2) {
  
  int length1 = string_len(str1);
  int length2 = string_len(str2);
  int comparacion = 0;

  for (int i = 0; i < length1 && i < length2 ; i++) {
    if (*(str1+i) < *(str2+i)) {
      comparacion = -1;
    } else if (*(str1 + i) > *(str2 + i)) {
      comparacion = 1;
    }
  }

  if (comparacion == 0) {
    if (length1 < length2) {
      return comparacion = -1;
    } else if (length1 > length2) {
      return comparacion = 1;
    }
  }

  return comparacion;
}

int string_subcadena (char* str1, char* str2) {
  
  int i = 0, j = 1;
  int condicion = 1;

  for (; *(str1 + i) != '\0' ; i++) {
    if (*(str1 + i) ==  *(str2)) {
      for(; *(str2 + j) != '\0' && condicion  ; j++) {
        if(*(str1+i+j) != *(str2+j)) {
          condicion = -1;
        }
      }
    }
  }

  if (condicion) {
    return i;
  } else {
    return condicion;
  }
  
}

int main () {
  char string[] = "acaqwdqwb";
  char string2[] = "ca";
  // int max = 2;
  // printf("Cantidad de elementos: %d\n", string_len(string));
  
  // string_reversa(string);
  // printf("String reversa: %s\n",string);
  
  // int concatenados = string_concat(string,string2,max);
  // printf("Cadena concatenada: %s\n", string);
  // printf("Caracteres concatenados: %d\n",concatenados);
  
  // int comparacion = string_compare(string,string2);
  // if (comparacion == -1){
  //   printf("%s < %s\n", string, string2);
  // } else if (comparacion == 1) {
  //   printf("%s > %s\n", string, string2);
  // } else {
  //   printf("%s = %s\n", string, string2);
  // }

  int subcadena = string_subcadena(string,string2);
  printf("Ocurrencia: %d",subcadena);
  return 0;
}