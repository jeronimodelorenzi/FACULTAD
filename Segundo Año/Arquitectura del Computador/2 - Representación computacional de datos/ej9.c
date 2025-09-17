#include <stdio.h>

int main () {
  int A = 200;
  int B = 300;
  int C = 500;
  int D = 400;

  int S = A * B * C * D;

  printf("Suma interpretando los datos como enteros con signo\n");
  printf("%d\n", S);

  long int A2 = 200;
  long int B2 = 300;
  long int C2 = 500;
  long int D2 = 400;

  long int S2 = A2 * B2 * C2 * D;

  printf("Suma interpretando los datos como long int\n");
  printf("%ld\n", S2);
  
  return 0;
}