# Esteban Angel, Dec 2017
#
# This script takes the original datasets and performs some wrangling in order to make the visualization process easier. 
#
# Usage: Rscript var_price_margin.R data/original/fundamentals.csv data/original/prices.csv 
#        data/original/securities.csv data/processed/var_price_margin.csv 

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
#Wrangling for Hypothesis 2
######################################################################################

#This code compares the profitability of the companies and their returns and saves the resulting dataframe in a CSV.

var_price_margin <- fundamentals %>%  select(ticker = `Ticker Symbol`,
                                              period = `Period Ending`,
                                              operating_margin = `Operating Margin`) %>%
                                        left_join(prices,by=c("ticker" = "symbol","period" = "date")) %>% 
                                        select(ticker,period,operating_margin,price = close) %>% 
                                        group_by(ticker) %>% 
                                        mutate(var_price = price / lag(price) - 1)

write_csv(var_price_margin,paste(root,destination_1,sep=""))

#Code for enabling R warnings in the terminal again
options(warn = 0)
