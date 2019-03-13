import babel
import perf
import TestRoute
import sys, getopt
import route
def main():
    #todo
    #babel.startB("ens3")
    babel.test_downBattery()
    perf.startPerf(25,"ens3")
    #TestRoute.test_is_link()

def usage():
    print("usage: \n\t -b : to test battery criteria"+
          "\n\t -p <nb_Perf> <list_of_hosts): performance test nb_times "+
          "\n\t -h : display help")
if __name__ == "__main__":
    #main()
    try:
        opts,args= getopt.getopt(sys.argv[1:], "hbp:",["nbperf=", "list="])
    except getopt.GetoptError:
        usage()
        sys.exit(0)
    for opt,arg in opts:
        if opt == '-h':
            usage()
            sys.exit(0)
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
        elif opt == '-b':
            babel.test_downBattery()

