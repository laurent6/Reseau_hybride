import route
import babel
import time
import os
import string
import subprocess

def startPerf(nb_time,hosts, interface):
    route.list_of_host_by_number(int(hosts))
    print("\033[1m"+"PERFORMANCE TEST".center(80) + "\033[0m")
    file = open("perf", "w")
    print("\t Please,  "
          "\n\t\t 1)  start {PATH_To_Babel}/daemon_connect_neighboor.sh in all Host"
          "\n\t\t 2) Start mobilizer in Nemu prompt  ( 1) can be do before 2) )")
    input("Press Enter to continue ... ")
    time_mobilizer = time.time()
    '''if subprocess.call("ps -a |grep 'babeld' >/dev/null", shell=True) == 1:
        print("\033[91m  \033[1m Babel is not Starting ")
        exit(1)'''
    i=0
    while i < nb_time:
        while not route.is_reachable_link("host5"):
            continue
        print("All link reachable ")
        start_time = time.time()
        is_on_time= True
        while not route.check_have_all_route():
            if((time.time()-start_time) >45):
                is_on_time = False
                break

        end_time = time.time()
        if is_on_time:
            print(" \t Save time stabiliszation of all routes :" + str(end_time-start_time) +"s")
            file.write("\n" +str(i)+"\t" + str(end_time-start_time))
        else :
            print("\t Problem with synchronisation continue ")
        i = i + 1
        if(i < nb_time):
            while route.is_reachable_link("host5"):
                continue
            print("All link are unreachable")








    file.close()
