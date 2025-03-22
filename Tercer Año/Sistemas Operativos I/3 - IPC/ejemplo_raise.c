#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void handler (int sig){
  if (sig == SIGCONT) {
    printf("Proceso %d reanudado.\n", getpid());
  }
}

int main () {
  
  signal(SIGCONT,handler);

  printf("Probando raise. PID: %d\n",getpid());

  raise(SIGSTOP);

  printf("Prueba completada.\n");
  
  return 0;
}