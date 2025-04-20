#include <stdio.h>
#include <pthread.h>

// implementar un programa con dos threads que suman los elementos de un arreglo compartido
// usando pthread mutex t para evitar race conditions.

int len = 5;
int arr[] = {1,2,3,4,5};
pthread_mutex_t myMutex = PTHREAD_MUTEX_INITIALIZER;
volatile int suma = 0;
volatile int i = 0;

void *suma_arreglo (void *ptr) {

    while(i<len) {
      pthread_mutex_lock(&myMutex);
      suma += arr[i++];
      pthread_mutex_unlock(&myMutex);
    }
    pthread_exit(0);
}

int main () {
  pthread_t thread1, thread2;

  //pthread_mutex_init(&myMutex, NULL);

  pthread_create(&thread1, NULL,suma_arreglo, NULL);
  pthread_create(&thread2, NULL,suma_arreglo, NULL);

  pthread_join(thread1, NULL);
  pthread_join(thread2, NULL);

  printf("Suma del arreglo: %d\n", suma);

  return 0;
}
