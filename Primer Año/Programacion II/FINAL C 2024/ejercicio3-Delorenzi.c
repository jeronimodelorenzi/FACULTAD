#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

//Estructura Cumple
typedef struct {
    int dia, mes, anio;
    char* nombre;
} Cumple;

//PROTOTIPOS
void eliminarEspacio(char* str);
Cumple crearCumple();
void busqueda_cumple(Cumple cumple[5], int dia, int mes);

int main(){

    Cumple cumple[5];
    int dia,mes,anio;

    for(int i = 0; i<5; i++){
        cumple[i] = crearCumple();
    }

    printf("Ingrese el dia de nacimiento a buscar: ");
    scanf("%d", &dia);
    while(dia < 1 || dia > 31){
        printf("Ingrese el dia de nacimiento a buscar correcto: ");
        scanf("%d", &dia);
    }

    printf("Ingrese el mes de nacimiento a buscar: ");
    scanf("%d", &mes);

    while(mes < 1 || mes > 12){
        printf("Ingrese el mes de nacimiento a buscar correcto: ");
        scanf("%d", &mes);
    }

    busqueda_cumple(cumple, dia, mes);

    for(int i = 0; i<5; i++){
        free(cumple[i].nombre);
    }

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

//crearCumple(): void -> Struct Cumple
//Dado un dia, una mes, un año y un nombre la funcion retorna una estructura Cumple.
//dia: int
//mes: int
//año: int
//nombre: str
//Ejemplo: Si se ingresa dia: 4/mes: 2/ año: 2003 nombre: Jero se retorna: 
//Cumple {4 , 2, 2003 , Jero}
Cumple crearCumple(){
    Cumple cumple;
    char temp[30];
    int dia, mes, anio;

    printf("Ingrese el dia de nacimiento: ");
    scanf("%d", &cumple.dia);

    while(cumple.dia < 1 || cumple.dia > 31){
        printf("Ingrese el dia de nacimiento correcto: ");
        scanf("%d", &cumple.dia);
    }

    printf("Ingrese el mes de nacimiento: ");
    scanf("%d", &cumple.mes);

    while(cumple.mes < 1 || cumple.mes > 12){
        printf("Ingrese el mes de nacimiento correcto: ");
        scanf("%d", &cumple.mes);
    }

    printf("Ingrese el año de nacimiento: ");
    scanf("%d", &cumple.anio);
    getchar();

    printf("Ingrese una cadena: ");
    fgets(temp, sizeof(temp), stdin);
    eliminarEspacio(temp);
    cumple.nombre = (char *) malloc(sizeof(char)*(strlen(temp+1)));
    strcpy(cumple.nombre,temp);

    return cumple;
}
//busqueda_cumple: Cumple[5] int int-> void
//Dado un array de estructuras Cumple, y el dia, mes, año, de la/las personas que se quieran buscar cumpleaños,
//Muestra en pantalla aquellos que coincidan con la fecha dada.

void busqueda_cumple(Cumple cumple[5], int dia, int mes){
    int bandera = 0;
    for(int i = 0 ; i<5 ; i++){
        if(dia == cumple[i].dia && mes == cumple[i].mes){
            printf("La persona que cumple años en la fecha %d/%d es %s.\n", cumple[i].dia, cumple[i].mes,cumple[i].nombre);
            bandera = 1;
        }
    }
    if(!bandera){
        printf("Nadie cumple años en la fecha %d/%d.\n",dia,mes);
    }
}