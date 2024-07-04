#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Ejercicio 1

/*typedef struct{
    double x;
    double y;
} Punto;

double proy(Punto p, char eje){
    if(eje == 'x'){
        return p.x;
    } else if(eje == 'y'){
        return p.y;
    } else {
        printf("Resultado invalido\n.");
        return 0;
    }
}

double dist(Punto punto1, Punto punto2){
    double diferencia_x = punto1.x - punto2.x;
    double diferencia_y = punto1.y - punto2.y;
    double suma_cuadrados = diferencia_x*diferencia_x + diferencia_y*diferencia_y;
    double distancia = sqrt(suma_cuadrados);
    return distancia;
}

char pos(Punto p){
    if(p.x == 0 && p.y == 0){
        return 'o';
    } else if(p.x == 0){
        return 'y';
    } else if(p.y == 0){
        return 'x';
    } else if(p.x > 0 && p.y > 0){
        return '1';
    } else if(p.x < 0 && p.y > 0){
        return '2';
    } else if(p.x < 0 && p.y < 0){
        return '3';
    } else if(p.x > 0 && p.y < 0){
        return '4';
    }
}

int main(){

    Punto punto1;
    Punto punto2;

    printf("Ingrese un numero para x (punto1): ");
    scanf("%lf", &punto1.x);

    printf("\nIngrese un numero para y (punto1): ");
    scanf("%lf", &punto1.y);

    printf("\nIngrese un numero para x (punto2): ");
    scanf("%lf", &punto2.x);

    printf("\nIngrese un numero para y (punto2): ");
    scanf("%lf", &punto2.y);

    char eje;
    printf("\nIngrese el eje para la proyección (x o y): ");
    scanf(" %c", &eje);

    double distancia = dist(punto1, punto2);

    double proyeccion_p1 = proy(punto1, eje);
    double proyeccion_p2 = proy(punto2, eje);

    char posicion1 = pos(punto1);
    char posicion2 = pos(punto2);

    if(eje == 'x'){
        printf("La proyeccion del punto (%0.1f,%0.1f) en el eje x es: (%0.1f,0)\n",punto1.x,punto1.y, proyeccion_p1);
        printf("La proyeccion del punto (%0.1f,%0.1f) en el eje x es: (%0.1f,0)\n",punto2.x,punto2.y,proyeccion_p2);
    } else {
        printf("La proyeccion del punto (%0.1f,%0.1f) en el eje y es: (0,%0.1f)\n",punto1.x,punto1.y,proyeccion_p1);
        printf("La proyeccion del punto (%0.1f,%0.1f) en el eje y es: (0,%0.1f)\n",punto2.x,punto2.y,proyeccion_p2);
    }

    printf("La distancia del punto (%0.1f,%0.1f) y (%0.1f,%0.1f) es %0.2f\n",punto1.x,punto1.y,punto2.x,punto2.y,distancia);

    printf("El punto (%0.1f,%0.1f) se encuentra en el cuadrante: %c\n", punto1.x,punto1.y,posicion1);
    printf("El punto (%0.1f,%0.1f) se encuentra en el cuadrante: %c\n", punto2.x,punto2.y,posicion2);

    return 0;
}*/

// Ejercicio 2

