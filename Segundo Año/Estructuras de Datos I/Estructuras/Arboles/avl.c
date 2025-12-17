#include <stdio.h>
#include <stdlib.h>
#include "avl.h"

typedef struct _AVL_Nodo {
  void *data;
  struct _AVL_Nodo *left, *right;
  int height;
} AVL_Nodo;

struct _AVL {
  AVL_Nodo *root;
  FuncionCopiadora copy;
  FuncionDestructora destroy;
  FuncionComparadora comp;
};

AVL avl_crear(FuncionCopiadora copy, FuncionComparadora comp, FuncionDestructora destroy) {
  AVL tree = malloc(sizeof(struct _AVL));
  tree->root = NULL;
  tree->copy = copy;
  tree->destroy = destroy;
  tree->comp = comp;
  return tree;
}

static void avl_nodo_destruir (AVL_Nodo * root, FuncionDestructora destroy) {
  if (root != NULL) {
    avl_nodo_destruir(root->left, destroy);
    avl_nodo_destruir(root->right, destroy);
    destroy(root->data);
    free(root);
  }
}

void avl_destruir (AVL tree) {
  avl_nodo_destruir(tree->root, tree->destroy);
  free(tree);
}

static int avl_nodo_buscar (AVL_Nodo *root, FuncionComparadora comp, void *data) {
  if (root == NULL) return 0;
  if (comp(data, root->data)==0) return 1;
  if (comp(data, root->data)<0) return avl_nodo_buscar(root->left, comp, data);
  else return avl_nodo_buscar(root->right, comp, data);
}

int avl_buscar (AVL tree, void *data) {
  return avl_nodo_buscar(tree->root, tree->comp, data);
}

static int avl_nodo_altura (AVL_Nodo *root) {
  return root == NULL ? -1 : root->height; 
}

static int avl_nodo_max_altura_hijos (AVL_Nodo *root) {
  if (root == NULL) return 0;
  int heightL = avl_nodo_altura(root->left);
  int heightR = avl_nodo_altura(root->right);
  return heightL < heightR ? heightR : heightL;
}

static int avl_nodo_factor_balance (AVL_Nodo *root) {
  if (root == NULL) return 0;
  int factor = avl_nodo_altura(root->right) - avl_nodo_altura(root->left);
  if (factor >= -2 || factor <= 2) return factor;
  else return -111111111;
}

static AVL_Nodo* avl_nodo_rotacion_simple_izq (AVL_Nodo *root) {
  AVL_Nodo *hijoDer = root->right;
  if (hijoDer == NULL) return NULL;
  root->right = hijoDer->left;
  hijoDer->left = root;
  root->height = 1 + avl_nodo_max_altura_hijos(root);
  hijoDer->height = 1 + avl_nodo_max_altura_hijos(hijoDer);
  return hijoDer;
}

static AVL_Nodo* avl_nodo_rotacion_simple_der (AVL_Nodo *root) {
  AVL_Nodo *hijoIzq = root->left;
  if (root->left == NULL) return NULL;
  root->left = hijoIzq->right;
  hijoIzq->right = root;
  root->height = 1 + avl_nodo_max_altura_hijos(root);
  hijoIzq->height = 1 + avl_nodo_max_altura_hijos(root);
  return hijoIzq; 
}

static AVL_Nodo* avl_nodo_rebalancear (AVL_Nodo *root) {
  if (avl_nodo_factor_balance(root) == -2) { // desbalanceado I
    if (avl_nodo_factor_balance(root->left) == 1) // desbalanceado ID
      root->left = avl_nodo_rotacion_simple_izq(root->left);
    root = avl_nodo_rotacion_simple_der(root);
  } else if (avl_nodo_factor_balance(root) == 2) { // desbalanceado D 
      if (avl_nodo_factor_balance(root->right) == -1)  // desbalanceado DI
        root->right = avl_nodo_rotacion_simple_der(root->right);
      root = avl_nodo_rotacion_simple_izq(root);
  }
  return root;
}

static AVL_Nodo* avl_nodo_crear (void *data, FuncionCopiadora copy) {
  AVL_Nodo *newNode = malloc(sizeof(AVL_Nodo));
  newNode->data = copy(data);
  newNode->right = NULL;
  newNode->left = NULL;
  newNode->height = 0;
  return newNode;
}

// static AVL_Nodo* avl_nodo_insertar (AVL_Nodo *root, void *data, FuncionComparadora comp, FuncionCopiadora copy) {
//   if (root == NULL) return avl_nodo_crear(data, copy);

//   if (comp(data, root->data) < 0) {
//     root->left = avl_nodo_insertar(root->left, data, comp, copy);
//     root = avl_nodo_rebalancear(root);
//     root->height = 1 + avl_nodo_max_altura_hijos(root);
//     return root;
//   }

//   if (comp(data, root->data) > 0) {
//     root->right = avl_nodo_insertar(root->right, data, comp, copy);
//     root = avl_nodo_rebalancear(root);
//     root->height = 1 + avl_nodo_max_altura_hijos(root);
//     return root;
//   }

//   return root;
// }

static AVL_Nodo* avl_nodo_insertar (AVL_Nodo *root, void *data, FuncionComparadora comp, FuncionCopiadora copy) {
  if (root == NULL) return avl_nodo_crear(data, copy);

  if (comp(data, root->data) > 0)
    root->right = avl_nodo_insertar(root->right, data, comp, copy);
  else if (comp(data, root->data) < 0)
    root->left = avl_nodo_insertar(root->left, data, comp, copy);
  else
    return root;
  
  root->height = 1 + avl_nodo_max_altura_hijos(root);
  root = avl_nodo_rebalancear(root);

  return root;
}

