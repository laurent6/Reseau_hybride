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
int getBattery(){
  FILE *f;
  int res = 0; 
  f = fopen("battery","r");
  if(f != NULL){
    char tmp[255];
    if(fgets(tmp, sizeof tmp, f) != NULL){
      int b = atoi(tmp);
      if(b >=0 && b <= 100)
	res = b; 
    }
    fclose(f); 
  }

  return res; 
}


void battery(struct buffered *buf){
  int b=getBattery();
  buf->buf[buf->len++]= MESSAGE_BATTERY;
  buf->buf[buf->len++]= 1;
  buf->buf[buf->len++]= b;
}
/**
   Accumulate all criteria. 
   WARNING : change LENGTH_ALL_CRITERIA in header file when you change this function 
 **/
void push_criteria(struct buffered *buf){

  battery(buf); 
  


}
