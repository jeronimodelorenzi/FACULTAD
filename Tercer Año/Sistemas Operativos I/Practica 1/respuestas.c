#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

/*
Ejercicio 1.
El comando echo escribe el string pasado como argumento en la salida estandar.
echo "Hola Mundo" mostrará en la salida estandar Hola mundo.
El comando echo "$$" muestra el PID del proceso que se está ejecutando en la sell.
--
El comando env muestra el enterno actual o establece el entorno para la ejecucion de un comando.
Asigna a cada nombre el valor en el entorno y ejecuta la orden
--
El comando ps muestra información sobre los procesos activos.
--
El comando tree muestra la estructura de directorios y archivos en forma de árbol.
--
El comando strace permite hacer un seguimiento de las llamadas al sistema realizadas por un proceso.
*/

// Ejercicio 2

//a

/*int main () {
  close(1);
  printf("Probando\n");

  return 0;
}*/

/*
Se cerro el file descriptor de la salida estandar, por lo que al intentar escribir en el, en este caso con printf, 
no mostrará nada en la salida pues se cerró previamente
*/

// b

/*int main () {
  close(0);
  char buff[100];
  fgets(buff,100,stdin);
  printf("%s", buff);

  if (fgets(buff,100,stdin) == NULL) {
    perror("Se cerro la entrada estandar\n");
  }

  return 0;
}*/

/*
Al cerrar el file descriptor de la entrada estandar es imposible escribir en ella, por lo que fgets no podrá leer el buffer y
se devolverá NULL.
*/

// c

/*int main () {

  int fd = open("archivo.txt", O_RDWR | O_CREAT);
  int fdDup = dup(fd); // duplicamos el fd, devolviendo un fd al mismo archivo que apunta el que se duplica.

  char buff1[] = "Hola Mundo_fd\n";
  char buff2[] = "Hola Mundo_fdDup\n";

  write(fd, buff1, 14); // usando fd escribimos.
  close(fd);  // cerramos fd.
  
  write(fdDup, buff2,17); // usando fdDup escribimos.
  close(fdDup); // cerramos fdDup.

  return 0;
}*/

/* 
Se escribio en el archivo Hola Mundo_fd\n y Hola Mundo_fdDup\n. Esto quiere decir que igualmente al cerrar uno de las copias, sigue funcionando ya que
en este caso ambas apuntan a "archivo.txt"
*/

// d

/*int main () {
  printf("Iniciando proceso.\n");

  pid_t pid = fork();
  if (pid == 0) {
    printf("PID child: %d\n",getpid());
  } else {
    printf("PID parent: %d\n", getpid());

  }

  return 0;
}*/

/*
Cuando realizamos un fork se crea un nuevo proceso, tenemos padre e hijo, donde cada uno tiene su pid.asm
Al realizar exec el pid se mantiene pero el proceso es reemplazado.
*/

// e

/*int main () {
  pid_t pid = fork();
  if (pid == 0) {
      printf("Child termina\n");
      exit(0);
  }
  sleep(10);
  
  return 0;
}*/

/* 
Lo que ocurre con el hijo sin que el padre espere a que termine es que su estado pasa a ser zombie. Este hijo es adoptado por init terminando su proceso.
*/

// f 

/*int main () {
  void* p = malloc(1024*1024*1024);
  sleep(100);
  return 0;
}*/

/*
PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
245 jero      20   0 1059396    584    440 S   0.0   0.0   0:00.00 resp.out
Vemos que VIRT = 1059396 es la memoria virtual reservada y RES = 584 memoria usada. Estas son muy diferentes.
*/

// g
