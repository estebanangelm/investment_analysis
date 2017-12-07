library(tidyverse)

# Esteban Angel, Dec 2017
#
# This script imports the datasets for the `investment_analysis` project from Amazon S3. 
#
# Usage: Rscript data_import.R fundamentals prices securities data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv

options(warn = -1)

root <- "../../"

args <- commandArgs(trailingOnly = TRUE)
file_name_1 <- args[1]
file_name_2 <- args[2]
file_name_3 <- args[3]
destination_1 <- args[4]
destination_2 <- args[5]
destination_3 <- args[6]




fundamentals <- read_csv(paste("https://s3.ca-central-1.amazonaws.com/investment-analysis/",file_name_1,".csv",sep=""))
#prices <- read_csv(paste("https://s3.ca-central-1.amazonaws.com/investment-analysis/",file_name_2,".csv",sep=""))
securities <- read_csv(paste("https://s3.ca-central-1.amazonaws.com/investment-analysis/",file_name_3,".csv",sep=""))

write_csv(fundamentals,paste(root,destination_1,sep=""))
#write_csv(prices,paste(root,destination_2,sep=""))
write_csv(securities,paste(root,destination_3,sep=""))

options(warn = 0)



