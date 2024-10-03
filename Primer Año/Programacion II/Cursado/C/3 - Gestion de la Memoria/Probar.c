#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <math.h>

// Ejercicio 1

/*int main(){
    int a = 5;
    char c = 'C';
    char cadena[] = "Hola Mundo!";
    int vector[] = {1,2,3,4,5};


    printf("Valor de a: %d, direccion: %p.\n", a, &a);
    printf("Valor de c: %c, direccion: %p.\n", c, &c);

    for(int i = 0; cadena[i] != '\0' ; i++){
        printf("Valor de %s en la posicion %d: %c,direccion: %p.\n",cadena,i,cadena[i],&cadena[i]);
    }

    for(int i = 0; i < 5 ; i++){
        printf("Valor de la posicion %d: %d ,direccion: %p.\n",i,vector[i],&vector[i]);
    }

    return 0;
}*/

// Ejercicio 2

/*void setzerozero(int arr[]){
    int* ptr = arr;
    *ptr = 0;
}

void cargarDatos(int arr[],int tam){
    for(int i = 0; i < tam; i++){
        printf("Elemento %d -\n",i);
        scanf("%d",&arr[i]);
    }
}

int main(){

    int tam;
    printf("Ingrese el tamaño del arreglo: \n");
    scanf("%d",&tam);

    int arr[tam];

    cargarDatos(arr,tam);

    setzerozero(arr);

    for(int i = 0;i < tam ; i++){
        printf("\nElemento en la posicion %d - %d",i,arr[i]);
    }


    return 0;
}*/

// Ejercicio 3

/*int setin(int* a){
    if(*a != 0){
        *a = 1;
    } else {
        *a = 0;
    }
}

int main(){

    int a;
    printf("Ingrese un numero: ");
    scanf("%d", &a);

    setin(&a);

    printf("%d\n",a);

    return 0;
}*/

// Ejercicio 4

/*void swap(int* a, int* b){
    *a = *b;
    *b = *a;
}

int main(){

    int a, b;
    printf("\nIngrese dos enteros: ");
    scanf("%d%d",&a,&b);
    printf("\nEl valor de a es: %d y el de b es: %d",a,b);

    swap(&a,&b);

    printf("\nEl valor de a es: %d y el de b es: %d",a,b);

    return 0;
}*/

/*typedef struct{
    char* nombre, *direccion, *nacionalidad;
    int edad;
} Persona;

//Prueba

int main(){
    // struct Persona* p1;
    // p1 = malloc(sizeof(struct Persona));
    // p1->nombre = malloc(sizeof(char)* (strlen("Jeronimo")+1));
    // strcpy(p1->nombre,"Jeronimo");

    // char temp[30];
    // printf("Ingrese una direccion: ");
    // scanf("%s", temp);
    // p1->direccion = malloc(sizeof(char)* (strlen(temp)+1));
    // strcpy(p1->direccion, temp);

    // p1->nacionalidad = malloc(sizeof(char)* (strlen("argentino")+1));
    // strcpy(p1->nacionalidad, "argentino");

    // printf("%s %s %s\n", p1->nombre, p1->direccion, p1->nacionalidad);

    // free(p1->nombre);
    // free(p1->direccion);
    // free(p1->nacionalidad);
    // free(p1);
    // return 1;

    Persona p1;
    p1.nombre = malloc(sizeof(char)* (strlen("Jeronimo")+1));
    strcpy(p1.nombre, "Jeronimo");

    char temp[30];
    printf("Ingrese una direccion: ");
    scanf("%s", temp);
    p1.direccion = malloc(sizeof(char)* (strlen(temp)+1));
    strcpy(p1.direccion, temp);

    p1.nacionalidad = malloc(sizeof(char)* (strlen("argentino")+1));
    strcpy(p1.nacionalidad, "argentino");

    printf("%s %s %s\n", p1.nombre, p1.direccion, p1.nacionalidad);

    free(p1.nombre);
    free(p1.direccion);
    free(p1.nacionalidad);

    return 1;
}*/

