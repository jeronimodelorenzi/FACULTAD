typedef struct _GNodo {
    void *dato;
    struct _GNodo *sig;
} GNodo;

typedef struct {
    GNodo *primero;
    GNodo *ultimo;
} GList;

typedef void (*FuncionDestructora)(void *dato);
typedef void* (*FuncionCopia)(void *dato);
typedef void (*FuncionVisitante)(void *dato);
typedef void* (*FuncionTransformar)(void *dato);

GList glist_crear();
GList glist_agregar_final(GList lista, void *dato, FuncionCopia copia);
void glist_destruir(GList lista, FuncionDestructora destroy);
void glist_recorrer (GList lista, FuncionVisitante visit);
GList glist_map(GList lista, FuncionTransformar f, FuncionCopia c);
