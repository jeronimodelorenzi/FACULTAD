#include <stdio.h>
#include <stdlib.h>
#include "heap.h"

#define RIGHT(i) (2*i)
#define LEFT(i) ((2*i)+1)
#define PARENT(i) (i/2)

static void swap (void **a, void **b) {
  void *temp = *a;
  *a = *b;
  *b = temp;
}

static void hundir (BHeap heap, int pos) {
  int mayor = pos;
  if (LEFT(pos) <= heap->ultimo && heap->comp(heap->arr[LEFT(pos)], heap->arr[mayor]) > 0)
    mayor = LEFT(pos);
  if (RIGHT(pos) <= heap->ultimo && heap->comp(heap->arr[RIGHT(pos)], heap->arr[mayor]) > 0)
    mayor = RIGHT(pos);
  if (mayor != pos) {
    swap(&heap->arr[pos], &heap->arr[mayor]);
    hundir(heap, mayor);
  }
}

static void flotar (BHeap heap, int pos) {
  if (pos <= 1) return;
  int pos_padre = PARENT(pos);
  if (heap->comp(heap->arr[pos], heap->arr[pos_padre]) > 0) {
    swap(&heap->arr[pos], &heap->arr[pos_padre]);
    flotar(heap, pos_padre);
  }
}

BHeap bheap_crear (int capacidad, FuncionComparadora comp, FuncionCopiadora copy, FuncionDestructora destroy) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = malloc(sizeof(void*)*(capacidad + 1));
  heap->capacidad = capacidad;
  heap->ultimo = 0;
  heap->comp = comp;
  heap->copy = copy;
  heap->destroy = destroy;
  return heap;
}

BHeap bheap_crear_desde_arr (void **arr, int n, FuncionCopiadora copy, FuncionComparadora comp, FuncionDestructora destroy) {
  BHeap heap = malloc(sizeof(struct _BHeap));
  heap->arr = malloc(sizeof(void*) * (n+1));
  heap->capacidad = n;
  heap->ultimo = n;
  heap->comp = comp;
  heap->copy = copy;
  heap->destroy = destroy;

  for (int i = 0 ; i < n ; i++)
    heap->arr[i+1] = arr[i];

  for (int i = n/2 ; i >= 1 ; i--)
    hundir(heap, i);

  return heap;
}

void bheap_destruir (BHeap heap) {
  bheap_recorrer(heap, heap->destroy);
  free(heap->arr);
  free(heap);
}

int bheap_es_vacio (BHeap heap) {
  return heap->ultimo == 0;
}

void bheap_recorrer (BHeap heap, FuncionVisitante visit) {
  for (int i = 1 ; i <= heap->ultimo ; i++)
    visit(heap->arr[i]);
}

BHeap bheap_insertar (BHeap heap, void *dato) {
  if (heap->ultimo == heap->capacidad) {
    heap->capacidad = heap->capacidad*2;
    heap->arr = realloc(heap->arr, sizeof(void*)*(heap->capacidad+1));
  }

  heap->ultimo++;
  heap->arr[heap->ultimo] = heap->copy(dato);

  flotar(heap, heap->ultimo);

  return heap;
}

BHeap bheap_eliminar (BHeap heap, int pos) {
  if(bheap_es_vacio(heap)) return NULL;

  void *elem = heap->arr[pos];
  heap->arr[pos] = heap->arr[heap->ultimo];
  heap->ultimo--;

  heap->destroy(elem);

  if (pos > 1 && heap->comp(heap->arr[pos], heap->arr[PARENT(pos)]) > 0)
    flotar(heap, pos);
  else
    hundir(heap, pos);

  return heap;
}

void *bheap_pop (BHeap heap) {
  void *max = heap->arr[1];
  heap->arr[1] = heap->arr[heap->ultimo];
  heap->ultimo--;
  hundir(heap, 1);
  return max;
}

static void* no_copia (void *dato){
    return dato;
  }
  
static void no_destruye (void *dato) {
  (void)dato;
  return;
}

void bheap_sort (void **arr, int n, FuncionComparadora comp) {
  BHeap heap = bheap_crear_desde_arr (arr, n, no_copia, comp, no_destruye);
  for (int i = n-1 ; i >= 0 ; i--) {
    void *max = bheap_pop(heap);
    arr[i] = max;
  }
  bheap_destruir(heap);
}