/*int my_strlen(char* str){
    int i;
    for(i = 0 ;  *(str+i) != '\0' ; i++);
    return i;
}

void my_strcpy(char* strcopy,char* str){
    int i;
    for(i = 0 ; *(str+i) != '\0' ; i++){
        *(strcopy+i) = *(str+i);
    }
    *(strcopy + i) = '\0';
}

int my_strcmp(char* str1,const char* str2){
    int i = 0;
    while (str1[i] == str2[i] && str1[i] != '\0' && str2[i] != '\0'){
        i++;
    }
    return str1[i] - str2[i];
}

char* concat(char* str1,char* str2){
    char* strconcat = malloc(sizeof(char)*(strlen(str1)+strlen(str2)+1));
    int i = 0 , j = 0;
    while(*(str1 + i) != '\0'){
        *(strconcat + i) = *(str1 + i);
        i++;
    }

    while(*(str2 + j) != '\0'){
        *(strconcat + (i+j)) = *(str2 + j);
        j++;
    }

    *(strconcat + (i+j)) = '\0';
    return strconcat;
}

int main(){

    char str[100];
    printf("Ingrese una cadena a copiar: ");
    fgets(str, sizeof(str), stdin);

    for(int i = 0 ; str[i] != '\0' ; i++){
        if(str[i] == '\n'){
            str[i] = '\0';
        }
    }

    char *strcopy;
    strcopy = malloc(sizeof(char)*my_strlen(str)+1);
    my_strcpy(strcopy, str);


    char* strconcat = concat(str, strcopy);

    int length_str = my_strlen(str);
    int length_strcopy = my_strlen(strcopy);


    printf("La cadena ingresada es: %s. Su copia es %s.\n", str, strcopy);
    printf("La longitud de la cadena: %d. Longitud de la cadena copiada: %d.\n",length_str, length_strcopy);
    printf("Direccion de memoria de la cadena: %p. Direccion de memoria de la cadena copiada: %p.\n", &str,&strcopy);
    printf("Las cadena concatenada es: %s. Longitud: %ld.\n", strconcat, strlen(strconcat));

    free(strcopy);
    free(strconcat);
    

    return 0;
}*/

/*int* duplicacion(int* entrada, int* duplicar, int tam){
    for(int i = 0; i < tam ; i++){
        *(duplicar + i) = *(entrada + i);
    }
    return duplicar;
}

void mostrarArray(int* duplicar, int tam){
    for(int i = 0;i<tam;i++){
        printf("%d\n",*(duplicar+i));
    }
}

void cargarDatos(int* arr, int tam){
    for(int i = 0; i<tam;i++){
        printf("Ingrese un numero para la posicion %d: ",i);
        scanf("%d",arr+i);
    }
}

void agregarDatos(int* arr, int tam){
    for(int i = tam; i<tam+10; i++){
        printf("Ingrese un numero para la posicion %d: ",i);
        scanf("%d",arr+i);
    }
}

int main(){

    int* entrada;
    int* duplicar;
    int tam;
    
    printf("Ingrese el tamaño del arreglo: ");
    scanf("%d",&tam);

    entrada = (int *) malloc(sizeof(int)*tam);
    cargarDatos(entrada,tam);


    duplicar = (int *) malloc(sizeof(int)*tam);

    printf("Arreglo ingresado: \n");
    mostrarArray(entrada,tam);

    printf("Arreglo duplicado: \n");
    duplicacion(entrada, duplicar, tam);
    mostrarArray(duplicar,tam);

    duplicar = realloc(duplicar, sizeof(int)*(tam + 10));

    agregarDatos(duplicar,tam);
    tam += 10;

    mostrarArray(duplicar,tam);

    free(entrada);
    free(duplicar);

    return 0;
}*/

