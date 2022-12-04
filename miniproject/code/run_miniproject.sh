#!/bin/bash
# Desc: Runs MiniProject and compiles LaTeX report

python3 IDData.py

Rscript Population.R

pdflatex report.tex
bibtex report.aux
pdflatex report.tex
pdflatex report.tex

## Cleanup
rm *.aux
rm *.log
rm *.bbl
rm *.blg
echo "Compiled LaTeX report"