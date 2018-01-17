# -*- coding: utf-8 -*-
import numpy as np
import pylab as pl
#import scipy as sp

n = 1024

t = np.linspace(0,2*np.pi*(n-1)/n,n)

#print(t)

d = np.sin(t)

#print(d)

d = d/2*65534

d = np.rint(d)

print(d)

#ref: http://stackoverflow.com/questions/21871829/twos-complement-of-numbers-in-python
d = np.bitwise_and(d,0xffff,dtype=np.uint16)
#print(d)
#d = d.astype(np.int16)

print(d)
pl.plot(d)
np.savetxt('data.txt', d , '%0X', newline='\r\n')
