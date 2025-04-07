#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <fcntl.h>

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

int buscar_indice (char* args[], const char* elemento) {
  int bandera = -1;
  for (int i = 0 ; args[i] != NULL && bandera < 0; i++)
    if (strcmp(args[i], elemento) == 0)
      bandera = i;
  return bandera;
}

int buscar_pipes (char* args[], int pos[], int tam) {
  int cantidad = 0;
  for (int i = 0 ; i < tam ; i++) {
    if (args[i] != NULL && strcmp(args[i], "|") == 0) {
      pos[cantidad] = i;
      cantidad++;
      args[i] = NULL;
    }
  }
  return cantidad;
}

int main (){

  int res = 0;
  
  while (1){
    
    char buff[MAX_BUFF];
    char* args[MAX_ARGS];
    
    printf("-> ");
    char* comando = fgets(buff,1023,stdin);
    buff[strcspn(buff, "\n")] = '\0';
    char* token = strtok(buff," ");
    cargarArgs(args, MAX_ARGS, token);

    if (strcmp(args[0], "exit") == 0) {
        printf("Saliendo de la shell...\n");
        exit(0);
    }

    pid_t pid = fork();

    if (pid < 0){
      perror("Error.");
      exit(1);
    } else if (pid == 0) {

      int ind = buscar_indice(args, ">");
      
      if (ind != -1 && args[ind + 1] != NULL) {
        int fd = open(args[ind+1] , O_CREAT | O_WRONLY | O_TRUNC, 0644);
        int dupFd = dup2(fd, STDOUT_FILENO);
        close(fd);
        args[ind] = NULL;
      }

      res = execvp(args[0], args);
      
      if (res < 0){
        printf("El comando es inexistente.\n");
        exit(1); 
      }
    }
      
    wait(NULL);
  }

  return 0;
}