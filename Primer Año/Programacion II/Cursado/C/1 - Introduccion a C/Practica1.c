#include <stdio.h>

//Ejercicio 4

/*int main () {
    int estado;
    printf("Introduzca la temperatura del agua: \n");
    scanf("%d", &estado);
        if (estado <= 0){
            printf("La temperatura del agua es %d y su estado es solido \n", estado);
        }
        else if (estado < 100){
            printf("La temperatura del agua es %d y su estado es liquido \n", estado);
        }
        else{
            printf("La temperatura del agua es %d y su estado es gaseoso \n", estado);
        }
    return 0;
}*/

//Ejercicio 5 a
 
/*int main () {
    int nota;
    printf("Ingrese una nota: ");
    scanf("%d", &nota);
    if (nota >= 2 && nota <= 5){
        printf("Insuficiente \n");
    }else{
        if (nota == 6) {
            printf("Aprobado \n");
        } else {
            if (nota == 7) {
                printf("Bueno \n");
                } else {
                     if (nota == 8) {
                            printf("Muy Bueno \n");
                    } else {
                        if (nota == 9){
                            printf("Distinguido \n");
                        } else {
                            if (nota == 10){
                                printf("Sobresaliente \n");
                            } else {
                                printf("La nota ingresada no es valida \n");
                            }
                        }
                    }
                }
            }
        
    }
    return 0;
}*/

//Ejercicio 5 b

/* int main () {
    int nota;
    printf("Ingrese una nota: ");
    scanf("%d", &nota);

    if (nota >= 2 && nota <= 5){
        printf("Insuficiente \n");
    }
    else if (nota == 6){
        printf("Aprobado \n");
    }
    else if (nota == 7){
        printf("Bueno \n");
    }
    else if (nota == 8){
        printf("Muy Bueno \n");
    }
    else if (nota == 9) {
        printf("Distinguido \n");
    }
    else if(nota == 10) {
        printf("Sobresaliente \n");
    } else {
       printf ("La nota ingresada no es valida \n"); 
    }
    return 0;
}*/

//Ejercicio 6

/*int main () {
    int dia, mes;
    printf("Introduzca su dia y mes de nacimiento: ");
    scanf("%d%d", &dia,&mes);

    if (mes == 1){
        if (dia <= 20){
            printf("Capricornio \n");
        } else {
            printf("Acuario \n");
        }
    } 
    else if (mes == 2){
        if (dia <= 19){
            printf("Acuario \n");
        } else {
            printf("Piscis \n");
        }
    }
    else if (mes == 3){
        if (dia <=20){
            printf("Piscis \n");
        } else {
            printf("Aries \n");
        }
    }
    else if (mes == 4){
        if (dia <= 19){
            printf("Aries \n");
        } else {
            printf("Tauro \n");
        }
    }
    else if (mes == 5){
        if (dia <= 20){
            printf("Tauro \n");
        } else {
            printf("Geminis \n");
        }
    }
    else if(mes == 6){
        if (dia <= 22){
            printf("Geminis \n");
        } else {
            printf("Cancer \n");
        }
    }
    else if (mes == 7){
        if(dia <= 21){
            printf("Cancer \n");
        } else {
            printf("Leo \n");
        }
    }
    else if (mes == 8){
        if (dia <= 21){
            printf("Leo \n");
        } else {
            printf("Virgo");
        }
    }
    else if (mes == 9){
        if (dia <= 22){
            printf("Virgo \n");
        } else {
            printf("Libra \n");
        }
    }
    else if (mes == 10){
        if(dia <= 22){
            printf("Libra \n");
        } else {
            printf("Escorpio \n");
        }
    }
    else if (mes == 11){
        if (dia <= 21) {
            printf("Escorpio \n");
        } else {
            printf("Sagitario \n");
        }
    }
    else {
        if (dia <= 22) {
            printf("Sagitario \n");
        } else {
            printf("Capricornio \n");
        }
    }
    return 0;
}*/

//Ejercicio 7


