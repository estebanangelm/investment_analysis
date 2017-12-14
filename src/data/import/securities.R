# Esteban Angel, Dec 2017
#
# This script imports the securities dataset for the `investment_analysis` project from the Amazon S3 bucket. 
#
# Usage:  Rscript data_import.R securities data/original/securities.csv

library(tidyverse)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)
origin_1 <- args[1]
destination_1 <- args[2]


securities <- read_csv(paste("https://s3.ca-central-1.amazonaws.com/investment-analysis/",origin_1,".csv",sep=""))

write_csv(securities,paste(root,destination_1,sep=""))

#Code for enabling R warnings in the terminal again
options(warn = 0)