#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <sys/wait.h>
#include <fcntl.h>

void fun (int n) {
  
  int fd[2];
  pipe(fd);
    
  pid_t pid = fork();
  
  if (pid < 0) {
    perror("ERROR.");
    exit(1);
  } else if (pid == 0) {

    close(fd[1]);
    
    int buff[n];

    read(fd[0], buff, sizeof(int)*n);


    for(int i = 0 ; i < n ; i++) {
        
        if(i%3 == 0 && i != 0) {
            printf("\n");
        }
        printf("%d, ",buff[i]);
    }
      
    close(fd[0]);
    exit(0);
    

  } else {
    
    close(fd[0]);

    int arr[n];
    int largo = n;
    
    // generamos una lista ordenada del 1 a n
    for(int i = 0; i <= n; i++){
        arr[i] = i;
    }

    for(int i = 0; i < largo; i++){
        int ran = rand() % largo; //da una pos random del arreglo

        // intercabio
        int temp = arr[ran];
        arr[ran] = arr[largo];
        arr[largo] = temp;
        largo--;
    }

    write(fd[1],arr,sizeof(int)*n);
    
    close(fd[1]);
    wait(NULL);
  }
}  

int main() {
  srand(time(NULL));
    fun(5);
  }

