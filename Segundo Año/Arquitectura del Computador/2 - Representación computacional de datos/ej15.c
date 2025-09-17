#include <stdio.h>

int is_one (long n, int b) {
  int cond = 0;
  if (n & (1 << b))
    cond = 1;
  return cond;
}

int main () {
  
  long n= 0b11111001;
  printf("Valor de n = %ld\n", n);
  int b = 2;

  int resultado = is_one(n, b);
  if (resultado)
    printf("El bit %d del entero %ld es 1\n", b, n);
  else
    printf("El bit %d del entero %ld no es 1\n", b, n);

  return 0;
}