from os import popen
from re import match
import os
import subprocess

all_ip_address = dict([("host1" ,"2001:db8:3c4d:1::1"),
                       ("host2" ,"2001:db8:3c4d:2::1"),
                       ("host3" ,"2001:db8:3c4d:3::1"),
                       ("host4" ,"2001:db8:3c4d:4::1"),
                       ("host5" ,"2001:db8:3c4d:5::1"),
                       ("host6" ,"2001:db8:3c4d:6::1"),
                       ("host7" ,"2001:db8:3c4d:7::1"),
                       ])

all_mac_address = dict([("host1" ,"fe80::a000:ff:fe00:1"),
                        ("host2" ,"fe80::a000:ff:fe00:3"),
                        ("host3" ,"fe80::a000:ff:fe00:5"),
                        ("host4" ,"fe80::a000:ff:fe00:7"),
                        ("host5" ,"fe80::a000:ff:fe00:9"),
                        ("host6" ,"fe80::a000:ff:fe00:b"),
                        ("host7" ,"fe80::a000:ff:fe00:d"),
                        ])

nb_host = 7

def list_of_host(list):
    a={}
    for elt in list:
        if elt in all_ip_address.keys():
            a[elt] = all_ip_address[elt]

    all_ip_address.clear()
    all_ip_address.update(a)

def print_all_ip_address():
    print(all_ip_address)

def get_routes():
    rtr_table = [elem for elem in popen("route -6 -n ")]
    res = {}
    for i in range(1, len(rtr_table)):
        route = rtr_table[i].split()
        if(route[3] != "-1"): # metric != +infini
            res[route[0].split("/")[0]] = route[1]  # res[ip_destination] = nextHop

    return res

def reset_routes(interface):
    print("Clean routing table ...", end='')
    command = "ifdown  " + interface
    os.system(command)
    command = "ifup  " + interface
    os.system(command)
    print("Done")

def check_have_all_route():
    routes = get_routes()
    cop_list_adress = all_ip_address.copy()
    for key,value in routes.items():
        if key in cop_list_adress.values():
            del cop_list_adress[list(cop_list_adress.
                                keys())[list(cop_list_adress.values()).
                                index(key)]]
    return len(cop_list_adress) == 0

def match_ip_mac(hostname_ip, hostname_mac):
    rtr_table = get_routes()
    for key, value in rtr_table.items():
        destination = key
        nexthop = value
        if destination == all_ip_address[hostname_ip]:
            if nexthop == all_mac_address[hostname_mac]:
                return True

    return False

def print_all_routes():
    rtr_table = get_routes()
    for destination, nexthop in rtr_table.items():

        print("Destination : " + destination + "\tNexthop : " + nexthop)

def ping_all_hosts():
        for i in range(1,nb_host):
            host = "2001:db8:3c4d:" + str(i) + "::1"
            cmd = "ping -6 -w 1 -c 1 " + host + " > /dev/null"
            res = os.system(cmd)
            if res == 0:
                    print(host + " : host" + str(i) + " reachable")
            else:
                print(host + " : host" + str(i) + " unreachable")


def is_reachable_link(host):
        cmd = "ping6  -I ens3 " + all_mac_address[host]+" -c 1 -w 1  >/dev/null 2>&1"
        res = os.system(cmd)
        return res == 0
