#include <stdio.h>
#include <math.h>

#define EXPONENTE(x) (((*(int*)&(x)) >> 23) & 0xFF)
#define FRACCION(x) (((*(int*)&(x)) & 0x7FFFFF))

int myisnan(float f) {
    unsigned int bits = *(unsigned int*)&f;
    unsigned int exp = EXPONENTE(bits);
    unsigned int frac = FRACCION(bits);
    return (exp == 0xff && frac != 0);
}

int myisnan2(float f) {
    return f != f;
}

int myisinf(float f) {
    unsigned int bits = *(unsigned int*)&f;
    unsigned int exp = EXPONENTE(f);
    unsigned int frac = FRACCION(f);

    return (exp == 0xFF && frac == 0);
}

int main () {
  float g = 0.0;
  float f = 0.0 / g;
  printf("f: %f\n", f);
  if (f == NAN)
    printf("Es NAN\n");
  if (myisnan(f))
    printf("myisNaN dice que sí\n");
  if (myisnan2(f))
    printf("myisNaN2 dice que sí\n");
  
  float f2 = 1.0 / g;
  if (f2 == INFINITY)
    printf("Es INFINITY\n");
  if (myisinf(f2))
    printf("myisinf dice que sí\n");
  
  return 0;
}