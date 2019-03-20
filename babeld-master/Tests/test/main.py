import babel
import perf
import TestRoute
import sys, getopt
def main():
    #todo
    #babel.startB("ens3")
    babel.test_downBattery()
    perf.startPerf(25,"ens3")
    #TestRoute.test_is_link()

def usage():
    print("usage: \n\t -b : to test battery criteria"+
<<<<<<< HEAD
          "\n\t -p <nb_Perf> <list_of_hosts): performance test nb_times "+
=======
          "\n\t -p <nbPerf>: performance test nb_times"+
>>>>>>> parent of 69e022b... Merge branch 'master' of https://github.com/laurent6/reseau_hybride into Test_new_Install
          "\n\t -h : display help")
if __name__ == "__main__":
    #main()
    try:
        opts,args= getopt.getopt(sys.argv[1:], "hbp:",["nbperf="])
    except getopt.GetoptError:
        usage()
        sys.exit(0)
    for opt,arg in opts:
        if opt == '-h':
            usage()
            sys.exit(0)
<<<<<<< HEAD
        elif opt in ("-p","--nbPerf", "--list"):
            if args == []:
                usage()
            else:
                ''''print("before")
                route.print_all_ip_address()
                route.list_of_host(args)
                print("after")
                route.print_all_ip_address()'''
                perf.startPerf(int(arg), args, "ens3")
=======
        elif opt in ("-p","--nbPerf"):
            perf.startPerf(int(arg), "ens3")
>>>>>>> parent of 69e022b... Merge branch 'master' of https://github.com/laurent6/reseau_hybride into Test_new_Install
        elif opt == '-b':
            babel.test_downBattery()

