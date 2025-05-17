#include <pthread.h>

#include "rwlock_vc.h"

void rwlock_init (rwlock_t *rw) {
    pthread_mutex_init(&rw->mutex, NULL);
    pthread_cond_init(&rw->lectores, NULL);
    pthread_cond_init(&rw->escritores, NULL);
    rw->cant_escritores = 0;
    rw->cant_lectores = 0;
    rw->escritores_esperando = 0;
    rw->lectores_esperando = 0;
  }
  
void rwlock_rlock (rwlock_t *rw) {
  pthread_mutex_lock(&rw->mutex);
  rw->lectores_esperando++;
  while(rw->cant_escritores || rw->escritores_esperando)
    pthread_cond_wait(&rw->lectores, &rw->mutex);
  rw->lectores_esperando--;
  rw->cant_lectores++;
  pthread_mutex_unlock(&rw->mutex);
}

void rwlock_runlock (rwlock_t *rw) {
  pthread_mutex_lock(&rw->mutex);
  rw->cant_lectores--;
  if (rw->cant_lectores == 0 && rw->escritores_esperando)
      pthread_cond_signal(&rw->escritores);

  pthread_mutex_unlock(&rw->mutex);
}

void rwlock_wlock (rwlock_t *rw) {
  pthread_mutex_lock(&rw->mutex);
  rw->escritores_esperando++;
  while(rw->cant_lectores || rw->cant_escritores)
    pthread_cond_wait(&rw->escritores, &rw->mutex);
  rw->escritores_esperando--;
  rw->cant_escritores = 1;
  pthread_mutex_unlock(&rw->mutex);
}

void rwlock_wunlock (rwlock_t *rw) {
  pthread_mutex_lock(&rw->mutex);
  rw->cant_escritores = 0;

  if(rw->escritores_esperando)
    pthread_cond_signal(&rw->escritores);
  else
    pthread_cond_broadcast(&rw->lectores);
  pthread_mutex_unlock(&rw->mutex);
}

void rwlock_destroy (rwlock_t *rw) {
  pthread_mutex_destroy(&rw->mutex);
  pthread_cond_destroy(&rw->escritores);
  pthread_cond_destroy(&rw->lectores);
}
