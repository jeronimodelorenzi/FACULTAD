#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Ejercicio 1

// a

/*int main(){
    int *punt;        //Inicializa puntero a entero.
    int x = 7, y = 5; //Declara variables. x entero igual a 7, y entero igual a 5.
    punt = &x; //Indica que el puntero debe apuntar a la direccion de memoria de x.
    *punt = 4; //Modifica el valor almacenado en la direccion de memoria apuntada por punt a 4.
    printf(" %d %d", x, y); //Muestra 4 y 5.
    return 0;
}*/

// b

/*int main(){
     int *punt; //Declara puntero a entero.
     int x = 7, y = 5; //Declara variables. x entero igual a 7, y entero igual a 5.
     punt = &x; //Indica que el puntero debe apuntar a la direccion de memoria de x.
     x = 4; //Cambia el valor de x. De 7 pasa a 4.
     punt = &y; //Cambia donde apunta el puntero. Antes apuntaba a la direccion de memoria de x, ahora a la de y.
     printf(" %d %d", *punt, x); //Muestra 5 y 4.
     return 0;
 }*/

// c

/*int main(){
     int *punt, i; //Declara dos variables. Un puntero a entero y un entero.
     int x[] = {1, 2, 3, 4, 5}; //Declara un arreglo de 5 enteros ya definidos.
     punt = x; //Indica que el puntero debe apuntar a la direccion de memoria del arreglo,
               //es decir, a la direccion del primer elemento del arreglo.
     *punt = 9; //Modifica el valor almacenado en la direccion de memoria apuntada por punt a 4.
     for (i = 0; i < 5; i++)
         printf(" %d, ", x[i]); //Muestre 9,2,3,4,5.
     return 0;
 }*/

// d

/*int main(){
     int *punt, i; //Declara variables. Una un puntero a entero y otra un entero.
     int x[] = {1, 2, 3, 4, 5}; //Declara un arreglo de 5 enteros ya definidos.
     punt = x; //Indica que el puntero debe apuntar a la direccion de memoria del arreglo,
              //es decir, a la direccion del primer elemento del arreglo.
     *(punt + 2) = 9; //(punt+2) aritmetica de punteros, indica que se debe mover dos lugar en la memoria.
                      //Luego *(punt + 2) = 9 modifica el valor almacenado en el puntero a 9.
     *(x + 3) = 7; //De igual forma, se posiciona esta vez en el cuarto elemento y modifica el valor almacenado en el puntero a 7.
     punt[1] = 11; //Cambia el segundo elemento a 11.
     for (i = 0; i < 5; i++)
         printf(" %d, ", *(punt + i)); //Muestra en pantalla 1,11,9,7,6,5.
     return 0;
 }*/

// e

/*int main(){
     int *punt, i; //Declara dos variables. Un puntero a entero y un entero.
     int x[5] = {1, 2, 3, 4, 5}; //Declara un arreglo de 5 enteros ya definidos.
     punt = &x[0] + 3; //Indica que el puntero apunte a la direccion de memoria del primer elemento y se mueva 3 lugares,
                       //es decir, el puntero apunta al cuarto elemento del arreglo.
     *(punt-2) = 9; //(punt-2) indica que el puntero se mueva dos lugares antes de la direccion indicada anteriormente y apunte,
                    //en este caso, al segundo elemento. Luego modifica el valor almacenado en el el puntero por 9.
     punt--; //punt-- hace que se posicione en la direccion de memoria anterior a donde apunta. Como esta apuntando al 4 elemento,
             //pasa al tercero. MI ERROR FUE PENSAR QUE POR LA LINEA ANTERIOR EL PUNTERO ESTA EN EL SEGUNDO ELEMENTO.
     *(punt) = 7; //Modifica el valor almacenado en el puntero a 7.
     punt[1] = 11; //Ahora, como el puntero si se encuentra en una posicion menos a donde estaba,
                   //es decir, esta en el tercer elemento, modifica el valor del cuarto elemento.
     punt = x; //Posiciona el puntero en la direccion del primer elemento del arreglo.
     for (i = 0; i < 5; i++)
         printf(" %d, ", punt[i]); //Muestra 1,9,7,11,5
     return 0;
 }*/

// f

