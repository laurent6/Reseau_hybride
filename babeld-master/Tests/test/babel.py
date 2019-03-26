
import subprocess
import os
from os import popen
from re import match
import sys
import time
import string
import route
process=0

def startB(interface, opt):
    print("Start Babeld protocol ... ", end='')
    os.chdir("../../")
    if subprocess.call("ps -a |grep 'babeld' > /dev/null", shell=True) == 0:
            stopB(interface)
    command = "./babeld " + interface
    process = subprocess.Popen(command, shell=True,  stderr=None, stdout=None)
    print(" Done !")



def stopB(interface):
    print("Stop babeld protocol ... ", end='')
    os.system("pkill -9 babeld > /dev/null 2>&1")
    os.system(" rm -f /var/run/babeld.pid > /dev/null 2>&1 ")
    cmd = "ifdown "+ interface
    os.system(cmd)
    cmd = "ifup "+ interface
    os.system(cmd)
    print("Done ! ")


def test_downBattery():
    print("\033[1m " +"TEST BATTERY CRITERIA".center(80) + "\033[0m")
    print(" \t Make sure that host5's battery is over than 15% and all host are up with '-b' option")
    input("Press Enter to continue... ")
    startB("ens3", "-b")
    print("Checking all routes ... ", end='')
    start_time = time.time()
    while not route.check_have_all_route():
        time.sleep(5)
        if(time.time() - start_time )> 45:
            stopB("ens3")
            print("Failed")
            exit(1)
    print("Done")
    print("checking match host7 host5 ...", end='')
    start_time = time.time()
    while not route.match_ip_mac("host7", "host5"):
        time.sleep(5)
        if (time.time() - start_time) > 45:
            stopB("ens3")
            print("Failed")
            exit(1)
    print('Done !')
    print("\t Please down host5's battery (lower than 15%)")
    input("Press Enter to continue...")
    print("Checking change route ...")
    start_time = time.time()
    while not route.check_have_all_route():
        time.sleep(5)
        if (time.time() - start_time) > 45:
            stopB("ens3")
            print("Failed")
            exit(1)

    start_time = time.time()
    while not route.match_ip_mac("host7" ,"host4"):
        time.sleep(5)
        if (time.time() - start_time) > 45:
            stopB("ens3")
            print("Failed")
            exit(1)

    print("\x1b[0;32;40m Everything is ok \x1b[0m")
    stopB("ens3")
