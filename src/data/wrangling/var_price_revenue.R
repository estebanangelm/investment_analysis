# Esteban Angel, Dec 2017
#
# This script takes the original datasets and performs some wrangling in order to make the visualization process easier. 
#
# Usage: Rscript var_price_revenue.R data/original/fundamentals.csv data/original/prices.csv 
#        data/original/securities.csv data/processed/var_price_revenue.csv

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
#Wrangling for Hypothesis 1
######################################################################################

#This code gets the data from Fundamentals and creates two new columns with the variation year on year
#for revenue and price.
#Also, it discards the columns that are not important for this analysis and saves the dataframe in a CSV file.

var_price_revenue <- fundamentals %>%  select(ticker = `Ticker Symbol`,
                                              period = `Period Ending`,
                                              total_revenue = `Total Revenue`) %>%
                                        left_join(prices,by=c("ticker" = "symbol","period" = "date")) %>% 
                                        select(ticker,period,total_revenue,price = close) %>% 
                                        group_by(ticker) %>% 
                                        mutate(var_revenue = total_revenue / lag(total_revenue) - 1,
                                               var_price = price / lag(price) - 1)

write_csv(var_price_revenue,paste(root,destination_1,sep=""))

#Code for enabling R warnings in the terminal again
options(warn = 0)
