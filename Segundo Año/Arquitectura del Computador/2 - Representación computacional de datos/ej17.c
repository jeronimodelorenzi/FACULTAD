#include <stdio.h>

void rotar (int *a, int *b, int *c) {
  // a -> b
  *a = *a ^ *b;
  *b = *a ^ *b;
  *a = *a ^ *b;
  // a -> c
  *a = *a ^ *c;
  *c = *a ^ *c;
  *a = *a ^ *c;
}

int main () {
    int a = 1, b = 2, c = 3;
    printf("a = %d, b = %d, c = %d\n", a, b, c);
    rotar(&a,&b,&c);
    printf("a = %d, b = %d, c = %d\n", a, b, c);
    return 0;
}