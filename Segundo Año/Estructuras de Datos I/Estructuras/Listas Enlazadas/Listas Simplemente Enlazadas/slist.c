#include "slist.h"
#include <stdlib.h>

SList slist_crear() {
  return NULL;
}

void slist_destruir(SList lista) {
  SNodo *nodoAEliminar;
  while (lista != NULL) {
    nodoAEliminar = lista;
    lista = lista->sig;
    free(nodoAEliminar);
  }
}

int slist_vacia(SList lista) {
  return lista == NULL;
}

SList slist_agregar_final(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;

  if (lista == NULL)
    return nuevoNodo;

  SList nodo = lista;
  for (;nodo->sig != NULL;nodo = nodo->sig);
  /* ahora 'nodo' apunta al ultimo elemento en la lista */

  nodo->sig = nuevoNodo;
  return lista;
}

SList slist_agregar_inicio(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = lista;
  return nuevoNodo;
}

void slist_recorrer(SList lista, FuncionVisitante visit) {
  for (SNodo *nodo = lista; nodo != NULL; nodo = nodo->sig)
    visit(nodo->dato);
}

// a) slist_longitud que devuelve la longitud de una lista.

int slist_longitud (SList inicio /* SNodo* inicio */) {
  int cont = 0;
  for (SNodo* temp = inicio ; temp != NULL ; temp = temp->sig)
    cont ++;
  return cont;
}

// b) slist_concatenar que devuelve la concatenación de dos listas, modificando la primera.

void slist_concatenar (SList* lista1, SList* lista2) {
  if (*lista1 == NULL) {
    *lista1 = *lista2;
  } else {
    SNodo* temp = *lista1;
    for(; temp->sig != NULL; temp = temp->sig);
    temp->sig = *lista2;
  }
}

// c) slist_insertar que inserta un dato en una lista en una posición arbitraria.

void slist_insertar(SList* lista, int dato, int pos) {
  SNodo* nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;
  
  if (*lista == NULL || pos == 0)  {
    nuevoNodo->sig = *lista;
    *lista = nuevoNodo;
  } else {
    SNodo* temp = *lista;
    SNodo* temp2 = (*lista)->sig;
    int contador = 0;
    for (; contador < pos && temp2 != NULL ; contador++) {
      temp = temp->sig;
      temp2 = temp2->sig;
    }
    temp->sig = nuevoNodo;
    nuevoNodo->sig = temp2;
  }
}

// d) slist_eliminar que borra de una lista un dato apuntado en una posicion arbitraria.

void slist_eliminar(SList* lista, int pos) {
  if (*lista == NULL) return;
  
  if ((*lista)->sig == NULL || pos == 0) {
    SNodo* temp = *lista;
    *lista = temp->sig;
    free(temp);
  }
  int i = 0;
  SNodo* temp = *lista;
  for (; i < pos - 1 && temp->sig != NULL; i++, temp = temp->sig);
  
  if (i == pos - 1 && temp->sig != NULL){
    SNodo* elim = temp->sig;
    temp->sig = elim->sig;
    free(elim);
  }
}

// e) slist_contiene que determina si un elemento esta en una lista dada.

int slist_contiene (SList lista, int dato) {
  int contiene = 0;
  for (SNodo* temp = lista ; temp != NULL && !contiene ; temp = temp->sig) {
    if (temp->dato == dato) {
      contiene = 1;
    }
  } 
  return contiene;
}

// f) slist_indice que devuelve la posicion de la primera ocurrencia de un elemento si el mismo este enla lista dada, y -1 en caso que no este.

int slist_indice (SList lista, int dato) {
  int ocurrencia = -1;
  int i = 0;
  for (SNodo* temp = lista ; temp != NULL && ocurrencia == -1 ; temp = temp->sig) {
    
    if (temp->dato == dato) {
      ocurrencia = i;
    }
    i++;
  }
  return ocurrencia;
}

// g) slist_intersecar que devuelve una nueva lista con los elementos comunes (independientemente de la posicion) de dos listas dadas por parametro. 
//    Las listas originales no se modifican.

SList slist_intersecar(SList lista1, SList lista2) {
  SList nuevoNodo = slist_crear();

  for (SNodo* temp = lista1; temp != NULL ; temp = temp->sig) {
    for (SNodo* temp2 = lista2; temp2 != NULL ; temp2 = temp2->sig) {
      if (temp->dato == temp2->dato) {
        nuevoNodo = slist_agregar_inicio(nuevoNodo,temp->dato);
      }
    }
  }
  return nuevoNodo;
}

// h) slist_intersecar_custom que trabaja como la anterior pero recibe un parametro extra que es un
//  puntero a una funcion de comparacion que permite definir la nocion de igualdad a ser usada al
// comparar elementos por igualdad.

SList slist_intersecar_custom(SList lista1, SList lista2, int (*FuncionComparadora)(int, int)) {
  SList nuevoNodo = slist_crear();

  for (SNodo* temp = lista1; temp != NULL ; temp = temp->sig) {
    for (SNodo* temp2 = lista2; temp2 != NULL ; temp2 = temp2->sig) {
      if (FuncionComparadora(temp->dato, temp2->dato)) {
        nuevoNodo = slist_agregar_inicio(nuevoNodo,temp->dato);
      }
    }
  }
  return nuevoNodo;
}

// i) slist_ordenar que ordena una lista de acuerdo al criterio dado por una funcion de comparacion (que usa los mismos valores de retorno que strcmp()) pasada por parametro.

void slist_ordenar (SList* lista, int (*FuncionOrdenar) (int, int)) {
  for (SNodo* temp = *lista ; temp != NULL ; temp = temp->sig) {
    for (SNodo* temp2 = temp->sig ; temp2 != NULL ; temp2 = temp2->sig) {
      if(FuncionOrdenar(temp->dato, temp2->dato) > 0) {
        int aux = temp->dato;
        temp->dato = temp2->dato;
        temp2->dato = aux;
      }
    }
  }
}

// j) slist_reverso que obtenga el reverso de una lista.

SList slist_reverso(SList lista) {
  SList nuevoNodo = slist_crear();
  for (SNodo* temp = lista ; temp != NULL ; temp = temp->sig)
    nuevoNodo = slist_agregar_inicio(nuevoNodo, temp->dato);
  return nuevoNodo;
}

// k) slist_intercalar que dadas dos listas, intercale sus elementos en la lista resultante.

SList slist_intercalar (SList lista1, SList lista2) {
 if (lista1 == NULL && lista2 == NULL) return NULL;
 SList nuevoNodo = malloc(sizeof(SNodo));
 if (lista1 != NULL) {
  nuevoNodo->dato = lista1->dato;
  nuevoNodo->sig = slist_intercalar(lista2,lista1->sig);
 } else {
  nuevoNodo->dato = lista2->dato;
  nuevoNodo->sig = slist_intercalar(lista1, lista2->sig);
 }

  return nuevoNodo;
}

// l ) slist_partir que divide una lista a la mitad. En caso de longitud impar (2n + 1), la primer lista
//tendra longitud n + 1 y la segunda n. Retorna un puntero al primer elemento de la segunda mitad,
//siempre que sea no vacia.

SList slist_partir (SList lista) {
  SNodo* temp = lista;
  int longitud = slist_longitud(lista);
  
  for (int i = 0; i < (longitud - 1)/2 ; i++, temp = temp->sig);
  SList nuevoNodo = temp->sig;
  temp->sig = NULL;
  return nuevoNodo;
}


