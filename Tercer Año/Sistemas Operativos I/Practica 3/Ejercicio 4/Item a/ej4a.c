/*
El problema de los lectores y escritores consiste en M hilos
lectores y N escritores tratando de acceder a un arreglo en memoria compartida con las siguientes
restricciones:
No puede haber un lector accediendo al arreglo al mismo tiempo que un escritor.
Varios lectores pueden acceder al arreglo simult´aneamente.
S´olo puede haber un escritor a la vez.

La soluci´on a este problema es esencialmente un read-write lock. Los siguientes apartados piden implementar
distintas variantes. Las mismas deben ser reusables: el read-write lock no debe estar atado de ninguna
forma a este problema en particular (e.g. no debe saber las cantidades de escritores y lectores, ni asumir
que un proceso es siempre lector o siempre escritor). Organice su respuesta separando claramente la
implementaci´on del lock de su uso en el problema (idealmente en archivos separados). La interfaz deber´ıa
ser similar a la ofrecida por los mutex de pthread.
*/

/*
a) Implemente una soluci´on y expl´ıquela. Para este apartado, siempre que el lock est´e tomado por un
lector y aparezca un segundo lector, el segundo debe poder entrar inmediatamente (read-preferring). 
*/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include "rwlock_vc.h"

#define M 5
#define N 5
#define ARRLEN 10240

int arr[ARRLEN];

rwlock_t rw;

void *escritor(void *arg) {
  int i;
  int num = arg - (void *)0;

  while (1) {
    sleep(rand() % 3);

    rwlock_wlock(&rw);
    printf("Escritor %d escribiendo\n", num);
    for (i = 0; i < ARRLEN; i++)
      arr[i] = num;
    printf("Escritor %d termino\n", num);
    rwlock_wunlock(&rw);
  }
  
  return NULL;
}

void *lector(void *arg) {
  int v, i;
  int num = arg - (void *)0;

  while (1) {
    sleep(rand() % 3);

    rwlock_rlock(&rw);
    v = arr[0];
    for (i = 1; i < ARRLEN; i++) {
      if (arr[i] != v)
        break;
    }
    if (i < ARRLEN)
      printf("Lector %d, error de lectura\n", num);
    else
      printf("Lector %d, dato %d\n", num, v);
    rwlock_runlock(&rw);
  }
  return NULL;
}

int main() {
  pthread_t lectores[M], escritores[N];
  int i;

  rwlock_init(&rw);

  for (i = 0; i < M; i++)
    pthread_create(&lectores[i], NULL, lector, i + (void *)0);
  for (i = 0; i < N; i++)
    pthread_create(&escritores[i], NULL, escritor, i + (void *)0);

  pthread_join(lectores[0], NULL); /* Espera para siempre */
  rwlock_destroy(&rw);
  
  return 0;
}