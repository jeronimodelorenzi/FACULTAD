#include <stdio.h>
#include <assert.h>



#define MAX_ARR 12 //Definimos el tamaño maximo del arreglo.

//Prototipos

float promedioAritmetico(float aAlturas[], int max);
int test_promedioAritmetico();
float alturaMaxima(float aAlturas[],int max);
int test_alturaMaxima();
float calculoModa(float aAlturas[],int max);
int test_calculoModa();
float my_abs(float n);
int test_my_abs();
void desviacionPromedio(float aAlturas[], float aDesviacion[] ,float promedio, int max);


int main(){

    float aAlturas[MAX_ARR] = {1.95 , 1.89, 1.88, 1.86, 1.86, 2.0, 2.0, 2.0, 2.0, 2.07, 2.09, 2.12};

    float aDesviacion[MAX_ARR];

    //PROMEDIO ARITMETICO
    float promedio = promedioAritmetico(aAlturas, MAX_ARR);
    printf("El promedio aritmético es: %f.\n", promedio);

    //ALTURA MAXIMA
    float max = alturaMaxima(aAlturas, MAX_ARR);
    printf("La altura máxima fue de: %0.2f.\n", max);


    //DESVIACION DE PROMEDIO.
    printf("Desviacion de promedio:\n");
    desviacionPromedio(aAlturas,aDesviacion, promedio, MAX_ARR);

    for(int i = 0 ; i < MAX_ARR ; i++){
        printf("Desviacion de promedio de %0.2f: %0.2f\n",aAlturas[i], aDesviacion[i]);
    }

    //TESTEOS
    test_promedioAritmetico();
    test_alturaMaxima();
    test_my_abs();

    return 0;
}

//Representamos las alturas del Río Paraná durante los 12 dias de Junio con float.
//promedioAritmetico: array[float] int -> float.
//Dado un arreglo de numeros , que referencias las altura de los ultimos 12 dias del Río Paraná, y su tamaño,
//calcula el promedio aritmético de la altura.
//Ejemplos: 
//promedioAritmetico([1.95 , 1.89, 1.88, 1.86, 1.86, 2.0, 2.0, 2.0, 2.0, 2.07, 2.09, 2.12],12) = 1.98.
//promedioAritmetico([5.0,4.0,5.0],3) = 5.00.
//promedioAritmetico([3.0,2.0],2) = 2.50.

float promedioAritmetico(float* aAlturas, int max){
    float suma = 0;
    for(int i = 0 ; i < max ; i++){
        suma += aAlturas[i];
    }
    suma /= max;
    return suma;
}

int test_promedioAritmetico(){
    float arr_test1[] = {1.95 , 1.89, 1.88, 1.86, 1.86, 2.0, 2.0, 2.0, 2.0, 2.07, 2.09, 2.12};
    float arr_test2[] = {5.0,4.0,5.0};
    float arr_test3[] = {3.0,2.0};

    float resultado_test1 = promedioAritmetico(arr_test1, 12) - 1.976667;
    float resultado_test2 = promedioAritmetico(arr_test2, 3) - 5.00;
    float resultado_test3 = promedioAritmetico(arr_test3, 2) - 2.50;
    
    assert(resultado_test1 < 0.01);
    assert(resultado_test2 < 0.01);
    assert(resultado_test3 < 0.01);
}

//Representamos las alturas del Río Paraná durante los 12 dias de Junio con float.
//alturaMaxima: array[float] int -> float.
//Dado un arreglo de numeros , que referencias las altura de los ultimos 12 dias del Río Paraná, y su tamaño,
//retorna la maxima altura.
//alturaMaxima([1.95 , 1.89, 1.88, 1.86, 1.86, 2.0, 2.0, 2.0, 2.0, 2.07, 2.09, 2.12],12) = 2.12
//alturaMaxima([5.0,4.0,5.0],3) = 5.0
//alturaMaxima([3.0,2.0],2) = 3.0
float alturaMaxima(float aAlturas[], int max){
    float maxima = aAlturas[0];
    for(int i = 1 ; i < max; i++){
        if(aAlturas[i] > maxima){
            maxima = *(aAlturas + i);
        }
    }
    return maxima;
}

int test_alturaMaxima(){
    float arr_test1[] = {1.95 , 1.89, 1.88, 1.86, 1.86, 2.0, 2.0, 2.0, 2.0, 2.07, 2.09, 2.12};
    float arr_test2[] = {5.0,4.0,5.0};
    float arr_test3[] = {3.0,2.0};

    float resultado_test1 = alturaMaxima(arr_test1, 12) - 2.12;
    float resultado_test2 = alturaMaxima(arr_test2, 3) - 5.00;
    float resultado_test3 = alturaMaxima(arr_test3, 2) - 3.00;

    assert(resultado_test1 < 0.01);
    assert(resultado_test2 < 0.01);
    assert(resultado_test3 < 0.01);;
}

// No pude implementar calculoModa
float calculoModa(float aAlturas[],int max){
    float cant = 0;
    float rep[max];

    for(int i = 0; i< max; i++){
        for(int j = 1; i<max;j++){
            if(aAlturas[i] == aAlturas[j]){
                rep[i] = aAlturas[i];
            }
        }

    }
}


//my_abs: float -> float.
//Dado un numero, retorna su valor absoluto.
//my_abs(3.0) = 3.0
//my_abs(-2.5) = 2.5
//my_abs(0) = 0

float my_abs(float n){
    if(n >= 0){
        return n;
    } else {
        return -n;
    }
}

int test_my_abs(){
    assert(my_abs(3.0) == 3.0);
    assert(my_abs(-2.5) == 2.5);
    assert(my_abs(0) == 0);
}

//Representamos las alturas del Río Paraná durante los 12 dias de Junio con floats.
//aDesviacion se almacenan la desviacion.
//alturaMaxima: array[float] array[float] float -> void.
//Dado un arreglo de numeros flotantes, que referencias las altura de los ultimos 12 dias del Río Paraná,
//un array para almacenar la desviacion, el promedio y su tamaño, carga en aDesviacion el resultado del valor absoluto
//entre el promedio y la altura.


void desviacionPromedio(float aAlturas[], float aDesviacion[], float promedio ,int max){
    for(int i = 0 ; i < max ; i++){
        float diferencia = aAlturas[i] - promedio;
        float diferencia_abs = my_abs(diferencia);
        aDesviacion[i] = diferencia_abs;
    }
}