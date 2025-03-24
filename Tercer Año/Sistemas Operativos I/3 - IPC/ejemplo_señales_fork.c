#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void handler (int sig) {
    printf("Child recibio SIGNAL.\n");
}

int main () {

  int status;

  pid_t pid = fork();

  if (pid < 0) {
    printf("Error en fork.\n");
    exit(0);
  }
  
  if (pid == 0) { // child
    signal(SIGHUP,handler);
    printf("Child esperando señal.\n");
    pause();
  } else { // parent
    sleep(1);
    printf("Parent enviando SIGNAL.\n");
    kill(pid, SIGHUP);
    wait(&status);
    printf("Fin.\n");
  }
  
  return 0;
}