/*int main () {
    int año;
    printf("Ingrese un año: ");
    scanf("%d", &año);
    
    if ((año % 4  == 0) && (año % 100 != 0)){
        printf("El año %d es bisiesto \n", año);
    }

    return 0;
}*/

//Ejercicio 8

/*int main () {
    int edad;
    printf ("Ingrese su edad: ");
    scanf("%d", &edad);

    if (edad > 64) {
        printf("Seguridad Social");
    } 
    else if (edad < 18) {
        printf("Exento");
    } else {
        printf("Imposible");
    }

    return 0;
}*/

//Ejercicio 9

/*int main () {
    int i = 1;
    while (i <= 100){
        printf("%d\n", i);
        i++;
    }

    return 0;
}*/

//Ejercicio 10

/*int main () {
    int i = 1;
    while (i <= 100) {
        if (i % 2 != 0){
            printf("%d\n", i);
        }
        i++;
    }

    return 0;
}*/

//Ejercicio 11

/* int main () {
    int x,y;
    printf("Ingrese dos numeros: ");
    scanf("%d%d",&x,&y);

    while(x <= y){
        printf("%d\n",x);
        x++;
    }
    return 0;
}*/

//Ejercicio 12 ¡-PREGUNTAR-!

/*int main () {
    int x,i = 2;
    printf("Ingrese un numero: ");
    scanf("%d", &x);

    if (x == 2 || x == 1){
        printf("%d es primo", x);
    }

    while(i <= x / 2){
        if (x % i == 0) {
            printf("%d no es primo \n", x);
        } 
        i++;
    }
    return 0;   
}*/

//Ejercicio 13

/*int main () {
    int x, i = 1, factorial = 1;
    printf("Ingrese un numero: ");
    scanf("%d",&x);

    if (x == 0) {
        printf("%d", 1);
    }
    else {
        while (i <= x){
            factorial *= i;
            i ++;
        }
        printf("El factorial de %d es %d \n",x,factorial);
    return 0;
    }
}*/

//Ejercicio 14 -REVISAR-

/*int main () {
    int pacientes, edad, edad_general = 0,edades_ingresados = 0, edades_operados = 0, cont_ingresado = 0, cont_operados = 0, i = 0;
    double indice;
    printf("Ingrese cantidad de pacientes a analizar: ");
    scanf("%d", &pacientes);

    while (i < pacientes){
        printf("Ingrese la edad y el indice del paciente %d:", i + 1);
        scanf("%d%le", &edad, &indice);
        edad_general += edad;

        if (indice > 0.6 && indice <= 0.9) {
            edades_ingresados += edad;
            cont_ingresado++;
        }
        else if (indice > 0.9) {
            edades_operados += edad;
            cont_operados++;
        }
        i++;
    }

    printf("La edad media de pacientes analizados es %d \n", edad_general / pacientes);
    
    if(cont_ingresado > 0 ){
        printf("La edad media de pacientes ingresados es %d\n", edades_ingresados / cont_ingresado);
    }else{
        printf("No hay pacientes ingresados");
        }
    if(cont_operados > 0){
        printf("La edad media de pacientes operados es %d \n", edades_operados / cont_operados);
    }else{
        printf("No hay pacientes operados");
    }

    return 0;
}*/

//Ejercicio 15

/*int maximo (int n1, int n2) {
    int max = n1;
    if (n2 > max){
        max = n2;
    }
    return max;
}

int main () {
     int f = maximo(1,3);
     printf("El maximo es %d \n", f);
     return 0;
}

int main () {
    int n1, n2, n3, n4;

    printf("Ingrese primer numero:");
    scanf("%d",&n1);

    printf("Ingrese segundo numero:");
    scanf("%d",&n2);

    printf("Ingrese tercero numero:");
    scanf("%d",&n3);

    printf("Ingrese cuarto numero:");
    scanf("%d",&n4);

    int max1 = maximo(n1,n2);
    int max2 = maximo(n3,n4);
    int max_general = maximo(max1,max2);

    printf("El maximo es %d \n", max);

    return 0;
}*/

