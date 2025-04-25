CC = gcc
FLAGS = -Wall -Wextra -Werror -std=c99

programa: main.o pila.o glist.o contacto.o
	$(CC) -o $@ $^ $(FLAGS)

main.o: main.c pila.h glist.h contacto.h
	$(CC) -c main.c $< $(FLAGS)

contacto.o: contacto.c contacto.h
	$(CC) -c contacto.c $< $(FLAGS)

pila.o: pila.c pila.h glist.h
	$(CC) -c pila.c $< $(FLAGS)

glist.o: glist.c glist.h
	$(CC) -c glist.c $< $(FLAGS)

clean:
	rm -f *.o programa

.PHONY: clean