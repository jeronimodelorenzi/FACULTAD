#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

void handler_signals (int sig) {
  
  static int SIGINT_count = 0;

  if (sig == SIGQUIT) {
    printf("Manejando SIGQUIT.\n");
  } else if (sig == SIGINT) {
    SIGINT_count++;
    if (SIGINT_count == 1) {
      printf("\nManejando SIGINT.\n");
      signal(SIGINT, SIG_DFL);
    }
  }
}

int main () {
  
  signal(SIGINT,handler_signals);
  signal(SIGQUIT,handler_signals);

  printf("PID: %d\n",getpid());

  while(1);
  
  return 0;
}