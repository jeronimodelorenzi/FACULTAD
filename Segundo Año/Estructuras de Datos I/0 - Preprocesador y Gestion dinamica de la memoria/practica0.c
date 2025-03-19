#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

// Ejercicio 1

/*int main () {
  int a = 2;
  int b[] = {1,2,3};
  char c = 'a';
  char d[] = {'h','o','l','a'};

  printf("dir a: %p\ndir b: %p\ndir c: %p\n",&a,&b,&c);

  for (int i = 0 ; i<4 ; i++){
    printf("dir d[%d]: %p\n",i,&d[i]);
  }

  return 0;
}*/

// Ejercicio 2

/*void set_first (int a[]){
  a[0] = 0;
}

int main(){
  int a[] = {1,2,3,4,5,6};
  printf("Antes de llamar a set_first: a[0] = %d\n",a[0]);
  set_first(a);
  printf("Despues de llamar a set_first: a[0] = %d\n",a[0]);

  return 0;
}*/

// Ejercicio 3

/*void set_in (int *a){
  if (*a != 0){
    *a = 1;
  }
}

int main(){
  int a;
  printf("Ingrese un entero: ");
  scanf("%d",&a);
  printf("Valor del entero: %d\n",a);
  set_in(&a);
  printf("Valor del entero al aplicar set_in: %d\n",a);
  return 0;
}*/

// Ejercicio 4

/*void swap(int *a, int *b){
  int buff = *a;
  *a = *b;
  *b = buff;
}

int main (){
  int a,b;
  printf("Ingrese dos enteros: ");
  scanf("%d %d",&a,&b);
  printf("a = %d, b = %d\n",a,b);
  swap(&a,&b);
  printf("Aplicando swap, a = %d, b = %d\n", a,b);
  return 0;
}*/

// Ejercicio 6

/*char *get_new_line (){
  char* str = malloc(sizeof(char)*100);
  printf("Ingrese una cadena: ");
  fgets(str,100,stdin);
  str[strcspn(str, "\n")] = '\0';
  return str;
}

int main (){
  char* str = get_new_line();
  printf("Cadena: %s\n",str);
  printf("Direccion: %p\n",str);
  free(str);
  return 0;
}*/

// Ejercicio 8

/*int sucesor (int n) {
  return n+1;
}

void imprimir (int n) {
  printf("%d \n", n);
}

int apply (int (*fun)(int), int x){
  return fun(x);
}

void apply_in (int (*fun)(int), int* x){
  *x = fun(*x);
}

typedef void (*VisitorFunc)(int);

void recorre (VisitorFunc fun, int a[], int l){
  for (int i = 0; i<l;i++){
    fun(a[i]);
  }  
}

int main (){
  // apply
  int a;
  printf("Ingrese un enteros: ");
  scanf("%d",&a);
  printf("a = %d\n",a);
  int suc = apply(sucesor,a);
  printf("Aplicando, a = %d\n\n",suc);
  
  // apply_in
  printf("a = %d\n",a);
  apply_in(sucesor,&a);
  printf("Aplicando, a = %d\n",a);

  //recorre
  int arr[] = {1,2,3};
  recorre(imprimir,arr,3);

  return 0;
}*/

// Ejercicio 9

/* a 
int main () {
  int* punt ; // Declaramos puntero a entero.
  int x = 7 , y = 5; // Declaramos dos enteros x = 7, y = 5.
  punt = &x ; // Indica que el puntero debe apuntar a la direccion de memoria de x.
  *punt = 4; // Modifica el valor almacenado en la direccion de memoria apuntada por punt a 4.
  printf ("%d %d",x,y) ; // Muestra en pantalla 4 y 5.
return 0;
}*/

