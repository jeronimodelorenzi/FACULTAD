#include <stdio.h>
#include <unistd.h>

int main (int argc, char** argv){
  
  char* args[] = {"./pid.exe" , NULL};
  int res = 0;

  printf("Programa %s con PID:%d\n",argv[0],getpid());

  //res = execv("/bin/ls", args);
  res = execv("./pid.exe", args);

  if (res < 0){
    perror("Error");
  }
  
  return 0;
}