/*int main(){
     int v[4] = {2, 4, 5, 7}, a, *p; //Declara un arreglo de 4 enteros ya definidos, un entero y un puntero a entero.
     p = v + 2; //Indica que el puntero debe apuntar a la direccion de memoria del tercer elemento (v[2]),
                //esto es porque 'v' marca la direccion del primer elemento y el '+2' mueve dos lugares.
     p--; //Indica que el puntero debe apuntar ahora a la direccion de memoria anterior a la que esta,
           //en este caso a la del segundo elemento(v[1]).
     a = *p + *(p + 1) + *(v + 1) + p[2]; // A la variable se le asigna *p que es igual a 4, se le suma *(p+1), es decir,
                                          //el puntero ahora apunta al tercer elemento(v[2]), y accedemos al valor almacenado en la
                                          //posicion, entonces 4+5. Ahora tenemos v+1, nos movemos una posicion en el arreglo y tomamos
                                          //su valor, 4+5+4. p[2], dado que p apunta a v[1], nos movemos dos direcciones de memoria, y
                                          //tenemos v[4], 4+5+4+7.
     printf(" %d", a); //Muestra 20.
     return 0;
 }*/

// g

/*void aumentar(int *x, int *y, int z){ //funcion que no devuelve nada y tiene como argumentos dos punteros a enteros y un entero.
    *x = *x + 2; //Modifica el valor almacenado en la direccion de memoria de x sumando el mismo valor + 2.
    *y = *y + 5; //Modifica el valor almacenado en la direccion de memoria de x sumando el mismo valor + 5.
    z = z + 4; //Le suma a z 4.
 }
int main(){
     int x, y, z; //Declara 3 variables enteras.
     x = 3;  //Asigna a x, 3.
     y = 10; //Asigna a y, 10.
     z = 15; //Asigna a z, 15.
     aumentar(&x, &y, z); //Llama a la funcion aumentar, esta va a acceder a las direcciones de memoria de x e y, modificara sus valores.
                          //x sera 3+2=5, y sera 10+5=15, como a z no se apunta su direccion, no sera modificado.
     printf(" %d %d %d", x, y, z); //Muestra 5 15 15.
     return 0;
 }*/

// h

/*void ingreseCadena(char *c){
    fgets(c, 10, stdin);
}

int main()
{
    char *cadena = malloc(sizeof(char) * 10);
    fgets(cadena, 10, stdin);
    printf(" %s\n", cadena);
    ingreseCadena(cadena);
    printf(" %s", cadena);
    free(cadena);
    return 0;
} No se como explicarlo. */

// i

/*int *direccion_local(int x){
     return &x;
 }
int main(){
     int *ptr = NULL;
     ptr = direccion_local(2);
     printf(" %d\n", *ptr);
     return 0;
 } //ERROR */

// Ejercicio 2

// Analice los programas dados a continuación. ¿Cuál es la salida por pantalla del
// programa? ¿Hay errores en el manejo de memoria? ¿Cómo solucionaría estos errores?

// a

/*int main(){
    char textoA[30] = "Agarrate Catalina"; //Declara una string.
    char textoB[30] = "El Cuarteto de Nos"; //Declara una string.
    char *p = textoA; //Declara un puntero a caracter que esta posicionado en el primer elemento de la cadena.
    char *q = textoB; //Declara un puntero a caracter que esta posicionado en el primer elemento de la cadena.
    char a; //Declara un caracter.
    printf("textoA : %s\ntextoB : %s\n", textoA, textoB); //Muestra las cadenas
    while (*p++ = *q++); //*q++ - El puntero apunta a la cadena textoB y por cada iteracion va pasando a la siguente.
                         //Luego, se se modifica la cadena de textoA.
    printf("while(*p++ = *q ++);\n");
    printf("textoA : %s\ntextoB : %s\n", textoA, textoB);
    return 0;
}*/

// b

/*int main(){
    int array[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; //Declaracion de un arreglo de 10 elementos ya establecidos.
    int *ptr; //Declaracion de puntero a entero.
    ptr = array; //El puntero apunta al primer elemento del arreglo.
    printf(" array [0] > %d; * ptr : %d\n", array[0], *ptr); //Muestra array[0] > 1; ptr: 1.
    printf(" array [1] > %d; *( ptr +1) : %d\n", array[1], *(ptr + 1));//Muestra array[1] > 2 *(ptr+1): 2
    ptr++; //El puntero ahora apunta a la siguiente direccion de memoria del arreglo.
    printf("ptr ++; *ptr : %d\n", *ptr); //Muestra ptr++; ptr: 2;
    return 0;
}*/

// c

