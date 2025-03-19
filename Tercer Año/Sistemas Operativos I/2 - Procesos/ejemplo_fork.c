#include <stdio.h>
#include <unistd.h>

int main (){

  int eleccion;
  printf("1 v 2: ");
  scanf("%d", &eleccion);

  switch (eleccion){
    case 1:
      pid_t pid;

    pid = fork();
  
    if (pid < 0){
      perror("Error");
    }
  
    printf("PID proceso: %d\n",getpid());
  
    if (pid == 0){
      printf("PID proceso child: %d\n",getpid());
    } else {
      printf("PID proceso parent: %d, PID proceso child : %d\n",getpid(),pid);
    }
    break;

    case 2:
      pid_t pid1 = fork();                              //                       P1
      pid_t pid2 = fork();                              //                      fork()
      printf("pid1: %d pid2: %d!\n", pid1, pid2);       //       P1-fork()                  C1-fork()
                                                        //P1-printf     C11-printf   C1-printf     c12-printf
      break;
    default:
      break;
  }

  return 0;
}