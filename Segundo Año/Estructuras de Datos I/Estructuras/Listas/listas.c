#include <stdio.h>
#include <stdlib.h>
#include "listas.h"

SList slist_crear () {
  return NULL;
}

void slist_destruir (SList list) {
  SNodo *nodoToDelete;
  while (list != NULL) {
    nodoToDelete = list;
    list = list->next;
    free(nodoToDelete);
  }
}

int slist_vacia (SList list) {
  return list == NULL;
}

SList slist_agregar_final (SList list, int data) {
  SNodo *newNode = malloc(sizeof(SNodo));
  newNode->data = data;
  newNode->next = NULL;
  
  if (list == NULL)
    return newNode;

  SList node = list;
  for (; node->next != NULL ; node = node->next);

  node->next = newNode;
  return list;
}

SList slist_agregar_inicio (SList list, int data) {
  SNodo *newNode = malloc(sizeof(SNodo));
  newNode->data = data;
  newNode->next = list;
  return newNode;
}

void slist_recorrer (SList list, FuncionVisitante visit) {
  for (SNodo *node = list ; node != NULL ; node = node->next)
    visit(node->data);
}

int slist_longitud (SList list) {
  int cont = 0;
  for (SNodo *node = list ; node != NULL ; node = node->next)
    cont++;
  return cont;
}

SList slist_concatenar (SList list1, SList list2) {
  if(list1 == NULL)
    return list2;
  else {
    SNodo *temp = list1;
    for (; temp->next != NULL ; temp = temp->next);
    temp->next = list2;
    return list1;
  }
}

SList slist_insertar (SList list, int data, int pos) {
  SNodo *newNode = malloc(sizeof(SNodo));
  newNode->data = data;

  if (pos == 0 || list == NULL) {
    newNode->next = list;
    return newNode;
  }

  SNodo *temp = list;
  for (int i = 0 ; i < pos-1 && temp->next != NULL ; i++, temp = temp->next);
  newNode->next = temp->next;
  temp->next = newNode;
  return list;
}

SList slist_eliminar (SList list, int data) {
  if (list == NULL)
    return NULL;

  if (list->data == data) {
    SList temp = list->next;
    free(list);
    return temp;
  }

  SNodo *temp = list;
  for (; temp->next != NULL && temp->next->data != data ; temp = temp->next);
  
  if (temp->next != NULL) {
    SNodo *nodeToDelete = temp->next;
    temp->next = nodeToDelete->next;
    free(nodeToDelete);
  }

  return list;
}

int slist_contiene (SList list, int data) {
  int contiene = 0;
  for (SNodo* temp = list ; temp != NULL  && !contiene ; temp = temp->next)
    if (temp->data == data)
      contiene = 1;
  return contiene;
}

int slist_indice (SList list, int data) {
  int contiene = 0;
  int pos = -1;

  for (SNodo *temp = list ; temp != NULL && !contiene ; temp = temp->next){
    if (temp->data == data)
      contiene = 1;
    pos++;
  }

  if (!contiene){
    pos = -1;
  }

  return pos;
}

SList slist_intersecar (SList list1, SList list2) {
  SList newList = slist_crear();  

  for (SNodo *temp = list1 ; temp != NULL ; temp = temp->next)
    for (SNodo *temp2 = list2 ; temp2 != NULL ; temp2 = temp2->next)
      if (temp->data == temp2->data)
        newList = slist_agregar_inicio(newList, temp->data);
  return newList;
}


SList slist_intersecar_custom(SList list1, SList list2, int (*comparadora) (int, int)) {
  SList newList = slist_crear();

  for (SNodo *temp = list1 ; temp != NULL ; temp = temp->next)
    for (SNodo *temp2 = list2 ; temp2 != NULL ; temp2 = temp2->next)
      if (comparadora(temp->data, temp2->data))
        newList = slist_agregar_inicio(newList, temp->data);
  return newList;
}

