//Ejemplo 1
/*#define PI 3.14159 // constante
#define NUM_ELEM 5 // constante
#define AREA(rad) PI*(rad)*(rad) // macro
#define MAX(a,b) ((a)>(b)?(a):(b)) // macro*/

//Ejemplo 2
/*#define CADENADONDE "[archivo %s, línea %d] "
#define ARGUMENTOSDONDE __FILE__,__LINE__*/

//Ejemplo 1
/*int main(){
    int i; // Tras la fase de preprocesamiento
    float vec[NUM_ELEM]; // float vec[5];
    for(i=0;i<NUM_ELEM;i++){ // for(i=0;i<5;i++)
        vec[i] = MAX(i*5.2,AREA(i)); // vec[i] = ((i*5.2)>(3.14159*(i)*(i))?(i*5.2):(3.14159*(i));
        printf("Elemento %d - Valor: %lf\n",i,vec[i]);
    }
    return 0;
}*/

//Ejemplo 2
/*int main(){
    int x = 2;
    printf (CADENADONDE ": mira, x=%d\n", ARGUMENTOSDONDE, x);
    return 0;
}*/



// Ejercicio 1

/*#include <stdio.h>
#define YES 1
#define NO 0
#line 3000 "preprocesamiento.c"

#undef TRUE
#define TRUE 1

#ifdef TRUE
#undef TRUE
#define TRUE 1
#endif

#if TRUE != 0
    #define FALSE 0
#else
    #define FALSE 1
#endif

#define SQUARE_VOLUME(x) (x)*(x)*(x)

int main(){

    printf("YES: %d, NO: %d\n", YES, NO);
    printf("TRUE: %d, FALSE: %d\n", TRUE, FALSE);
    printf("El volumen del cubo de lado 3 es: %d\n", SQUARE_VOLUME(3));

    return 0;
}*/

// Ejercicio 2

/*#include <stdio.h>

#define PI 3.14159
#define VOL_ESF(x) 4.0/3*PI*(x)*(x)*(x)

int main(){

    for(int i=1;i<11;i++){
        printf("Volumen esfera de radio %d: %lf \t",i,VOL_ESF(i));
    }
    printf("\n");

    return 0;
}*/

// Ejercicio 3

/*#include <stdio.h>
#define SUM(x,y) printf("La suma de %d y %d es %d\n",x,y,x+y)

int main(){

    for(int i=1 ; i<5; i++){
        SUM(i,i+1);
    }

    return 0;
}*/

// Ejercicio 4

/*#include <stdio.h>
#define MININUM2(x,y) ((x<y)?(x):(y))

int main(){

    printf("El numero más chico entre 55 y 66 es: %d\n",MININUM2(55,66));

    return 0;
}*/

// Ejercicio 5

/*#include <stdio.h>
#define MININUM2(x,y) ((x<y)?(x):(y))
#define MININUM3(x,y,z) (MININUM2(MININUM2(x,y),z))

int main(){

    printf("El numero más chico entre , 42, 55 y 66 es: %d\n",MININUM3(55,66,42));

    return 0;
}*/

// Ejercicio 6

/*#include <stdio.h>
#define PRINT(x) printf("%s\n",x)

int main(){

    PRINT("HOLA");

    return 0;
}*/

// Ejercicio 7

/*#include <stdio.h>
#define PRINTARRAY(x,i) for(int k=0;k<i;k++){printf("Elemento %d - %d\n", k, x[k]);}

int main(){

    int x[] = {1,2,3,4,5};

    PRINTARRAY(x,5);

    return 0;
}*/

// Ejercicio 8

/*#include <stdio.h>
#define SUMARRAY(x,i) int suma=0; for(int k=0;k<i;k++){suma += x[k];} printf("Suma del arreglo: %d\n",suma)

int main(){

    int x[] = {1,2,3,4,5};

    SUMARRAY(x,5);

    return 0;
}*/