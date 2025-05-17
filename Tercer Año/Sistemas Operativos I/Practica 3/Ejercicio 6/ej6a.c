/*
Tres procesos tratan de fumar cada vez que pueden.
Para hacerlo necesitan tres ingredientes: tabaco, papel y f´osforos. Cada uno tiene una cantidad ilimitada
de uno de estos ingredientes. Esto es, un fumador tiene tabaco, otro tiene papel y el ´ultimo tiene f´osforos.
Los fumadores no se prestan los ingredientes entre ellos, pero hay un cuarto proceso, el agente, con
cantidad ilimitada de todos los ingredientes, que repetidamente pone a disposici´on de los fumadores dos
de los tres ingredientes, eligi´endolos al azar. Cada vez que esto pasa, el fumador que tiene el ingrediente
restante deber´ıa proceder a hacerse un cigarrillo y fumar. Al terminar de fumar (y no antes) el fumador
avisa al agente que termin´o, para que el mismo pueda seguir atendiendo.

El problema consiste en garantizar que el sistema progresa normalmente, es decir que los fumadores toman
los ingredientes cuando les corresponde, fuman, y luego notifican al agente que se puede continuar. Los
fumadores deben sincronizar entre ellos; no debe modificarse al agente en lo m´as min´ımo. S´ı pueden
crearse nuevos sem´aforos, mutexes, y threads.
*/

// a) ¿C´omo puede ocurrir un deadlock en esta implementaci´on ingenua?

/*
Puede ocurrir un deadlock si varios fumadores toman un ingrediente que no les corresponden.
Por ejemplo, supongamos que el agente pone tabaco y papel. El fumador con fósforos es el
único que debería tomar los ingredientes, ya que son los dos ingredientes que le faltan.
Puede ocurrir que uno de los otros dos fumadores tomen uno de los ingredientes que da el agente,
aunque no puedan hacer un cigarrillo.
Entonces todos estan esperando un ingrediente que no está disponible y no pueden continuar.
Luego el agente se queda boqueado esperando a que alguno termine de fumar.
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

sem_t tabaco, papel, fosforos, otra_vez;
void agente() {
  while (1) {
    sem_wait(&otra_vez);
    int caso = random() % 3;
    if (caso != 0)
      sem_post(&fosforos);
    if (caso != 1)
      sem_post(&papel);
    if (caso != 2)
      sem_post(&tabaco);
  }
}

void fumar(int fumador) {
  printf("Fumador %d: Puf! Puf! Puf!\n", fumador);
  sleep(1);
}

void *fumador1(void *arg) {
  while (1) {
    sem_wait(&tabaco);
    sem_wait(&papel);
    fumar(1);
    sem_post(&otra_vez);
  }
}

void *fumador2(void *arg) {
  while (1) {
    sem_wait(&fosforos);
    sem_wait(&tabaco);
    fumar(2);
    sem_post(&otra_vez);
  }
}

void *fumador3(void *arg) {
  while (1) {
    sem_wait(&papel);
    sem_wait(&fosforos);
    fumar(3);
    sem_post(&otra_vez);
  }
}

int main() {
  pthread_t s1, s2, s3;

  sem_init(&tabaco, 0, 0);
  sem_init(&papel, 0, 0);
  sem_init(&fosforos, 0, 0);
  sem_init(&otra_vez, 0, 1);

  pthread_create(&s1, NULL, fumador1, NULL);
  pthread_create(&s2, NULL, fumador2, NULL);
  pthread_create(&s3, NULL, fumador3, NULL);

  agente();

  return 0;
}