#include "sem_cond.h"

void sem_cond_init (sem_cond_t *sem, unsigned int value) {
  sem->value = value;
  pthread_mutex_init(&sem->mutex, NULL);
  pthread_cond_init(&sem->cond, NULL);
}

void sem_cond_destroy (sem_cond_t *sem) {
  pthread_mutex_destroy(&sem->mutex);
  pthread_cond_destroy(&sem->cond);
}

void sem_cond_wait (sem_cond_t *sem) {
  pthread_mutex_lock(&sem->mutex);
    while (sem->value == 0)
      pthread_cond_wait(&sem->cond, &sem->mutex);
    sem->value--;
  pthread_mutex_unlock(&sem->mutex);
}

void sem_cond_trywait (sem_cond_t *sem) {
  pthread_mutex_lock(&sem->mutex);
  if (sem->value == 0) {
    pthread_mutex_unlock(&sem->mutex);
    return;
  }
  sem->value--;
  pthread_mutex_unlock(&sem->mutex);
}

void sem_cond_timedwait(sem_cond_t *sem, const struct timespec *abstime) {
  pthread_mutex_lock(&sem->mutex);
  while (sem->value == 0) 
    pthread_cond_timedwait(&sem->cond, &sem->mutex, abstime);
  sem->value--;
  pthread_mutex_unlock(&sem->mutex);
}

void sem_cond_post(sem_cond_t *sem) {
  pthread_mutex_lock(&sem->mutex);
    sem->value++;
    pthread_cond_broadcast(&sem->cond);
  pthread_mutex_unlock(&sem->mutex);
}
