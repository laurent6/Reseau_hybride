#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <pthread.h>
void handle_client(int c)
{
    char buf[8192];
    char *lastpos;
    int size;

    while (1) {
        size = recv(c, buf, 8192, 0);
        if (size == 0) {
            break;
        }
        lastpos = strchr(buf, '\n');
        send(c, buf, lastpos+1-buf, 0);
    }
}
void run(){
  int s, c;
  int reuseaddr = 1;
  struct sockaddr_in6 addr;
  int pid;

  s = socket(AF_INET6, SOCK_STREAM, 0);
  setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &reuseaddr, sizeof(reuseaddr));

  addr.sin6_family = AF_INET6;
  addr.sin6_port = htons(5000);
  addr.sin6_addr = in6addr_any;

  bind(s, (struct sockaddr *)&addr, sizeof(addr));
  listen(s, 5);

  while (1) {
      c = accept(s, NULL, NULL);
      pid = fork();
      if (pid == -1) {
          exit(1);
      } else if (pid == 0) {
          close(s);
          handle_client(c);
          close(c);
          exit(0);
      } else {
          close(c);
          waitpid(pid, NULL, 0);
      }
  }
  pthread_exit(NULL);
}
int main()
{
  pthread_t thread1;
    if (pthread_create(&thread1, NULL,(void *) run, NULL)) {
        perror("pthread_create");
        return 1;
    }
    if (pthread_join(thread1, NULL)) {
      perror("pthread_join");
      return 1;
    }

}
