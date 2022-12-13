#!/usr/bin/env python3

""" Excercise file on python conditions """

__appname__ = 'cfexercises1.py'
__author__ = 'Zitong Zhao (zitong.zhao22@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys

def foo_1(x):
    '''calculation'''
    return x ** 0.5

def foo_2(x, y):
    '''calculation'''
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    '''calculation'''
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    '''calculation'''
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x): 
    ''' a recursive function that calculates the factorial of x'''
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x): 
    ''' Calculate the factorial of x in a different way; no if statement involved'''
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    """ Main entry point of the program """
    print(foo_1(5))
    print(foo_2(10,15))
    print(foo_3(20,15,10))
    print(foo_4(10))
    print(foo_5(10))
    return 0

if (__name__ == "__main__"):
    """Makes sure the "main" function is called from command line""" 
    status = main(sys.argv)
    sys.exit(status)