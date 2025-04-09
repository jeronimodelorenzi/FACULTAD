# Makefile para P2E8
# ejecutar desde la terminal escribiendo "make" 
# genera automáticamente el ejecutable del programa

FLAGS = -Wall -Wextra -Werror -std=c99

programa: main.o sglist.o
	$(CC) -o $@ $^ $(FLAGS)

main.o: main.c sglist.h
	$(CC) -c $< $(FLAGS)

sglist.o: sglist.c sglist.h
	$(CC) -c $< $(FLAGS)

clean:
	rm *.o
	rm programa

.PHONY = clean