/*
// Función para crear un arreglo de cadenas
char** arregloCadenas(int tam) {
    char temp[30];
    char** arr = (char**)malloc(sizeof(char*) * tam);


    getchar();

    for (int i = 0; i < tam; i++) {
        printf("Ingrese un string para la posición %d: ", i);
        fgets(temp, sizeof(temp), stdin);
        
        if (temp[strlen(temp)-1] == '\n') {
            temp[strlen(temp)-1] = '\0';
        }
    

        *(arr+i) = (char*)malloc((strlen(temp) + 1) * sizeof(char));
        

        strcpy(*(arr+i), temp);
    }

    return arr;
}


void mostrarArregloCadenas(char** arr, int tam) {
    for (int i = 0; i < tam; i++) {
        printf("Cadena en la posición %d: %s..... %ld\n", i, arr[i], strlen(arr[i]));
    }
}


void liberarArreglo(char** arr, int tam) {
    for (int i = 0; i < tam; i++) { 
        free(*(arr+i));
    }
    free(arr);
}

int main() {
    int tam;
    printf("Ingrese el tamaño del arreglo: ");
    scanf("%d", &tam);

    char** cadenas = arregloCadenas(tam);

    mostrarArregloCadenas(cadenas, tam);

    liberarArreglo(cadenas, tam);

    return 0;
}*/

// Ejercicio: Manipulación de Cadenas de Caracteres
// Escribe un programa en C que haga lo siguiente:

// Solicite al usuario que ingrese una cadena de caracteres.
// Utilizando punteros, cuente el número de caracteres (excluyendo el carácter nulo \0) en la cadena.
// Reemplace todas las vocales en la cadena con el carácter '-'.
// Imprima la cadena resultante después de las modificaciones.
// Puedes utilizar las funciones estándar de C como strlen() para obtener la longitud de la cadena y printf() para mostrar la cadena resultante.

// Nota: Asegúrate de considerar todos los casos posibles, como cadenas vacías o cadenas sin vocales.

// Este ejercicio te permitirá practicar el uso de punteros para acceder y manipular caracteres en una cadena, así como entender cómo se comportan las funciones de manipulación de cadenas en C.

/*int in(char c, char* str){
    int condicion = 0;
    for(int i = 0; *(str+i) != '\0'; i++){
        if(*(str + i) == c){
            condicion = 1;
        }
    }
    return condicion;
}

void modificarCadena(char* str){
    char vocales[10] = "aeiouAEIOU";
    for(int i = 0; *(str+i) != '\0' ; i++){
        // if(*(str+i) == 'a' || *(str+i) == 'e' || *(str+i) == 'i' || *(str+i) == 'o' || *(str+i) == 'u'){
        //     *(str+i) = '-';
        // }
        if(in(*(str+i),vocales)){
            *(str+i) = '-';
        }

    }
}

void eliminarEspacio(char* str){
    for(int i = 0; *(str + i) != '\0'; i++){
        if(*(str + i) == '\n'){
            *(str + i) = '\0';
        }
    }
}

int main(){

    char str[30];
    printf("Ingrese una cadena: ");
    fgets(str,sizeof(str),stdin);
    //scanf("%[^\n]",str);
    
    eliminarEspacio(str);

    printf("Cadena ingresada: %s.\n" , str);

    modificarCadena(str);

    printf("Cadena modificada: %s.\n", str);

    return 0;
}*/

// Ejercicio: Matriz Cuadrada
// Escribe un programa en C que haga lo siguiente:

// Solicite al usuario que ingrese el tamaño de una matriz cuadrada (número de filas y columnas).
// Permita al usuario ingresar los elementos de la matriz utilizando punteros para acceder a cada posición de la matriz.
// Implementa una función para calcular la suma de los elementos en la diagonal principal de la matriz.
// Imprime la matriz y la suma de los elementos en la diagonal principal.
// Puedes utilizar punteros para acceder a los elementos de la matriz y para calcular la suma de la diagonal principal. 
// Asegúrate de manejar correctamente la memoria y validar las entradas del usuario para evitar desbordamientos de buffer.

