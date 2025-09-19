#include <stdio.h>

#define EXPONENTE(x) (((*(int*)&(f)) >> 23) & 0xFF)
#define FRACCION(x) (((*(int*)&(f)) & 0x7FFFFF))

int main () {
  float f = -138;

  float exp = EXPONENTE(f);
  float frac = FRACCION(f);

  printf("Numero: %f\n", f);
  printf("Exponente: %f\n", exp);
  printf("Fracción: %f\n", frac);

  return 0;
}