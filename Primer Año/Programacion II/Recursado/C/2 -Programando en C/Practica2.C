#include <stdio.h>
#include <math.h>
#include <string.h>
#include <ctype.h>

// Ejercicio 1

/*void dado(int caras);

int main(){
    int n;

    printf("\nIngrese un numero entre el 1 y el 6: ");
    scanf("%d", &n);

    dado(n);

    return 0;
}

void dado(int caras){
    switch(caras){
        case 1:
            printf("Cara opuesta: Cuatro\n");
            break;
        case 2:
            printf("Cara opuesta: Cinco\n");
            break;
        case 3:
            printf("Cara opuesta: Seis\n");
            break;
        case 4:
            printf("Cara opuesta: Uno\n");
            break;
        case 5:
            printf("Cara opuesta: Dos\n");
            break;
        case 6:
            printf("Cara opuesta: Tres\n");
            break;
        default:
            printf("Numero incorrecto\n");
    }
}*/

// Ejercicio 2

/*void mostrarHabitaciones();
void mostrarPlanta(int n);

int main(){

    int n;

    mostrarHabitaciones();

    printf("\nIngrese el numero de la habitacion: ");
    scanf("%d",&n);

    mostrarPlanta(n);

    return 0;
}

void mostrarHabitaciones(){
    printf("\nHABITACION\n");
    printf("   1.AZUL\n");
    printf("   2.ROJA\n");
    printf("   3.VERDE\n");
    printf("   4.ROSA\n");
    printf("   5.GRIS\n");
}

void mostrarPlanta(int n){
    switch (n){
        case 1:
            printf("La habitacion Azul esta en la primer planta y tiene 2 camas.\n");
            break;
        case 2:
            printf("La habitacion Roja esta en la primer planta y tiene 1 cama.\n");
            break;
        case 3:
            printf("La habitacion Verde esta en la segunda planta y tiene 3 camas.\n");
            break;
        case 4:
            printf("La habitacion Rosa esta en la segunda planta y tiene 2 camas.\n");
            break;
        case 5:
            printf("La habitacion Gris esta en la tercera planta y tiene 1 camas.\n");
            break;
        default:
            printf("Numero no asociado a habitacion.\n");
    }
}*/

/*double sumatorias(int n);

int main(){

    int n;
    double sumas = 0.0;

    printf("\nIngrese un numero del 1 al 4: ");
    scanf("%d", &n);

    sumas = sumatorias(n);
    printf("El resultado de la sumatoria %d es %lf",n,sumas);

    return 0;
}

double sumatorias(int n){
    int i;
    double sumatoria = 0.0;
    switch(n){
        case 1:
            for(i = 1 ; i <= 100 ; i++){
                sumatoria += 1.0/i;
            }
            return sumatoria;
        case 2:
            for(i=1 ; i<=30 ; i++){
                sumatoria += 1.0/pow(i,2);
            }
            return sumatoria;
        case 3:
            for(i=1 ; i<=25 ; i++){
                sumatoria += 1/pow(i,i);
            }
            return sumatoria;
        case 4:
            for(i=2 ; i<=10 ; i++){
                sumatoria += (i+1)*i;
            }
            return sumatoria;
        default:
            printf("Numero invalido");
            break;
    }
}*/

// Ejercicio 4

/*int main()
{
    int a, b, c;

    for (a = 1; a <= 20; a++)
    {
        for (b = 1; b <= 30; b++)
        {
            c = sqrt(a * a + b * b);
            if (a * a + b * b == c * c)
            {
                printf("\nTerna: %d, %d, %d", a, b, c);
            }
        }
    }

    return 0;
}*/

// Ejercicio 5

/*int main()
{
    int x, y;
    printf("Ingrese dos enteros dentro del rango [1,20]:\n"); // Ingresamos 1 2
    scanf(" %d %d", &x, &y);
    if (x >= 1 && y >= 1 && x <= 20 && y <= 20) // 1 >= 1 && 2 >= 1 && 1 <= 20 && 2 <= 20 #True
    {
        for (int i = 1; i <= y; i++) // i = 1 ; 1 <= 2 ; 1++ = 2 // 1 es menor igual a 2 entonces sigue
        {                            // i = 2 ; 2 <= 2 ; 2++ = 3 // 2 es menor igual a 2 entonces sigue
            for (int j = 1; j <= x; j++) // j = 1 ;  1 <= 1 ; 1++ = 2 // 1 es menor igual que 1 entoces sigue
            {                            // j = 1; 1 <= 1 ; 2++ = 3 // Como 2 no es menor igual a 1 sigue
                printf("@"); // Muestra un @
            }
            printf("\n"); // Luego del @ le pone \n
        }
    }
    else
    {
        printf("Los enteros no se encuentran en el rango pedido");
    }
    return 0;
} // Muestra en pantalla entonces con x = 1 && y = 2 -> @\n
//                                                       @\n
*/

