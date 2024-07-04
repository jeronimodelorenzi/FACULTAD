#include <stdio.h>
#include <assert.h>

//Ejercicio 1

/*int main (){
int a, b, c, d=6, e; 
a = b = 3; // a = 3, b = 3
c = a*b+d; // c = 3*3+6 = 15
e = (c + 5) / 4-3; // e = (15 + 5)/4 - 3 = 5-3=2
e+=5; //e = e + 5 = 2 + 5 = 7
printf("Los resultados son %d y %d ", c, e); // Los resultados son 15 y 7
return 0;
}*/

//Ejercicio 2

/*int main (){
int a, b, c, d=6, e; 
a = 3;
b = a - d / 3; //b = 3 - 6/3 = 3 - 2 = 1
a *=b; //a = a * b = 3 * 1 = 3
c = a + d / a - 3 / a * b; //c= 3 + 6/3 - 3/3*1 = 3 + 2 -3/3 = 3 + 2 - 1 = 5 - 1 = 4
e = c + 8 / 4-b; // e = 4 + 8/4 - 1 = 4 + 2 - 1= 6 - 1 = 5
e+=5; // e = e + 5 = 5 + 5 = 10
printf("Los resultados son %d y %d ", c, e); // Los resultados son 4 y 10
return 0;
}*/

//Ejercicio 3

/*int main (){
float x, y;
printf ("Introduzca 2 números:\n");
scanf (" %f %f", &x, &y);
printf ("La suma de %f y %f vale %f\n", x, y, x+y); 
printf ("La suma de %4f y %4.2f vale %10.3f\n", x, y, x+y);
printf ("La suma de %e y %e vale %e\n", x, y, x+y);
return 0;
}*/

//Ejercicio 4

/*int main(){
    int temperatura;
    printf("\nIngrese la temperatura de agua: ");
    scanf("%d", &temperatura);

    if(temperatura < 0){
        printf("Estado sólido\n");
    } else if (temperatura < 100){
        printf("Estado liquido\n");
    } else {
        printf("Estado gaseoso\n");
    }

    return 0;
}*/

//Ejercicio 5

//if secuenciales

/*int main(){
    int nota;
    printf("\nIngrese la nota: ");
    scanf("%d",&nota);

    if(nota <= 1 || nota > 10){
        printf("\nIngresaste una nota invalida");
    }
    if(nota >= 2 && nota <= 5){
        printf("\nInsuficiente");
    }
    if(nota == 6){
        printf("\nAprobado");
    }
    if(nota == 7){
        printf("\nBueno");
    }
    if(nota == 8){
        printf("\nMuy bueno");
    }
    if(nota == 9){
        printf("\nDistinguido");
    }
    if(nota == 10){
        printf("\nExcelente");
    }

    return 0;
}*/

//else-if

/*int main(){
    int nota;
    printf("\nIngrese una nota: ");
    scanf("%d",&nota);

    if(nota <= 1 || nota > 10){
        printf("\nIngresaste una nota invalida");
    } else if (nota <= 5){
        printf("\nInsuficiente");
    } else if (nota == 6){
        printf("\nAprobado");
    } else if (nota == 7){
        printf("\nBueno");
    } else if (nota == 8){
        printf("\nMuy bueno");
    } else if (nota == 9){
        printf("\nDistinguido");
    }  else if (nota == 10){
        printf("\nExcelente");
    }

    return 0;
}*/

//Ejercicio 6



//Ejercicio 7

/*int main(){
    int año;
    printf("\nIngrese un año: ");
    scanf("%d",&año);

    if((año % 4 == 0 && año % 100 != 0) || (año % 400 == 0)){
        printf("\nBisiesto");
    } else {
        printf("\nNo bisiesto");
    }
    return 0;
}*/

//Ejercicio 8

/*int main(){
    int edad;
    printf("\nIngrese una edad: ");
    scanf("%d",&edad);

    if(edad < 18){
        printf("\nExento");
    } else if (edad > 64){
        printf("\nSeguridad Social");
    } else {
        printf("\nImposible");
    }

    return 0;
}*/

//Ejercicio 9

/*int main(){
    int i = 1;

    while(i<=100){
        printf("\n%d",i);
        i++;
    }

    return 0;
}*/

//Ejercicio 10

/*int main(){
    int i = 1;

    while(i<=100){
        if (i % 2 != 0){
            printf("\n%d",i);
        }
        i++;
    }

    return 0;
}*/

