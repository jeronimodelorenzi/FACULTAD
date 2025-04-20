# Makefile para el proyecto con arregloEnteros, pilas y main

CC = gcc
FLAGS = -Wall -Wextra -Werror -std=c99

programa: main.o pilas.o arregloEnteros.o
	$(CC) -o $@ $^ $(FLAGS)

main.o: main.c pilas.h arregloEnteros.h
	$(CC) -c main.c $(FLAGS)

pilas.o: pilas.c pilas.h arregloEnteros.h
	$(CC) -c pilas.c $(FLAGS)

arregloEnteros.o: arregloEnteros.c arregloEnteros.h
	$(CC) -c arregloEnteros.c $(FLAGS)

clean:
	rm -f *.o programa

.PHONY: clean
