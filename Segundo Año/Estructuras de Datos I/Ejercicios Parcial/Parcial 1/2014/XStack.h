#include "colas.h"

typedef struct {
  Cola *q1;
  Cola *q2;
} XStack;

XStack* xstack_create();

int xstack_es_vacia(XStack *p);

void xstack_push(XStack *p, void *dato);

void xstack_pop(XStack *p);
