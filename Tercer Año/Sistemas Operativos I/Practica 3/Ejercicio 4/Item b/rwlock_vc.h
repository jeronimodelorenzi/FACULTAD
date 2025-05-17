#ifndef __RWLOCK_VC_H__
#define __RWLOCK_VC_H__

#include <pthread.h>

typedef struct _rwlock_t {
  pthread_mutex_t mutex;
  pthread_cond_t lectores;
  pthread_cond_t escritores;
  int cant_lectores, cant_escritores, escritores_esperando;
} rwlock_t;

/**
 * Inicializa los valores de la estructura rwlock_t.
 */
void rwlock_init (rwlock_t *rw);

/**
 * Lock a lectores.
 */
void rwlock_rlock (rwlock_t *rw);

/**
 * Unlock a lectores.
 */
void rwlock_runlock (rwlock_t *rw);

/**
 * Lock a escritores. 
 */
void rwlock_wlock (rwlock_t *rw);

/**
 * Unlock a escritores.
 */
void rwlock_wunlock (rwlock_t *rw);

/**
 * Destruye la estructura rwlock_t.
 */

void rwlock_destroy (rwlock_t *rw);

#endif