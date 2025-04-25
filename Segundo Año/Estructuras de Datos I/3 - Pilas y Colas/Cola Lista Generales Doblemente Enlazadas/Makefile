CC = gcc
FLAGS = -Wall -Wextra -Werror -std=c99

programa: main.o colas.o glist.o contacto.o
	$(CC) -o $@ $^ $(FLAGS)

main.o: main.c colas.h glist.h contacto.h
	$(CC) -c main.c $< $(FLAGS)

contacto.o: contacto.c contacto.h
	$(CC) -c contacto.c $< $(FLAGS)

colas.o: colas.c colas.h glist.h
	$(CC) -c colas.c $< $(FLAGS)

glist.o: glist.c glist.h
	$(CC) -c glist.c $< $(FLAGS)

clean:
	rm -f *.o programa

.PHONY: clean