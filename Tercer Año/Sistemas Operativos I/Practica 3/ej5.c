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

pthread_t barbero;
pthread_t clientes[CLIENTES];

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int sillas = SILLAS;

void cortando(int i) {
  printf("Barbero cortando al cliente %d\n", i);
}

void pagando(int i) {
  printf("Cliente %d pagando\n", i);
}

void me_cortan(int i){
  printf("Cliente %i recibiendo corte de pelo\n", i);
}

void me_pagan(int i){
  printf("Barbero recibiendo pago del cliente %d\n", i);
}

void *barbero_func(void *arg) {
  int num = arg - (void*)0;

  while (1) {
    sleep(rand()% 3);

    sem_wait(&durmiendo);
    cortando(num);
    sem_post(&atendido);
    me_pagan(num);
    
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
      me_cortan(num);
      sem_wait(&atendido);
      pagando(num);
      sillas++;
      sem_post(&ocupado);

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

  pthread_create(&barbero, NULL, barbero_func, NULL);
  
  for(int i = 0 ; i < CLIENTES ; i++)
    pthread_create(&clientes[i], NULL, cliente_func, i+(void*)0);

  pthread_join(barbero, NULL);

  return 0;
}