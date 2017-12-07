library(tidyverse)

options(warn = -1)

fundamentals <- read_csv('../../data/original/fundamentals.csv')
prices <- read_csv('../../data/original/prices.csv')
securities <- read_csv('../../data/original/securities.csv')

#This code gets the data from Fundamentals and creates two new columns with the variation year on year for revenue and price
#Also, it discards the columns that are not important for this analysis

var_price_revenue <- fundamentals %>%  select(ticker = `Ticker Symbol`,
                                              period = `Period Ending`,
                                              total_revenue = `Total Revenue`) %>%
                                        left_join(prices,by=c("ticker" = "symbol","period" = "date")) %>% 
                                        select(ticker,period,total_revenue,price = close) %>% 
                                        group_by(ticker) %>% 
                                        mutate(var_revenue = total_revenue / lag(total_revenue) - 1,
                                               var_price = price / lag(price) - 1)

#This code saves the previous wrangled dataframe in a CSV in the data folder. Will help solve hypothesis 1.

write_csv(var_price_revenue,'../../data/processed/var_price_revenue.csv')

#This code compares the profitability of the companies and their year on year returns

var_price_margin <- fundamentals %>%  select(ticker = `Ticker Symbol`,
                                              period = `Period Ending`,
                                              operating_margin = `Operating Margin`) %>%
                                        left_join(prices,by=c("ticker" = "symbol","period" = "date")) %>% 
                                        select(ticker,period,operating_margin,price = close) %>% 
                                        group_by(ticker) %>% 
                                        mutate(var_price = price / lag(price) - 1)

#This code saves the previous wrangled dataframe in a CSV in the data folder. Will help solve hypothesis 1.

write_csv(var_price_margin,'../../data/processed/var_price_margin.csv')

#The dataframe for hypothesis 2 requires a join between the var_price_revenue dataset and the securities dataset

prices_sector <- var_price_revenue %>% inner_join(securities,by = c("ticker" = "Ticker symbol")) %>% 
  select(ticker,var_price,sector = `GICS Sector`)

#I save this dataframe in an additional csv for the analysis.

write_csv(prices_sector,'../../data/processed/price_sector.csv')

options(warn = 0)
