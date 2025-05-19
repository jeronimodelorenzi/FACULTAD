#include "channel.h"
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define N_ITEMS 10
#define N_PRODUCTORES 3
#define N_CONSUMIDORES 3

pthread_t consumidores[N_CONSUMIDORES];
pthread_t productores[N_PRODUCTORES];

channel_t c;

void* productor (void *arg) {
  int num = arg - (void*)0;
  while(1) {
    int val = rand() % 100;
    printf("Productor %d escribiendo %d\n", num, val);
    chan_write(&c, val);
  }
  return NULL;
}

void* consumidor(void *arg) {
  int num = arg - (void*)0;
  while(1) {
    int val = chan_read(&c);
    printf("Consumidor %d leyendo %d\n", num, val);
  }
  return NULL;
}

int main () {
  channel_init(&c);
  

  for (int i = 0 ; i < N_CONSUMIDORES ; i++)
    pthread_create(&consumidores[i], NULL, consumidor, i+(void*)0);
  
  for(int i = 0 ; i < N_PRODUCTORES ; i++)
    pthread_create(&productores[i], NULL, productor, i+(void*)0);

  for (int i = 0 ; i < N_CONSUMIDORES ; i++)
    pthread_join(consumidores[i], NULL);

  for (int i = 0 ; i < N_PRODUCTORES ; i++)
    pthread_join(productores[i], NULL);

  channel_destroy(&c);

  return 0;
}
