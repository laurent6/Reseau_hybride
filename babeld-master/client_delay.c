#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <stdbool.h>

struct timeval stop, start;

bool ping(int s, char *message)
{
    char buf[8192];

    gettimeofday(&start, NULL);

    if(send(s, message, strlen(message), 0) <0){
      perror("Can't send message shoudn't happened");
      exit(1);
    };
    int v;
    struct timeval timeout;
    timeout.tv_sec = 1;
    fd_set input_set;
    FD_ZERO(&input_set);
    FD_SET(s, &input_set);
    v = select(s+1, &input_set, NULL, NULL, &timeout); // we look time to recv.
    if(v >0){
      recv(s, buf, 8192, 0);
    }

    gettimeofday(&stop, NULL);
    if(strcmp(buf, message) !=0){
      return false;
    }
    return true;
}
unsigned long get_delay(char *address){
  int s;
  struct sockaddr_in6 addr;
  unsigned long time_average;
  s = socket(AF_INET6, SOCK_STREAM, 0);
  addr.sin6_family = AF_INET6;
  addr.sin6_port = htons(5000);
  fprintf(stdout," address %s \n",address);
  if(inet_pton(AF_INET6, address, &addr.sin6_addr) !=1){
      perror(" Convert adress string to socket structure failed");
      exit(1);
  }
  if(connect(s, (struct sockaddr *)&addr, sizeof(addr)) == -1){
      perror(" Connect to neighbour to delay failed");
      exit(1);
  }
  char *string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  size_t stringLen = strlen(string);
  char char_to_send[10];
  time_average = 0;
  for(int i=0; i<=4; i++){
    for(int j =0; j<10; j++){
       int key = rand() % stringLen;
       char_to_send[j] = string[key];
    }
    if(ping(s, char_to_send)){
      time_average =  (unsigned long)(time_average +(stop.tv_usec - start.tv_usec))/2;
    }

  }
  return time_average;
  close(s);
}
