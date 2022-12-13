#!/usr/bin/env python3

"""save the tree height"""

__appname__ = 'get_TreeHeight.py'
__author__ = 'Zitong Zhao (zitong.zhao22@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
import pandas as pd
import numpy as np



def treeheight(degrees, distance):
    '''tree height function'''
    radians = np.radians(degrees)
    height = distance * np.tan(radians)
    return height


def main(argv):
    """Parse filename and execute tree height calculation."""
    if len(argv) == 2:
        file=sys.argv[1]
        filename=file.split(".")[0]
        df=pd.read_csv(file)
        df["Tree.Height.m"]=treeheight(df["Angle.degrees"],df["Distance.m"])
        filename=file.split("/")[-1]
        filename=filename.split(".")[0]
        outpath=(f"../results/{filename}_TreeHeights_py.csv")
        df.to_csv(outpath,index=False)
        print("Tree height data saved as "+outpath)
    else:
        print("Please specify one csv file with tree measurement data (degrees,distance).")
    


    
if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
