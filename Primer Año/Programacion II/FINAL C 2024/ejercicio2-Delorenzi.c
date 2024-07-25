#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <stdlib.h>

//PROTOTIPOS
void eliminarEspacio(char* str);
int in(char* str, char c);
int test_in();
int calcularPrecio(char* str);
int test_calcularPrecio();

int main(){
    char* str;
    int tam;
    printf("Ingrese el tamaño de la cadena: ");
    scanf("%d", &tam);
    getchar();

    str = (char *) malloc(sizeof(char)*(tam+1));

    printf("Ingrese una cadena: ");
    fgets(str, tam+1, stdin);
    eliminarEspacio(str);
    
    int precio = calcularPrecio(str);
    printf("Precio de la cadena '%s': %d.\n",str, precio);

    free(str);

    //TESTEO
    test_in();
    test_calcularPrecio();

    return 0;
}
//eliminarEspacio: str -> void
//Dada una cadena de caracteres, elimina si se encuentra el espacio en blanco.
//Ejemplo:
//eliminarEspacio("Hola ") = "Hola"
//eliminarEspacio("Chau") = "Chau"
void eliminarEspacio(char* str){
    for(int i = 0 ; *(str+i) != '\0' ; i++){
        if(*(str+i) == '\n'){
            *(str+i) = '\0';
        }
    }
}

//in: str char -> int.
//Dada una cadena de caracteres y un caracter, retorna 1 si el caracter se encuentra
//en la cadena y 0 si no.
//Ejemplos:
//in("Licenciatura", 'a') = 1
//in("Ciencias", 'x') = 0
//in("Computacion", 'C') = 1
int in(char* str, char c){
    int condicion = 0;
    for(int i = 0 ; *(str + i) != '\0'; i++){
        if(*(str + i) == c){
            condicion = 1;
        }
    }
    return condicion;
}

int test_in(){
    assert(in("Licenciatura", 'a') == 1);
    assert(in("Ciencias", 'x') == 0);
    assert(in("Computacion", 'C') == 1);
}

//calcularPrecio: str -> int
//Dada una cadena de caracteres retorna el precio total teniendo en cuenta
//que las letras valen 10 pesos, los digitos valen 20 pesos y los caracteres
//especiales valen 30. El espacio no vale nada.
//Ejemplos:
//calcularPrecio("Hi my name is Jero.") = 170
//calcularPrecio("10 + 10 = 20") = 180
//calcularPrecio("jero4@gmail) = 120
int calcularPrecio(char* str){
    int precio = 0;
    char letras[] = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    char digitos[] = "0123456789";
    for(int i = 0 ; *(str+i) != '\0' ; i++){
        if(*(str+i) == ' '){
            precio += 0;
        } else if(in(letras, *(str+i))){
            precio += 10;
        } else if(in(digitos, *(str+i))) {
            precio += 20;
        } else {
            precio += 30;
        }
    }
    return precio;
}

int test_calcularPrecio(){
    assert(calcularPrecio("Hi my name is Jero.") == 170);
    assert(calcularPrecio("10 + 10 = 20") == 180);
    assert(calcularPrecio("jero4@gmail") == 140);
}