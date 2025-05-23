#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>

#include <pthread.h>

#define MAX_EVENTS 10
int fde;

/*
a) Adapte su implementaci´on de la pr´actica anterior del servidor de turnos para atender concurrentemente
a todas las conexiones abiertas levantando un thread nuevo por cada conexi´on. Nota: todos los
clientes deber´an poder hacer pedidos sin esperar a otros, y siempre debe poder conectarse un nuevo
cliente. Esta vez, se debe garantizar que dos pedidos nunca reciben el mismo entero.
b) Implemente una soluci´on con select/epoll.
c) Compare la performance de ambas soluciones.
*/


/*
 * Para probar, usar netcat. Ej:
 *
 *      $ nc localhost 4040
 *      NUEVO
 *      0
 *      NUEVO
 *      1
 *      CHAU
 */

void quit(char *s)
{
	perror(s);
	abort();
}

int U = 0;

int fd_readline(int fd, char *buf)
{
	int rc;
	int i = 0;

	/*
	 * Leemos de a un caracter (no muy eficiente...) hasta
	 * completar una línea.
	 */
	while ((rc = read(fd, buf + i, 1)) > 0) {
		if (buf[i] == '\n')
			break;
		i++;
	}

	if (rc < 0)
		return rc;

	buf[i] = 0;
	return i;
}

void* handle_conn(void* csock)
{
	char buf[200];
	int rc;

	int csock_cast = *(int*)csock;

	while (1) {
		/* Atendemos pedidos, uno por linea */
		rc = fd_readline(csock_cast, buf);
		if (rc < 0)
			quit("read... raro");

		if (rc == 0) {
			/* linea vacia, se cerró la conexión */
			close(csock_cast);
			return NULL;
		}

		if (!strcmp(buf, "NUEVO")) {
			char reply[20];
			sprintf(reply, "%d\n", U);
			U++;
			write(csock_cast, reply, strlen(reply));
		} else if (!strcmp(buf, "CHAU")) {
			close(csock_cast);
			return NULL;
		}
	}
}

void wait_for_clients(int lsock)
{
	pthread_t thread;
	int csock;
	//int lsock_cast = *(int*)lsock;
	
	/* Esperamos una conexión, no nos interesa de donde viene */
	csock = accept(lsock, NULL, NULL);
	if (csock < 0)
	quit("accept");
	
	/* Atendemos al cliente */
	pthread_create(&thread, NULL, handle_conn, &csock);
	
	/* Volvemos a esperar conexiones */
	wait_for_clients(lsock);
}

/* Crea un socket de escucha en puerto 4040 TCP */
int mk_lsock()
{
	struct sockaddr_in sa;
	int lsock;
	int rc;
	int yes = 1;

	/* Crear socket */
	lsock = socket(AF_INET, SOCK_STREAM, 0);
	if (lsock < 0)
		quit("socket");

	/* Setear opción reuseaddr... normalmente no es necesario */
	if (setsockopt(lsock, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof yes) == 1)
		quit("setsockopt");

	sa.sin_family = AF_INET;
	sa.sin_port = htons(4040);
	sa.sin_addr.s_addr = htonl(INADDR_ANY);

	/* Bindear al puerto 4040 TCP, en todas las direcciones disponibles */
	rc = bind(lsock, (struct sockaddr *)&sa, sizeof sa);
	if (rc < 0)
		quit("bind");

	/* Setear en modo escucha */
	rc = listen(lsock, 10);
	if (rc < 0)
		quit("listen");

	return lsock;
}

int main()
{
	int lsock;
	lsock = mk_lsock();
	wait_for_clients(lsock);
}
