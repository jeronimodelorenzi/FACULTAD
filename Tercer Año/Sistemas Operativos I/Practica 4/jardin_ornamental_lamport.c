#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define VISITANTES 100

#define N 4

int NUM[N];
int ELIGIENDO[N];

int visitantes = 0;

void lock (int index) {
  ELIGIENDO[index] = 1;  
  int max = NUM[0];  

  for (int i = 1 ; i < N ; i++)
    if (NUM[i] > max)
      max = NUM[i];  

  NUM[index] = max + 1;  
  ELIGIENDO[index] = 0; 

  for (int j = 0 ; j < N ; j++) {
    // Busy waiting.
    while (ELIGIENDO[j]);  
    // Busy waiting.
    while((NUM[j] != 0) && ((NUM[j] < NUM[index]) 
      || ((NUM[j] == NUM[index]) && (j < index))));
  }
}

void unlock (int index) {
  NUM[index] = 0 ;
}

void *contar_threads (void *v) {
  int id = *((int*)v);

  for(int i = 0 ; i < VISITANTES ; i++) {
    lock(id);

    visitantes++;
    printf("Contador %d: %d\n", id, visitantes);

    unlock(id);
  }

  pthread_exit(NULL);
}

int main () {
  pthread_t t1, t2;

  int u = 0, v = 1;

  for (int i = 0 ; i < N ; i++) {
    ELIGIENDO[i] = 0;
    NUM[i] = 0;
  }

  pthread_create(&t1, NULL, contar_threads, &u);
  pthread_create(&t2, NULL, contar_threads, &v);

  pthread_join(t1, NULL);
  pthread_join(t1, NULL);

  printf("Main, contador: %d", visitantes);

  return 0;
}

