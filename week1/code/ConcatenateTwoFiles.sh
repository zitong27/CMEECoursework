#!/bin/bash
if [ $# -eq 0 ] || [ $# -eq 1 ] ; then
  echo "error input"

else
  cat $1 > $3
  cat $2 >> $3
  echo "Merged File is"
  cat $3
fi
exit