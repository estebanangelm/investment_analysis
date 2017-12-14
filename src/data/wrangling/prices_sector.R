# Esteban Angel, Dec 2017
#
# This script takes the original datasets and performs some wrangling in order to make the visualization process easier. 
#
# Usage: Rscript prices_sector.R data/original/fundamentals.csv data/original/prices.csv 
#        data/original/securities.csv data/processed/price_sector.csv

library(tidyverse)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]
origin_2 <- args[2]
origin_3 <- args[3]

destination_1 <- args[4]

fundamentals <- read_csv(paste(root,origin_1,sep=""))
prices <- read_csv(paste(root,origin_2,sep=""))
securities <- read_csv(paste(root,origin_3,sep=""))


######################################################################################
#Wrangling for EDA
######################################################################################

#This code chunk calculates the variations in price for each ticker with Sector and saves them in a CSV file.

prices_sector <- var_price_revenue %>% inner_join(securities,by = c("ticker" = "Ticker symbol")) %>% 
  select(ticker,var_price,sector = `GICS Sector`)

write_csv(prices_sector,paste(root,destination_1,sep=""))


#Code for enabling R warnings in the terminal again
options(warn = 0)