/*int** crearMatriz(int tam){
    int** matriz;

    matriz = (int **) malloc(sizeof(int*)*tam);
    if(matriz == NULL){
        printf("ERROR al alocar memoria.\n");
        exit(1);
    }
    

    for(int i = 0; i < tam; i++){
        *(matriz + i) = (int *) malloc(sizeof(int)*tam);
        if(*(matriz+i) == NULL){
            printf("ERROR al alocar memoria.\n");
            exit(1);
        }
    }

    for(int i = 0 ; i < tam ; i++){
        for(int j = 0 ; j < tam ; j++){
            printf("Ingrese un numero para la posicion [%d - %d]: ", i+1, j+1);
            scanf("%d",(*(matriz +i)+j));
        }
    }

    return matriz;
}

void mostrarMatriz(int** matriz, int tam){
    for(int i = 0; i<tam ; i++){
        for(int j = 0; j<tam ; j++){
            printf("Elemento [%d - %d]: %d.\n", i+1, j+1, *(*(matriz +i)+j));
        }
    }
}

int sumaDiagonalMatriz(int** matriz, int tam){
    int suma = 0;
    for(int i = 0; i<tam; i++){
        for(int j = 0; j<tam ; j++){
            if(i == j){
                suma += *(*(matriz + i) +j);
            }
        }
    }
    return suma;
}

void test_sumaDiagonalMatriz(){
    int tam = 3;
    int matriz1[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    int* matrizPtr1[3];
    for(int i = 0; i < tam; i++) {
        matrizPtr1[i] = matriz1[i];
    }
    assert(sumaDiagonalMatriz(matrizPtr1, tam) == 15);

    int matriz2[3][3] = {
        {5, 0, 0},
        {0, 5, 0},
        {0, 0, 5}
    };

    int* matrizPtr2[3];
    for(int i = 0; i < tam; i++) {
        matrizPtr2[i] = matriz2[i];
    }
    assert(sumaDiagonalMatriz(matrizPtr2, tam) == 15);

    int matriz3[3][3] = {
        {10, 2, 3},
        {4, 10, 6},
        {7, 8, 10}
    };

    int* matrizPtr3[3];
    for(int i = 0; i < tam; i++) {
        matrizPtr3[i] = matriz3[i];
    }
    assert(sumaDiagonalMatriz(matrizPtr3, tam) == 30);
}

int main(){

    int tam;
    printf("Ingrese el tamaño de la matriz: ");
    scanf("%d", &tam);

    int** matriz = crearMatriz(tam);
    mostrarMatriz(matriz, tam);

    int suma = sumaDiagonalMatriz(matriz,tam);
    printf("La suma de la diagonal es: %d.\n", suma);

    for(int i = 0; i < tam; i++){
        free(*(matriz + i));
    }

    test_sumaDiagonalMatriz();

    free(matriz);
    
    return 0;
}*/

/*void cargarDatos(int* arr,int tam){
    for(int i = 0; i<tam ; i++){
        printf("Ingrese el elemento %d: ",i);
        scanf("%d",arr+i);
    }
}

void mostrarDatos(int* arr, int tam){
    for(int i = 0; i<tam; i++){
        printf("Elemento %d: %d.\n",i,*(arr+i));
    }
}

void ordenarDatos(int* arr, int tam){
    for(int i = 0; i<tam ; i++){
        for(int j = i+1 ; j<tam ; j++){
            if(*(arr+i) > *(arr+j)){
                int aux = *(arr+i);
                *(arr+i) = *(arr+j);
                *(arr+j) = aux;
            }
        }
    }
}

int main(){
    int tam;
    
    printf("Ingrese el tamaño del arreglo: ");
    scanf("%d", &tam);

    //int arr[tam];
    int* arr = (int*) malloc(sizeof(int)*tam);

    cargarDatos(arr,tam);
    
    printf("Arreglo ingresado: \n");
    mostrarDatos(arr,tam);

    printf("Arreglo ordenado: \n");
    ordenarDatos(arr,tam);
    mostrarDatos(arr,tam);

    free(arr);

    return 0;
}*/

