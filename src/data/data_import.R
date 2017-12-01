library(tidyverse)

options(warn = -1)

fundamentals <- read_csv("https://s3.ca-central-1.amazonaws.com/investment-analysis/fundamentals.csv")
prices <- read_csv("https://s3.ca-central-1.amazonaws.com/investment-analysis/prices-split-adjusted.csv")
securities <- read_csv("https://s3.ca-central-1.amazonaws.com/investment-analysis/securities.csv")

head(fundamentals)
head(prices)
head(securities)

write_csv(fundamentals,'../../data/original/fundamentals.csv')
write_csv(prices,'../../data/original/prices.csv')
write_csv(securities,'../../data/original/securities.csv')

options(warn = 0)



