#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <time.h> 


//Ejercicio 1

//a

/*struct point{
    double x;
    double y;
};

int main(){
    struct point test;
    test.x = .25; test.y = .75;
    printf("[%f %f]\n",test.x,test.y);
    return 0;
}*/

//b

/*typedef struct{
    double x;
    double y;
} Point;

int main(){
    Point test;
    test.x = .25; test.y = .75;
    printf("[%f %f]\n",test.x,test.y);
    return 0;
}*/

//c

/*typedef struct{
    double x;
    double y;
} Point;

int main(){
    Point test = {.25, .75};
    printf("[%f %f]\n",test.x,test.y);
    return 0;
}*/

//La diferencia entre los tres programas: en el primero se declara una estructura y se muestra un punto en pantalla.
//en el segundo se declara un tipo struct, en el tercero se define desde el main los puntos.

//Ejercicio 2

/*struct point {
    double x;
    double y;
};

typedef struct point Point;

double POINTdist(Point punto1, Point punto2){
    double diferencia_x = punto1.x - punto2.x;
    double diferencia_y = punto1.y - punto2.y;
    double suma_cuadrados = diferencia_x*diferencia_x + diferencia_y*diferencia_y;
    double distancia = sqrt(suma_cuadrados);
    return distancia;
}

int POINTeq(Point punto1, Point punto2){
    const double epsilon = 0.000001;
    if(fabs(punto1.x-punto2.x) < epsilon && fabs(punto1.y - punto2.y) < epsilon){
        return 1;
    } else {
        return 0;
    }
}

struct rectangulo{
    Point v_inf_izq;
    Point v_sup_der;
};

typedef struct rectangulo Rectangulo;

int RECTarea(Rectangulo rect){
    double base = rect.v_sup_der.x - rect.v_inf_izq.x;
    double altura = rect.v_sup_der.y - rect.v_inf_izq.y;

    double area = base*altura;

    return area;
}

int RECTin(Rectangulo rect, Point punto) {
    if ((punto.x >= rect.v_inf_izq.x && punto.x <= rect.v_sup_der.x) && (punto.y >= rect.v_inf_izq.y && punto.y <= rect.v_sup_der.y)) {
        return 1;
    } else {
        return 0;
    }
}

int main(){

    Point punto1;
    Point punto2;
    Rectangulo rect;

    printf("Ingrese valores para x (punto 1): ");
    scanf("%lf %lf", &punto1.x,&punto1.y);

    printf("Ingrese valores para x e y (punto 2): ");
    scanf("%lf %lf", &punto2.x, &punto2.y);

    double distancia = POINTdist(punto1, punto2);

    printf("La distancia entre el punto (%0.1f,%0.1f) y (%0.1f,%0.1f) es %0.2f\n", punto1.x, punto1.y, punto2.x, punto2.y, distancia);

    int iguales = POINTeq(punto1,punto2);

    if(iguales){
        printf("Los puntos son iguales.\n");
    } else {
        printf("Los puntos no son iguales.\n");
    }

    rect.v_inf_izq.x = 1.0; rect.v_inf_izq.y = 1.0;
    rect.v_sup_der.x = 3.0; rect.v_sup_der.y = 4.0;

    double area = RECTarea(rect);
    printf("El area del rectangulo es: %0.1f\n", area);

    int adentro = RECTin(rect,punto1);
    if(adentro){
        printf("El punto (%0.1f,%0.1f) esta dentro del rectangulo.\n", punto1.x, punto1.y);
    } else {
        printf("El punto (%0.1f,%0.1f) esta dentro del rectangulo.\n", punto1.x, punto1.y);
    }
    
    return 0;
}*/

//Ejercicio 4 - MAL

