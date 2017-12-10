# Driver script
# Date: December 2017
# This script is used for creating the knitted md report in the results directory.
# usage: bash run_report.sh

#create report

Rscript -e 'ezknitr::ezknit("./report.Rmd", out_dir="../../doc/report/")'
