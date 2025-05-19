#ifndef __CHANNEL_H__
#define __CHANNEL_H__

#include <semaphore.h>
#include <pthread.h>

#define SZ 8

typedef struct _Cola {
  int buff[SZ];
  int primero;
  int ultimo;
} Cola;

typedef struct _channel {
  Cola *cola;
  pthread_mutex_t mutex;
  sem_t escritura;
  sem_t lectura;
} channel_t;

void channel_init(channel_t *c);
void chan_write(channel_t *c, int v);
int chan_read(channel_t *c);
void channel_destroy(channel_t *c);


#endif