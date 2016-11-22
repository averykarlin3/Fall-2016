# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import matplotlib.pyplot as plt

xvals = []
yvals = []
hvals = []
h = 6.626 * (10 ** -34)

def readFile():
    f = open('../../../Desktop/millikan.txt', 'r')
    data = f.read()
    f.close()
    data = data.split('\n')
    length = len(data)
    data.remove(data[length - 1])
    for i in range(0, length - 1):
        d = data[i].split(' ')
        xvals.append(float(d[0]))
        yvals.append(float(d[1]))
    plt.plot(xvals, yvals, 'ro')
    plt.show()

def sqDistance():
    numVals = len(xvals)
    ex = 0
    ey = 0
    exx = 0
    exy = 0
    for i in range(0, numVals):
        ex += xvals[i]
        ey += yvals[i]
        exx += (xvals[i] * xvals[i])
        exy += (xvals[i] * yvals[i])
    ex /= numVals
    ey /= numVals
    exx /= numVals
    exy /= numVals
    m = (exy - ex*ey)/(exx - ex*ex)
    b = (exx*ey - ex*exy)/(exx - ex*ex)
    print("M: ", m)
    print("B: ", b)
    plt.plot(xvals, yvals, 'ro', [0, max(xvals)], [b, m*max(xvals) + b])
    plt.show()
    
def millikan():
    e = 1.602 * (10 ** -19)
    numVals = len(xvals)
    for i in range(0, numVals):
        hvals.append(yvals[i] * e / xvals[i])
        print("H#", i, ": ", hvals[i])
        print("Percent Error: ", abs((hvals[i] - h)/h) * 100)
        
readFile()
sqDistance()
millikan()