import os
import re
import statistics

file_data = os.popen ("ls *.c *.h").read ()
file_data = file_data.split ()

for i in file_data:
  cmd = "indent " + i
  os.system (cmd)
