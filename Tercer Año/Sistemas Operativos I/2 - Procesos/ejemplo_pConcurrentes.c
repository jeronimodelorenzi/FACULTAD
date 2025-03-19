#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main (){
  
  int tiempo = 2;
  char* args[] = {"/bin/ls", NULL};

  while (1){
    pid_t pid = fork();
    if (pid < 0){
      perror("Error");
    } else if (pid == 0){
      execv("/bin/ls",args);
      printf("PID child: %d\n",getpid());
      perror("Error en execl");
      exit(1);
    } else {
        sleep(tiempo);
    }
  }

  return 0;
}