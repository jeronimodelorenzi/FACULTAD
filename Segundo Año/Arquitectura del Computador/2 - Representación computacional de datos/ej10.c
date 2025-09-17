#include <stdio.h>

int main () {
  char a = 127;
  printf("%hhd %hhu\n",a,a); // hhd -> 8 bits entero, hhu -> 8 bits unsigned
                             // tenemos entonces que el rango de valores será
                             // para los enteros [-128, 127] y para los unsigned
                             // [0, 255]
  a=++a; 
  printf("%hdd %hhu\n",a,a); // al sumarle 1 a 127 tomando enteros ocurrirá un overflow con lo
                             // cual se mostrará en pantalla -128, por parte de unsigned se mostrará
                             // 128 ya que está dentro del rango.
  unsigned char b = 128;
  printf("%hhd  %hhu\n",b,b); // mismo caso que antes
  b=++b;
  printf("%hhd %hhu\n",b,b); // muestra -127 y 129
  return 0;
}