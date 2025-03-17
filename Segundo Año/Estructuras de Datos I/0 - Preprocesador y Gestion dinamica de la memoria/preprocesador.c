#include <stdio.h>


// Ejercicios preprocesador

// Ejercicio 1

/*
#define YES 1 // constante YES = 1
#define NO 0 // constante NO = 0
#line 3000 "preprocesador.c" // cambiamos comienzo de linea a 3000 en p

#if defined(TRUE) // si esta definida la constante TRUE
#undef TRUE // la eliminamos
#define TRUE 1 // luego, definimos nuestra constante TRUE y le asignamos 1
#endif // cerramos el condicional


#undef TRUE // la eliminamos
#define TRUE 1 // luego, definimos nuestra constante TRUE y le asignamos 1

#if TRUE // si la constante TRUE es igual a 1
#define FALSE 0 // definimos false como 0
#else  // si no
#define FALSE 1 // definimos false como 1
#endif // cerramos el condicional

#define SQUARE_VOLUMEN(x) (x)*(x)*(x)

int main(){
  printf("YES: %d - NO: %d - TRUE: %d - FALSE: %d\n", YES,NO,TRUE,FALSE);
  int sq_vol = SQUARE_VOLUMEN(2);
  printf("El volumen es: %d\n", sq_vol);
    
  return 0;
    }
*/

// Ejercicio 2

/*
#define PI 3.14159
#define ESFERA_VOL(r) (4.0)/3 * PI * (r) * (r) * (r)

int main () {

  float esf_vol;

  for (int i = 1;i<= 10 ; i++) {
      esf_vol = ESFERA_VOL(i);
      printf("Volumen esfera de radio %d es %lf\t", i, esf_vol);
  }

  return 0;
}
*/

// Ejercicio 3

/*
#define SUM(x,y) printf("La suma de %d y %d es %d\n",x,y,(x)+(y))

int main () {
  SUM(6,7);
}
*/

// Ejercicio 4

/*
#define MININUM2(x,y) (((x)<(y)) ? (x) : (y))

int main () {
  int n,m;
  printf("Ingrese un numero: ");
  scanf("%d",&n);
  printf("Ingrese otro numero: ");
  scanf("%d",&m);
  int min = MININUM2(n,m);
  printf("El minimo entre %d y %d es %d\n",n,m,min);
 
  return 0;
}
*/

// Ejercicio 5

/*
#define MININUM2(x,y) (((x)<(y)) ? (x) : (y))
#define MININUM3(x,y,z) (((x) < MININUM2(y,z)) ? (x) : (MININUM2(y,z)))

int main (){
  int n,m,p;
  printf("Ingrese un numero: ");
  scanf("%d",&n);
  printf("Ingrese otro numero: ");
  scanf("%d",&m);
  printf("Ingrese un ultimo numero: ");
  scanf("%d", &p);
  int min = MININUM3(n,m,p);
  printf("El minimo entre %d, %d y %d es %d\n",n,m,p,min);  
  
  return 0;
}*/

// Ejercicio 6

/*
#define PRINT(x) printf("%s\n",x);

int main (){
  char s[100];
  printf("Ingrese una cadena: ");
  fgets(s,sizeof(s),stdin);
  PRINT(s);

  return 0;
}*/

// Ejercicio 7

/*
#define PRINTARRAY(a,e) for(int i = 0 ; i<e ; i++){ printf("Elemento %d - %d\n", i+1, a[i]); }

int main () {
  int arr[] = {1, 2, 3, 4, 5};
  PRINTARRAY(arr,5);
  return 0;
}*/

// Ejercicio 8

#define SUMARRAY(a,e) ({int sum=0;for(int i=0;i<(e);i++){sum+=(a)[i];}sum;})

int main (){
  int arr[] = {1,2,3,4,5};
  int sumArray = SUMARRAY(arr,5);
  printf("La suma del array es %d\n",sumArray);

  return 0;
}