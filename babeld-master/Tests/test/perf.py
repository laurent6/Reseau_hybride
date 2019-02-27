import route
import babel
import time
import os


def startPerf(nb_time, interface):
    print("\033[1m"+"PERFORMANCE TEST".center(80) + "\033[0m")
    print("Down all interface ")
    input("Press Enter to continue ... ")
    file = open("perf","w")
    file.write("#i \t time")
    babel.startB(interface)
    print("Up all interface ")
    input("Press Enter to continue ... ")
    for i in range(1,nb_time+1):
        start_time = time.time()
        while not route.check_have_all_route():
            continue

        end_time = time.time()
        file.write(str(i)+"\t" + str(end_time-start_time))
        time.sleep(3)
        babel.startB(interface)
        print("restart All interface ... ")
        input("Press Enter to continue ... ")

    file.close()

