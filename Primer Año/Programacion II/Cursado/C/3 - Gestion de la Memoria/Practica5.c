#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*int main(){
    int a = 55, *ptr = &a;
    char c = 'A', *ptr2 = &c;
    char* str = "hola";
    int arreglo[] = {1,2,3,4};
    int* ptr3 = arreglo;

    printf("Puntero a entero.\n");
    printf("Valor de a: %d,direccion de memoria de a: %p.\n", a, &a);
    printf("Valor de ptr: %p, direccion de memoria de ptr: %p, valor guardado en la direccion de ptr: %d.\n",ptr,&ptr,*ptr);

    printf("Puntero a char.\n");
    printf("Valor de c: %c, direccion de memoria de c: %p.\n",c,&c);
    printf("Valor de ptr2: %p, direccion de memoria de ptr2: %p, valor guardado en la direccion de ptr2: %c.\n",ptr2,&ptr2,*ptr2);

    printf("\n\nUsando aritmetica de punteros:\n");
    for(int i = 0 ; i < 4 ; i++){
        printf("Posicion: %d, caracter: %c,direccion de memoria: %p.\n", i, *(str+i), (str+i));
    }

    printf("\n\nUsando []\n");
    for(int i = 0 ; i < 4 ; i++){
        printf("Posicion: %d, numero: %d, direccion de memoria: %p\n",i,(ptr3[i]), &ptr3[i]);
    }

    return 0;
}*/

// Ejercicio 2

/*void setzerozero(int arr[]){
    arr[0] = 0;
}

void cargaDatos(int arr[],int tam){
    for(int i = 0 ; i < tam ; i++){
        printf("Posicion %d - Ingrese un numero: ",i);
        scanf("%d",&arr[i]);
    }
}

void mostrarDatos(int arr[],int tam){
    for(int i = 0 ; i < tam ; i++){
        printf("Posicion %d - Elemento: %d\n",i, arr[i]);
    }
}

int main(){

    int tam;
    printf("Ingrese el tamaño del array: ");
    scanf("%d", &tam);

    int arr[tam];

    cargaDatos(arr,tam);

    mostrarDatos(arr,tam);

    setzerozero(arr);

    printf("Arreglo modificado.\n");

    mostrarDatos(arr,tam);

    return 0;
}
*/

// Ejercicio 3.

/*void setin(int *n){
    if(*n != 0){
        *n = 1;
    }
}

int main(){

    int n;
    printf("Ingrese un numero entero: ");
    scanf("%d", &n);

    printf("Entero ingresado: %d.\n", n);

    setin(&n);

    printf("Entero modificado: %d\n.", n);

    return 0;
}*/

// Ejercicio 4

/*void swap(int *n1, int* n2){
    int temp = *n1;
    *n1 = *n2;
    *n2 = temp;
}

int main(){
    int n1, n2;
    printf("Ingrese dos numeros enteros: ");
    scanf("%d%d", &n1,&n2);

    printf("Numero 1: %d, Numero 2: %d.\n",n1,n2);

    swap(&n1,&n2);

    printf("Numero 1: %d, Numero 2: %d.\n",n1,n2);

    return 0;
}*/

// Ejercicio 5. Explique el tipo de la función malloc, ¿qué valor retorna la función en caso de que no pueda reservar el espacio solicitado?

// El tipo de la funcion void* malloc(size_t size). Si no puede reservar el espacio devuelve NULL.

// Ejercicio 6. Implemente una función char *getnewline(void) que ingrese una linea por teclado (hasta \n) y devuelva un puntero a la cadena ingresada.

/*char *getnewline(){

    char *ptr;
    ptr = malloc(sizeof(char)*100);
    printf("Ingrese una linea: ");
    if(ptr == NULL){
        printf("ERROR.\n");
        return 1;
    }

    fgets(ptr,100,stdin);

    return ptr;
}

int main(){

    char *linea = getnewline();

    printf("Cadena ingresada: %s", linea);

    free(linea);

    return 0;
}*/

// Ejercicio 7 Escriba un programa que reserve un espacio de memoria de 100 bytes y luego lo libere dos veces. ¿Se produce algún error?

/*int main(){

    int *ptr;
    int tamaño = 100;
    ptr = malloc(tamaño);
    if (ptr == NULL){
        printf("Error al asignar memoria.\n");
        return 1;
    }

    free(ptr);
    free(ptr); //genera un error, 'double free'.

    return 0;
}*/

// Ejercicio 8

// a

/*int sumar10(int x){
    return x + 10;
}

int apply(int (*func)(int), int x){
    return func(x);
}

int main(){

    int x;
    printf("Ingrese un numero: ");
    scanf("%d",&x);

    int resultado = apply(sumar10, x);

    printf("Resultado: %d.\n",resultado);

    return 0;
}*/

// b

/*int sumar10(int x){
    return x + 10;
}

void applyin(int (*func)(int),int *x){
    *x = func(*x);
}

int main(){

    int x;
    printf("Ingrese un numero: ");
    scanf("%d",&x);

    applyin(sumar10, &x);

    printf("Resultado: %d.\n",x);

    return 0;
}*/

// c
// void recorre(VisitorFunc, int [], int) que toma un puntero a una función, un arreglo de enteros y su longitud y aplica la función a cada elemento del arreglo.
// VisitorFunc está definido por typedef void (*VisitorFunc)(int).

/*typedef void (*VisitorFunc)(int x);

void sumar10(int x){
    printf("%d\n", x + 10);
}

void recorre(VisitorFunc func, int arr[], int tam){
    for(int i = 0; i < tam ; i++){
        func(arr[i]);
    }
}

void cargaDatos(int arr[], int tam){
    for(int i = 0 ; i < tam ; i++){
        printf("Posicion %d - Elemento: ",i);
        scanf("%d", &arr[i]);
    }
}

int main(){
    int tam;
    printf("Ingrese el tamaño del arreglo: ");
    scanf("%d", &tam);

    int arr[tam];

    cargaDatos(arr,tam);

    printf("Arreglo ingresado:\n");
    for(int i = 0 ; i < tam ; i++){
        printf("Posicion %d - Elemento: %d\n",i, arr[i]);
    }

    recorre(sumar10,arr,tam);

    return 0;
}*/

// Ejercicio 9

// a

/*void nullify(int *a){             // Funcion que tiene como argumento un puntero a entero y no retorna nada.
    a = NULL; // Declara el puntero como nulo.
}

int main(){
    int a[67];             // Declara un arreglo de 67 bytes.
    a[0] = 123;            // Declara el primer elemento como 123.
    printf(" %d\n", a[0]); // Imprime 123.
    nullify(a);            // Llama a la funcion que deje al array como NULL. Como la funcion solo modifica en el entorno local de ella, no pasa nada en el main.
    printf(" %d\n", a[0]); // Muestra 123.
    return 0;
}*/

/*int main()
{
    char *ptr = "hola mundo"; //Se declara una cadena literal. La direccion de memoria de la cadena es una sola. No es que cada tiene una distinta.
    ptr[0] = 's'; //Se intenta cambiar el primer elemento.
    printf(" %s\n", ptr); //Segmentation fault pues no se puede cambiar una cadena literal.
    return 0;
}*/