// Ejercicio 6

/*#define N 254

int main(){

    int valor, i;

    for(i = 0 ; i<15 ; i++){
        printf("\nIngrese otro numero entre el 0 y 500: ");
        scanf("%d",&valor);
        if (valor == N){
            printf("\nNumero Correcto.");
            i = 16;
        } else {
            if(valor < N){
                printf("\nEl numero es mayor. Intentos: %d",14-i);
            } else {
                printf("\nEl numero es menor Intentos: %d",15-i);
            }
        }
    }

    if(valor !=N){
        printf("\nFallaste");
    }

    return 0;
}*/

// Ejercicio 7

int main(){
    int MAX = 6;
    char letra = 'T';
    char str[] = "bucle";

    for(int i= 0 ; i < MAX - 1; i++){
        str[MAX - 1] = str[i+1];
        str[i+1] = '\0';
        printf("%s %d %c\n",str, 5-i,i%2 == 0 ? letra : tolower(letra)) ;
        str[i+1] = str[MAX - 1];
        letra--;
    }
    return 0;
}

/*void collatz(int n);

int main(){
    int n;
    printf("\nIngrese un numero natural: ");
    scanf("%d",&n);

    collatz(n);

    return 0;
}

void collatz(int n){
    int pasos = 0;
    if(n<1){
        printf("ERROR");
    } else{

        printf("\nEl valor inicial es %d", n);

        for(pasos; n > 1 ; pasos++){
            if(n%2==0){
                n /= 2;
            } else {
                n = 3*n + 1;
            }
            if(n==1){
                printf("\nValor final 1, numero de pasos: %d",pasos+1);
            } else {
                printf("\nEl siguiente valor es %d", n);
            }

        }
    }
}*/

//Ejercicio 9

/*int main(){
    int a[100];

    for(int i = 0 ; i <= 100 ; i++){
        printf("\n%d", a[i] = i);
    }

    return 0;
}*/

//Ejercicio 10

/*int main(){
    int a[100];

    for(int i = 100 ; i >= 0 ; i--){
        if(i%2==0){
            printf("\n%d",a[100 - i] = 100 + i);
        }
    }

    return 0;
}*/

//Ejercicio 11

/*int main(){
    int a[200];

    for(int i=150 ; i > 0 ; i--){
        if(i%3==0){
            printf("\n%d",a[100-i] = i);
        }
    }
    
    return 0;
}*/

//Ejercicio 12

/*void leerArreglo(int a[10],int n);

int main(){

    int a[] = {1,2,3,4,5,6,7,8,9,10};
    int n = 4;
    leerArreglo(a,n);

    return 0;
}

void leerArreglo(int a[10], int n){
    int bandera = 0;
    for(int i = 0; i <= 10 && bandera != 1 ; i++){
        if(a[i] == n){
            printf("\nEl entero %d se encuentra el la posicion %d",n , i);
            bandera = 1;
        }
    }
    if(bandera == 0){
        printf("\n-1");
    }
}*/

//Ejercicio 13

/*void cargarDatos(int numeros[], int n);
int sumaDatos(int numeros[],int n);


int main(){
    int n,suma = 0;
    printf("\nIngrese un numero entre 5 y 100: ");
    scanf("%d", &n);
    
    int numeros[n];

    if(n >= 5 && n <= 100){

        cargarDatos(numeros, n);
        suma = sumaDatos(numeros, n);

        if(suma > 30){
            printf("\nLa suma de los elementos del arreglo es mayor a 30");
            printf("\nSuma = %d",suma);
        } else {
            printf("\nLa suma de los elementos del arreglo es menor a 30");
            printf("\nSuma = %d",suma);
        }
    } else {
        printf("\nERROR");
    }

    return 0;

}

void cargarDatos(int numeros[], int n){
    for(int i = 0 ; i < n ; i++){
        printf("\nIngrese el elemento %d :", i);
        scanf("%d", &numeros[i]);
    }
}

int sumaDatos(int numeros[],int n){
    int suma = 0;
    for(int i = 0; i < n ; i++){
        suma += numeros[i];
    }

    return suma;
}*/

//Ejercicio 14 - INCOMPLETO

