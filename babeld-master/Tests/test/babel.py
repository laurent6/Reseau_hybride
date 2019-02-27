

import subprocess
import os
import route
import sys
import time
import string
process=0


def startB(interface):
    print("Start Babeld protocol", end='')
    os.chdir("../../")
    subprocess.run("rm -f /var/run/babeld.pid", stderr=None, shell=True)
    command = "killall babeld"
    os.system(command)
    command = "ifdown "+ interface
    os.system(command)
    command = "ifup "+ interface
    os.system(command)
    command = "./babeld " + interface + " > /dev/null 2>&1  "
    process = subprocess.Popen(command, shell=True,  stderr=None, stdout=None)
    print(" Done !")
    #os.system("./babeld ens3 >  /dev/null 2>&1")


def stopB():
    print("Stop babeld protocol ... ", end='')
    os.system("rm -f /var/run/babeld.pid > /dev/null 2>&1")
    os.system("killall babeld")
    if process != 0:
        process.terminate()
    print("Done ! ")


def test_downBattery():
    print("\033[1m"+"TEST BATTERY CRITERIA".center(80) + "\033[0m")
    print(" \t Make sure that host5's battery is upper than 15% and all host are up")
    input("Press Enter to continue... ")
    startB("ens3")
    print("Check all routes ... ")
    start_time = time.time()
    while not route.check_have_all_route():
        time.sleep(5)
        print(route.check_have_all_route())
        if(time.time() - start_time)> 45:
            print("Failed")
            exit(1)
    print("a tout ")
    start_time = time.time()
    while not route.match_ip_mac("host7", "host5"):
        time.sleep(5)
        if (time.time() - start_time) > 45:
            print("Failed")
            exit(1)

    print("\t Please down host5's battery (lower than 15%)")
    input("Press Enter to continue...")
    print("Check change route ...")
    start_time = time.time()
    while not route.check_have_all_route():
        time.sleep(5)
        if (time.time() - start_time) > 45:
            print("Failed")
            exit(1)

    start_time = time.time()
    while not route.match_ip_mac("host7","host4"):
        time.sleep(5)
        if (time.time() - start_time) > 45:
            print("Failed")
            exit(1)

    print("Everything it's ok")
    stopB()