#include <stdio.h>
#include <pthread.h>

#define NUM_VISIT 400000

// for((i = 0 ; i < 20 ; i++)); do ./a.out ; done

int num = 0;
int flag[2] = {0,0};
int turno = 0;

void *molinete1 (void *ptr) {
  for(int i = 0 ; i < NUM_VISIT/2 ; i++) {
    // lock
    flag[0] = 1;
    turno = 2;
    asm("mfence");
    while(flag[1] == 1 && turno == 2);
    // región crítica
    num++;
    // unlock
    flag[0] = 0;
  }
  pthread_exit(0);
}

void *molinete2 (void *ptr) {
    for(int i = 0 ; i < NUM_VISIT/2 ; i++) {
      // lock 
      flag[1] = 1;
      turno = 1;
      asm("mfence");
      while(flag[0] == 1 && turno == 1);
      // región crítica
      num++;
      // unlock
      flag[1] = 0;
    }
    pthread_exit(0);
  }

int main () {
    pthread_t mol1, mol2;
    pthread_create(&mol1, NULL, molinete1, NULL);
    pthread_create(&mol2, NULL, molinete2, NULL);

    pthread_join(mol1, NULL);
    pthread_join(mol2, NULL);
    
    printf("Entraron:%d\n", num);

    return 0;
}