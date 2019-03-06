import route
import os

all_ip_test_address = [("2001:db8:3c4d:1::1"),
                       ("2001:db8:3c4d:2::1"),
                       ("2001:db8:3c4d:3::1"),
                       ("2001:db8:3c4d:4::1"),
                       ("2001:db8:3c4d:5::1"),
                       ("2001:db8:3c4d:6::1"),
                       ("2001:db8:3c4d:7::1")]
def testGetRoutes():

    # make sure that all route does not exists
    del_all_routes()

    # add all route for test with infini metric
    for key in all_ip_test_address:
        command= "ip -6 route add "+key+" via fe80::a000:ff:fe00:7 dev ens3 metric 4294967295"
        os.system(command)

    assert not route.check_have_all_route(), "have all route with good metric"
    input("check have all root with infini metric and press Enter to continue ... ")

    del_all_routes()
    # change metric
    for key in all_ip_test_address:
        command = "ip -6 route add " + key + " via fe80::a000:ff:fe00:7 dev ens3 metric 5"
        os.system(command)

    assert route.check_have_all_route(), "have not all route"
    input("check have all route and press to Enter to continue ...  ")

    del_all_routes()

    assert not route.check_have_all_route(), "have all route"
    input("check have not all route and press to Enter to continue ...  ")

def del_all_routes():
        command = "ip -6 route flush  table main"
        os.system(command)
        input(" dell all routes ? ")

def test_is_link():
    route.is_reachable_link("host5")