SList slist_ordenar (SList list, int (*comparadora) (int, int)) {
  if (list == NULL) return NULL;

  for (SNodo *temp = list ; temp->next != NULL ; temp = temp->next){
    for (SNodo *temp2 = temp->next ; temp2 != NULL ; temp2 = temp2->next) {
      if (comparadora(temp->data, temp2->data) > 0) {
      int aux = temp->data;
      temp->data = temp2->data;
      temp2->data = aux;
      }
    }
  }
    return list;
}

SList slist_reverso (SList list) {
  SList newNode = slist_crear();
  for (SNodo *temp = list ; temp != NULL ; temp = temp->next)
    newNode = slist_agregar_inicio(newNode, temp->data);
  return newNode;
} 

SList slist_intercalar (SList list1, SList list2) {
  if (list1 == NULL && list2 == NULL) return NULL;
  SList newNode = malloc(sizeof(SNodo));
  if (list1 != NULL) {
    newNode->data = list1->data;
    newNode->next = slist_intercalar(list2, list1->next);
  } else {
    newNode->data = list2->data;
    newNode->next = slist_intercalar(list1, list2->next);
  }

  return newNode;
}

SList slist_partir (SList list) {
  SNodo *temp = list;
  int longitud = slist_longitud(list);

  for (int i = 0; i < (longitud - 1)/2 ; i++, temp = temp->next);
  SList newNode = temp->next;
  temp->next = NULL;
  return newNode;
}

#include <stdio.h>
#include <stdlib.h>
#include "listas.h"

// --- Funciones auxiliares para las pruebas ---

// Para slist_recorrer
void imprimir_int(int data) {
    printf("%d -> ", data);
}

// Para slist_ordenar (ascendente)
int comparar_ints(int a, int b) {
    return a - b;
}

// Para intersecar_custom (igualdad)
int son_iguales(int a, int b) {
    return a == b;
}

// Función helper para imprimir con salto de línea
void mostrar_lista(const char* titulo, SList lista) {
    printf("[%s]: ", titulo);
    if (slist_vacia(lista)) {
        printf("VACIA\n");
    } else {
        slist_recorrer(lista, imprimir_int);
        printf("NULL\n");
    }
}

