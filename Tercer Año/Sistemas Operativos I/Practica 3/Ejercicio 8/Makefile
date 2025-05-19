FLAGS = -Wall -Wextra -Werror -lpthread -std=c99

programa: ej8.o barrier.o
			$(CC) -o $@ $^ $(FLAGS)

ej8.o: ej8.c barrier.h
			$(CC) -c $< $(FLAGS)

barrier.o: barrier.c barrier.h
			$(CC) -c $< $(FLAGS)

clean:
			rm *.o
			rm programa

.PHONY = clean