/*struct tiempo{
    int hora;
    int minuto;
    int segundo;
};

typedef struct tiempo Tiempo;

Tiempo crear_Tiempo(int hora, int minutos, int segundos){
    Tiempo horario = {hora, minutos, segundos};
    return horario;
}

void imprimir_Tiempo(Tiempo horario){
    printf("%02d:%02d:%02d\n", horario.hora, horario.minuto, horario.segundo);
}

Tiempo suma_Tiempo(Tiempo h1, Tiempo h2){
    Tiempo horario_sumado;
    
    int total_segundos = h1.segundo + h2.segundo;
    int total_minutos = h1.minuto + h2.minuto + total_segundos / 60;

    horario_sumado.segundo = total_segundos % 60;
    horario_sumado.hora = h1.hora + h2.hora + total_minutos / 60;
    horario_sumado.minuto = total_minutos % 60;

    return horario_sumado;
}

Tiempo resta_Tiempo(Tiempo h1, Tiempo h2){
    Tiempo horario_restado;

    if (h1.segundo < h2.segundo) {
        h1.segundo += 60;
        h1.minuto--;
    }
    horario_restado.segundo = h1.segundo - h2.segundo;

    if (h1.minuto < h2.minuto) {
        h1.minuto += 60;
        h1.hora--;
    }
    horario_restado.minuto = h1.minuto - h2.minuto;

    horario_restado.hora = h1.hora - h2.hora;

    return horario_restado;
}

void Tiempo_Dias(Tiempo h){
    double dias = 0;
    int año = 0;

    while(h.segundo > 60){
        h.segundo -= 60;
        h.minuto += 1;
    }
    while(h.minuto > 60){
        h.minuto -= 60;
        h.hora += 1;
    }

    while(h.hora > 24){
        dias += 1;
        h.hora -=24;
    }
    
    if(dias>365){
        año += 1;
        dias -=365;
    }

    printf("Tiempo ingresado representa %d años, %lf días.\n", año, dias);

}



int main(){

    int hora1 = 8800, minuto1 = 15, segundo1 = 30;
    // int hora2, minuto2, segundo2;

    // printf("Ingrese hora | minutos | segundos para horario 1: ");
    // scanf("%d%d%d",&hora1,&minuto1,&segundo1);

    // printf("Ingrese hora | minutos | segundos para horario 2: ");
    // scanf("%d%d%d",&hora2,&minuto2,&segundo2);

    Tiempo h1 = crear_Tiempo(hora1,minuto1,segundo1);
    // Tiempo h2 = crear_Tiempo(hora2,minuto2,segundo2);

    // imprimir_Tiempo(h1);
    // imprimir_Tiempo(h2);

    // Tiempo horario_sumado = suma_Tiempo(h1,h2);
    // printf("El horario sumado es: %02d:%02d:%02d\n", horario_sumado.hora, horario_sumado.minuto, horario_sumado.segundo);

    // Tiempo horario_restado = resta_Tiempo(h1,h2);
    // printf("El horario restado es: %02d:%02d:%02d\n", horario_restado.hora, horario_restado.minuto, horario_restado.segundo);

    Tiempo_Dias(h1);
    //Tiempo_Dias(h2);
    
    return 0;
}*/

//Ejercicio 5

