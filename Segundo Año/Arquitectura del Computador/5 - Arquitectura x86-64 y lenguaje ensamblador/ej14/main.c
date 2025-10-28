#include <stdio.h>
unsigned long suma(int, char**);
int main (int argc, char *argv[]) {
    if (argc <= 1) {
        printf("Ingrese al menos un argumento\n");
        return 0;
    }

    unsigned long res = suma(argc, argv);
    printf("Cantidad de argumentos ingresados: %d. La suma es %lu.\n", argc-1, res);
    return 0;
}
