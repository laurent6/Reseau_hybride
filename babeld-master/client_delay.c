#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include "kernel.h"
#include "util.h"


unsigned ping(int sock, char *message,struct sockaddr_in6 serv){
  struct sockaddr_in6 cli;
  struct timeval start;
  struct timeval stop;
  socklen_t clilen= sizeof(cli);
  socklen_t servlen = sizeof(serv);
  char buffer_reception[10];

  if (sendto(sock,message, sizeof(message)+1, 0,(struct sockaddr *)&serv,servlen) < 0) {
      perror("sendto failed");
      exit(1);
  }
  gettimeofday(&start, NULL);
  memset(&buffer_reception, 0, sizeof(buffer_reception));


  struct timeval timeout;
  timeout.tv_sec = 1;
  fd_set input_set;
  FD_ZERO(&input_set);
  FD_SET(sock, &input_set);
  int v = select(sock+1, &input_set, NULL, NULL, &timeout); // we look time to recv.
  if(v >0){
    memset(buffer_reception,0,sizeof(buffer_reception));
    if (recvfrom(sock, buffer_reception, sizeof(buffer_reception), 0,(struct sockaddr *)&cli,&clilen) < 0) {
        perror("recvfrom failed");
        exit(1);
    }
    gettimeofday(&stop,NULL);
  }
  char addrbuf[INET6_ADDRSTRLEN];
  /*printf("got '%s' from %s with send '%s'\n", buffer_reception,
   inet_ntop(AF_INET6, &cli.sin6_addr, addrbuf,
       INET6_ADDRSTRLEN),message);*/


  if(strcmp(buffer_reception, message) !=0){
    printf("rentre \n");
      return 0;
    }
    unsigned start_in_milli = (unsigned)((start.tv_sec)*1000 + (start.tv_usec)/1000);
    unsigned stop_in_milli = (unsigned)((stop.tv_sec)*1000 + (stop.tv_usec)/1000);
    int v2 =0;
    int p =0;
    printf(" %lu",stop_in_milli-start_in_milli);
    return stop_in_milli-start_in_milli;
}
unsigned get_delay(char *address){
  int sock;
  struct sockaddr_in6 server;
  unsigned time_average=0;
  char *string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  size_t stringLen = strlen(string);
  char string_to_send[10];
  /* create a DGRAM (UDP) socket in the INET6 (IPv6) protocol */

  sock = socket(PF_INET6, SOCK_DGRAM, 0);

  if (sock < 0) {
    perror("creating socket");
    exit(1);
  }
  memset(&server, 0, sizeof(server));
  server.sin6_family = AF_INET6;
  if(inet_pton(AF_INET6, address, &server.sin6_addr)!= 1){
    perror("Incorrect format address in server");
    exit(1);
  }
  server.sin6_port = htons(PORT_DELAY);



  for(int i=0; i<=4; i++){
    memset(&string_to_send, 0, sizeof(string_to_send));
    for(int j =0; j<10; j++){
       int key = rand() % stringLen;
       string_to_send[j] = string[key];
    }
    string_to_send[9]='\0';
    unsigned res=0;
    if((res=ping(sock, string_to_send,server)) > 0){
      time_average =  (time_average +res)/2;
    }

  }
  close(sock);
  return time_average;

}
