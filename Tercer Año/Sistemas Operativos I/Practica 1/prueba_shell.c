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

int dividir_comandos (char* cadena, char* comandos[]) {
  int contador = 0;
  char* token = strtok(cadena, "|");
  while (token != NULL) {
    comandos[contador] = token;
    contador++;
    token = strtok(NULL,"|");
  }

  return contador;
}

int main (){
  
  while (1){
    
    char buff[MAX_BUFF];
    char* comandos[MAX_ARGS];
    
    printf("$ ");
    fgets(buff,1023,stdin);
    buff[strcspn(buff, "\n")] = '\0';

    if (strcmp(buff, "exit") == 0) {
      printf("Saliendo de la shell...\n");
      exit(0);
    }

    int cantComandos = dividir_comandos(buff, comandos);

    int fds[cantComandos-1][2];
    for (int i = 0 ; i < cantComandos-1; i++)
      pipe(fds[i]);

    for (int i = 0 ; i < cantComandos ; i++) {
      pid_t pid = fork();
      
      if (pid == 0) {
        
        char* args[MAX_ARGS];
        char* token = strtok(comandos[i]," ");
        cargarArgs(args, MAX_ARGS, token);

        if (i > 0) {
          dup2(fds[i-1][0],STDIN_FILENO);
        }

        if (i < cantComandos - 1) {
          dup2(fds[i][1],STDOUT_FILENO);
        }

        for (int j = 0 ; j < cantComandos - 1 ; j++) {
          close(fds[j][0]);
          close(fds[j][1]);
        }

        int ind = buscar_indice(args, ">");
        if (ind != -1 && args[ind+1] != NULL && i == cantComandos - 1) {
          int fd = open(args[ind+1], O_CREAT | O_WRONLY | O_TRUNC, 0644);
          dup2(fd,STDOUT_FILENO);
          close(fd);
          args[ind] = NULL;
        }

        int res = execvp(args[0], args);
        if(res < 0) {
          printf("El comando no existe.\n");
          exit(1);
        }
      }
    }

    for (int i = 0 ; i < cantComandos - 1 ; i++) {
        close(fds[i][0]);
        close(fds[i][1]);
    }

    for(int i = 0 ; i < cantComandos ; i++) {
        wait(NULL);
    }
  }
return 0;
}