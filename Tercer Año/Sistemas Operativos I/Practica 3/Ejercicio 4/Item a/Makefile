FLAGS = -Wall -Wextra -Werror -std=c99

programa: ej4a.o rwlock_vc.o
			$(CC) -o $@ $^ $(FLAGS)

ej4a.o: ej4a.c rwlock_vc.h
			$(CC) -c $< $(FLAGS)

rwlock_vc.o: rwlock_vc.c rwlock_vc.h
			$(CC) -c $< $(FLAGS)

clean:
			rm *.o
			rm programa

.PHONY = clean