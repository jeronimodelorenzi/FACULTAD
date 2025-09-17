#include <stdio.h>

int is_one (long n, int b) {
  int cond = 0;
  if (n & (1 << b))
    cond = 1;
  return cond;
}

void printbin (long n) {
  for (int i = 31 ; i >= 0 ; i--)
    printf("%d", is_one(n, i));
  puts("");
}

int main () {
  
  long n = 255;
  printbin(n);
  
  return 0;
}