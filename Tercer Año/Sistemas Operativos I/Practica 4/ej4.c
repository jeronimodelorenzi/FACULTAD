/*
Escriba utilizando OpenMP una funci´on que verifique si un entero es primo
(buscando divisores entre 2 y √N ). Su soluci´on deber´ıa andar igual o m´as r´apido que una versi´on secuencial
que “corta” apenas encuentra un divisor. Escriba su funci´on para tomar un long, i.e. un entero de 64
bits1, y aseg´urese de probarla con n´umeros grandes (incluyendo primos, semiprimos, y pares).
*/

#include <stdio.h>
#include <omp.h>
#include <math.h>
#include "timing.h"

// int es_primo (long int n) {
//   int primo = 1;
//   long int limite = (long int)sqrt(n);
//   #pragma omp parallel for shared(primo)
//   for (long int i = 2 ; i <= limite ; i++) {
    
//       if (n % i == 0){ 
//         primo = 0;
//       }
//     }
//   return primo;
// }

int es_primo (long int n) {
  int primo = 1;
  long int limite = (long int)sqrt(n);
  for (long int i = 2 ; i <= limite && primo == 1 ; i++)
    if (n % i == 0)
      primo = 0;
  return primo;
}

int main () {

  long int n = 982451653;
  int primo = es_primo(n);

  if (primo)
    printf("El número %ld es primo\n", n);
  else
    printf("El numero %ld no es primo\n",n);

  float fv;
  TIME_void(es_primo(n), &fv);


  return 0;
}