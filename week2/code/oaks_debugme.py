import csv
import sys
import doctest
    

#Define function
def is_an_oak(name):
    
    '''
    >>> is_an_oak('Genus, species')
    False
    >>> is_an_oak('Quercus, robur')
    True
    >>> is_an_oak('Fraxinus, excelsior')
    False
    >>> is_an_oak('Pinus, sylvestris')
    False
    >>> is_an_oak('Quercus, cerris')
    True
    >>> is_an_oak('Quercus, petraea')
    True
    >>> is_an_oak('Quercuss, petraea')
    True
    
    '''
    """ Returns True if name is starts with 'quercs' """
    
    return name.lower().startswith('quercus')
doctest.testmod()


def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)