/*b
int main () {
  int* punt ; // Declaramos puntero a entero.
  int x = 7 , y = 5; // Declaramos dos enteros, x = 7, y = 5.
  punt = &x ; // Indica que el puntero debe apuntar a la direccion de memoria de x.
  x = 4; // Cambiamos el valor de la variable x por 4.
  punt = &y; // Indica que el puntero debe apuntar a la direccion de memoria de y. 
  printf ("%d %d", *punt , x) ; // Muestra en pantalla 5,4
  return 0;
}*/

/*c
int main () {
  int* punt , i ; // Declaramos puntero a entero y un entero.
  int x[] = {1 , 2 , 3 , 4 , 5}; // Declaramos un array de enteros de 5 elementos.
  punt = x ; // Indica que el puntero debe apuntar al primer elemento del array, en este caso al 5.
  *punt = 9; // Cambiamos el valor almacenado en la direccion de memoria apuntada por el puntero, es decir, el primer elemento de x por 9
  for ( i = 0; i < 5; i ++)
    printf ("%d,", x[i]); // Iteramos y mostramos en pantalla los valores. Muestra 9,2,3,4,5
  return 0;
}*/

/*d
int main () {
  int *punt , i ; // Declaramos puntero a entero y un entero.
  int x[5] = {1 , 2 , 3 , 4 , 5}; // Declaramos un array de enteros de 5 elementos.
  punt = &x[0]+3; // Indica que el puntero debe apuntar a la direccion de memoria del primer elemento mas tres lugares, es decir, el cuarto elemento.
  *(punt-2) = 9; // Movemos el puntero dos direcciones de memoria hacia atras y cambiamos el valor almacenado por 9, el elemento 2 es 9 ahora.
  punt--; // Apuntamos el puntero una direccion de memoria atras de la indicada, es decir, ahora estamos en el tercer elemento.
  *(punt) = 7; // Cambiamos el valor almacenado en la direccion de memoria por el numero 7. 
  punt[1] = 11; // Cambiamos el valor de la posicion de memoria a la derecha de donde estamos situados por 11. En este caso la posicion es la cuarta y pasa a ser 11
  punt = x; // Volvemos a apuntar a la direccion de memoria del primer elemento.
  for( i = 0; i < 5; i ++)
  printf ("%d,", punt[i]); // Mostramos en pantalla 1,9,7,11,5.
  return 0;
}
*/

/*e
void aumentar_punteros (int * x , int * y , int z ) { // Funcion que no retorna nada y toma como argumentos dos punteros a enteros y un entero.
  *x = *x + 2; // Al valor almacenado en la posicion de memoria x le sumamos 2.
  *y = *y + 5; // Al valor almacenado en la posicion de memoria y le sumamos 5.
  z = z + 4; // A la variable z le sumamos 4.
}

int main () {
  int x , y , z ; // Declaramos 3 enteros.
  x = 3; 
  y = 10;
  z = 15;
  aumentar_punteros(&x , &y , z ) ; // Llama a la funcion aumentar, esta va a acceder a las direcciones de memoria de x e y, modificara sus valores. Tenemos x = 5, y = 15, z = 15, 
                                    // ya que la variable z que recibe aumentar_punteros es una copia.
  return 0;
}*/

/*f
int* direccion_local (int x) { // Funcion que retorna un puntero a entero y recibe como argumento un entero.
  return &x; // Esto es un error pues se esta retornando la direccion de memoria de una variable local de la funcion, que luego de su ejecuccion deja de existir.
}

int main () {
  int* ptr = NULL; 
  ptr = direccion_local(2); 
  printf ("%d\n", *ptr);
  return 0;
}*/