/*int main(){
    int vector[5] = {10, 20, 30, 40, 50};
    int a = 3;
    int *ptr = &a;
    int *qtr = vector;
    // a
    printf("El tipo de dato que retorna a es int y vale %d.\n", a);
    printf("El tipo de dato que retorna &a es puntero a entero y vale %p.\n", &a);
    printf("El tipo de dato que retorna *a no existe ya que no es un puntero a.\n");
    // ptr
    printf("\n\nEl tipo de dato que retorna ptr es un puntero a entero ya que es la direccion de memoria de a. ptr es un puntero a la direccion de a. Podemos ver que la direccion de a es %p y ptr es %p.\n", &a, ptr);
    printf("El tipo de dato que retorna &ptr es un puntero a un puntero a entero. El valor de &ptr es la direccion de memoria de ptr: %p\n", &ptr);
    printf("El tipo de dato que retorna *ptr es un entero, ya que estamos accediendo mediante el puntero. El valor de *ptr es %d.\n",*ptr);
    // qtr
    printf("\n\nEL tipo de dato que retorna qtr es un puntero a entero ya que esta apuntando al primer elemento del vector. El valor es %p.\n",qtr);
    printf("El tipo de dato que retorna &qtr es un puntero a puntero de entero, el mismo caso que &ptr, porque esta apuntando a la direccion de memoria donde se encuentra qtr. Su valor es %p.\n", &qtr);
    printf("El tipo de dato que retorna *qtr es un entero ya que accedemos al primer elemento del vector. Su valor es: %d", *qtr);
    // vector
    printf("\n\nEl tipo de dato que retorna vector es la direccion de memoria del primer elemento del vector, es decir que es el mismo valor que qtr. Podemos comprobar, vector %p ; qtr: %p.\n",vector,qtr);
    printf("El tipo de dato que retorna &vector es la misma que vector. %p.\n",&vector);
    printf("El tipo de dato que retorna *vector es un entero, el primer elemento del arreglo. Su valor es %d.\n",*vector);
    //otros
    printf("\n\nEl tipo de dato que retorna ++qtr es la posicion de memoria del siguiente elemento del arreglo. Su valor es %p.\n",++qtr);
    printf("El tipo de dato que retorna ++*qtr es un entero, ya que estamos accediendo al segundo elemento del arreglo y agregandole 1. Su valor es %d.\n", ++*qtr);
    printf("El tipo de dato que retorna ++*vector es un entero, ya que estamos accediendo al primer elemento del arreglo y sumandole 1. %d\n", ++*vector);
    printf("El tipo de dato que retorna *&ptr es la posicion de memoria de a ya que estamos apuntando a la direccion de memoria que tiene ptr, es decir a la direccion de memoria de a. Podemos ver: &a: %p, *&ptr:%p.\n",&a,*&ptr);
    return 0;
}*/

// Ejercicio 3

/*int main(){
    int *ip1 , ip2 = 2 ;
    char ch , *cp ;


    //VIOLACION ip1 = "cadena de ejemplo";
    //cp = 0;
    //ip1 = 0;
    //VIOLACION cp = &'a';
    //VIOLACION ip1 = ip2;
    //cp = '\0';
    //ip1 = '\0';
    //cp = &ch;
    //VIOLACION *ip1 = ip2;

    printf("%d",*ip1);

    return 0;
}*/

// Ejercicio 4

// 1

/*void initialize(int a, int* b){
    if (a > 0)
        *b = 1;
    else
        *b = 0;
}
int main(){
    int a = 1, b;
    initialize(a,&b);
    printf(" %d %d\n", a, b);
    return 0;
}*/

// 2

/*int main(){
    int *pi = malloc(sizeof(int));
    int *pj = malloc(sizeof(int));
    *pi = 11;
    *pj = *pi;
    printf("*pi= %d, *pj= %d", *pi, *pj);
    free(pi);
    free(pj);
    // resto de codigo
    return 0;
}*/

// 3

/*int main(){
    int *ptr, a = 34;
    int b = 45,*ptr2 = &b;
    ptr = &a;
    printf(" %d =?= %d", a, *ptr);
    return 0;
}*/

// 4

/*struct vector{
    float x, y;
};

struct vector *normal(struct vector v){
    struct vector *ptr;
    ptr = malloc(sizeof(struct vector));
    ptr->x = v.x;
    ptr->y = v.y;
    return ptr;
}*/

// Ejercicio 5

// Dadas las siguientes definiciones de estructura y asignaciones:

struct estudiante
{
    char *apellido;
    int anio_ingreso;
    char division;
};
struct estudiante nuevo, *pest = &nuevo;
nuevo.apellido = "Lopez";
nuevo.anio_ingreso = 1998;
nuevo.division = 'A';
// Determine si las siguientes sentencias son correctas. En caso de ser incorrectas explique por
// qué, en caso de ser correctas indique cuál es el valor que representan.
// a. nuevo->apellido -> nuevo.apellido
// b. pest->division ->  A
// c. (*pest)->apellido -> (*pest).apellido 
// d. *pest->apellido+2 -> (*pest).apellido + 2
// e. *(pest->apellido+2) -> p
// f. pest->apellido[2] -> p
