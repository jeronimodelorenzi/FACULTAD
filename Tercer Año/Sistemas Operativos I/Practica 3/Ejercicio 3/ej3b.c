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

// b) Implemente una soluci´on usando variables de condici´on.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define M 5
#define N 5
#define SZ 8

pthread_cond_t lleno = PTHREAD_COND_INITIALIZER;
pthread_cond_t vacio = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
/*
 * El buffer guarda punteros a enteros, los
 * productores los consiguen con malloc() y los
 * consumidores los liberan con free()
 */
int *buffer[SZ];
int i = -1;

void enviar(int *p) {
  buffer[i+1] = p;
  i++;
  return;
}

int * recibir()  {
  int *dato = buffer[i];
  i--;
  return dato;
}

void * prod_f(void *arg) {
  int id = arg - (void*)0;

  while (1) {
  	sleep(random() % 3); 

    pthread_mutex_lock(&mutex);

        while (i >= SZ-1)
          pthread_cond_wait(&lleno, &mutex);

  	    int *p = malloc(sizeof *p);
  	    *p = random() % 100;
  	    printf("Productor %d: produje %p->%d\n", id, p, *p);
  	    enviar(p);
        pthread_cond_signal(&vacio);
    pthread_mutex_unlock(&mutex);
  }
  return NULL;
}

void * cons_f(void *arg) {
  int id = arg - (void*)0;
  while (1) {
    sleep(random() % 3);  

    pthread_mutex_lock(&mutex);
      
      while(i < 0)
        pthread_cond_wait(&vacio, &mutex);

  	  int *p = recibir();
  	  printf("Consumidor %d: obtuve %p->%d\n", id, p, *p);
  	  free(p);
      pthread_cond_signal(&lleno);
    pthread_mutex_unlock(&mutex);
  }
  return NULL;
}

int main() {
  pthread_t productores[M], consumidores[N];
  int i;

  for (i = 0; i < M; i++)
  	pthread_create(&productores[i], NULL, prod_f, i + (void*)0); 

  for (i = 0; i < N; i++)
  	pthread_create(&consumidores[i], NULL, cons_f, i + (void*)0);

  pthread_join(productores[0], NULL); /* Espera para siempre */
  return 0;
}
