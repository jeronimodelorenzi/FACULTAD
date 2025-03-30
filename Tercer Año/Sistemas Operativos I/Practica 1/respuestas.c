#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
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
    perror("Error\n");
  }

  return 0;
}*/

/*
Al cerrar el file descriptor de la entrada estar se imposibilita escribir en ella, por lo que fgets no podrá leer el buffer y
se devolverá NULL.
*/

// c

int main () {

  int stdincopy = dup(stdin);
  close(stdin);

  printf();

  return 0;
}

/* 

*/