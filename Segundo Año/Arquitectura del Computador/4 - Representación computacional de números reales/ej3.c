#include <stdio.h>
#include <ieee754.h>

#define EXPONENTE(x) (((*(int*)&(x)) >> 23) & 0xFF)
#define FRACCION(x) (((*(int*)&(x)) & 0x7FFFFF))

int is_one (long n, int b) {
  int cond = 0;
  if (n & (1 << b))
    cond = 1;
  return cond;
}
  
void printbin (long n, int bits) {
  switch (bits)
  {
  case 32:
    for (int i = 31 ; i >= 0 ; i--)
      printf("%d", is_one(n, i));
    puts("");
    break;
  case 64:
    for (int i = 63 ; i >= 0 ; i--)
      printf("%d", is_one(n, i));
    puts("");
  default:
  printf("Numero de bits ingresados incorrecto\n");
    break;
  }
}

int main () {
  float f = 6.225f;
  double d = 6.225;

  printf("Float 32 bits: %f", f);
  printf("Bits: ");
  float


}