/*g
int main () {
  char textoA [30] = "Agarrate Catalina"; // Declaramos un string.
  char textoB [30] = "El Cuarteto de Nos"; // Declaramos otro string.
  char *p = textoA; // Declaramos un puntero a caracter que apunta a la direccion de memoria del primer elemento del string.
  char *q = textoB; // Declaramos otro puntero a caracter que apunta a la direccion de memoria del primer elemento del string.
  printf ("textoA: %s\ntextoB: %s\n", textoA , textoB ) ; // Muestra en pantalla ambos string.
  while (*p++ = *q++) // Cambiamos los valores siguientes de las direccionnes de memoria apuntadas por el puntero p por los valores de las direcciones de memoria del puntero q. Esto se hace hasta que p = NULL.
    ; // Estamos copiando los string.
  printf ("while (*p++ = *q++) ;\n") ;
  printf ("textoA : %s\ntextoB : %s\n", textoA , textoB ) ; // Muestra El Cuarteto de Nos El Cuartetode Nos.
  return 0;
}*/

// Ejercicio 10

/*char * copiar_cadena ( char * cad , int longitud ) { // Funcion que toma como parametros un puntero a caracter y un entero y retorna un puntero a caracter. Toma una cadena de caracteres y su longitud y retorna una cadena.
  char* a = malloc(sizeof(char) * longitud ) ; // Pedimos memoria dinamica mediante el malloc.
  a = cad; // Al puntero a le indicamos que apunte a la direccion de memoria del primer elemento de la cadena. Perdemos la memoria dinamica pedida.
  return a; // Retornamos la cadena.
}

int main () {
  char a [10] = "hola"; // Definimos una cadena de caractares.
  char * b = copiar_cadena (a , 10) ; // Copiamos la cadena de caracteres en un puntero b.
  printf ("%s %s\n", a , b ) ; // Mostramos la cadena y la cadena copiada, tenemos hola hola.
  b [0] = 's'; // Cambiamos el primer elemento de la cadena copiada por s,
  printf ("%s %s\n", a , b ) ; // Mostramos la cadena y la cadena copiada modificada, tenemos sola sola.
  // No se libera memoria.
  return 0;
}*/

// Ejercicio 11

/*a
void nullify ( int* a ) { // Declaramos una funcion que toma como valor un puntero a entero y no retorna nada
  a = NULL ; // Declara el puntero como nulo.
}

int main () {
  int a[67]; // Declaramos un array de tamaño 67.
  a[0] = 123; // El primer elemento del array es 123.
  printf("%d\n", a[0]) ; // Mostramos en pantalla 123.
  nullify(a);  // Aplicamos la funcion nullify, como la funcion modifica en un entorno local, no ocurre nada.
  printf("%d\n", a[0]) ; // Mostramos en pantalla el primer elemento, nuevamente 123.
  // Muestra 123 123.
  return 0;
}*/

/*b*/
/*int main () {
  char * ptr = "hola mundo";//Se declara una cadena literal. La direccion de memoria de la cadena es una sola. No es que cada elemento tiene una direccion distinta.
    ptr[0] = 's'; //Se intenta cambiar el primer elemento.
    printf(" %s\n", ptr); //Segmentation fault pues no se puede cambiar una cadena literal.
    return 0;
}*/

// Ejercicio 12

/*typedef struct{
  double x;
  double y;
} Punto;

Punto medio(Punto p1, Punto p2){
  Punto pMedio;
  pMedio.x = (p1.x + p2.x)/2;
  pMedio.y = (p1.y + p2.y)/2;
  return pMedio;
}

int main (){
  Punto p1;
  Punto p2;

  printf("Ingrese la posicion x e y del punto 1: ");
  scanf("%lf%lf",&p1.x,&p1.y);
  printf("Ingrese la posicion x e y del punto 2: ");
  scanf("%lf%lf",&p2.x,&p2.y);

  Punto pMedio = medio(p1,p2);
  
  printf("Punto 1: (%lf,%lf)\n",p1.x,p1.y);
  printf("Punto 2: (%lf,%lf)\n",p2.x,p2.y);
  printf("Punto medio: (%lf,%lf)\n",pMedio.x,pMedio.y);

  return 0;
}*/

// Ejercicio 13