//Ejercicio 16

/*int maximo (int n1, int n2) {
    int max = n1;
    if (n2 > max){
        max = n2;
    }
    return max;
}

int ladosTriangulo (int n1, int n2, int n3) {
    if(n1 < 0 || n2 < 0 || n3 < 0){
        printf("No se puede si son numeros negativos\n");
    } else {
        int max1 = maximo(n1,n2);
        int max_general = maximo(max1,n3);

        if (max_general < n1+n2+n3 - max_general) {
            return 1;
        }      
    }
    return 0;
}

int main(){
    int n1, n2, n3;

    printf("Ingrese los tres lados del triangulo: ");
    scanf("%d%d%d", &n1, &n2, &n3);

    int resultado = ladosTriangulo(n1, n2, n3);

    if (resultado == 1){
        printf("Estos lados pueden ser medidas de un triangulo.\n");
    } else {
        printf("Estos lados no pueden ser medidas de un triangulo.\n");
    }

    return 0;
}*/

// Ejercicio 17 a

/*int maximo (int n1, int n2) {
    int max = n1;
    if (n2 > max){
        max = n2;
    }
    return max;
}

int ladosTriangulo (int n1, int n2, int n3) {
    if(n1 < 0 || n2 < 0 || n3 < 0){
        printf("No se puede si son numeros negativos\n");
    } else {
        int max1 = maximo(n1,n2);
        int max_general = maximo(max1,n3);

        if (max_general < n1+n2+n3 - max_general) {
            return 1;
        }      
    }
    return 0;
}

int esRectangulo1(int n1, int n2, int n3) {
    int lados = ladosTriangulo(n1,n2,n3);
    if(lados == 1){

        int max1 = maximo(n1, n2);
        int max_general = maximo(max1, n3);
        int catetos = n1 * n1 + n2 * n2 + n3 * n3 - max_general * max_general;

        if (max_general * max_general == catetos){
            return 1;
        }
    }
    return 0;
}

int max3 (int n1,int n2,int n3) {
    int max = n1;
    if(n2 > max){
        max = n2;
    }
    if (n3 > max){
        max = n3;
    }
    return max;
}

int esRectangulo2(int n1, int n2, int n3) {
    int lados = ladosTriangulo(n1,n2,n3);
    if(lados == 1){    
        int max_general = max3(n1, n2, n3);
        int catetos = n1 * n1 + n2 * n2 + n3 * n3 - max_general * max_general;

        if (max_general * max_general == catetos) {
            return 1;  
        } 
    }
    return 0;
}

int main (){
    int i = esRectangulo1(3, 5, 4);
    int j = esRectangulo2(3, 5, 4);
    printf("%d\n%d\n",i,j);
    return 0;
}*/

// Ejercicio 18

/*int f (int año){
    int A = año % 19;
    int B = año % 4;
    int C = año % 7;
    int D = (19 * A + 24) % 30;
    int E = (2 * B + 4 * C + 6 * D + 5) % 7;
    int N = (22 + D + E);
    return N;
}

void calcularFechaPascua(int año) {
    int N = f(año);
    if(N > 31){
        printf("Pascua es el %d/04/%d\n", N - 31, año);
    } else {
        printf("Pascua es el %d/03/%d\n", N, año);
    }
}

int main (){
    int año;
    printf("Ingrese un año: ");
    scanf("%d",&año);
    calcularFechaPascua(año);
    return 0;
}*/

// Ejercicio 19

// int sucFibonacci (int n){
//     if(n == 0){
//         return 0;
//     }
//     if(n == 1){
//         return 1;
//     }
//     return sucFibonacci(n-1) + sucFibonacci(n-2);
// }

// int main (){
//     int n;
//     printf("Ingrese un numero: ");
//     scanf("%d",&n);
//     int resultado = sucFibonacci(n);
//     printf("La sucesion de Fibonacci del numero %d es %d\n", n, resultado);
//     return 0;
// }

