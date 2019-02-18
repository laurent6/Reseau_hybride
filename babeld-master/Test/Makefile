PREFIX = /usr/local
MANDIR = $(PREFIX)/share/man

CDEBUGFLAGS = -Os -g -Wall

DEFINES = $(PLATFORM_DEFINES)

CFLAGS = $(CDEBUGFLAGS) $(DEFINES) $(EXTRA_DEFINES)

LDLIBS = -lrt

SRCS =  criteriaTest.c ../net.c ../kernel.c ../util.c ../interface.c ../source.c ../neighbour.c \
       ../route.c ../xroute.c ../message.c ../resend.c ../configuration.c ../local.c \
       ../disambiguation.c ../rule.c ../criteria.c

OBJS =  criteriaTest.o  ../net.o ../kernel.o ../util.o ../interface.o ../source.o ../neighbour.o \
       ../route.o ../xroute.o ../message.o ../resend.o ../configuration.o ../local.o \
       ../disambiguation.o ../rule.o ../criteria.o


test: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o criteriaTest $(OBJS) $(LDLIBS)

local.o: ../local.c ../version.h

../kernel.o: ../kernel_netlink.c ../kernel_socket.c

../version.h:
	.././generate-version.sh > ../version.h



.PHONY: all  clean

all: test

clean:
	-rm -f test  *.o *~ core TAGS gmon.out
