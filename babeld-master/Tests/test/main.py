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
          "\n\t -p <nbPerf>: performance test nb_times"+
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
        elif opt in ("-p","--nbPerf"):
            perf.startPerf(int(arg), "ens3")
        elif opt == '-b':
            babel.test_downBattery()

