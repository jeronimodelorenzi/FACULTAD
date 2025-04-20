#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>

#include <pthread.h>
#include <sys/epoll.h>

#define MAX_EVENTS 10 // Cantidad máxima que epoll puede manejar al mismo tiempo.
int fde, lsock, conn_sock, U = 0; // fde: file descriptor epoll, lsock: socket de escucha, U: turno.
struct epoll_event ev, events[MAX_EVENTS]; // Eventos epoll.

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER; // Mutex.
pthread_t thread[MAX_EVENTS]; // Hilos para epoll_wait.

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


/**
 * Imprime el error y aborta el programa.
 */
void quit(char *s)
{
	perror(s);
	abort();
}


/**
 * Lee una linea desde el socket.
 */
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
	return i; // Retorna la cantidad de caracteres leidos
}

/**
 * Maneja cada conexión.
 */
void handle_conn(int csock)
{
	char buf[200];
	int rc;

	// int csock_cast = *(int*)csock;

	while (1) {
		/* Atendemos pedidos, uno por linea */
		rc = fd_readline(csock, buf);
		if (rc < 0)
			quit("read... raro");

		if (rc == 0) {
			/* linea vacia, se cerró la conexión */
			close(csock);
			break;
		}

		if (!strcmp(buf, "NUEVO")) {
			// Cliente pide turno
			char reply[20];
			pthread_mutex_lock(&mutex); // Protegemos región crítica.
			sprintf(reply, "%d\n", U++); // Asigna turno.
			pthread_mutex_unlock(&mutex); // Libera región crítica.
			write(csock, reply, strlen(reply)); // Responde al cliente
		} else if (!strcmp(buf, "CHAU")) {
			close(csock);
			break;
		}
	}
	pthread_exit(0);
}

void* manejador_epoll (void *arg) {
	int nfds;
  
	while (1) {
	  // Espera eventos en los fd registrados.
	  nfds = epoll_wait(*(int*)arg, events, MAX_EVENTS, -1);
	  if (nfds < 0) quit("epoll_wait");
  
	  for(int n = 0 ; n < nfds; ++n) {
		  if (events[n].data.fd == lsock) {
			// Se conectó un nuevo cliente.
			int conn_sock = accept(lsock, NULL, NULL);
			if (conn_sock < 0) quit("accept");

			// Registra el nuevo socket en epoll
			ev.events = EPOLLIN | EPOLLONESHOT;
			ev.data.fd = conn_sock;

			if (epoll_ctl(*(int*)arg, EPOLL_CTL_ADD, conn_sock, &ev) < 0) quit("epoll_ctl: conn_sock"); // Espera lectura.
			} else {
			// Hay datos en un socket.
			handle_conn(events[n].data.fd); // Atiende pedido.
			
			// Reactiva el socket en epoll si sigue abierto
			ev.events = EPOLLIN | EPOLLONESHOT;
            ev.data.fd = events[n].data.fd;

                if (epoll_ctl(*(int*)arg, EPOLL_CTL_MOD, events[n].data.fd, &ev) < 0) quit("epoll_ctl: reactivate conn_sock");
		  	}
		}
	}
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
	// Crea socket de escucha en 4040
	lsock = mk_lsock();
	// Crea objeto epoll.
    fde = epoll_create1(0);
	if (fde < 0) quit("epoll_create1");
	
	// Agrega el socket de escucha al epoll
    ev.events = EPOLLIN; // Espera lectura.
    ev.data.fd = lsock;
    if (epoll_ctl(fde, EPOLL_CTL_ADD, lsock, &ev) == -1) {
		perror("epoll_ctl: listen_sock");
        exit(EXIT_FAILURE);
    }
    
	// Crea hilos que corren epoll_wait.
    for(int i = 0; i < MAX_EVENTS; i++) 
        pthread_create(&thread[i], NULL, manejador_epoll, &fde);

	for (int i = 0 ; i < MAX_EVENTS ; i++)
		pthread_join(thread[i], NULL);

	// Cierra el socket de escucha.
	close(lsock);
	return 0;
}
