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


/*
Get battery status.
@return -1 if battery doesn't exist.
*/
int getBattery(){
  FILE *f;
  int res = -1;
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

/**
   Add battery criteria in buffer.
 **/
void push_battery_buff(struct buffered *buf){
  int battery=getBattery();
  debugf("update buffer battery Criteria : %d \n",battery);
  buf->buf[buf->len++]= MESSAGE_BATTERY;
  buf->buf[buf->len++]= 1;
  buf->buf[buf->len++]= battery;
}

void update_metric_battery_criteria(int * metric ){
  int battery = getBattery();
  if(battery <= 15 && *metric < (int)INFINITY/2){
      *metric += (int)INFINITY/2;
  } 
  }


}

int is_battery_critical(int b){
    return b <=15;
}

/**
   Accumulate all criteria.
   WARNING : change LENGTH_ALL_CRITERIA in header file when you change this function
 **/
void push_criteria(struct buffered *buf){

  push_battery_buff(buf);



}
