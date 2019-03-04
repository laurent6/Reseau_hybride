import route
import babel
import time
import os
import string

def startPerf(nb_time, interface):
    print("\033[1m"+"PERFORMANCE TEST".center(80) + "\033[0m")
    file = open("perf", "w")
    babel.startB("ens3")
    '''print("\t Make sure that babeld is up in all host and start mobilizer ")
    input("Press Enter to continue ... ")
    time_mobilizer = time.time()
    time.sleep(60)
    for i in range(1,nb_time):

        print("\t Start  test number "+str(i))
        start_time = time.time()
        is_on_time= True
        while not route.check_have_all_route():
            if((time.time()-start_time) >45):
                is_on_time = False
                break

            continue
        end_time = time.time()
        if is_on_time:
            print(" \t Save time stabiliszation of all routes")
            file.write("\n" +str(i)+"\t" + str(end_time-start_time))
        else :
            print("\t Problem with synchronisation continue ")
        time.sleep(60-round((end_time-start_time)))'''
    input(" wait for you ..")
    routes = route.get_routes()
    print(routes)
    babel.stopB("ens3")
    input("wait other")
    routes = route.get_routes()
    print("\n \n \n" + routes)



    file.close()
    babel.stopB("ens3")