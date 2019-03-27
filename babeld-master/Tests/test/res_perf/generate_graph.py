import os
import re
import statistics

file_data = os.popen("ls perf_*_host").read()
file_data = file_data.split()

all_data = dict()


for f in file_data:

    nb_host = int(re.findall(r'\d+', f).pop())

    output = os.popen("cat " + f).read().split("\n")

    data=list()
    average=0

    for d in output:
        d = d.split('\t')
        del d[0]
        if len(d)>0:
            if float(d[0])>0.5 and nb_host==2:
                data.append(float(d[0]))
                average+=float(d[0])
            if float(d[0])>5 and nb_host>2:
                data.append(float(d[0]))
                average+=float(d[0])

    average=average/len(data)
    all_data[nb_host] = [average, statistics.stdev(data)]


f = open("data.txt","w+")
for e in all_data.keys():
    string = str(e) + "\t" + str(all_data[e][0]) + "\t" + str(all_data[e][1]) +  "\n"
    f.write(string)
f.close()

os.system("gnuplot -c gnuplot_script")
