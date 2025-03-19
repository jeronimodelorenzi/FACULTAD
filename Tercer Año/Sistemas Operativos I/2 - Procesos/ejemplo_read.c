#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main (){
  char buff[1024];
  char path[] = "./text.txt";

  int fd = open(path,O_RDONLY);
  int numRead = read(fd,buff,1024);
  buff[numRead] = '\0';
  printf("%s",buff);
  close(fd);
  
  return 0;
}