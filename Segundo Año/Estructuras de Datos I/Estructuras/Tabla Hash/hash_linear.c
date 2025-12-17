#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hash_linear.h"


typedef enum {
  VACIA,
  OCUPADA,
  BORRADA
} EstadoCasilla;

/**
 * Casillas donde se almacenan los datos en la tabla.
 */
typedef struct {
  void *dato;
  EstadoCasilla estado;
} CasillaHash;

/**
 * Estructura de la tabla hash.
 */
struct _TablaHash {
    CasillaHash *elems;
    unsigned numElems;
    unsigned capacidad;
    FuncionCopiadora copia;
    FuncionComparadora comp;
    FuncionDestructora destroy;
    FuncionHash hash;

};

TablaHash tablahash_crear (unsigned capacidad, FuncionCopiadora copy, FuncionComparadora comp, FuncionDestructora destroy, FuncionHash fHash) {
  TablaHash tabla = malloc(sizeof(struct _TablaHash));
  tabla->elems = malloc(sizeof(CasillaHash)*capacidad);
  tabla->numElems = 0;
  tabla->capacidad = capacidad;
  tabla->copia = copy;
  tabla->comp = comp;
  tabla->destroy = destroy;
  tabla->hash = fHash;

  for (unsigned i = 0 ; i < capacidad ; ++i) {
    tabla->elems[i].dato = NULL;
    tabla->elems[i].estado = VACIA;
  }

  return tabla;
}

int tablahash_nelems (TablaHash tabla) { return tabla->numElems; }

int tablahash_capacidad (TablaHash tabla) { return tabla->capacidad; }

void tablahash_destruir (TablaHash tabla) {
  for (unsigned i = 0 ; i < tabla->capacidad ; ++i)
    if(tabla->elems[i].dato != NULL)
      tabla->destroy(tabla->elems[i].dato);

  free(tabla->elems);
  free(tabla);
}

void tablahash_insertar(TablaHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  unsigned bandera = 0;
  int borrado = -1;

  for (unsigned i = 0 ; i < tabla->capacidad && !bandera; i++) {
    unsigned pos = (idx + i) % tabla->capacidad;

    if (tabla->elems[pos].estado == BORRADA)
      if (borrado == -1)
        borrado = pos;

    if (tabla->elems[pos].estado == OCUPADA) {
      if (tabla->comp(tabla->elems[pos].dato, dato) == 0) {
        tabla->destroy(tabla->elems[pos].dato);
        tabla->elems[pos].dato = tabla->copia(dato);
        bandera = 1;
      }
    }

    else if (tabla->elems[pos].estado == VACIA) {
      unsigned posFinal = borrado != -1 ? (unsigned)borrado : pos;
      tabla->elems[posFinal].dato = tabla->copia(dato);
      tabla->elems[posFinal].estado = OCUPADA;
      tabla->numElems++;
      bandera = 1;
    }
  }

  if (!bandera && borrado != -1) {
    tabla->elems[borrado].dato = tabla->copia(dato);
    tabla->elems[borrado].estado = OCUPADA;
    tabla->numElems++;
  }
}

void *tablahash_buscar(TablaHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  void *datoEncontrado = NULL;
  int encontrado = 0;
  int vacio = 0;

  for (unsigned i = 0 ; i < tabla->capacidad && !encontrado && !vacio; ++i) {
    unsigned pos = (idx + i) % tabla->capacidad;

    if (tabla->elems[pos].estado == VACIA)
      vacio = 1;
    else if (tabla->elems[pos].estado == OCUPADA && 
             tabla->comp(tabla->elems[pos].dato, dato) == 0) {
      datoEncontrado = tabla->elems[pos].dato;
      encontrado = 1;
    }
  }

  return datoEncontrado;
}

void tablahash_eliminar(TablaHash tabla, void *dato) {
  unsigned idx = tabla->hash(dato) % tabla->capacidad;

  int eliminado = 0;
  int vacio = 0;

  for (unsigned i = 0 ; i < tabla->capacidad && !vacio && !eliminado ; ++i) {
    unsigned pos = (idx + i) % tabla->capacidad;

    if (tabla->elems[pos].estado == VACIA)
      vacio = 1;
    else if (tabla->elems[pos].estado == OCUPADA && tabla->comp(tabla->elems[pos].dato, dato) == 0) {
      tabla->destroy(tabla->elems[pos].dato);
      tabla->elems[pos].dato = NULL;
      tabla->elems[pos].estado = BORRADA;
      tabla->numElems--;
      eliminado = 1;
    }
  }
}

// TablaHash tablahash_redimensionar (TablaHash tabla) {
//   unsigned nuevaCapacidad = tabla->capacidad * 2;
//   TablaHash nuevaTabla = tablahash_crear(nuevaCapacidad, tabla->copia, tabla->comp, tabla->destroy, tabla->hash);
//   for (unsigned i = 0 ; i < tabla->capacidad ; ++i)
//     if (tabla->elems[i].estado == OCUPADA)
//       tablahash_insertar(nuevaTabla, tabla->elems[i].dato);

//   tablahash_destruir(tabla);
//   return nuevaTabla;
// }

void tablahash_redimensionar(TablaHash tabla) {
  unsigned nuevaCapacidad = tabla->capacidad * 2;
  
  CasillaHash *nuevosElems = malloc(sizeof(CasillaHash) * nuevaCapacidad);
  
  for (unsigned i = 0; i < nuevaCapacidad; ++i) 
    nuevosElems[i].estado = VACIA;

  for (unsigned i = 0; i < tabla->capacidad; ++i) {
    if (tabla->elems[i].estado == OCUPADA) {
      
      unsigned idx = tabla->hash(tabla->elems[i].dato) % nuevaCapacidad;
      
      while (nuevosElems[idx].estado != VACIA)
        idx = (idx + 1) % nuevaCapacidad;

      nuevosElems[idx].dato = tabla->elems[i].dato;
      nuevosElems[idx].estado = OCUPADA;
    }
  }
  free(tabla->elems);

  tabla->elems = nuevosElems;
  tabla->capacidad = nuevaCapacidad;
}

