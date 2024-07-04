#include <stdio.h>
#include <math.h>
#include <ctype.h>

// Ejercicio 1

/*int main (){
    int caras;
    printf("Ingrese un numero del dado: ");
    scanf("%d",&caras);
    switch(caras){
        case 1:
            printf("Seis\n");
            break;
        case 2:
            printf("Cinco\n");
            break;
        case 3:
            printf("Cuatro\n");
            break;
        case 4:
            printf("Tres\n");
            break;
        case 5:
            printf("Dos\n");
            break;
        case 6:
            printf("Uno\n");
            break;
        default:
            printf("Numero incorrecto\n");
    }
    return 0;
}*/

// Ejercicio 2

/*int main (){
    int habitacion;
    printf("Habitaciones: 1.Azul 2.Roja 3.Verde 4.Rosa 5.Gris\n");
    printf("Ingrese el numero de la habitacion: ");
    scanf("%d", &habitacion);
    switch(habitacion){
        case 1:
            printf("Habitacion Azul, Primer planta, 2 camas\n");
            break;
        case 2:
            printf("Habitacion Roja, Primer planta, 1 cama\n");
            break;
        case 3:
            printf("Habitacion Verde, Segunda planta, 3 camas\n");
            break;
        case 4:
            printf("Habitacion Rosa, Segunda planta, 2 camas\n");
            break;
        case 5:
            printf("Habitacion Gris, Tercera planta, 1 camas\n");
            break;
        default:
        printf("Numero no asociado a habitacion\n");
    }
    return 0;
}*/

// Ejercicio 3

/*int main() {
    int eleccion;
    printf("Elija una sumatoria: 1 | 2 | 3 | 4 : ");
    scanf("%d", &eleccion);

    double sumatoria = 0.0;
    int n;

    switch (eleccion) {
        case 1:
            for (n = 1; n <= 100; n++) {
                sumatoria += 1.0 / n;
            }
            printf("El resultado de la sumatoria es %f\n", sumatoria);
            break;
        case 2:
            for (n = 1; n <= 30; n++) {
                sumatoria += 1.0 / (n * n);
            }
            printf("El resultado de la sumatoria es %f\n", sumatoria);
            break;
        case 3:
            for (n = 1; n <= 25; n++) {
                sumatoria += 1.0 / pow(n, n);
            }
            printf("El resultado de la sumatoria es %f\n", sumatoria);
            break;
        case 4:
            for (n = 2; n <= 10; n++) {
                sumatoria += (n + 1)*n;
            }
            printf("El resultado de la sumatoria es %f\n", sumatoria);
            break;
        default:
            printf("Eleccion no valida\n");
    }
    return 0;
}*/

//Ejercicio 4

/*int main () {
    int a, b;
    for(a = 1; a <= 20; a++){
        for(b = 1; b <= 30; b++){
            int c = sqrt(a*a+b*b);
            if(a*a + b*b == c*c){
                printf("(%d, %d, %d)",a,b,c);
            }
        }
    }
    return 0;
}*/

//Ejercicio 6

/*#define N 468

int main () {
    int ingreso;
    for(int intentos = 1; intentos != 15; intentos++){ 
        printf("Ingrese un numero entre 0 y 500: ");
        scanf("%d",&ingreso);
            if(ingreso == N){
                printf("Numero correcto\n");
                intentos = 16;
            } else {
                if(ingreso < N){
                    printf("Numero incorrecto, te quedan %d intentos, Pista: el numero es mayor a %d\n", 15 - intentos, ingreso);
                }
                else if (ingreso > N){
                    printf("Numero incorrecto, te quedan %d intentos, Pista: el numero es menor a %d\n", 15 - intentos, ingreso);                   
                }
            }
    }
    printf("Te quedaste sin intentos\n");
    return 0;
}*/

//Ejercicio 7

/*#define TAM 6

int main (){
    char letra = 'T';
    char str[] = "bucle";
    
    for(int i = 0; i < TAM -1;i++){
        str[TAM - 1] = str[i+1];
        str[i+1] = '\0';
        printf("%s %d %c\n", str, 5-i, i%2 == 0 ? letra : tolower(letra));
        str[i+1] = str[TAM - 1];
        letra--;

    }
    return 0;
}*/

//Ejercicio 8

/*void funcion (int n){
    int resultado;
    int pasos;
    if(n > 0){
        printf("El valor inicial es %d\n",n);
        for (pasos = 0; n != 2; pasos++){
            if(n % 2 == 0){
                resultado = n / 2;
                printf("El siguiente valor es %d\n", resultado);
            }else if (n != 1){
                resultado = n * 3 + 1;
                printf("El siguiente valor es %d\n", resultado);
            }
            n = resultado;
        }
    resultado = n / 2;
    printf("Resultado 1, pasos: %d\n", pasos + 1);
    } else {
        printf("Error\n");
    }
}

int main (){
    funcion(9);
    return 0;
}*/

//Ejercicio 9

/*int main (){
    int a[100];
    for(int i=0; i < 100; i++){
        printf("%d\n", a[i] = i+1);
    }
    return 0;
}*/

//Ejercicio 10

/*int main (){
    int a[51];
    for (int i = 100; i>=50; i--){
        printf("%d\n", a[100 - i] = i*2);
    }
    return 0;
}*/

//Ejercicio 11

/*int main (){
    int a[50];
    for(int i = 16; i >=1; i--){
        printf("%d\n", a[16 - i] = i * 3);
    }
}*/

//Ejercicio 12

/*void funcion (int a[10], int n){
    int bandera = 0;
    for(int i = 0; i < 10 && bandera != 1; i++){
        if(a[i] == n){
            printf("%d\n", i);
            bandera = 1;
        }
    }
    if(bandera == 0){
        printf("-1\n");
    }
}

int main (){
    int a[] = {1,2,3,4,5,6,7,8,9,10};
    int n = 4;
    funcion(a,n);
    return 0;
}*/

//Ejercicio 13


/*void funcion(int n) {
    int a[100];
    if(n >= 5 && n <= 100) {
        for(int i = 0; i < n; i++) {
            printf("Ingrese un numero: ");
            scanf("%d", &a[i]);
        }

        int suma;

        for(int i = 0; i < n; i++){
            suma += a[i];
        }
        if (suma > 30){
            printf("Suma mayor a 30\n");
        } else {
            printf("Suma menor a 30\n");
        }
    } else {
        printf("El valor de 'n' debe estar entre 5 y 100.\n");
    }
}

int main() {
    int n;
    printf("Ingrese un valor para 'n' (debe estar entre 5 y 100): ");
    scanf("%d", &n);
    funcion(n);
    return 0;
}*/

//Ejercicio 14

int main() {
    int a[100]; 
    int n, i = 0;
    
    printf("Ingrese un numero: ");
    scanf("%d", &n);
    while(n > 0){
        a[i] = n;
        i++;
        printf("Ingrese un numero: ");
        scanf("%d", &n);
    }
    
    int cont = 0;
    int max = a[0];

    for(int j = 1; j < i ; j++){
        if(max< a[j]){
            max = a[j];
            cont = j;
        }
    }

    if (max > 0) {
        printf("El valor más ingresado es: %d, se ingresó %d veces.\n", max, cont);
    } else {
        printf("No se ingresaron valores entre 0 y 99.\n");
    }

    return 0;
}


