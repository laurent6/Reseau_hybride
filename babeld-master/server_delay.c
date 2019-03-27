#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <pthread.h>
#include "kernel.h"



void
run ()
{
  int sock;

  struct sockaddr_in6 server, client;
  socklen_t clilen = sizeof (client);
  socklen_t servlen = sizeof (server);
  char buffer[13];

  char addrbuf[INET6_ADDRSTRLEN];

  /* create a DGRAM (UDP) socket in the INET6 (IPv6) protocol */
  sock = socket (PF_INET6, SOCK_DGRAM, 0);

  if (sock < 0)
    {
      perror ("creating socket");
      exit (1);
    }

#ifdef V6ONLY
  // setting this means the socket only accepts connections from v6;
  // unset, it accepts v6 and v4 (mapped address) connections
  {
    int opt = 1;
    if (setsockopt (sock, IPPROTO_IPV6, IPV6_V6ONLY, &opt, sizeof (opt)) < 0)
      {

      }
  }
#endif

  memset (&server, 0, sizeof (server));
  server.sin6_family = AF_INET6;
  server.sin6_addr = in6addr_any;
  server.sin6_port = htons (PORT_DELAY);

  /* associate the socket with the address and port */
  if (bind (sock, (struct sockaddr *) &server, servlen) < 0)
    {

    }

  while (1)
    {
      memset (&buffer, 0, sizeof (buffer));
      /* now wait until we get a datagram */
      //printf("waiting for a datagram...\n");
      if (recvfrom (sock, buffer, sizeof (buffer) + 1, 0,
		    (struct sockaddr *) &client, &clilen) < 0)
	{

	}

      /* now client_addr contains the address of the client */
      //printf("got '%s' from %s\n", buffer,
      inet_ntop (AF_INET6, &client.sin6_addr, addrbuf, INET6_ADDRSTRLEN);
      //printf("sending message back\n");
      buffer[strlen (buffer)] = '\0';
      if (sendto
	  (sock, buffer, sizeof (buffer) + 1, 0, (struct sockaddr *) &client,
	   clilen) < 0)
	{

	}

    }
}

void
start_serv ()
{
  pthread_t thread1;
  if (pthread_create (&thread1, NULL, (void *) run, NULL))
    {
      perror ("pthread_create");
      exit (1);
    }


}