int main() {
    printf("=== INICIO DE PRUEBAS ===\n\n");

    // ---------------------------------------------------------
    // 1. CREACIÓN Y AGREGADO
    // ---------------------------------------------------------
    SList lista = slist_crear();
    lista = slist_agregar_inicio(lista, 20);
    lista = slist_agregar_inicio(lista, 10);
    lista = slist_agregar_final(lista, 30);
    lista = slist_agregar_final(lista, 40);
    
    // Esperado: 10 -> 20 -> 30 -> 40 -> NULL
    mostrar_lista("1. Inicio y Final", lista);
    printf("Longitud: %d (Esperado: 4)\n\n", slist_longitud(lista));

    // ---------------------------------------------------------
    // 2. INSERCIÓN
    // ---------------------------------------------------------
    // Insertamos 25 en la posición 2 (entre 20 y 30)
    lista = slist_insertar(lista, 25, 2);
    // Insertamos 5 al inicio (pos 0)
    lista = slist_insertar(lista, 5, 0);
    
    // Esperado: 5 -> 10 -> 20 -> 25 -> 30 -> 40 -> NULL
    mostrar_lista("2. Insertar (0 y 2)", lista);

    // ---------------------------------------------------------
    // 3. BÚSQUEDA
    // ---------------------------------------------------------
    printf("\n--- 3. Búsqueda ---\n");
    printf("Contiene 25? %d (Esperado: 1)\n", slist_contiene(lista, 25));
    printf("Contiene 99? %d (Esperado: 0)\n", slist_contiene(lista, 99));
    printf("Indice de 20: %d (Esperado: 2)\n", slist_indice(lista, 20));

    // ---------------------------------------------------------
    // 4. ELIMINACIÓN
    // ---------------------------------------------------------
    lista = slist_eliminar(lista, 5);  // Borrar primero
    lista = slist_eliminar(lista, 25); // Borrar medio
    lista = slist_eliminar(lista, 40); // Borrar ultimo
    lista = slist_eliminar(lista, 99); // Borrar no existente (no debe romper nada)

    // Esperado: 10 -> 20 -> 30 -> NULL
    mostrar_lista("\n4. Eliminar (5, 25, 40)", lista);

    // ---------------------------------------------------------
    // 5. OPERACIONES COMPLEJAS (Reverso y Partir)
    // ---------------------------------------------------------
    SList listaInvertida = slist_reverso(lista);
    mostrar_lista("\n5a. Reverso (Copia)", listaInvertida);

    // Partir: lista original tiene 3 elementos (10, 20, 30)
    // Mitad es index 1. 
    // Parte 1 quedará con: 10
    // Parte 2 retornada: 20 -> 30
    SList segundaMitad = slist_partir(lista);
    
    mostrar_lista("5b. Partir (Original modif)", lista);
    mostrar_lista("5b. Partir (Nueva mitad)", segundaMitad);

    // LIMPIEZA PARCIAL (Para evitar fugas antes de seguir)
    slist_destruir(listaInvertida);
    slist_destruir(lista);       // Primera mitad
    slist_destruir(segundaMitad); // Segunda mitad

    // ---------------------------------------------------------
    // 6. OPERACIONES ENTRE DOS LISTAS
    // ---------------------------------------------------------
    printf("\n--- 6. Operaciones con 2 listas ---\n");
    SList l1 = slist_crear();
    l1 = slist_agregar_final(l1, 1);
    l1 = slist_agregar_final(l1, 3);
    l1 = slist_agregar_final(l1, 5); // l1: 1 -> 3 -> 5

    SList l2 = slist_crear();
    l2 = slist_agregar_final(l2, 2);
    l2 = slist_agregar_final(l2, 3);
    l2 = slist_agregar_final(l2, 6); // l2: 2 -> 3 -> 6

    // Intersección (Elementos comunes: 3)
    SList l_inter = slist_intersecar(l1, l2);
    mostrar_lista("Interseccion", l_inter);
    slist_destruir(l_inter);

    // Intercalar (Zip)
    SList l_zip = slist_intercalar(l1, l2);
    // Esperado: 1 -> 2 -> 3 -> 3 -> 5 -> 6
    mostrar_lista("Intercalar", l_zip);
    
    // Concatenar (Destructiva para l1)
    // OJO: Concatenar pega l2 al final de l1.
    // l1 cambia. l2 sigue existiendo como puntero, pero sus nodos ahora son parte de l1.
    // Para evitar "double free", NO destruiremos l2 después de esto, solo l1.
    
    // IMPORTANTE: Como 'intercalar' no modifica las originales, 
    // l1 y l2 siguen siendo validas aqui.
    l1 = slist_concatenar(l1, l2);
    mostrar_lista("Concatenar (l1 + l2)", l1);

    // ---------------------------------------------------------
    // 7. ORDENAMIENTO
    // ---------------------------------------------------------
    // l1 ahora tiene: 1 -> 3 -> 5 -> 2 -> 3 -> 6
    slist_ordenar(l1, comparar_ints);
    mostrar_lista("\n7. Ordenar", l1);


    // ---------------------------------------------------------
    // LIMPIEZA FINAL
    // ---------------------------------------------------------
    printf("\n--- Limpiando memoria ---\n");
    
    slist_destruir(l_zip); // Liberamos la lista intercalada
    slist_destruir(l1);    // Liberamos l1 (que ahora contiene a l2 tambien)
    
    // NO hacemos slist_destruir(l2) porque l2 fue enganchada dentro de l1.
    // Si destruimos l2, haríamos free de nodos que l1 ya liberó.

    printf("=== FIN DE PRUEBAS ===\n");
    return 0;
}