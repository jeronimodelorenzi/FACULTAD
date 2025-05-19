/*
Para calentar motores, adapte a OpenMP su soluci´on del jard´ın ornamental usando el Algoritmo
de la Panader´ıa de Lamport.
*/

#include <stdio.h>
#include <omp.h>

#define VISITANTES 100

#define N_THREADS 12

int NUM[N_THREADS];
int ELIGIENDO[N_THREADS];

int visitantes = 0;

void lock (int index) {
  ELIGIENDO[index] = 1;  
  int max = NUM[0];  

  for (int i = 1 ; i < N_THREADS ; i++)
    if (NUM[i] > max)
      max = NUM[i];  

  NUM[index] = max + 1;  
  ELIGIENDO[index] = 0; 

  for (int j = 0 ; j < N_THREADS ; j++) {
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

// void contar_threads () {
//   int id = omp_get_thread_num();

//   #pragma parallel for
//   for(int i = 0 ; i < VISITANTES ; i++) {
//     lock(id);

//     visitantes++;
//     printf("Contador %d: %d\n", id, visitantes);

//     unlock(id);
//   }
// }

int main () {

  for (int i = 0 ; i < N_THREADS ; i++) {
    ELIGIENDO[i] = 0;
    NUM[i] = 0;
  }
  
  #pragma omp parallel
  {
    int id = omp_get_thread_num();  
    #pragma omp for
    for(int i = 0 ; i < VISITANTES ; i++) {
      lock(id);

      visitantes++;
      printf("Contador %d: %d\n", id, visitantes);

      unlock(id);
    }    
  }

  printf("Main, contador: %d", visitantes);
  
  return 0;
}