//Ejercicio 11

/*int main(){
    int a, b;
    printf("\nIngrese dos numeros: ");
    scanf("%d%d",&a,&b);

    if(a > b){
        printf("\nError");
    } else {
        while(a < b){
            printf("\n%d",a);
            a++;
        }
    }

    return 0;
}*/

//Ejercicio 12

/*int main(){
    int n, i = 2, condicion = 1;
    printf("\nIngrese un numero: ");
    scanf("%d", &n);

    if(n<0){
        printf("\nInvalido");
    } else if (n == 1){
        printf("\nNo es primo");
    } else if (n == 2){
        printf("\nEs primo");
    } else {
        while(i<n){
            if(n % i == 0 || !condicion ){
                condicion = 0;
            }
            i++;
        }
        if(condicion){
            printf("\nEs primo");
        } else{
            printf("\nNo es primo");
        }
    }

    return 0; 
}*/

//Ejercicio 13

/*int main(){
    int n;
    double factorial=1;
    printf("\nIngrese un numero: ");
    scanf("%d",&n);

    while(n>0){
        factorial *=n;
        n--;
    }
    printf("%lf",factorial);

    return 0;
}*/

//Ejercicio 14



//Ejercicio 15

/*int max(int a, int b);

int main(){
    int a,b,c,d,maximo1,maximo2,maximo_total;
    printf("\nIngrese 4 numeros: ");
    scanf("%d%d%d%d",&a,&b,&c,&d);

    maximo1 = max(a,b);
    maximo2 = max(c,d);
    maximo_total = max(maximo1,maximo2);
    printf("El numero mas grande es %d", maximo_total);

    return 0;
}

int max(int a,int b){
    if(a>b){
        return a;
    } else {
        return b;
    }
}*/

//Ejercicio 16

/*int ladosTriangulos(int a, int b, int c);
int max3(int a, int b, int c);

int main(){
    int a,b,c;
    printf("\nIngrese tres numeros: ");
    scanf("%d%d%d",&a,&b,&c);
    
    if(a < 0 || b < 0 || c < 0){
        printf("\nNo se puede con negativos");
    }
    int resultado = ladosTriangulos(a,b,c);
    
    if(resultado){
        printf("\nPueden ser triangulos");
    }else{
        printf("\nNo pueden ser triangulos");
    }

    return 0;
}

int ladosTriangulos(int a, int b, int c){
    int max;
    max = max3(a,b,c);
    if(max < a+b+c-max){
        return 1;
    } else {
        return 0;
    }
}

int max3(int a ,int b, int c){
    if(a < b && b > c){
        return b;
    } else if(c > a){
        return c;
    } else {
        return a;
    }
}*/

//Ejercicio 17

int esRectangulo(int a, int b, int c);
int max3(int a, int b, int c);
int test_max3();

int main(){
    int a,b,c;
    printf("\nIngrese tres numeros: ");
    scanf("%d%d%d",&a,&b,&c);

    if(a < 0 || b < 0 || c < 0){
        printf("\nNo se puede con negativos");
    }
    int resultado = esRectangulo(a,b,c);
    
    if(resultado){
        printf("\nEs rectangulo");
    } else {
        printf("\nNo es rectangulo");
    }

    test_max3();

    return 0;
}

int esRectangulo(int a, int b, int c){
    int max,cuadrados;
    max = max3(a,b,c);
    cuadrados = a*a + b*b + c*c - max*max;
    if(max*max == cuadrados){
        return 1;
    } else {
        return 0;
    }
}

int max3(int a ,int b, int c){
    if(a < b && b > c){
        return b;
    } else if(c > a){
        return c;
    } else {
        return a;
    }
}

int test_max3(){
    assert(max3(3,5,4) == 5);
    assert(max3(5,13,12) == 13);
    assert(max3(7,3,5) == 7);
}

//Ejercicio 18



//Ejercicio 19

/*int sucFibonacci(int n);

int main(){
    int n,fibonacci;
    printf("\nIngrese un numero: ");
    scanf("%d",&n);

    fibonacci = sucFibonacci(n);
    printf("La sucesion Fibonacci de %d es %d",n,fibonacci);

    return 0;
}

int sucFibonacci(int n){
    if(n == 0){
        return 0;
    } else if(n == 1) {
        return 1;
    } else {
        return sucFibonacci(n-1) + sucFibonacci(n-2);
    }
}*/