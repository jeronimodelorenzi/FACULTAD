/*
Un canal es una primitiva que permite el env´ıo de un valor entre threads.
Que sea s´ıncrono implica que no s´olo el lector espera al escritor (obviamente) sino que el escritor no
avanza hasta que haya aparecido un lector.
*/

#include "channel.h"
#include <pthread.h>
#include <stdlib.h>

void channel_init(channel_t *c) {
  c->cola = malloc(sizeof(Cola));
  c->cola->primero = 0;
  c->cola->ultimo = 0;
  pthread_mutex_init(&c->mutex, NULL);
  sem_init(&c->escritura, 0, 1);
  sem_init(&c->lectura, 0, 0);
}

void channel_destroy(channel_t *c) {
  pthread_mutex_destroy(&c->mutex);
  sem_destroy(&c->escritura);
  sem_destroy(&c->lectura);
  free(c->cola);
}

void chan_write(channel_t *c, int v) {
  sem_wait(&c->escritura);

  pthread_mutex_lock(&c->mutex);
  c->cola->buff[c->cola->ultimo] = v;
  c->cola->ultimo = (c->cola->ultimo + 1) % SZ;
  pthread_mutex_unlock(&c->mutex);

  sem_post(&c->lectura);
}
int chan_read(channel_t *c) {
  sem_wait(&c->lectura);

  pthread_mutex_lock(&c->mutex);
  int val = c->cola->buff[c->cola->primero];
  c->cola->primero = (c->cola->primero + 1) % SZ;
  pthread_mutex_unlock(&c->mutex);

  sem_post(&c->escritura);
  return val;
}