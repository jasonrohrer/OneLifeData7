#!/usr/bin/python
import sys
import os
import csv
import linecache

if len(sys.argv)==2:
	with open("{0}.csv".format(sys.argv[1]),"w") as output:
		csv_w = csv.writer(output)
		csv_w.writerow(["english",sys.argv[1]])
		for file in os.listdir("../objects/"):
			csv_w.writerow([linecache.getline(os.path.join("../objects/",file),2).rstrip(),0])

else:
	sys.stderr.write("Usage:{0} <name>\n".format(sys.argv[0]))

