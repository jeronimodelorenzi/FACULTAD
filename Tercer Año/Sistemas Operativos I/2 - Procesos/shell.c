#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

#define MAX_ARGS 10
#define MAX_BUFF 1024

void cargarArgs(char* args[], int tam, char* token) {
    int i = 0;
    while (token != NULL && i < tam - 1) {
        args[i++] = token;
        token = strtok(NULL, " ");
    }
    args[i] = NULL;
}


int main (){

  int status;
  int res = 0;
  
  while (1){
    
    char buff[MAX_BUFF];
    char* args[MAX_ARGS];
    

    printf("->");
    char* comando = fgets(buff,1023,stdin);
    buff[strcspn(buff, "\n")] = '\0';
    char* token = strtok(buff," ");
    cargarArgs(args,MAX_ARGS,token);

    if (strcmp(args[0], "exit") == 0) {
        printf("Saliendo de la shell...\n");
        break;
    }

    pid_t pid = fork();

    if (pid < 0){
      perror("Error");
      exit(1);
    } else if (pid == 0){
      res = execvp(args[0],args);
      if(res < 0){
        printf("El comando es inexistente\n");
      }
    } else {
        wait(&status);
    }

  }

  return 0;
}