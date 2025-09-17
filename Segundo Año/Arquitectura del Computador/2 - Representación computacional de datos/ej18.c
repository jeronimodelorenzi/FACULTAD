#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
  int codigo = atoi(argv[1]);
  char *cadena = argv[2];

  for (int i = 0; cadena[i] != '\0' ; i++){
    char codificado = cadena[i] ^ codigo;
    printf("%c", codificado);
  }
  puts("");

  return 0;
}