//SIN PUNTEROS

// void cargarDatos(int arr[], int tam);
// void mostrarDatos(int arr[], int tam);
// void duplicarDatos(int arr1[], int arr2[], int tam);

// int main(){

//     int tam;
//     printf("Ingrese el tamaño del arreglo: ");
//     scanf("%d", &tam);

//     int datos[tam], duplicados[tam];

//     cargarDatos(datos, tam);
//     mostrarDatos(datos, tam);

//     duplicarDatos(datos, duplicados, tam);
//     printf("ARREGLO DUPLICADO.\n");
//     mostrarDatos(duplicados, tam);

//     return 0;
// }

// void cargarDatos(int arr[], int tam){
//     for(int i = 0 ; i < tam ; i++){
//         printf("Ingrese valor para la posicion %d - ", i);
//         scanf("%d", &arr[i]);
//     }
// }

// void mostrarDatos(int arr[], int tam){
//     for(int i = 0 ; i < tam ; i++){
//         printf("Elemento en la posicion %d - %d.\n", i , arr[i]);
//     }
// }

// void duplicarDatos(int arr1[], int arr2[], int tam){
//     for(int i = 0 ; i < tam ; i++){
//         arr2[i] = 2*arr1[i];
//     }
// }

//CON PUNTEROS

// void cargarDatos(int* arr, int tam);
// void mostrarDatos(int* arr, int tam);
// void duplicarDatos(int* arr1, int* arr2, int tam);

// int main(){

//     int tam;
//     printf("Ingrese el tamaño del arreglo: ");
//     scanf("%d", &tam);

//     int* datos = malloc(sizeof(int)*tam);
//     int* duplicados = malloc(sizeof(int)*tam);

//     cargarDatos(datos,tam);
//     mostrarDatos(datos,tam);

//     printf("ARREGLO DUPLICADO.\n");
//     duplicarDatos(datos,duplicados,tam);
//     mostrarDatos(duplicados,tam);

//     free(datos);
//     free(duplicados);

//     return 0;
// }

// void cargarDatos(int* arr, int tam){
//     for(int i = 0 ; i < tam ; i++){
//         printf("Ingrese un valor para la posicion %d - ",i);
//         scanf("%d",arr+i);
//     }
// }

// void mostrarDatos(int* arr, int tam){
//     for(int i = 0 ; i < tam ; i++){
//         printf("Elemento %d - %d.\n",i, *(arr+i));
//     }
// }

// void duplicarDatos(int* arr1, int* arr2, int tam){
//     for(int i = 0; i < tam ; i++){
//         *(arr2 + i) = 2 * *(arr1+i);
//     }
// }

//CON PUNTEROS (MODIFICADO)

// int* cargarDatos(int tam);
// void mostrarDatos(int* arr, int tam);
// void duplicarDatos(int* arr1, int* arr2, int tam);

// int main(){

//     int tam;
//     printf("Ingrese el tamaño del arreglo: ");
//     scanf("%d", &tam);

//     int* datos = cargarDatos(tam);
//     int* duplicados = malloc(sizeof(int)*tam);

//     mostrarDatos(datos,tam);

//     printf("ARREGLO DUPLICADO.\n");
//     duplicarDatos(datos,duplicados,tam);
//     mostrarDatos(duplicados,tam);

//     free(datos);
//     free(duplicados);

//     return 0;
// }

// int* cargarDatos(int tam){

