#!/usr/bin/env python3

"""aligns two DNA sequences, returns the best match,
 and count the “score” as total of number of bases matched."""

__appname__ = 'align_seqs.py'
__author__ = 'Zitong Zhao (zitong.zhao22@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Two example sequences to match
seq2 = []
seq1 = []

import csv

with open("../data/aligntest.csv", "r") as f:
    line = f.readlines()
    seq2 = line[0]
    seq1 = line[1]


# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths


def calculate_score(s1, s2, l1, l2, startpoint):
    '''A function that computes a score by returning the number of matches starting
    from arbitrary startpoint (chosen by user)'''
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)


with open('../data/alignseqs.txt','w') as g:
    g.write("my best align is "+ str(my_best_align) + '\n'+str(s1) + '\n'+"Best score:" + str(my_best_score))





