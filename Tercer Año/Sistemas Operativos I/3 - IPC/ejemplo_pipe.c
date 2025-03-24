#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

#define BUFFER_SIZE 20

int main () {

  int status;
  char msg[] = "Hola, probando, 1 2 3";
  char buffer[BUFFER_SIZE];
  int fd[2]; // fd[0] lectura - fd[1] escritura

  pipe(fd);
  pid_t pid = fork ();
  
  if (pid < 0) {
    printf("Error");
    exit(0);
  } else if (pid == 0) {
    close(fd[1]);
    printf("Child leyendo.\n");

    while(read(fd[0],&buffer,1)>0){
      write(STDOUT_FILENO,&buffer,1);
    }
    
    printf("\nChild finalizo.\n");
    close(fd[0]);

  } else {
    close(fd[0]);
    printf("Parent escribiendo.\n");
    
    write(fd[1],msg,strlen(msg));
    close(fd[1]);
    
    wait(&status);
    printf("Parent termino.\n");
  }

  return 0;
}