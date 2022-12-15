#!/usr/bin/env python3

'''The Lotka-Volterra model revisited'''

import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
import sys


if len(sys.argv) == 6:
    r = float(sys.argv[1])
    K = float(sys.argv[2])
    a = float(sys.argv[3])
    z = float(sys.argv[4])
    e = float(sys.argv[5])  
else:

    r = 1.    #intrinsic (per-capita) growth rate of the resource population 
    a = 0.1   #per-capita “search rate” for the resource () multiplied by its attack success probability
    z = 1.5   #mortality rate
    e = 0.75  #consumer’s efficiency (a fraction) in converting resource to consumer biomass.
    K = 100  #resource population’s carrying capacity

def dCR_dt(pops, t=0):
    ''' growth rate of consumer and resource population 
    at any given time step'''
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - R / K) - a * R * C 
    dCdt = -z * C + e * a * R * C
    return np.array([dRdt, dCdt])


t = np.linspace(0, 15, 1000)
R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

def plot1(t,pops):
    '''draw plot'''
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    f1.savefig('../results/LV2_model.pdf')
    return 0

def plot2(pops):
    '''draw plot'''
    f2 = p.figure()
    p.figure
    p.plot(pops[:,0],pops[:,1],'r-')
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics')
    f2.savefig('../results/LV2_model2.pdf')
    return 0


plot1(t,pops)
plot2(pops)