// =============================================================
// FUNCIONES AUXILIARES (Para manejar datos dinámicos - int*)
// =============================================================

// Copia: Reserva memoria nueva en el Heap
void *copiar_int(void *dato) {
    int *nuevo = malloc(sizeof(int));
    if (nuevo == NULL) return NULL;
    *nuevo = *(int*)dato;
    return nuevo;
}

// Comparar: a - b (Para Max-Heap, los mayores "flotan")
int comparar_int(void *a, void *b) {
    int numA = *(int*)a;
    int numB = *(int*)b;
    return numA - numB;
}

// Destruir: Libera la memoria
void destruir_int(void *dato) {
    free(dato);
}

// Imprimir: Muestra el dato
void imprimir_int(void *dato) {
    printf("%d ", *(int*)dato);
}

// Helper para validaciones en consola
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
    printf("=== INICIO DE PRUEBAS: BINARY HEAP ===\n\n");

    // -------------------------------------------------------------
    // PRUEBA 1: Inserción Manual y Pop (Propiedad Max-Heap)
    // -------------------------------------------------------------
    printf("--- Test 1: Insercion y Pop ---\n");
    
    // Creamos heap con capacidad pequeña para forzar realloc (si está implementado)
    BHeap heap = bheap_crear(4, comparar_int, copiar_int, destruir_int);
    
    int v1=10, v2=50, v3=20, v4=5, v5=60, v6=30;

    // Insertamos desordenado
    bheap_insertar(heap, &v1); // 10
    bheap_insertar(heap, &v2); // 50
    bheap_insertar(heap, &v3); // 20
    bheap_insertar(heap, &v4); // 5
    bheap_insertar(heap, &v5); // 60 (Debería subir a la raíz)
    bheap_insertar(heap, &v6); // 30

    printf("Elementos insertados: 10, 50, 20, 5, 60, 30\n");
    printf("Recorrido (orden interno del arreglo): ");
    bheap_recorrer(heap, imprimir_int);
    printf("\n");

    // Sacamos el máximo (Debería ser 60)
    int *max1 = (int*) bheap_pop(heap);
    verificar(*max1 == 60, "Primer Pop es 60 (Maximo global)");
    free(max1); // Importante: bheap_pop te devuelve el puntero, ahora es tu responsabilidad

    // Sacamos el siguiente (Debería ser 50)
    int *max2 = (int*) bheap_pop(heap);
    verificar(*max2 == 50, "Segundo Pop es 50");
    free(max2);

    // Destruimos el resto (10, 20, 5, 30 deben ser liberados aquí)
    bheap_destruir(heap); 
    printf("Heap destruido correctamente (Test de memoria).\n");


    // -------------------------------------------------------------
    // PRUEBA 2: Heapsort (Ordenar Arreglo)
    // -------------------------------------------------------------
    printf("\n--- Test 2: Heapsort ---\n");

    int n = 6;
    void **arreglo = malloc(sizeof(void*) * n);
    
    // Llenamos el arreglo con punteros a enteros nuevos
    int datos_raw[] = {100, 5, 20, 1, 99, 50};
    for (int i = 0; i < n; i++) {
        arreglo[i] = copiar_int(&datos_raw[i]);
    }

    printf("Arreglo antes de ordenar: ");
    for(int i=0; i<n; i++) imprimir_int(arreglo[i]);
    printf("\n");

    // Ejecutamos Heapsort
    // NOTA: Pasamos NULL como destroy porque no queremos que destruya nuestros datos
    // mientras ordena, solo queremos que ordene los punteros.
    bheap_sort(arreglo, n, comparar_int);

    printf("Arreglo despues de ordenar: ");
    for(int i=0; i<n; i++) imprimir_int(arreglo[i]);
    printf("\n");

    // Verificación de orden ascendente
    int ordenado = 1;
    for (int i = 0; i < n - 1; i++) {
        if (comparar_int(arreglo[i], arreglo[i+1]) > 0) {
            ordenado = 0;
            break;
        }
    }
    verificar(ordenado, "El arreglo esta ordenado ascendentemente");

    // Limpieza manual del arreglo
    for (int i = 0; i < n; i++) {
        free(arreglo[i]);
    }
    free(arreglo);
    
    printf("\n=== FIN DE PRUEBAS ===\n");
    return 0;
}