#include <stdio.h>

unsigned int intercambiar (unsigned int x) {
  //unsigned int parteBaja = (x & 0x0000ffff);
  //unsigned int parteAlta = (x & 0xffff0000);
  //unsigned int xInvertido = (parteAlta >> 16) | (parteBaja << 16);
  //return xInvertido;
  return (x << 16) | (x >> 16);
}

int main () {
  unsigned int x = 0b11111111111111110000000000000000;
  unsigned int xInvertido = intercambiar(x);
  
  printf("x = %d, xInvertido = %d\n", x, xInvertido);

  return 0;
}