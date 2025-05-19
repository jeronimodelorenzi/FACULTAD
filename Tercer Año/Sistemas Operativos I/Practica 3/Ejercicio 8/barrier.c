/*
Una barrera para n threads tiene una ´unica operaci´on barrier_wait() que causa
que los threads se pausen hasta que todos lleguen a la barrera. Son usadas, generalmente, para asegurar
que las iteraciones de varios bucles en paralelo proceden a un mismo paso,
*/

#include "pthread.h"

#include "barrier.h"

void barrier_init(barrier_t *b, int n) {
  b->contador_threads = 0;
  b->n_threads = n;
  pthread_mutex_init(&b->mutex, NULL);
  pthread_cond_init(&b->cond, NULL);
}

void barrier_wait(barrier_t *b) {
  pthread_mutex_lock(&b->mutex);

    b->contador_threads++;

    if (b->contador_threads < b->n_threads)
      pthread_cond_wait(&b->cond, &b->mutex);
    else {
    b->contador_threads = 0;
    pthread_cond_broadcast(&b->cond);
    }

    pthread_mutex_unlock(&b->mutex);
}