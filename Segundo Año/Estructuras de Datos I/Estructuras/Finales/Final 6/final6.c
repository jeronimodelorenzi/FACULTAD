#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef struct _DNodo {
  int valor;
  int cantMenores;
  struct _DNodo *sig;
  struct _DNodo *ant;
} DNodo;

typedef DNodo *DList;

typedef struct _SNodo {
  int valor;
  struct _SNodo *sig;
} SNodo;

DList dlist_crear () {
  return NULL;
}

DList insertar_en_posicion (DList list, int dato, int pos) {
  DNodo *nodo = malloc(sizeof(DNodo));
  nodo->valor = dato;
  nodo->ant = NULL;
  nodo->sig = NULL;
  nodo->cantMenores = 0;
  
  if (pos == 0) {
    nodo->sig = list;
    if (list != NULL)
      list->ant = nodo;
    return nodo;
  }

  DNodo *temp = list;
  int i = 0;
  while (temp!= NULL && i < pos-1) {
    temp = temp->sig;
    i++;
  }

  if (temp == NULL) return list;

  nodo->sig = temp->sig;
  if (temp->sig != NULL) temp->sig->ant = nodo;
  temp->sig = nodo;
  nodo->ant = temp;
  
  int contMenores = 0;
  DNodo *temp2 = nodo->ant;
  while (temp2 != NULL) {
    if (temp2->valor < dato)
      contMenores++;
    temp2 = temp2->ant;
  }
  nodo->cantMenores = contMenores;

  temp2 = nodo->sig;
  while (temp2 != NULL) {
   if (temp2->valor > dato)
     temp2->cantMenores++;
   temp2 = temp2->sig;
  }

  return list;
}

SNodo* buscar_por_cantidadMenores (DList list, int cantidad) {
  SNodo *listMenores = NULL;
  for (DNodo *nodo = list ; nodo != NULL ; nodo = nodo->sig)
    if (nodo->cantMenores == cantidad) {
      SNodo *nodoMenores = malloc(sizeof(SNodo));
      nodoMenores->valor = nodo->valor;
      nodoMenores->sig = listMenores;
      listMenores = nodoMenores;
    }
  return listMenores;
}

DList borrar_en_posicion (DList list, int pos) {
  if (list == NULL) return NULL;

  DNodo *temp = list;
  int i = 0;

  while (temp != NULL && i < pos) {
    temp = temp->sig;
    i++;
  }

  if (temp == NULL) return list;

  int datoAEliminar = temp->valor;
  DNodo *nodoSig = temp->sig;

  if (temp->ant == NULL) {
    list = temp->sig;
    if (list != NULL)
      list->ant = NULL;
    free(temp);
    return list;
  }

  if (temp->sig == NULL) {
    temp->ant->sig = NULL;
    free(temp);
    return list;
  }
  

  temp->ant->sig = temp->sig;
  temp->sig->ant = temp->ant;
  free(temp);
  
  while (nodoSig != NULL) {
    if (datoAEliminar < nodoSig->valor) {
      nodoSig->cantMenores--;
    }
    nodoSig = nodoSig->sig;
  }

  return list;
}

DList dividir_lista (DList list) {
  DNodo *slow = list;
  DNodo *fast = list->sig;

  while (fast != NULL && fast->sig != NULL) {
    slow = slow->sig;
    fast = fast->sig->sig;
  }

  DNodo* mitad = slow->sig;
  slow->sig = NULL;
  
  if (mitad != NULL)
    mitad->ant = NULL;

  return mitad;
}

DList merge (DList list1, DList list2) {
  if (list1 == NULL) return list2;
  if (list2 == NULL) return list1;

  if (list1->cantMenores <= list2->cantMenores) {
    list1->sig = merge(list1->sig, list2);
    if (list1->sig != NULL) list1->sig->ant = list1;
    list1->ant = NULL;
    return list1;
  }
  
  list2->sig = merge(list1, list2->sig);
  if (list2->sig != NULL) list2->sig->ant = list2;
  list2->ant = NULL;
  return list2;
}

DList ordenar_por_cantidadMenores(DList list) {
  if (list == NULL || list->sig == NULL)
    return list;

  DNodo *mitad = dividir_lista(list);

  list = ordenar_por_cantidadMenores(list);
  mitad = ordenar_por_cantidadMenores(mitad);

  return merge(list, mitad);
}

int main () {

  DList secuencia = dlist_crear();
  int arr[] = {12, 30, 1, 2, 5, 1, 55, 4};
  for (int i = 0 ; i < 8 ; i++)
    secuencia = insertar_en_posicion(secuencia, arr[i], i);

  printf("\n\nSECUENCIA:\n\n");
  for (DNodo *nodo = secuencia; nodo != NULL ; nodo = nodo->sig)
    printf("valor=%d, menores=%d\n", nodo->valor, nodo->cantMenores);

  SNodo *listMenores = buscar_por_cantidadMenores(secuencia, 1);

  printf("\n\nMENORES:\n\n");
  for (SNodo *nodo = listMenores; nodo != NULL ; nodo = nodo->sig)
    printf("valor=%d\n", nodo->valor);

  secuencia = borrar_en_posicion(secuencia, 2);

  printf("\n\nBORRAR:\n\n");
  for (DNodo *nodo = secuencia; nodo != NULL ; nodo = nodo->sig)
    printf("valor=%d, menores=%d\n", nodo->valor, nodo->cantMenores);

  secuencia = ordenar_por_cantidadMenores(secuencia);

  printf("\n\nORDENAR:\n\n");
  for (DNodo *nodo = secuencia; nodo != NULL ; nodo = nodo->sig)
    printf("valor=%d, menores=%d\n", nodo->valor, nodo->cantMenores);


  return 0;
}