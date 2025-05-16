/*
Cinco fil´osofos se sientan alrededor
de una mesa redonda y viven la buena vida alternando entre comer y pensar.
Cada fil´osofo tiene su plato de pasta, un tipo particular de fideos que requieren
dos tenedores para ser comidos. Entre cada par de fil´osofos consecutivos hay un
tenedor, y cada fil´osofo s´olo puede alcanzar los que est´an a su izquierda y derecha.
Para comer, los fil´osofos acordaron primero tomar el tenedor a su derecha y luego
el de a su izquierda. Si cualquier fil´osofo toma un tenedor y el otro est´a ocupado,
se quedar´a esperando, con un tenedor en la mano, hasta que pueda tomar el otro
tenedor, para luego empezar a comer. Una vez que un fil´osofo terminar de comer
deja los tenedores sobre la mesa y piensa hasta que le vuelve a dar hambre, cuando
repite el procedimiento.
*/

/*
d) Un fil´osofo, ya sufriendo secuelas del hambre, sugiere que los comensales suelten su tenedor derecho
si encuentran que el izquierdo ya est´a tomado, posiblemente esperando un tiempo antes de reintentar
tomarlo. Implemente esta variante e invest´ıguela. ¿Funciona? ¿Es eficiente? Cuantifique su respuesta.
*/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

#define N_FILOSOFOS 5
#define ESPERA 5000000

pthread_mutex_t tenedor[N_FILOSOFOS];

pthread_mutex_t *izq(int i) { return &tenedor[i]; }
pthread_mutex_t *der(int i) { return &tenedor[(i + 1) % N_FILOSOFOS]; }

sem_t sem;

void pensar(int i) {
  printf("Filosofo %d pensando...\n", i);
  usleep(random() % ESPERA);
}

void comer(int i) {
  printf("Filosofo %d comiendo...\n", i);
  usleep(random() % ESPERA);
}

void tomar_tenedores(int i) {
  while (1) {
    printf("Filósofo %d intenta agarrar el tenedor derecho.\n",i);
    pthread_mutex_unlock(der(i));
    printf("Filósofo %d agarró el tenedor derecho.\n",i);
    
    printf("Filósofo %d intenta agarrar el tenedor izquierdo.\n",i);
    if (!pthread_mutex_trylock(izq(i))){
      printf("Filósofo %d intentó agarrar el tenedor izquierdo, como no pudo intenta soltar el tenedor derecho.\n",i);
      pthread_mutex_unlock(der(i));
      printf("Filósofo %i soltó el tenedor derecho\n",i);
      sleep(1);
    } else {
      printf("Filósofo %d agarró el tenedor izquierdo.\n",i);
      break;
    }
  }
}

void dejar_tenedores(int i) {
  printf("Filósofo %d intenta soltar el tenedor derecho.\n",i);
  pthread_mutex_unlock(der(i));
  printf("Filósofo %d soltó el tenedor derecho.\n",i);
  
  printf("Filósofo %d intenta soltar el tenedor izquierdo.\n",i);
  pthread_mutex_lock(izq(i));
  printf("Filósofo %d soltó el tenedor izquierdo.\n",i);
}

void *filosofo(void *arg) {
  int i = arg - (void *)0;
  while (1) {
    tomar_tenedores(i);
    comer(i);
    dejar_tenedores(i);
    pensar(i);
  }
}

int main() {
  pthread_t filo[N_FILOSOFOS];
  int i;

  for (i = 0; i < N_FILOSOFOS; i++)
    pthread_mutex_init(&tenedor[i], NULL);
  
  for (i = 0; i < N_FILOSOFOS; i++)
    pthread_create(&filo[i], NULL, filosofo, i + (void *)0);

  pthread_join(filo[0], NULL);

  return 0;
}