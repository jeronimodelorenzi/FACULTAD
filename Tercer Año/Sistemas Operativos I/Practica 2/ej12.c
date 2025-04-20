#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

pthread_mutex_t a = PTHREAD_MUTEX_INITIALIZER; // inicializo mutex

void * foo(void *_arg) {
  pthread_mutex_lock(&a); // hilo entra en la sección crítica.
  printf("Foo!\n"); // muestra en pantalla Foo!
  sleep(1); // espera un segundo.
  pthread_mutex_unlock(&a); // hilo sale de la región crítica.
  return NULL; 
}
int main(){
  pthread_t th; // variable para el hilo.
  pthread_create(&th, NULL, foo, NULL); // crea hilo.
  
  pthread_mutex_t b = a; // mutex local ¿?

  pthread_mutex_lock(&b); // hilo ingresa en región crítica local.
  printf("Bar!\n"); // muestra en pantalla Bar!
  sleep(1); // espera un segundo.
  pthread_mutex_unlock(&b); // hilo sale de la región crítica local.
  
  pthread_join(th, NULL); // espera a que el hilo termine.
  return 0;
}