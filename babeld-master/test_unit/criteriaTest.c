/*
Copyright (c) 2007, 2008 by Juliusz Chroboczek
Copyright (c) 2010 by Vincent Gross

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/time.h>
#include <time.h>
#include <signal.h>
#include <assert.h>

#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>

#include "criteriaTest.h"
#include "../util.h"
#include "../net.h"
#include "../kernel.h"
#include "../interface.h"
#include "../source.h"
#include "../neighbour.h"
#include "../route.h"
#include "../xroute.h"
#include "../message.h"
#include "../resend.h"
#include "../configuration.h"
#include "../local.h"
#include "../rule.h"
#include "../version.h"
#include "../babeld.h"
#include "../criteria.h"

int use_battery=0;
void testBattery(){

  //set battery

  FILE *f;
  f = fopen("battery","w");
  if(f != NULL){
    char *c = "42";
    if(fputs(c,f) == EOF){
      perror(" \t Could not create battery file \n");
      exit(1);
    }
    fclose(f);
  }


struct buffered *buf;
buf = malloc(sizeof(struct buffered));
buf->len =0;
buf->buf = malloc(sizeof(char *));
push_criteria(buf);
assert(buf->len == 3);
assert(buf->buf[0]== MESSAGE_BATTERY);
assert(buf->buf[1]== 1);
assert(buf->buf[2] == 42);



}

int
main(int argc, char **argv)
{
testBattery();
  return 0;
}


void
schedule_neighbours_check(int msecs, int override)
{
    struct timeval timeout;

    timeval_add_msec(&timeout, &now, roughly(msecs));
    if(override)
        check_neighbours_timeout = timeout;
    else
        timeval_min(&check_neighbours_timeout, &timeout);
}

void
schedule_interfaces_check(int msecs, int override)
{
    struct timeval timeout;

    timeval_add_msec(&timeout, &now, roughly(msecs));
    if(override)
        check_interfaces_timeout = timeout;
    else
        timeval_min(&check_interfaces_timeout, &timeout);
}

int
resize_receive_buffer(int size)
{
    unsigned char *new;

    if(size <= receive_buffer_size)
        return 0;

    new = realloc(receive_buffer, size);
    if(new == NULL) {
        perror("realloc(receive_buffer)");
        return -1;
    }
    receive_buffer = new;
    receive_buffer_size = size;

    return 1;
}





int
reopen_logfile()
{
    int lfd, rc;

    if(logfile == NULL)
        return 0;

    lfd = open(logfile, O_CREAT | O_WRONLY | O_APPEND, 0644);
    if(lfd < 0)
        return -1;

    fflush(stdout);
    fflush(stderr);

    rc = dup2(lfd, 1);
    if(rc < 0)
        return -1;

    rc = dup2(lfd, 2);
    if(rc < 0)
        return -1;

    if(lfd > 2)
        close(lfd);

    return 1;
}
