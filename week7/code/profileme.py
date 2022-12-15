#!/usr/bin/env python3

'''find out what is slowing down the code '''
def my_squares(iters):
    '''calculation'''
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    '''calculation'''
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    '''calculation'''
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")