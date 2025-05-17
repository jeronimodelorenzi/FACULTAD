FLAGS = -Wall -Wextra -Werror -std=c99

programa: ej4c.o rwlock_vc.o
			$(CC) -o $@ $^ $(FLAGS)

ej4c.o: ej4c.c rwlock_vc.h
			$(CC) -c $< $(FLAGS)

rwlock_vc.o: rwlock_vc.c rwlock_vc.h
			$(CC) -c $< $(FLAGS)

clean:
			rm *.o
			rm programa

.PHONY = clean