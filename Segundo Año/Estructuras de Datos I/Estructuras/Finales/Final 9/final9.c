#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct _Cliente {
  char *nombre, *apellido, *direccion;
  int DNI, telefono;
} Cliente;

typedef struct _Consumo {
  char *fechaDeConsumo;
  int montoConsumo;
  int DNI;
}