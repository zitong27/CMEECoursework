#!/usr/bin/env python3

""" Save the elements of a list to a file """

#############################
# FILE OUTPUT
#############################

list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end

f.close()   