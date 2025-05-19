#ifndef __BARRIER_H__
#define __BARRIER_H__

#include <pthread.h>

typedef struct _barrier_t {
  int contador_threads;
  int n_threads;
  pthread_mutex_t mutex;
  pthread_cond_t cond;
} barrier_t;

void barrier_init(barrier_t *b, int n);
void barrier_wait(barrier_t *b);

#endif