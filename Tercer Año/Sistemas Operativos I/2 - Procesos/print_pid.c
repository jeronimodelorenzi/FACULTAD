#include <stdio.h>
#include <unistd.h>

void print_pid (){
  printf("El pid de este proceso es %d\n",getpid());
}

int main(){
  print_pid();
}