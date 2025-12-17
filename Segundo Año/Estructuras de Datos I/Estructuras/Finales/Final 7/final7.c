#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum color {Rojo , Azul , Neutro} Color;

typedef struct Nodo_ {
  char* cdato;
  Color colorNodo;
  struct Nodo_ *der , *izq;
} Nodo;

typedef Nodo* ArbolBinarioColoreado;


ArbolBinarioColoreado arbolCrear () { return NULL; }

ArbolBinarioColoreado arbolUnir (ArbolBinarioColoreado izq, ArbolBinarioColoreado der, char* str, Color color) {
  ArbolBinarioColoreado nuevoNodo = malloc(sizeof(Nodo));
  nuevoNodo->cdato = strdup(str);
  nuevoNodo->colorNodo = color;
  nuevoNodo->izq = izq;
  nuevoNodo->der = der;
  return nuevoNodo;
}

void arbolDestruir (ArbolBinarioColoreado inicio) {
  if (inicio != NULL) {
    arbolDestruir(inicio->izq);
    arbolDestruir(inicio->der);
    free(inicio->cdato);
    free(inicio); 
  }
}

// int cant_color (ArbolBinarioColoreado inicio , Color color, int *cantidad) {
//     if (inicio == NULL) return 0;
  
//     if (color == inicio->colorNodo) *cantidad = *cantidad + 1;
  
//     *cantidad = cant_color(inicio->izq, color, cantidad) + cant_color(inicio->der, color, cantidad);
//     return *cantidad; 
// }

int cant_color (ArbolBinarioColoreado inicio , Color color) {
  if (inicio == NULL) return 0;

  int cantColor = cant_color(inicio->izq, color) + cant_color(inicio->der, color); 
  if (color == inicio->colorNodo) cantColor++;
  return cantColor;
}

Color color (ArbolBinarioColoreado inicio) {
  int cantColorRojo = cant_color(inicio, Rojo);
  int cantColorAzul = cant_color(inicio, Azul);

  if (cantColorAzul < cantColorRojo) return Rojo;
  if (cantColorAzul > cantColorRojo) return Azul;
  return Neutro;
}

void arbolRecorrer (ArbolBinarioColoreado inicio) {
  if (inicio == NULL) return;

  arbolRecorrer(inicio->izq);
  printf("Contenido = %s\n", inicio->cdato);
  arbolRecorrer(inicio->der);
}

int cantidadPurasAux (ArbolBinarioColoreado inicio, Color color) {
  if (inicio == NULL) return 0;

  if (color != inicio->colorNodo) return 0;

  if (inicio->izq == NULL && inicio->der == NULL) return 1;

  return cantidadPurasAux(inicio->izq, color) + cantidadPurasAux(inicio->der, color);
}

int cantidadPuras (ArbolBinarioColoreado inicio) {
  if (inicio == NULL) return 0;
  return cantidadPurasAux(inicio, inicio->colorNodo);
}

typedef enum _EstadoCasilla {
  VACIA, BORRADA, OCUPADA
} EstadoCasilla;

typedef struct {
  int dato;
  EstadoCasilla estado;
} CasillaHash;
  
struct _TablaHash {
  CasillaHash *elems;
  unsigned numElems;
  unsigned capacidad;
};

typedef struct _TablaHash *TablaHash;

int tablahash_buscar (TablaHash tabla, int dato) {
  unsigned idx = dato % tabla->capacidad;

  int datoEncontrado;
  int vacio = 0;
  int encontrado = 0;

  for (unsigned i = 0 ; i < tabla->capacidad && !encontrado; ++i) {
    unsigned pos = (idx + 1) % tabla->capacidad;

    if (tabla->elems[pos].estado == VACIA)
      vacio = 1;
    else if (tabla->elems[pos].estado == OCUPADA && dato == tabla->elems[pos].dato) {
      datoEncontrado = dato;
      encontrado = 1;
    }
  }
  return datoEncontrado;
}


int main () {
  
  ArbolBinarioColoreado arbol1 = arbolUnir(NULL, NULL, "R", Rojo);
  ArbolBinarioColoreado arbol8 = arbolUnir(NULL, NULL, "R", Rojo);
  ArbolBinarioColoreado arbol2 = arbolUnir(NULL, NULL, "R", Rojo);
  ArbolBinarioColoreado arbol3 = arbolUnir(NULL, NULL, "A", Azul);
  ArbolBinarioColoreado arbol4 = arbolUnir(arbol1, arbol8, "Rojo", Rojo);
  ArbolBinarioColoreado arbol5 = arbolUnir(arbol3, NULL, "A", Azul);
  ArbolBinarioColoreado arbol6 = arbolUnir(arbol2, arbol5, "R", Rojo);
  ArbolBinarioColoreado arbol7 = arbolUnir(arbol4, arbol6, "R", Rojo);
  
  arbolRecorrer(arbol7);
  puts("");
  
  int cantRojo = cant_color(arbol7, Rojo);
  int cantAzul = cant_color(arbol7, Azul);
  
  printf("Cantidad rojo = %d.\n", cantRojo);
  printf("Cantidad azul = %d.\n", cantAzul);

  Color colorDelArbol = color(arbol7);
  if (colorDelArbol == Rojo) printf("El arbol es rojo\n");
  else if (colorDelArbol == Azul) printf("El arbol es azul\n");
  else printf("El arbol tiene color neutro\n");


  int cantPuras = cantidadPuras(arbol7);
  printf("Cantidad de hojas puras: %d\n", cantPuras);

  arbolDestruir(arbol7);

  return 0;
}