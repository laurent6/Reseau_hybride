

import subprocess
import os
from os import popen
from re import match
import sys
import time

process=0
all_ip_address = dict([("host1","2001:db8:3c4d:1::1/128"),
                   ("host2","2001:db8:3c4d:2::1/128"),
                    ("host3","2001:db8:3c4d:3::1/128"),
                    ("host4","2001:db8:3c4d:4::1/128"),
                    ("host5","2001:db8:3c4d:5::1/128"),
                    ("host6","2001:db8:3c4d:6::1/128"),
                    ("host7","2001:db8:3c4d:7::1/128"),
    ])

all_mac_address = dict([("host1","fe80::a000:ff:fe00:1"),
                   ("host2","fe80::a000:ff:fe00:3"),
                    ("host3","fe80::a000:ff:fe00:5"),
                    ("host4","fe80::a000:ff:fe00:7"),
                    ("host5","fe80::a000:ff:fe00:9"),
                    ("host6","fe80::a000:ff:fe00:b"),
                    ("host7","fe80::a000:ff:fe00:d"),
    ])
def startB(interface):
    os.chdir("../")
    print(os.getcwd())
    command = "./babeld "+ interface + "> /dev/null 2>&1"
    os.system("rm -f /var/run/babeld.pid")
    process = subprocess.Popen(command, shell=True)
    #os.system("./babeld ens3 >  /dev/null 2>&1")


def stopB():
    os.system("rm -f /var/run/babeld.pid")
    if process != 0:
        process.terminate()

def get_routes():
    rtr_table = [elem for elem in popen("route -6")]
    del rtr_table[0]
    res = []
    for i in range(1, len(rtr_table)):
        route = rtr_table[i].split()
        res[i-1][0] = route[0]  #destination
        res[i-1][1] = route[1]  #nextHop

    return res

def check_have_all_route():
    routes = get_routes()
    number_of_route = len(all_ip_address)
    cop_list_adress = all_ip_address.copy()
    for route in routes:
        if route[0] in cop_list_adress.values():
            del cop_list_adress[list(cop_list_adress.
                                     keys())[list(cop_list_adress.values()).
                                        index(route[0])]]

    return len(cop_list_adress) == 0


def test_downBattery():
    startB("ens3")
    while not check_have_all_route():
        time.sleep(5)


    rtr_table = get_routes()
    for i in range(0,len(rtr_table)):
        destination = rtr_table[i][0]
        nexthop = rtr_table[i][1]
        try:
            if(destination == all_ip_address["host7"]):
                if(nexthop != all_mac_address["host5"]):
                    raise Exception("bad_next_hop")

        except Exception as inst:
            print(type(inst))
            if(type(inst) == "bad_next_hop"):
                print("\n\t destination : "+ destination
                      + " have bad next hop " + nexthop)

        i = i+1

    print("Active default route:", rtr_table[1].split()[0])

    print("Active default next hop:", rtr_table[1][3])