void avl_insertar (AVL tree, void *data) {
  tree->root = avl_nodo_insertar(tree->root, data, tree->comp, tree->copy);
}

static AVL_Nodo* avl_nodo_eliminar (AVL_Nodo *root, void *data, FuncionComparadora comp, 
  FuncionDestructora destroy, FuncionCopiadora copy) {
  if (root == NULL) return NULL;

  if (comp(data, root->data) < 0)
    root->left = avl_nodo_eliminar(root->left, data, comp, destroy, copy);

  else if (comp(data, root->data) > 0)
    root->right = avl_nodo_eliminar(root->right, data, comp, destroy, copy);

  else if (comp(data,root->data) == 0) {

    if (root->left == NULL && root->right == NULL) {
      destroy(root->data);
      free(root);
      return NULL;
    }

    if (root->left == NULL) {
      AVL_Nodo *temp = root->right;
      destroy(root->data);
      free(root);
      return temp;
    }
    
    if (root->right == NULL) {
      AVL_Nodo *temp = root->left;
      destroy(root->data);
      free(root);
      return temp;
    }

    AVL_Nodo *actual = root->right;
    while(actual->left != NULL)
      actual = actual->left;

    destroy(root->data);
    root->data = copy(actual->data);
    

    root->right = avl_nodo_eliminar(root->right, actual->data, comp, destroy, copy);
  }

  root->height = 1 + avl_nodo_max_altura_hijos(root);
  root = avl_nodo_rebalancear(root);

  return root;
}

void avl_eliminar (AVL tree, void *data) {
  tree->root = avl_nodo_eliminar(tree->root, data, tree->comp, tree->destroy, tree->copy);
}

static int avl_nodo_validar_abb (AVL_Nodo *root, void *min, void *max, FuncionComparadora comp) {
  if (root == NULL) return 1;

  if (min != NULL && comp(root->data, min) <= 0)
    return 0;

  if (max != NULL && comp(root->data, max) >= 0)
    return 0;

  return avl_nodo_validar_abb(root->left, min, root->data, comp) && avl_nodo_validar_abb(root->right, root->data, max, comp);
}

static int avl_nodo_validar_altura_y_balance (AVL_Nodo *root) {
  if (root == NULL) return 1;

  int ret1 = avl_nodo_validar_altura_y_balance(root->left);
  int ret2 = avl_nodo_validar_altura_y_balance(root->right);

  if(ret1 && ret2) {
    int height = 1 + avl_nodo_max_altura_hijos(root);
    int balance = avl_nodo_factor_balance(root);
    if (root->height == height && balance >= -1 && balance <=1) return 1; 
  }
  return 0;
}

int avl_validar (AVL tree) {
  return avl_nodo_validar_abb(tree->root, NULL, NULL, tree->comp) && avl_nodo_validar_altura_y_balance(tree->root);
}

#include <stdio.h>
#include <stdlib.h>
#include "avl.h"

// --- FUNCIONES AUXILIARES (Enteros) ---

void *copiar_int(void *dato) {
    int *nuevo = malloc(sizeof(int));
    if (nuevo == NULL) return NULL;
    *nuevo = *(int*)dato;
    return nuevo;
}

int comparar_int(void *a, void *b) {
    int val_a = *(int*)a;
    int val_b = *(int*)b;
    return val_a - val_b;
}

void destruir_int(void *dato) {
    free(dato);
}

void verificar(int condicion, const char *mensaje) {
    if (condicion) printf("[OK] %s\n", mensaje);
    else printf("[ERROR] %s\n", mensaje);
}

int main() {
    printf("=== INICIO TEST VALGRIND AVL ===\n");

    // 1. Creación
    AVL arbol = avl_crear(copiar_int, comparar_int, destruir_int);
    
    // 2. Inserción (Forzando rotaciones)
    // 10, 20, 30 -> Fuerza rotación Izquierda en 10
    // 40, 50 -> Fuerza rotación Izquierda en 30
    // 25 -> Fuerza rotación Derecha-Izquierda en 40/20
    int datos[] = {10, 20, 30, 40, 50, 25};
    
    for (int i = 0; i < 6; i++) {
        avl_insertar(arbol, &datos[i]);
    }
    printf("Datos insertados.\n");

    // 3. Validación
    // Esto llamará a tus funciones avl_nodo_validar_abb y altura_y_balance
    verificar(avl_validar(arbol), "El arbol mantiene propiedades AVL tras insercion");

    // 4. Búsqueda
    int val_si = 25;
    int val_no = 99;
    verificar(avl_buscar(arbol, &val_si) == 1, "Busqueda de elemento existente (25)");
    verificar(avl_buscar(arbol, &val_no) == 0, "Busqueda de elemento inexistente (99)");

    // 5. Eliminación (Prueba de Fuego para Valgrind)
    // Tu implementación de eliminar hace un malloc extra (copy) al intercambiar nodos.
    // Es vital probar que ese malloc se libera.
    
    printf("\n--- Eliminando Nodos ---\n");

    // A. Eliminar nodo con 2 hijos (El 30 suele quedar como raíz o nodo interno alto)
    int eliminar_complejo = 30; 
    avl_eliminar(arbol, &eliminar_complejo);
    verificar(avl_buscar(arbol, &eliminar_complejo) == 0, "Eliminado 30 (Caso 2 hijos)");
    verificar(avl_validar(arbol), "Arbol valido tras eliminar 30");

    // B. Eliminar hoja
    int eliminar_hoja = 50;
    avl_eliminar(arbol, &eliminar_hoja);
    verificar(avl_buscar(arbol, &eliminar_hoja) == 0, "Eliminado 50 (Hoja)");

    // 6. Destrucción Final
    avl_destruir(arbol);
    printf("Arbol destruido.\n");

    return 0;
}