/*struct Numero_Complejo {
    int parte_real;
    int parte_imaginaria;
};

typedef struct Numero_Complejo Complejo;

Complejo crear_complejo(int real, int imaginaria){
    Complejo numero_complejo = {real, imaginaria};
    return numero_complejo;
}

Complejo suma_complejos(Complejo n1, Complejo n2){
    Complejo complejo_sumado;
    complejo_sumado.parte_real = n1.parte_real + n2.parte_real;
    complejo_sumado.parte_imaginaria = n1.parte_imaginaria + n2.parte_imaginaria;
    return complejo_sumado;
}

Complejo resta_complejos(Complejo n1, Complejo n2){
    Complejo complejo_restado;
    complejo_restado.parte_real = n1.parte_real - n2.parte_real;
    complejo_restado.parte_imaginaria = n1.parte_imaginaria - n2.parte_imaginaria;
    return complejo_restado;
}

Complejo multiplica_complejos(Complejo n1, Complejo n2){
    Complejo complejo_multiplicado; //(a+bi)*(c+di) = ac + adi + cbi + bd = (ac + bd) + (ad + cb)i
    complejo_multiplicado.parte_real = n1.parte_real*n2.parte_real - n1.parte_imaginaria*n2.parte_imaginaria;
    complejo_multiplicado.parte_imaginaria = n1.parte_real*n2.parte_imaginaria + n2.parte_real*n1.parte_imaginaria;
    return complejo_multiplicado;
}

int main(){

    int a = 2, b = -5;
    int c = 3, d = 6;

    Complejo n1_complejo = crear_complejo(a,b);
    Complejo n2_complejo = crear_complejo(c,d);

    printf("Numero complejo 1: %d + %di.\n",n1_complejo.parte_real,n1_complejo.parte_imaginaria);
    printf("Numero complejo 2: %d + %di.\n",n2_complejo.parte_real,n2_complejo.parte_imaginaria);

    Complejo suma = suma_complejos(n1_complejo, n2_complejo);

    printf("La suma entre (%d + %di) y (%d + %di) es: (%d + %di).\n", n1_complejo.parte_real,n1_complejo.parte_imaginaria,n2_complejo.parte_real,n2_complejo.parte_imaginaria, suma.parte_real, suma.parte_imaginaria);

    Complejo resta = resta_complejos(n1_complejo, n2_complejo);

    printf("La resta entre (%d + %di) y (%d + %di) es: (%d + %di).\n", n1_complejo.parte_real,n1_complejo.parte_imaginaria,n2_complejo.parte_real,n2_complejo.parte_imaginaria, resta.parte_real,resta.parte_imaginaria);

    Complejo mult = multiplica_complejos(n1_complejo, n2_complejo);

    printf("La suma entre (%d + %di) y (%d + %di) es: (%d + %di).\n", n1_complejo.parte_real,n1_complejo.parte_imaginaria,n2_complejo.parte_real,n2_complejo.parte_imaginaria, mult.parte_real,mult.parte_imaginaria);

    return 0;
}*/
 
//Ejercicio 6

/*typedef struct {
    char* nombre, *apellido, *direccion;
    int dni, telefono, edad;
} Persona;

typedef struct {
    Persona persona;
    char* carrera;
    int año_cursada;
} Estudiante;

Persona crear_Persona(){

    int edad, dni, telefono;
    char temp[100];
    
    printf("\nIngrese un nombre: ");
    scanf("%s",temp);
    char* nombre = malloc(sizeof(char)*(strlen(temp)+1));
    strcpy(nombre,temp);

    printf("Ingrese un apellido: ");
    scanf("%s",temp);
    char* apellido = malloc(sizeof(char)*(strlen(temp)+1));
    strcpy(apellido,temp);

    printf("Ingrese una direccion: ");
    scanf("%s",temp);
    char* direccion = malloc(sizeof(char)*(strlen(temp)+1));
    strcpy(direccion,temp);

    printf("Ingrese una edad: ");
    scanf("%d",&edad);

    printf("Ingrese un dni: ");
    scanf("%d",&dni);

    printf("Ingrese un telefono: ");
    scanf("%d",&telefono);
    
    Persona p = {nombre, apellido, direccion, dni, telefono, edad};
    return p;
}

Estudiante crear_Estudiante(){
   
    Persona p = crear_Persona();
    char temp[100];
    int año_cursada;

    printf("\nIngrese una carrea: ");
    scanf("%s",temp);
    char* carrera = malloc(sizeof(char)*(strlen(temp)+1));
    strcpy(carrera,temp);

    printf("Ingrese el año al que va: ");
    scanf("%d",&año_cursada);
    
    Estudiante estudiante = {p,carrera,año_cursada};
    return estudiante;
}

void imprimir_Persona(Persona p){
    printf("\nPERSONA:\n");
    printf("Nombre y apellido: %s %s.\n", p.nombre, p.apellido);
    printf("Edad: %d.\n", p.edad);
    printf("Dni: %d.\n", p.dni);
    printf("Direccion: %s.\n",p.direccion);
    printf("Telefono: %d.\n", p.telefono);
}

void imprimir_Estudiante(Estudiante e){
    imprimir_Persona(e.persona);
    printf("Carrera: %s.\n", e.carrera);
    printf("Año de cursada: %d.",e.año_cursada);
}

int igual_identidad(Persona p1, Persona p2){
    int condicion = 0;
    
    if(p1.dni == p2.dni){
        condicion = 1;
    }
    return condicion;
}

int familia(Persona p1, Persona p2){
    int condicion = 0;
    if(strcmp(p1.apellido,p2.apellido) == 1 && strcmp(p1.direccion,p2.direccion) == 1){
        condicion = 1;
    }
    return condicion;
}

int main(){

    //Persona p1 = crear_Persona();
    // Persona p2 = crear_Persona();

    Estudiante e1 = crear_Estudiante();

    imprimir_Estudiante(e1);

    // int sonFamilia = familia(p1,p2);
    // if(sonFamilia){
    //     printf("Son familia.\n");
    // } else{
    //     printf("No son familia");
    // }

    free(e1.persona.nombre);
    free(e1.persona.apellido);
    free(e1.persona.direccion);
    free(e1.carrera);
    // free(p2.nombre);
    // free(p2.apellido);
    // free(p2.direccion);

    return 0;
}*/

