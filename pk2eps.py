# -*- coding:utf-8 -*
#!/bin/python3

import os
os.path.dirname(os.path.abspath(__file__))
import sys
from tkinter import *
from math import sqrt, atan2, cos, sin


def main():
	if len(sys.argv) != 5:
		print("Usage: {0} [input .dat] [output .eps] [island length] [island width]".format(sys.argv[0]))
		os.system("pause")
		return
	
	l = float(sys.argv[3])
	w = float(sys.argv[4])
	
	
	# open input file
	f = open(sys.argv[1], 'r')
	
	# no error check! assuming good input file ...
	
	# first line with number of unit cells
	(Nx, Ny) = f.readline().split()
	Nx = int(Nx) + 1
	Ny = int(Ny) + 1
	
	# skip next two lines
	f.readline()
	f.readline()
	
	list = []
	
	# read moments
	for line in f:
		line = line.strip()
		if not line:
			continue
		
		# extract coordinates
		(px, py, mx, my) = line.split()
		px = float(px)*1e9
		py = float(py)*1e9
		mx = float(mx)
		my = float(my)
		
		list.append({'px' : px, 'py' : py, 'mx' : mx, 'my' : my})
	
	# close input file
	f.close()
	
	# determine lattice constant
	a = list[7]['py'] - list[1]['py']
	
	
	# initialize graphics
	master = Tk()
	
	c = Canvas(master, width=(Nx*sqrt(3.)*a + 50), height=((Ny+.5)*a + 50))
	c.pack()
	
	offset = ((Nx-1)*sqrt(3.)*a/2. + l/2. + 25., (Ny-2)*a/2. + 25)
	
	# draw
	for i in list:
		# prepare geometry for the island [rectangle shape]
		th = atan2(i['my'], i['mx'])
		
		aa = (cos(th)*l, sin(th)*l)
		ab = (-sin(th)*w, cos(th)*w)
		
		o = (i['px']-(aa[0]+ab[0])/2. + offset[0], i['py']-(aa[1]+ab[1])/2. + offset[1])
		
		# draw island
		c.create_polygon([o[0], o[1], o[0]+aa[0], o[1]+aa[1], o[0]+aa[0]+ab[0], o[1]+aa[1]+ab[1], o[0]+ab[0], o[1]+ab[1]],
		                 outline='black', fill=(aa[0] >= 0 and 'blue' or 'red'))
		# draw moment
		c.create_line(i['px']-aa[0]/2.+offset[0], i['py']-aa[1]/2.+offset[1],
		              i['px']+aa[0]/2.+offset[0], i['py']+aa[1]/2.+offset[1],
			      width=2, arrow='last', arrowshape=(20,25,8))
	
	# main loop
	#master.mainloop()
	
	# create temporary eps
	c.update()
	c.postscript(file=sys.argv[2], colormode='color')
	
	print('saved ' + sys.argv[2])
	os.system("pause")


if __name__ == '__main__':
	main()
