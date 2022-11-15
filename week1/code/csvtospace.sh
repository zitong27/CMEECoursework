#!/bin/sh
# Author: Zitong Zhao zitong.zhao22@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the commas in the files with space separated values
#
# Saves the output into a space separated values file
# Arguments: into space separated values file
# Date: Oct 2022


if [ $# -eq 0 ] ; then
  echo "error input"
      elif [ -f "$1" ] ; then

        echo "Creating a space separated values version of $1 ..."
        cat $1 | tr -s "," " " >> $1.ssv
        echo "Done!"
else
  echo "$1 is not a file"
fi
exit