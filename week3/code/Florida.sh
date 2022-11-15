#!/bin/bash

x=$(rev <<< $1 | cut -d . -f2- | rev)
pdflatex $x.tex
pdflatex $x.tex
pdflatex $x.tex
evince $x.pdf &

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg