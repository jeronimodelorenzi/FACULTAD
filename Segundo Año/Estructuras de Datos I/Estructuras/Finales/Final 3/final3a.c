#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAM_TABLA 19683

typedef struct _NodoHash {
  char *palabra;
  struct _NodoHash *sig;
} NodoHash;

typedef struct _TablaHash {
  NodoHash *elems[TAM_TABLA];
  int contadores[27];
} *TablaHash;

unsigned int funcion_hash (char *palabra) {
  int len = strlen(palabra);
  unsigned h = 0;

  if (len > 0)
    h += (palabra[0] - 'a') * 729; // 27^2

  if (len > 1)
    h += (palabra[1]-'a') * 27; // 27^1
    
  if (len > 2)
    h += (palabra[2]-'a');  //27^0

  return h % TAM_TABLA;
}

TablaHash tablahash_crear () {
  TablaHash tabla = malloc(sizeof(struct _TablaHash));
  for (unsigned i = 0 ; i < TAM_TABLA ; ++i) tabla->elems[i] = NULL;
  for (unsigned i = 0 ; i < 27 ; ++i) tabla->contadores[i] = 0;
  return tabla;
}

void tablahash_insertar (TablaHash tabla, char *palabra) {
  unsigned idx = funcion_hash(palabra);

  NodoHash *nuevoNodo = malloc(sizeof(NodoHash));
  nuevoNodo->palabra = strdup(palabra);
  nuevoNodo->sig = tabla->elems[idx];
  tabla->elems[idx] = nuevoNodo;

  if (strlen(palabra) > 0) {
    int letra = palabra[0] - 'a';
    tabla->contadores[letra]++;
  }
}

void buscar_3_letras (TablaHash tabla, char *p3_letras) {
  unsigned idx = funcion_hash(p3_letras);
  NodoHash *temp = tabla->elems[idx];

  printf("Palabras que comienzan con '%s'\n", p3_letras);
  while (temp != NULL) {
    if (strncmp(temp->palabra, p3_letras, 3) == 0)
      printf(" %s\n", temp->palabra);
    temp = temp->sig;
  }
}

int contar_palabras (TablaHash tabla, char c) {
  int idx = c - 'a';
  if (idx >= 0 && idx < 27)
    return tabla->contadores[idx];
  return 0;
}

void tablahash_eliminar (TablaHash tabla, char *palabra) {
  unsigned idx = funcion_hash(palabra);
  NodoHash *act = tabla->elems[idx];
  NodoHash *ant = NULL;
  int bandera = 0;

  while (act != NULL && !bandera) {
    if (strcmp(act->palabra, palabra) == 0) {
      if (ant == NULL)
        tabla->elems[idx] = act->sig;
      else
        ant->sig = act->sig;
    
    free(act->palabra);
    free(act);

    if (strlen(palabra) > 0)
      tabla->contadores[palabra[0]-'a']--;

    bandera = 1;
    } else {
      ant = act;
      act = act->sig;
    }
  }
}

void tablahash_destruir(TablaHash tabla) {
    if (tabla == NULL) return;

    for (int i = 0; i < TAM_TABLA; i++) {
        NodoHash *actual = tabla->elems[i];
        while (actual != NULL) {
            NodoHash *borrar = actual;
            actual = actual->sig;
            
            free(borrar->palabra); 
            free(borrar);          
        }
    }
    free(tabla); 
}

void tablahash_mostrar(TablaHash tabla) {
    printf("\n=== CONTENIDO DE LA TABLA HASH ===\n");
    for (int i = 0; i < TAM_TABLA; i++) {
        NodoHash *temp = tabla->elems[i];
        if (temp != NULL) {
            printf("[%d] -> ", i);
            while (temp != NULL) {
                printf("%s -> ", temp->palabra);
                temp = temp->sig;
            }
            printf("NULL\n");
        }
    }
    printf("===================================\n");
}

int main() {
    TablaHash T = tablahash_crear();

    // Insertamos palabras
    tablahash_insertar(T, "gato");
    tablahash_insertar(T, "gallina");
    tablahash_insertar(T, "gamba");
    tablahash_insertar(T, "perro");
    tablahash_insertar(T, "persona");
    tablahash_insertar(T, "pescado");
    tablahash_insertar(T, "pato");
    tablahash_insertar(T, "pala");
    tablahash_insertar(T, "casa");
    tablahash_insertar(T, "cama");
    tablahash_insertar(T, "camion");
    tablahash_insertar(T, "camisa");
    tablahash_insertar(T, "canto");
    tablahash_insertar(T, "cabra");

    printf("\n=== Palabras insertadas ===\n");
    tablahash_mostrar(T);

    // Buscar por 3 letras
    printf("\n=== Buscando palabras que empiezan con \"cam\" ===\n");
    buscar_3_letras(T, "cam");

    printf("\n=== Buscando palabras que empiezan con \"pes\" ===\n");
    buscar_3_letras(T, "pes");

    // Contar palabras por letra inicial
    printf("\nCantidad de palabras que empiezan con 'c': %d\n",
           contar_palabras(T, 'c'));

    printf("Cantidad de palabras que empiezan con 'g': %d\n",
           contar_palabras(T, 'g'));

    printf("Cantidad de palabras que empiezan con 'p': %d\n",
           contar_palabras(T, 'p'));

    // Eliminar palabras
    printf("\n=== Eliminando palabra 'camisa' ===\n");
    tablahash_eliminar(T, "camisa");

    printf("=== Eliminando palabra 'gato' ===\n");
    tablahash_eliminar(T, "gato");

    printf("\n=== Tabla luego de eliminar ===\n");
    tablahash_mostrar(T);

    // Buscar otra vez para ver si realmente se eliminaron
    printf("\n=== Buscando palabras que empiezan con \"cam\" luego de eliminar ===\n");
    buscar_3_letras(T, "cam");

    tablahash_destruir(T);

    return 0;
}

