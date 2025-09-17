#include <stdio.h>

unsigned mult (unsigned a, unsigned b) {
  unsigned res = 0;
  while (b > 0) {
    if (b & 1)
      res += a;
    a <<= 1;
    b >>= 1;
  }

  return res;
}

int main (){

  unsigned a = 5;
  unsigned b = 12;

  unsigned res = mult(a, b);

  printf("La multiplicación entre %u y %u es %u\n", a, b ,res);

  return 0;
}