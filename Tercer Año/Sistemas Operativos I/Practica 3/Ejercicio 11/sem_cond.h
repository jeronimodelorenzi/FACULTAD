#ifndef __SEM_COND_H__
#define __SEM_COND_H__

#include <pthread.h>
#include <time.h>

typedef struct _sem_cond_t {
  int value;
  pthread_mutex_t mutex;
  pthread_cond_t cond;
} sem_cond_t;

void sem_cond_init(sem_cond_t *sem, unsigned int value);
void sem_cond_wait(sem_cond_t *sem);
void sem_cond_trywait(sem_cond_t *sem);
void sem_cond_timedwait(sem_cond_t *sem, const struct timespec *abstime);
void sem_cond_post(sem_cond_t *sem);
void sem_cond_wait(sem_cond_t *sem);

#endif