//     int* arr = malloc(sizeof(int)*tam);

//     for(int i = 0 ; i < tam ; i++){
//         printf("Ingrese un valor para la posicion %d - ",i);
//         scanf("%d",arr+i);
//     }

//     return arr;
// }

// void mostrarDatos(int* arr, int tam){
//     for(int i = 0 ; i < tam ; i++){
//         printf("Elemento %d - %d.\n",i, *(arr+i));
//     }
// }

// void duplicarDatos(int* arr1, int* arr2, int tam){
//     for(int i = 0; i < tam ; i++){
//         *(arr2 + i) = 2 * *(arr1+i);
//     }
// }

// void sumar(int n1, int n2, int* suma){
//     *(suma) = n1 + n2;
// }

// int main() {
//     int n1, n2, suma;

//     printf("Ingrese el primer número: ");
//     scanf("%d", &n1);
//     printf("Ingrese el segundo número: ");
//     scanf("%d", &n2);


//     sumar(n1,n2,&suma);
//     printf("%d + %d = %d", n1, n2 , suma);

//     return 0;
// }

/*void cargarDatos(int arr[], int n){
    for (int i = 0; i < n; ++i) {
        printf("Ingrese el número %d: ", i + 1);
        scanf("%d", &arr[i]);
    }
}

void maximoMinimo(int arr[], int n, int* max, int* min){
    *(max) = arr[0];
    *(min) = arr[0];

    for(int i = 1 ; i < n ; i++){
        if(*(max) < arr[i]){
            *(max) = arr[i];
        }
        if(*(min) > arr[i]){
            *(min) = arr[i];
        }
    }

}

int main() {
    int n, i;
    printf("Ingrese la cantidad de números: ");
    scanf("%d", &n);

    int arr[n];
    cargarDatos(arr,n);

    int min, max;
    maximoMinimo(arr,n,&max,&min);

    printf("El maximo de la lista es %d y el minimo %d", max,min);

    return 0;
}*/

/*int main(){

    for(int i = 0 ; i < 5 ; i++){
        for(int j = 0 ; j < 3 ; j++){
            printf("%d\n",i*j);
        }
    }
    printf("--");
    for(int i = 0, j = 0 ; i < 5 && j < 3 ; i++, j++){
        printf("%d\n", i*j);
    }

    return 0;
}*/

/*#define NUM 16

void funcion1(int arr[]){
    for(int i = 0 ; i < NUM ; i++){
        arr[i] = i+1;
    }
}

int main(){

    int arr[NUM];

    funcion1(arr);

    for(int i = 0 ; i < NUM ; i++){
        printf("%d\n",arr[i]);
    }


    return 0;
}

int* funcion1(){

    int* ptr = (int *) malloc(sizeof(int)*NUM);
    if(ptr == NULL){
        printf("La memoria no pudo alocarse");
    } else {
        for(int i = 0 ; i < NUM ; i++){
            *(ptr+i) = i+1;
        }
    }
    return ptr;
    
}

int main(){

    int arr[NUM];

    int * puntero = funcion1();

    for(int i = 0 ; i < NUM ; i++){
        printf("%d\n",*(puntero + i));
    }


    free(puntero);

    return 0;
}*/

int factorial(int n){
    int fact = 1;
    if(n == 0){
        return 1;
    } else {
        fact = n * factorial(n-1);
        return fact;
    }
}

double sumatoria(int n){
    double suma = 0.0;
    // for(int i = 0 ; i <= n ; i++){
    //     suma += pow(-1, i) * (1.0/(3*i+1));
    // }
    for(int i = 2 ; i <= n ; i++){
        suma += 1.0/factorial(i-2);
    }
    return suma;
}

int main(){
    int n;
    printf("Ingrese un numero: ");
    scanf("%d",&n);

    double suma = sumatoria(n);
    printf("La sumatoria es: %0.11f.\n", suma);

    return 0;
}