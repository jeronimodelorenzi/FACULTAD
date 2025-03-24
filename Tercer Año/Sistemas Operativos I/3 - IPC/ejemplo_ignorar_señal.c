#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

int main () {
    
    signal(SIGTSTP, SIG_IGN);

    printf("Ejecutando... PID: %d\n",getpid());
    raise(SIGTSTP);

    printf("Señal ignorada...\n");

    return 0;
}