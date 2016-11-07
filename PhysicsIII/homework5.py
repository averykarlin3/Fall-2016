# -*- coding: utf-8 -*-
"""
Created on Tue Aug 16 13:30:37 2016

@author: Bob
"""


from math import sqrt, sin, pi
from numpy import empty, amax
from pylab import imshow, jet, show

side = 100        # Side of the square in cm
x0 = side/2         #position of center
x1 = x0 + 10
x2 = x0 - 10
y0 = side/2         #position of center
points = 100        # Number of grid points along each side
spacing = side/points #Spacing of points in cm
amplitude = 1
wavelength = 5
k = 2*pi/wavelength
approximation = 0.05

#Make an array to store the heights
wave1 = empty([points, points], float)
wave2 = empty([points, points], float)
total = empty([points, points], float)
totalMax = empty([points, points], float)
totalMin = empty([points, points], float) 

#Calculate the values in the array
for i in range(points):
    y = spacing*i
    for j in range(points):
        x = spacing*j
        wave1[i, j] = amplitude*sin(k*sqrt(((x - x1)**2) + ((y - y0)**2)))
        wave2[i, j] = amplitude*sin(k*sqrt(((x - x2)**2) + ((y - y0)**2)))
        total[i, j] = wave1[i, j] + wave2[i, j]
        if(abs(total[i, j] - amax(total)) < approximation):
            totalMax[i, j] = 1
        else:
            totalMax[i, j] = 0
        if(abs(total[i, j] + amax(-1*total)) < approximation):
            totalMin[i, j] = 1
        else:
            totalMin[i, j] = 0
    
#Make the plot
print("Amplitude:")
imshow(total, extent = [0, side, 0, side])
jet()
show()
print("Maxima:")
imshow(totalMax, extent = [0, side, 0, side])
jet()
show()
print("Minima:")
imshow(totalMin, extent = [0, side, 0, side])
jet()
show()