/*#define MAX 5

int cantNumero(int arreglo[MAX]);

int main(){
    int arreglo[MAX],n, i = 0;
    int cant = 0;
    printf("\nIngrese numeros (Negativos cancelan): ");
    scanf("%d", &n);

    while(n>=0){
        arreglo[i] = n;
        i++;
        printf("\nIngrese numeros (Negativos cancelan): ");
        scanf("%d", &n);
    }

    cant = cantNumero(arreglo);
    printf("\n%d", cant);

    return 0;
}

int cantNumero(int arreglo[MAX]){
    int contador = 0;
    for(int i = 0 ; i < MAX ; i++){
        for(int j = 1 ; j < MAX ; j++){
            if(arreglo[i] == arreglo[j]){
                contador += 1;
            }
        }
    }
    return contador;
}*/

//Ejercicio 15-16

/*void cargarDatos(int numeros[], int tam);
int sumaArr(int arreglo[],int tam);
int sumaAlt(int arreglo[],int tam);

int main(){

    int tam, eleccion;

    printf("\nIngrese el tamaño del arreglo: ");
    scanf("%d",&tam);

    int arreglo[tam];

    cargarDatos(arreglo,tam);

    printf("\nElija una opcion: \n1. SumaArr\n2. SumaAlt \n:");
    scanf("%d", &eleccion);

    switch(eleccion){
        case 1:
            int suma = sumaArr(arreglo,tam);
            printf("\nLa suma de los numeros del arreglo es %d", suma);
            break;
        case 2:
            int producto = sumaAlt(arreglo,tam);
            printf("\nEl producto de los numeros del arreglo en la posiciones pares es %d", producto);
            break;
        default:
            printf("\nERROR");
            break;
    }
    return 0;
}

void cargarDatos(int numeros[], int tam){
    for(int i = 0 ; i < tam ; i++){
        printf("\nIngrese el elemento %d :", i);
        scanf("%d", &numeros[i]);
    }
}

int sumaArr(int arreglo[], int tam){
    int suma = 0;
    for(int i = 0; i < tam ; i++){
        suma += arreglo[i];
    }

    return suma;
}

int sumaAlt(int arreglo[], int tam){
    int producto = 1;
    for(int i = 0; i < tam ; i+=2){
        producto *= arreglo[i];        
    }
    return producto;
}*/

//Ejercicio 18

/*#define MAX 500

int estaCaracter(char str[MAX] , char c);

int main(){
    char str[MAX], c;
    printf("\nIngrese una palabra: ");
    scanf("%s", str);

    printf("\nIngrese un caracter: ");
    scanf(" %c",&c);


    int condicion = estaCaracter(str,c);

    if(condicion){
        printf("\nEl caracter esta en la cadena.");
    } else {
        printf("\nNo esta.");
    }

    return 0;
}

int estaCaracter(char str[MAX] , char c){
    int condicion = 0;
    int length = strlen(str);
    int i = 0;

    while(i < length || !condicion){
        if(str[i] == c){
            condicion = 1;
        }
        i++;
    }
    return condicion;
}*/

//Ejercicio 19

/*#define MAX 500

int cantidadApariciones(char str[MAX], char c);

int main(){
    char str[MAX],c;
    printf("\nIngrese una palabra: ");
    scanf("%s", str);

    printf("\nIngrese un caracter: ");
    scanf(" %c", &c);

    int cantidad = cantidadApariciones(str, c);

    printf("La cantidad de apariciones del caracter '%c' en la palabra '%s' es %d.", c,str,cantidad);

    return 0;
}

int cantidadApariciones(char str[MAX], char c){
    int cantidad = 0, i = 0;

     while (str[i] != '\0'){
        if(str[i] == c){
            cantidad ++;
        }
        i++;
    }

    return cantidad;

}*/

//Ejercicio 20

/*#define MAX 500

void cadenaReves(char str[MAX], char new_str[MAX]);

int main(){

    char str[MAX], new_str[MAX];
    
    printf("\nIngrese una palabra: ");
    scanf("%s",str);

    cadenaReves(str,new_str);

    printf("La cadena '%s' al revez es %s", str, new_str);

    return 0;
}

void cadenaReves(char str[MAX],char new_str[MAX]){
    int length = strlen(str);
    

    for(int i = length - 1, j = 0;  i >= 0 ; i--, j++){
        new_str[j] = str[i];
    }

    new_str[length] = '\0';
}*/

//Ejercicio 21

/*#define MAX 500

int esCapicua(char str[MAX]);

int main(){

    char str[MAX];
    printf("\nIngrese una palabra: ");
    scanf("%s", str);

    int condicion = esCapicua(str);

    if(condicion){
        printf("\nEs capicua.");
    } else {
        printf("\nNo es capicua.");
    }
    

    return 0;
}

int esCapicua(char str[MAX]){
    int condicion = 1;
    int length = strlen(str);

    for (int i = 0; i < length / 2; i++) {
        if (str[i] != str[length - 1 - i]) {
            condicion = 0;
        }
    }
    return condicion;
}*/

//Ejercicio 23

