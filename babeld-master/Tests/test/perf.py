import route
import babel
import time
import os
import string

def startPerf(nb_time, interface):
    print("\033[1m"+"PERFORMANCE TEST".center(80) + "\033[0m")
    file = open("perf", "w")
    babel.startB("ens3")
    print("\t Make sure that babeld is up in all host and start mobilizer ")
    input("Press Enter to continue ... ")
    time_mobilizer = time.time()

    for i in range(1,nb_time):
        while not route.is_reachable_link("host2"):
            continue
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
        while route.is_reachable_link("host2"):
            continue






    file.close()
    babel.stopB("ens3")