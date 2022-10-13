#!/bin/sh
# Author: Zitong Zhao zitong.zhao22@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2022
if [ $# -eq 0 ] ; then
  echo "error input"
    elif [ -f "$1" ] ; then
      echo "Creating a comma delimited version of $1 ..."
      cat $1 | tr -s "\t" "," >> $1.csv
      echo "Done!"
else
  echo "$1 is not a file"
fi
exit