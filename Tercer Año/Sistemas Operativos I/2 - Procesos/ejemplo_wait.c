#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main (){
  int status;
  pid_t pid = fork();

  if (pid < 0){
    perror("Error:");
  } else if (pid == 0){ //child
    printf("PID child: %d\n",getpid());
    sleep(2);
    printf("Child terminado\n");
  } else { //parent
    printf("PID parent: %d\n",getpid());
    wait(&status);
    printf("Estado child: %d\n",status);
  }
  
  return 0;
}