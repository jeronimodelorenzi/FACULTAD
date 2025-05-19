#include "channel.h"
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define N_ITEMS 10

pthread_t consu;
pthread_t produc;

channel_t c;

void* productor (void *arg) {
  int num = arg - (void*)0;
  for (int i = 0 ; i < N_ITEMS ; i++) {
    int val = rand() % 100;
    printf("Productor %d escribiendo %d\n", num, val);
    chan_write(&c, val);
  }
  return NULL;
}

void* consumidor(void *arg) {
  int num = arg - (void*)0;
  for (int i = 0 ; i < N_ITEMS ; i++) {
    int val = chan_read(&c);
    printf("Consumidor %d leyendo %d\n", num, val);
  }
  return NULL;
}

int main () {
  channel_init(&c);
  
  pthread_create(&consu, NULL, consumidor, (void*)1);
  pthread_create(&produc, NULL, productor, (void*)1);

  pthread_join(consu, NULL);
  pthread_join(produc, NULL);

  channel_destroy(&c);

  return 0;
}
