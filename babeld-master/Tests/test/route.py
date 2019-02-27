from os import popen
from re import match


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



def get_routes():
    rtr_table = [elem for elem in popen("route -6")]
    del rtr_table[0]
    res = {}
    for i in range(1, len(rtr_table)):
        route = rtr_table[i].split()
        res[route[0]] = route[1]  # destination

    return res


def check_have_all_route():
    routes = get_routes()
    number_of_route = len(all_ip_address)
    cop_list_adress = all_ip_address.copy()
    for key, value in routes.items():
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
        print(" destination : " + destination + " nexthop : " + nexthop)
