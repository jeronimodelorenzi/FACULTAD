#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "glist.h"

void *copia_string(void *dato) {
    char *str = (char *)dato;
    char *nuevo = malloc(sizeof(char) * (strlen(str) + 1));
    strcpy(nuevo, str);
    return nuevo;
}

void dest_string(void *dato) {
    free(dato);
}

void* stringMayuscula(void *dato) {
    char *str = (char*)dato;
    char *newStr = malloc(sizeof(char)*(strlen(str)+1));
    int i = 0;
    for(; str[i] != '\0' ; i++){
        if(str[i]>= 'a' && str[i] <= 'z'){
            newStr[i] = str[i]-32;
        }else{
            newStr[i] = str[i];
        }
    }
    newStr[i] = '\0';

    return newStr;
}

void printf_string(void *dato) {
    char *str = (char*)dato;
    printf("%s", str);
}

int main() {
    GList lista = glist_crear();

    char *str = "Licenciatura ";
    lista = glist_agregar_final(lista, str, copia_string);

    str = "en ";
    lista = glist_agregar_final(lista, str, copia_string);

    str = "Ciencias ";
    lista = glist_agregar_final(lista, str, copia_string);

    str = "de la ";
    lista = glist_agregar_final(lista, str, copia_string);

    str = "Computacion.";
    lista = glist_agregar_final(lista, str, copia_string);

    glist_recorrer(lista, printf_string);
    puts("");

    GList newList = glist_map(lista, stringMayuscula, copia_string);

    glist_recorrer(newList, printf_string);    
    puts("");

    glist_destruir(lista, dest_string);

    return 0;
}
