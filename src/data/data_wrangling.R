# Esteban Angel, Dec 2017
#
# This script takes the original datasets and performs some wrangling in order to make the visualization process easier. 
#
# Usage: Rscript data_wrangling.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv

library(tidyverse)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- "../../"

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]
origin_2 <- args[2]
origin_3 <- args[3]

destination_1 <- args[4]
destination_2 <- args[5]
destination_3 <- args[6]
destination_4 <- args[7]

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

######################################################################################
#Wrangling for Hypothesis 2
######################################################################################

#This code compares the profitability of the companies and their year on year returns and saves the resulting dataframe in a CSV.

var_price_margin <- fundamentals %>%  select(ticker = `Ticker Symbol`,
                                              period = `Period Ending`,
                                              operating_margin = `Operating Margin`) %>%
                                        left_join(prices,by=c("ticker" = "symbol","period" = "date")) %>% 
                                        select(ticker,period,operating_margin,price = close) %>% 
                                        group_by(ticker) %>% 
                                        mutate(var_price = price / lag(price) - 1)

write_csv(var_price_margin,paste(root,destination_2,sep=""))

######################################################################################
#Wrangling for EDA
######################################################################################

#This code chunk calculates the variations in price for each ticker with Sector and saves them in a CSV file.

prices_sector <- var_price_revenue %>% inner_join(securities,by = c("ticker" = "Ticker symbol")) %>% 
  select(ticker,var_price,sector = `GICS Sector`)

write_csv(prices_sector,paste(root,destination_3,sep=""))

#This code chunk calculates the market cap for each of the sectors and saves it to a CSV.

market_cap_sector <- fundamentals %>% select(ticker = `Ticker Symbol`,
                                             period = `Period Ending`,
                                             shares = `Estimated Shares Outstanding`) %>%
                                      left_join(prices,by=c("ticker" = "symbol","period" = "date")) %>% 
                                      select(ticker,period,shares,price = close) %>% 
                                      left_join(securities,by=c("ticker"="Ticker symbol")) %>% 
                                      select(ticker,period,shares,price,sector=`GICS Sector`) %>% 
                                      mutate(market_cap = price * shares) %>% 
                                      group_by(sector) %>% 
                                      summarize(total_market_cap = sum(market_cap,na.rm=TRUE))

write_csv(market_cap_sector,paste(root,destination_4,sep=""))


#Code for enabling R warnings in the terminal again
options(warn = 0)