//Ejercicio 7

typedef struct {
    char* palo;
    int valor;
} Carta;

Carta crear_Carta(char* palo, int valor){
    Carta carta = {palo, valor};
    return carta;

    // int valor;
    // char temp[30];

    // printf("Ingrese un palo(O,C,E,B): ");
    // scanf("%s", temp);

    // while (strcmp(temp, "O") != 0 && strcmp(temp, "C") != 0 && strcmp(temp, "E") != 0 && strcmp(temp, "B") != 0) {
    //     printf("Palo inválido. Ingrese un palo válido ('O', 'C', 'E', 'B'): ");
    //     scanf("%s", temp);
    // }

    // char* palo = malloc(sizeof(char)*(strlen(temp)+1));
    // strcpy(palo, temp);

    // printf("Ingrese un valor(1 a 12): ");
    // scanf("%d", &valor);

    // while(valor < 1 || valor > 12){
    //     printf("Valor fuera de rango. Ingrese un valor valido (1 a 12): ");
    //     scanf("%d", &valor);
    // }

    //Carta carta = {palo, valor};
    //return carta;
}

Carta barajar(){
    char* palos[4] = {"O","E","B","C"};
    int valor = (rand() % 12)+1;
    int indice_palo = rand() % 4;

    Carta carta = crear_Carta(palos[indice_palo],valor);
    return carta;
}

int es_igual(Carta c1, Carta c2){
    int condicion = 0;
    if(strcmp(c1.palo,c2.palo) == 0 && c1.valor == c1.valor){
        condicion = 1;
    }
    return condicion;
}

int es_igualPalo(Carta c1, Carta c2){
    int condicion = 0;
    if(strcmp(c1.palo,c2.palo) == 0){
        condicion = 1;
    }
    return condicion;
}

int es_igualNumero(Carta c1, Carta c2){
    int condicion = 0;
    if(c1.valor == c1.valor){
        condicion = 1;
    }
    return condicion;
}

int es_full(Carta c1, Carta c2, Carta c3, Carta c4){
    int condicion = 0;
    if ((es_igualNumero(c1, c2) && es_igualNumero(c3, c4) && !es_igualPalo(c1, c2) && !es_igualPalo(c3, c4)) ||
        (es_igualNumero(c1, c3) && es_igualNumero(c2, c4) && !es_igualPalo(c1, c3) && !es_igualPalo(c2, c4)) ||
        (es_igualNumero(c1, c4) && es_igualNumero(c2, c3) && !es_igualPalo(c1, c4) && !es_igualPalo(c2, c3))) {
        condicion = 1;
    }
    return condicion;
}


int es_poker(Carta c1, Carta c2, Carta c3, Carta c4){
    int condicion = 0;
    if(es_igualNumero(c1,c2) && es_igualNumero(c2,c3) && es_igualNumero(c3,c4)){
        condicion = 1;
    }
    return condicion;
}

int es_escalera(Carta c1, Carta c2, Carta c3, Carta c4){
    int condicion = 0;
    if(es_igualPalo(c1,c2) && es_igualPalo(c2,c3) && es_igualPalo(c3,c4)){
        
    }

}

int main(){

    srand(time(NULL));
    Carta carta = barajar();
    printf("%d %s\n",carta.valor, carta.palo);

    return 0;
}