// =============================================================
// FUNCIONES AUXILIARES (Para manejar Strings)
// =============================================================

// 1. Copia: strdup (hace malloc internamente)
void *copiar_str(void *dato) {
    char *s = (char*)dato;
    // strdup reserva memoria y copia el string
    char *copia = malloc(strlen(s) + 1);
    if (copia) strcpy(copia, s);
    return copia;
}

// 2. Comparar: strcmp
int comparar_str(void *dato1, void *dato2) {
    return strcmp((char*)dato1, (char*)dato2);
}

// 3. Destruir: free
void destruir_str(void *dato) {
    free(dato);
}

// 4. Hash: Una función simple para Strings
// Usaremos una MUY simple para forzar colisiones en el Test
unsigned hash_simple(void *dato) {
    char *s = (char*)dato;
    // Retornamos el valor ASCII del primer caracter.
    // Esto garantiza que palabras que empiecen con la misma letra colisionen.
    return (unsigned)s[0];
}

// Helper para imprimir resultados
void verificar(int condicion, const char *mensaje) {
    if (condicion) {
        printf("[OK] %s\n", mensaje);
    } else {
        printf("[ERROR] %s\n", mensaje);
    }
}

// =============================================================
// MAIN DE PRUEBAS
// =============================================================

int main() {
    printf("=== TEST TABLA HASH (LINEAR PROBING) ===\n\n");

    // Creamos tabla pequeña (capacidad 7) para llenar rápido y colisionar
    TablaHash tabla = tablahash_crear(7, copiar_str, comparar_str, destruir_str, hash_simple);

    // 1. INSERCIÓN SIN COLISIÓN
    char *s1 = "Auto";   // Hash 'A' (65) % 7 = 2
    char *s2 = "Barco";  // Hash 'B' (66) % 7 = 3
    
    tablahash_insertar(tabla, s1);
    tablahash_insertar(tabla, s2);
    
    verificar(tablahash_nelems(tabla) == 2, "Elementos insertados correctamente");
    char *res = (char*)tablahash_buscar(tabla, "Auto");
    verificar(res != NULL && strcmp(res, "Auto") == 0, "Buscar 'Auto' funciona");

    // 2. COLISIONES (LINEAR PROBING)
    // Vamos a insertar palabras que empiecen con 'A' para que colisionen en el índice 2.
    // Indice 2 ("Auto") -> Ocupado
    // Indice 3 ("Barco") -> Ocupado
    // Indice 4 (VACIO) -> Debería ir "Avion"
    // Indice 5 (VACIO) -> Debería ir "Arbol"
    
    char *s3 = "Avion"; // Hash 'A' -> Colisiona con Auto -> Salta Barco -> Cae en 4
    char *s4 = "Arbol"; // Hash 'A' -> Colisiona -> ... -> Cae en 5
    
    tablahash_insertar(tabla, s3);
    tablahash_insertar(tabla, s4);

    verificar(tablahash_buscar(tabla, "Avion") != NULL, "Buscar elemento con colision (Avion)");
    verificar(tablahash_buscar(tabla, "Arbol") != NULL, "Buscar elemento con colision multiple (Arbol)");

    // 3. ACTUALIZACIÓN (DUPLICADOS)
    // Insertamos "Auto" de nuevo. No debe aumentar nelems, debe liberar el viejo y poner el nuevo.
    // Como son strings iguales no notamos el cambio de dato, pero Valgrind notará el free/malloc.
    tablahash_insertar(tabla, "Auto");
    verificar(tablahash_nelems(tabla) == 4, "Insertar duplicado no aumenta cantidad de elementos");

    // 4. ELIMINACIÓN Y ESTADO 'BORRADA' (Lazy Deletion)
    // Borramos "Avion". Esto estaba en medio de la cadena de colisión de las 'A'.
    // Estructura logica: [Auto, Barco, BORRADA(Avion), Arbol]
    printf("\n--- Eliminando 'Avion' (Puente) ---\n");
    tablahash_eliminar(tabla, "Avion");
    
    verificar(tablahash_buscar(tabla, "Avion") == NULL, "Avion ya no existe");
    
    // PRUEBA CRÍTICA: Buscar "Arbol".
    // Si el algoritmo se detiene en BORRADA, no encontrará Arbol.
    // Si salta BORRADA (funciona bien), encontrará Arbol.
    verificar(tablahash_buscar(tabla, "Arbol") != NULL, "El puente BORRADA funciona (encontro Arbol)");

    // 5. RECICLAJE DE CELDAS
    // Insertamos "Azul". Debería tomar el lugar de "Avion" (que está BORRADA)
    // en vez de irse al final.
    tablahash_insertar(tabla, "Azul");
    verificar(tablahash_buscar(tabla, "Azul") != NULL, "Inserto 'Azul' reciclando espacio");

    // 6. BUSQUEDA DE NO EXISTENTE
    verificar(tablahash_buscar(tabla, "Zapato") == NULL, "Buscar elemento inexistente da NULL");

    // 7. DESTRUCCIÓN
    printf("\n--- Destruyendo Tabla ---\n");
    tablahash_destruir(tabla);
    printf("Tabla destruida.\n");

    return 0;
}