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

/*int string_len (char *str) {
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
  
  int len1 = string_len(str1);
  int len2 = string_len(str2);
  
  int condicion = -1;
  
  int i = 0 , j = 0;

  for(; i <= len1 - len2 && condicion == -1 ; i++) {
    for (; j < len2 && *(str1 + i + j) == *(str2 + j) ; j++);
    if (j == len2) {
      condicion = i;
    }
  }
    
  return condicion;
}
  


void string_unir(char* arregloStrings[], int n, char* sep, char* res) {

  int pos = 0; int op = 0;

  for(int i = 0; i < n ; i++) {
    for(int j = 0 ; *(arregloStrings[i] + j) != '\0'; j++) {
      *(res + pos) = *(arregloStrings[i]+j);
      pos++;
      op++;
    }

    
    for(int k = 0 ; *(sep + k) != '\0' ; k++) {
      *(res + pos) = *(sep + k);
      pos++;
      op++;
    }

  }

  *(res + pos) = '\0';
  printf("%d\n",op);

}

int main () {

  //char string[] = "hola";
  //char string2[] = "ol";
  
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

  //int subcadena = string_subcadena(string,string2);
  //printf("Ocurrencia: %d",subcadena);

  char* arreglosString[] = {"Hola", "Hello", "Ciao"};
  char* sep = ", ";
  int n = 3;
  char res[500];

  string_unir(arreglosString,n,sep,res);
  printf("%s\n",res);

  return 0;
}*/

// Ejercicio 3

typedef struct {
  int* direccion;
  int capacidad;
} ArregloEnteros;

ArregloEnteros* arreglo_enteros_crear (int capacidad) {
  ArregloEnteros* ptr = malloc(sizeof(ArregloEnteros));

  ptr->direccion = malloc(sizeof(int) * capacidad);

  ptr->capacidad = capacidad;

  return ptr;
}

void arreglo_enteros_destruir (ArregloEnteros* arreglo) {
  free(arreglo->direccion);
  free(arreglo);
}

int arreglo_enteros_leer (ArregloEnteros* arreglo, int pos) {
  if(pos < 0 || pos > arreglo->capacidad){
    perror("ERROR");
  }
  return *(arreglo->direccion + pos);
}

void arreglo_enteros_escribir (ArregloEnteros* arreglo, int pos, int dato) {
  if(pos < 0 || pos > arreglo->capacidad){
    perror("ERROR");
  }
  *(arreglo->direccion + pos) = dato;
}

int arreglo_enteros_capacidad (ArregloEnteros* arreglo) {
  return arreglo->capacidad;
}

void arreglo_enteros_imprimir (ArregloEnteros* arreglo) {
  for (int i = 0 ; i < arreglo->capacidad ; i++) {
    printf("%d ", *(arreglo->direccion + i));
  }
  printf("\n");
}

void arreglo_enteros_ajustar (ArregloEnteros* arreglo, int capacidad) {  
  arreglo->direccion = realloc(arreglo->direccion,sizeof(int)*capacidad);
  arreglo->capacidad = capacidad;
}

void arreglo_enteros_insertar(ArregloEnteros* arreglo, int pos, int dato) {
  
  if (pos > arreglo->capacidad || pos < 0) {
    perror("Error");
  }
  
  int capacidad = arreglo_enteros_capacidad(arreglo);
  arreglo_enteros_ajustar(arreglo,capacidad+1);

  for(int i = arreglo->capacidad - 1 ; i >= pos;i--) {
    *(arreglo->direccion + i) = *(arreglo->direccion+i-1);
    arreglo_enteros_imprimir(arreglo);
  }

  *(arreglo->direccion + pos) = dato;
}

void arreglo_enteros_eliminar (ArregloEnteros* arreglo, int pos) {
  if (pos > arreglo->capacidad || pos < 0) {
    perror("Error");
  }

  // int capacidad = arreglo_enteros_capacidad(arreglo);
  // arreglo_enteros_ajustar(arreglo,capacidad-1);

  for(int i = pos; i < arreglo->capacidad ; i++) {
    *(arreglo->direccion + i) = *(arreglo->direccion+i+1);
    arreglo_enteros_imprimir(arreglo);
  }
  
  int capacidad = arreglo_enteros_capacidad(arreglo);
  arreglo_enteros_ajustar(arreglo,capacidad-1);
  
}

int main () {

  ArregloEnteros* arr = arreglo_enteros_crear(6);
  for(int i = 0; i < arr->capacidad ; i++) {
    arreglo_enteros_escribir(arr, i, i+1);
  }

  printf("Arreglo completo:\n");
  arreglo_enteros_imprimir(arr);
  
  for(int i = 0 ; i < arr->capacidad ; i++) {
    printf("Posicion %d del arreglo: %d\n", i+1, *(arr->direccion+i));
  }

  printf("Agregamos 55 en la pos 2\n");
  arreglo_enteros_insertar(arr,1,55);
  
  arreglo_enteros_imprimir(arr);
  
  printf("Eliminamos 55 en la pos 2\n");
  arreglo_enteros_eliminar(arr,1);

  arreglo_enteros_imprimir(arr);

  arreglo_enteros_destruir(arr);

  return 0;
}
