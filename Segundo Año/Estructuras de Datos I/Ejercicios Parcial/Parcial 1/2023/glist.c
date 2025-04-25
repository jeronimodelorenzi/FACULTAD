#include <stdio.h>
#include <stdlib.h>
#include "glist.h"

GList glist_crear()
{
    GList lista;
    lista.primero = NULL;
    lista.ultimo = NULL;
    return lista;
}
GList glist_agregar_final(GList lista, void *dato, FuncionCopia copia)
{
    GNodo *nuevo = malloc(sizeof(GNodo));
    nuevo->dato = copia(dato);
    nuevo->sig = NULL;
    if (lista.primero == NULL)
        lista.primero = nuevo;
    else
        lista.ultimo->sig = nuevo;
    lista.ultimo = nuevo;
    return lista;
}
void glist_destruir(GList lista, FuncionDestructora destroy)
{
    GNodo *temp;
    for (GNodo *nodo = lista.primero; nodo != NULL;)
    {
        temp = nodo;
        nodo = nodo->sig;
        destroy(temp->dato);
        free(temp);
    }
}

void glist_recorrer(GList lista, FuncionVisitante visit){
    for (GNodo *nodo = lista.primero; nodo != NULL; nodo = nodo->sig)
        visit(nodo->dato);
}

GList glist_map(GList lista, FuncionTransformar f, FuncionCopia c) {
    GList newList = glist_crear();
    for (GNodo* temp = lista.primero ; temp != NULL ; temp = temp->sig) {
        newList = glist_agregar_final(newList, f(temp->dato), c);
    }
    return newList;
}