/*typedef enum {
  ORO, BASTO, COPA, ESPADA
} Palo;

typedef struct {
  Palo palo;
  int numero;
} Carta;

typedef struct {
    Carta carta[48];
} Mazo;

void llenar(Mazo* mazo){
  int i = 0;
  for (int palo = ORO ; palo <= ESPADA ; palo++){
    for(int num = 1 ; num <= 12 ; num++){
      mazo->carta[i].palo = (Palo)palo;
      mazo->carta[i].numero = num;
      i++;
    }
  }
}

Carta azar (Mazo* mazo){
  int i = rand() % 48;
  return mazo->carta[i];
}

int main (){
  srand(time(NULL));
  
  Mazo mazo;
  llenar(&mazo);
  
  Carta cartaAzar = azar(&mazo);
  
  const char* palos[] = {"ORO", "BASTO", "COPA", "ESPADA"};

  printf("%d de %s\n", cartaAzar.numero, palos[cartaAzar.palo]);

  return 0;
}*/

// Ejercicio 14

/*typedef struct {
  char* nombre;
  int telefono;
  int edad;
} Contacto;

typedef struct {
    Contacto contactos[20];
    int cantidad;
} Agenda;

char *get_new_line (){
  char* str = malloc(sizeof(char)*20);
  printf("Ingrese el nombre del contacto: ");
  fgets(str,20,stdin);
  str[strcspn(str, "\n")] = '\0';
  return str;
}

Contacto crear_contacto (){
  Contacto contacto;
  contacto.nombre = get_new_line();
  
  printf("Ingrese el telefono: ");
  scanf("%d",&contacto.telefono);
  
  printf("Ingrese la edad del contacto: ");
  scanf("%d",&contacto.edad);
  while(contacto.edad < 0){
    printf("Ingrese correctamente la edad: ");
    scanf("%d",&contacto.edad);
  }

  return contacto;
}

void actualizar_edad (Contacto* contacto){
  printf("Ingrese una nueva edad: ");
  scanf("%d",&contacto->edad);
  while(contacto->edad < 0){
    printf("Ingrese correctamente la edad: ");
    scanf("%d",&contacto->edad);
  }
}

void alta_contacto(Agenda* agenda){
    agenda->contactos[agenda->cantidad] = crear_contacto();
    
}

int main (){
  Contacto contacto = crear_contacto();

  printf("Nombre: %s, Edad: %d, Telefono %d\n",contacto.nombre,contacto.edad,contacto.telefono);
  
  actualizar_edad(&contacto);

  printf("Nombre: %s, Edad: %d, Telefono %d\n",contacto.nombre,contacto.edad,contacto.telefono);

  return 0;
}*/

// Ejercicio 15

/*struct pack3 {
  int a ;
};

struct pack2 {
  int b ;
  struct pack3 * next ;
};

struct pack1 {
  int c ;
  struct pack2 * next ;
};

int main () {
  struct pack1 data1 , *dataPtr ;
  struct pack2 data2 ;
  struct pack3 data3 ;
  data1.c = 30;
  data2.b = 20;
  data3.a = 10;
  dataPtr = &data1 ;
  data1.next = &data2 ;
  data2.next = &data3 ;
  return 0;
}*/

//data1.c | Correcta | Valor = 30 
//dataPtr->c | Correcta | Valor = 30
//dataPtr.c | Incorrecta | Valor = X
//data1.next->b | Correcta | Valor = 20
//dataPtr->next->b | Correcta | Valor = 20
//dataPtr.next.b | Incorrecta | Valor = X
//dataPtr->next.b | Incorrecta | Valor = X
//(*(dataPtr->next)).b | Correcta | Valor = 20
//data1.next->next->a | Correcta | Valor = 10
//dataPtr->next->next.a | Incorrecta | Valor = X
//dataPtr->next->next->a | Correcta | Valor = 10
//dataPtr->next->a | Incorrecta | Valor = X
//dataPtr->next->next->b | Incorrecta | Valor = X