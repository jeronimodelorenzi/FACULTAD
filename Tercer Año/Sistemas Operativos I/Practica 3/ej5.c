/*
Una barber´ıa tiene una sala de espera con N sillas y
un barbero. Si no hay clientes para atender, el barbero se pone a dormir. Si un cliente llega y todas
las sillas est´an ocupadas, se va. Si el barbero est´a ocupado pero hay sillas disponibles, se sienta en
una y espera a ser atendido. Si el barbero est´a dormido, despierta al barbero. El cliente y el barbero
deben ejecutar concurrentemente las funciones me_cortan() y cortando() y al terminar los dos ejecutar
concurrentemente pagando() y me_pagan().
Escriba un programa que coordine el comportamiento del barbero y los clientes y expl´ıquelo.
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define SILLAS 5
#define CLIENTES 10

sem_t atendido;
sem_t durmiendo;
sem_t ocupado;

pthread_barrier_t barrera_corte;
pthread_barrier_t barrera_pago;

pthread_t barbero;
pthread_t clientes[CLIENTES];

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int sillas = SILLAS;

void cortando() {
  printf("Barbero cortando\n");
}

void pagando(int i) {
  printf("Cliente %d pagando\n", i);
}

void me_cortan(int i){
  printf("Cliente %i recibiendo corte de pelo\n", i);
}

void me_pagan(){
  printf("Barbero recibiendo pago\n");
}

void *barbero_func(void *arg) {
  while (1) {
    sem_wait(&durmiendo);

    pthread_barrier_wait(&barrera_corte);
    cortando();

    pthread_barrier_wait(&barrera_pago);
    me_pagan();
    
    sem_post(&atendido);
    sem_post(&ocupado);
  }
  return NULL;
}

void *cliente_func(void *arg) {
  int num = arg - (void*)0;
  while(1) {
    sleep(rand() % 3);

    pthread_mutex_lock(&mutex);
    if (sillas > 0) {
      
      printf("Cliente %d se sentó\n", num);
      sillas--;
      pthread_mutex_unlock(&mutex);

      sem_wait(&ocupado);
      sem_post(&durmiendo);

      pthread_barrier_wait(&barrera_corte);
      me_cortan(num);
  
      pthread_barrier_wait(&barrera_pago);
      pagando(num);

      sem_wait(&atendido);

      pthread_mutex_lock(&mutex);
      sillas++;
      printf("Cliente %d se fue\n", num);
      pthread_mutex_unlock(&mutex);


    } else {
      pthread_mutex_unlock(&mutex);
      printf("Cliente %d se fue porque no hay sillas\n", num);
    }
  }
}

int main() {
  sem_init(&atendido, 0, 0);
  sem_init(&durmiendo, 0, 0);
  sem_init(&ocupado, 0, 1);

  pthread_barrier_init(&barrera_corte, NULL, 2);
  pthread_barrier_init(&barrera_pago, NULL, 2);

  pthread_create(&barbero, NULL, barbero_func, NULL);
  
  for(int i = 0 ; i < CLIENTES ; i++)
    pthread_create(&clientes[i], NULL, cliente_func, i+(void*)0);

  pthread_join(barbero, NULL);

  sem_destroy(&ocupado);
  sem_destroy(&durmiendo);
  sem_destroy(&atendido);

  pthread_barrier_destroy(&barrera_corte);
  pthread_barrier_destroy(&barrera_pago);

  return 0;
}