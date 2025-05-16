/*
En un sistema, hay M procesos llamados “productores”
que generan valores (digamos, de tipo int) y N procesos “consumidores” que los leen y realizan alguna
computaci´on con ellos. Se debe garantizar que:
cada valor producido sea consumido, es decir, que no se pierda
cada valor producido no sea tomado por m´as de un consumidor
Los procesos se comunican mediante un buffer compartido, insertando y tomando elementos del mismo.
En este ejemplo (ver prod-cons.c), los productores alocan un entero con malloc() y los consumidores
los liberan con free(). Perder elementos producidos implica una fuga de memoria, y consumirlos dos
veces implica un doble-free.
*/


/*
a) Implemente una soluci´on usando sem´aforos para llevar las cantidades de elementos en el buffer, y la
cantidad de elementos libres.
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#define M 5
#define N 5
#define SZ 8

/*
 * El buffer guarda punteros a enteros, los
 * productores los consiguen con malloc() y los
 * consumidores los liberan con free()
 */
int *buffer[SZ];
int i = -1;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
sem_t in_buffer;
sem_t free_el;

void enviar(int *p) {
  buffer[i+1] = p;
  i++;
  return;
}

int * recibir() {
  int *dato = buffer[i];
  i--;
  return dato;
}

void * prod_f(void *arg) {
  int id = arg - (void*)0;
  while (1) {
    sleep(random() % 3);

    sem_wait(&free_el);
    pthread_mutex_lock(&mutex);
        int *p = malloc(sizeof *p);
	    *p = random() % 100;
	    printf("Productor %d: produje %p->%d\n", id, p, *p);
	    enviar(p);
        sem_post(&in_buffer);
    pthread_mutex_unlock(&mutex);
  }
  return NULL;
}

void * cons_f(void *arg) {
  int id = arg - (void*)0;
  while (1) {
	sleep(random() % 3);

    sem_wait(&in_buffer);
    pthread_mutex_lock(&mutex);
	    int *p = recibir();
	    printf("Consumidor %d: obtuve %p->%d\n", id, p, *p);
	    free(p);
        sem_post(&free_el);
    pthread_mutex_unlock(&mutex);
  }
  return NULL;
}

int main() {
  pthread_t productores[M], consumidores[N];
  int i;

  sem_init(&in_buffer, 0 , 0);
  sem_init(&free_el, 0 , SZ);

  for (i = 0; i < M; i++)
	pthread_create(&productores[i], NULL, prod_f, i + (void*)0);

  for (i = 0; i < N; i++)
	pthread_create(&consumidores[i], NULL, cons_f, i + (void*)0);

  pthread_join(productores[0], NULL); /* Espera para siempre */
  sem_destroy(&in_buffer);
  sem_destroy(&free_el);

  return 0;
}
