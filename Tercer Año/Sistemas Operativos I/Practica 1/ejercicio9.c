#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

void INThandler(int);

int main(void) {
  signal(SIGINT, INThandler);
  while (1)
      sleep(10);
}

void INThandler(int sig) {
  char c;
  signal(SIGINT,INThandler);
  printf("\nOUCH, did you hit Ctrl-C?\n"
         "Do you really want to quit? [y/n] ");
  c = getchar();
  if (c == 'y' || c == 'Y')
      exit(0);
  else
      signal(SIGCONT, INThandler);
  getchar();
}
