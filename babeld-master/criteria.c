/***


@author Laurent BOUQUIN 
Virgile Chatelain 
Julien Massonneau 

 **/
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <assert.h>
#include <sys/time.h>

#include "babeld.h"
#include "util.h"
#include "kernel.h"
#include "interface.h"
#include "source.h"
#include "neighbour.h"
#include "route.h"
#include "xroute.h"
#include "message.h"
#include "resend.h"
#include "configuration.h"
#include "local.h"
#include "disambiguation.h"
#include "criteria.h"

/**
   Add battery criteria in buffer. 
 **/
void battery(struct buffered *buf){

  unsigned int b=50;
  DO_HTONL(buf->buf + buf->len, MESSAGE_BATTERY); 
  DO_HTONL(buf->buf + buf->len+ sizeof(MESSAGE_BATTERY), b);
  buf->len +=8;
}
/**
   Accumulate all criteria. 
   WARNING : change LENGTH_ALL_CRITERIA in header file when you change this function 
 **/
void push_criteria(struct buffered *buf){

  battery(buf); 
  


}