# Compilador
CC = gcc
# Opciones de compilación
CFLAGS = -Wall -g

# Archivos fuente y objeto
OBJ = heap.o test.o

# Nombre del ejecutable
EXEC = test

# Regla por defecto
all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) -o $(EXEC) $(OBJ)

heap.o: heap.c heap.h
	$(CC) $(CFLAGS) -c heap.c

test.o: test.c heap.h
	$(CC) $(CFLAGS) -c test.c

# Limpiar archivos compilados
clean:
	rm -f *.o $(EXEC)