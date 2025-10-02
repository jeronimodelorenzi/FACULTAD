#include <stdio.h>
#include <ieee754.h>

#define EXPONENTE(x) (((*(int*)&(x)) >> 23) & 0xFF)
#define FRACCION(x) (((*(int*)&(x)) & 0x7FFFFF))

int main () {
  float f = -138.0f;

  float exp = EXPONENTE(f);
  float frac = FRACCION(f);

  printf("Numero: %f\n", f);
  printf("Exponente: %f\n", exp);
  printf("Fracción: %f\n", frac);

  union ieee754_float u;
  u.f = -138.0f;
  printf("Número ieee: %f\n", u.f);
  printf("Exponente ieee: %d\n", u.ieee.exponent);
  printf("Fracción ieee: %d\n", u.ieee.mantissa);

  return 0;
}