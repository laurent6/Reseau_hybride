import babel
import perf
import TestRoute
import sys, getopt
import route

def usage():
    print("usage: \n\t -b : to test battery criteria"+
          "\n\t -p <nb_Perf> <number_of_host> <interface_name>): performance test nb_times "+
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
            if len(args) != 2:
                print("Number of arg are incorrect")
                usage()
            elif not str.isdigit(arg):
                print(" \033[91m  \033[1marg1 of this option must be  an Integer")
                print("\033[0;0m")  
                usage()
            elif not str.isdigit(args[0]):
                print(" \033[91m  \033[1m arg2 of this option must be  an Integer")
                print("\033[0;0m")
                usage()
            else:
                perf.startPerf(int(arg), args[0], args[1])
        elif opt == '-b':
            babel.test_downBattery()