/*char *copiar_cadena(char *cad, int longitud) //Funcion que toma como parametros una cadena de texto y la lingitud de la misma, retorna otra cadena.
{
    char *a = malloc(sizeof(char) * longitud); //Se declara un puntero a un entero, luego se pide memoria dinamica con malloc,
                                               //el tamaño es la longitud agregada por parametro.
    strcpy(a,cad);//copia la cadena en a.
    //a = cad; //El puntero apunta a la cadena, osea, al primer elemento de ella. La copia.
    return a; //Retornamos la cadena.
}

int main()
{
    char a[10] = "hola"; //Declaramos una cadena.
    char *b = copiar_cadena(a, 10); //Declaramos una cadena, esta es la copia de la que declaramos anterior.
    printf(" %s %s\n", a, b); //Muestra hola hola.
    b[0] = 's'; //Cambiamos el primer caracter de la cadena a s.
    printf(" %s %s\n", a, b); //Muestra sola sola. //Si usamos strcpy muestra hola sola.
    free(b);//Liberamos la memoria pedida en la funcion.
    return 0;
}*/

// se toma char: 1 byte, int: 4 bytes, float: 4 bytes, double: 8 bytes,
// puntero de cualquier tipo: 4 bytes.

/*int vector[5] = {10, 20, 30, 40, 50};

#define SIZE 100

/* Informacion sobre la celda */
/*struct informacionCelda
{
    char nombre[SIZE];        // nombre de la celda |100 bytes.
    int identificador;        // número identificador |4 bytes
    float calidad;            // calidad de la señal ( entre 0 y 100) |4 bytes
    struct informacionOp *op; // puntero a una segunda estructura |4 bytes
};
struct informacionOp
{
    char nombre[SIZE];      // nombre del operador |100 bytes
    int prioridad;          // prioridad de conexión |4 bytes
    int ultimaComprobacion; // fecha de la ultima comprobación |4 bytes
};*/
// a) ¿Cuántos bytes ocupa una variable de tipo struct informacionCelda en memoria? //Calcule 112 bytes pero me marca 120

// int main() {
//     printf("Tamaño de struct informacionCelda: %lu bytes\n", sizeof(struct informacionCelda));
//     return 0;
// }

// b) Las siguientes dos líneas declaran dos variables.
// ¿Cuánto ocupa cada una de ellas en memoria?

// struct informacionCelda a;
// struct informacionCelda *b;

// int main() {
//     printf("Tamaño de struct informacionCelda: %lu bytes\n", sizeof(struct informacionCelda));
//     printf("Tamaño de struct informacionCelda *: %lu bytes\n", sizeof(struct informacionCelda *));
//     return 0;
// }

// c)Si una variable de tipo struct informacionCelda está almacenada en la posición
// de memoria 100, ¿qué dirección tienen cada uno de sus campos?
// d)¿Se pueden hacer las siguientes asignaciones?
// Explique lo que se realiza en cada una de ellas.
// struct informacionCelda c;
// struct informacionCelda *cptr = &c;
// struct informacionCelda d;
// struct informacionCelda *dptr = cptr;

/*struct pack3{
    int a;
};

struct pack2{
    int b;
    struct pack3 *next;
};

struct pack1{
    int c;
    struct pack2 *next;
};

int main(){
    struct pack1 data1, *dataPtr;
    struct pack2 data2;
    struct pack3 data3;
    data1.c = 30;
    data2.b = 20;
    data3.a = 10;
    dataPtr = &data1;
    data1.next = &data2;
    data2.next = &data3;
    printf("%d", (*dataPtr).next->b);
    return 1;
}*/

//data1.c es correcta y vale 30.
//dataPtr->c es correcta y vale 30. 
//dataPtr.c es incorrecta porque dataPtr es un puntero a la estructura . La forma correcta es (*dataPtr).c y vale 30.
//data1.next->b es correcta y vale 20.
//dataPtr->next->b es correcta y vale 20.
//dataPtr.next.b es incorrecto porque dataPtr es un puntero a la estructura. La forma corsrecta es (*dataPtr).next->b y vale 20.
//dataPtr->next.b es incorrecto. La forma correcta es (*data->next).b y vale 20.
//(*(dataPtr->next)).b es correcta y vale 20.
//data1.next->next->a es correcta y vale 10.
//dataPtr->next->next.a es incorrecto. La forma correcta es(*dataPtr->next->next).a y vale 10.
//dataPtr->next->next->a es correcta y vale 10.
//dataPtr->next->a es incorrecta porque estamos accediendo a la estructura 2 y no se encuentra a.
//dataPtr->next->next->b es incorrecta porque estamos accediendo a la estructura 3 y no se encuentra b.