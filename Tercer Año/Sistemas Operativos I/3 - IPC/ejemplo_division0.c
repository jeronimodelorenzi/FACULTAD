#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void handler(int sig) {
  printf("Estas intentando realizar una division por 0.\n");
  exit(1);
}


int main () {
  int a = 1,b = 0;

  signal(SIGFPE, handler);

  int division = a / b;

  return 0;
}