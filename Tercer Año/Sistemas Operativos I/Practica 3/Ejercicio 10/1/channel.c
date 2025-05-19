/*
Un canal es una primitiva que permite el env´ıo de un valor entre threads.
Que sea s´ıncrono implica que no s´olo el lector espera al escritor (obviamente) sino que el escritor no
avanza hasta que haya aparecido un lector.
*/

#include "channel.h"
#include <pthread.h>
#include <stdlib.h>

void channel_init(channel_t *c) {
  sem_init(&c->escritura, 0, 1);
  sem_init(&c->lectura, 0, 0);
}

void channel_destroy(channel_t *c) {
  sem_destroy(&c->escritura);
  sem_destroy(&c->lectura);
}

void chan_write(channel_t *c, int v) {
  sem_wait(&c->escritura);
  c->valor = v;
  sem_post(&c->lectura);
}

int chan_read(channel_t *c) {
  sem_wait(&c->lectura);
  int val = c->valor;
  sem_post(&c->escritura);
  return val;
}