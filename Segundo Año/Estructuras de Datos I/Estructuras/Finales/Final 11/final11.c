#include <stdio.h>
#include <stdlib.h>

int buscar_camino (int maze[10][10], int x, int y, int visitado[10][10]) {
  if (x < 0 || x >= 10 || y < 0 || y >= 10)
    return 0;

  if (maze[x][y] == 1 || visitado[x][y])
    return 0;

  if (x == 9 && y == 9) {
    printf("(%d, %d)\n", x,y);
    return 1;
  }

  visitado[x][y] = 1;

  int buscaDer = buscar_camino(maze, x+1, y, visitado);
  int buscaIzq = buscar_camino(maze, x-1, y, visitado);
  int buscaArriba = buscar_camino(maze, x, y+1, visitado);
  int buscaAbajo = buscar_camino(maze, x, y-1, visitado);

  if (buscaDer || buscaIzq || buscaAbajo || buscaArriba) {
    printf("(%d, %d)\n", x ,y);
    return 1;
  }

  return 0;
}

void sol_maze (int maze[10][10]) {
  int visitado[10][10] = {0};

  if (!buscar_camino(maze, 0, 0, visitado))
    printf("No existe un camina de maze[0][0] a maze[9][9]\n");
}

typedef struct _ABBNodo {
  void *dato;
  struct _ABBNodo *izq, *der;
} ABBNodo;

typedef ABBNodo *ABB;

typedef int (*FuncionComparadora)(void*,void*);
typedef void (*FuncionDestructora)(void*);
typedef void (*FuncionVisitante)(void*);
typedef void *(*FuncionCopiadora)(void*);

int es_ABB_aux (ABB raiz, void *min, void *max, FuncionComparadora comp) {
  if (raiz == NULL) return 1;

  if (min != NULL && comp(raiz->dato, min) <= 0) return 0;
  if (max != NULL && comp(raiz->dato, max) >= 0) return 0;

  return es_ABB_aux(raiz->izq, min, raiz->dato, comp) && es_ABB_aux(raiz->der, raiz->dato, max, comp);
}

int es_ABB (ABB raiz, FuncionComparadora comp) {
  if (raiz == NULL) return 1;
  return es_ABB_aux(raiz, NULL, NULL, comp);
}

ABB eliminar_ABB (ABB raiz, void *dato, FuncionComparadora comp, FuncionDestructora destr, FuncionCopiadora copy) {
  if (raiz == NULL) return NULL;

  if (comp(dato, raiz->dato) < 0)
    raiz->izq = eliminar_ABB(raiz->izq, dato, comp, destr, copy);
  else if (comp(dato, raiz->dato) > 0)
    raiz->der = eliminar_ABB(raiz->der, dato, comp, destr, copy);
  else {
    if (raiz->izq == NULL && raiz->der == NULL) {
      destr(raiz->dato);
      free(raiz);
      return NULL;
    }

    if (raiz->der == NULL) {
      ABBNodo *temp = raiz->izq;
      destr(raiz->dato);
      free(raiz);
      return temp;
    }

    if (raiz->izq == NULL) {
      ABBNodo *temp = raiz->der;
      destr(raiz->dato);
      free(raiz);
      return temp;
    }

    ABBNodo *temp = raiz->der;
    while (temp->izq != NULL)
      temp = temp->izq;

    destr(raiz->dato);
    raiz->dato = copy(temp->dato);
    
    raiz->der = eliminar_ABB(raiz->der, temp->dato, comp, destr, copy);
  }

  return raiz;
}

void *cota_inferior_ABB (ABB raiz, void *dato, FuncionComparadora comp) {
  if (raiz == NULL) return NULL;

  if (comp(dato, raiz->dato) > 0) return cota_inferior_ABB(raiz->der, dato, comp);

  void *izq = cota_inferior_ABB(raiz->izq, dato, comp);
  if (izq != NULL)
    return izq;

  return raiz->dato;
}

void *copia_entero (void *dato) {
  int *copia = malloc(sizeof(int));
  *copia = *(int*)dato;
  return copia;
}

int compara_entero (void *dato1, void *dato2) {
  return *(int*)dato1-*(int*)dato2;
}

void destruir_entero (void *dato) {
  free(dato);
}

void visitar_entero (void *dato) {
  printf("%d\n", *(int*)dato);
}

ABB crear_ABB () {
  return NULL;
}

ABB insertar_ABB (ABB raiz, void *dato, FuncionComparadora comp, FuncionCopiadora copy) {
  if (raiz == NULL) {
    ABBNodo *nodo = malloc(sizeof(ABBNodo));
    nodo->dato = copy(dato);
    nodo->izq = NULL;
    nodo->der = NULL;
    return nodo;
  };
  if (comp(dato, raiz->dato) < 0) 
    raiz->izq = insertar_ABB(raiz->izq, dato, comp, copy);
  else if (comp(dato, raiz->dato) > 0)
    raiz->der = insertar_ABB(raiz->der, dato, comp, copy);
  else
    return raiz;

  return raiz;
}

void destruir_ABB (ABB raiz, FuncionDestructora destr) {
  if (raiz != NULL) {
    destruir_ABB(raiz->izq, destr);
    destruir_ABB(raiz->der, destr);
    destr(raiz->dato);
    free(raiz);
  }
}

void recorrer_ABB (ABB raiz, FuncionVisitante visit) {
  if (raiz == NULL) return;

  visit(raiz->dato);
  recorrer_ABB(raiz->izq, visit);
  recorrer_ABB(raiz->der, visit);
}

int main(void) {
  int maze[10][10] = {
    {0,0,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,1,0,0,0,1},
    {1,1,1,1,0,1,0,1,0,1},
    {1,0,0,1,0,0,0,1,0,1},
    {1,0,1,1,1,1,0,1,0,1},
    {1,0,0,0,0,0,0,1,0,1},
    {1,1,1,1,1,1,0,1,0,1},
    {1,0,0,0,0,0,0,0,0,1},
    {1,0,1,1,1,1,1,1,0,1},
    {1,0,0,0,0,0,0,0,0,0}
  };

  printf("\n");

  ABB arbol = crear_ABB();
  int a1 = 20, a2 = 15, a3 = 10, a4 = 30;
  arbol = insertar_ABB(arbol, &a1, compara_entero, copia_entero);
  arbol = insertar_ABB(arbol, &a2, compara_entero, copia_entero);
  arbol = insertar_ABB(arbol, &a3, compara_entero, copia_entero);
  arbol = insertar_ABB(arbol, &a4, compara_entero, copia_entero);

  recorrer_ABB(arbol, visitar_entero);
  printf("\n");

  int condicion = es_ABB(arbol, compara_entero);
  if (condicion)
    printf("Es ABB\n");
  else
    printf("No es ABB");

  printf("\n");

  int a5 = 12;

  int *cotaInf = cota_inferior_ABB(arbol, &a5, compara_entero);
  if (cotaInf != NULL)
    printf("Cota inferior: %d\n", *cotaInf);
  else
    printf("No existe cota inferior\n");

  printf("\n");

  arbol = eliminar_ABB(arbol, &a1, compara_entero, destruir_entero, copia_entero);
  recorrer_ABB(arbol, visitar_entero);

  printf("\n");

  destruir_ABB(arbol, destruir_entero);

  sol_maze(maze);
  return 0;
}
