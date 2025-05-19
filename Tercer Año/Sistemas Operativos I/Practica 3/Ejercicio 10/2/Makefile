FLAGS = -Wall -Wextra -Werror -lpthread -std=c99

programa: ej10.o channel.o
			$(CC) -o $@ $^ $(FLAGS)

ej10.o: ej10.c channel.h
			$(CC) -c $< $(FLAGS)

channel.o: channel.c channel.h
			$(CC) -c $< $(FLAGS)

clean:
			rm *.o
			rm programa

.PHONY = clean