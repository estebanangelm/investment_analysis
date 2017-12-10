# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates some statistical analysis for testing the hypotheses. 
#
# Usage: Rscript data_analysis_tests.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv

library(tidyverse)
library(forcats)
library(broom)

options(warn = -1)

root <- "../../"

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]
origin_2 <- args[2]
origin_3 <- args[3]
origin_4 <- args[4]

destination_1 <- args[5]
destination_2 <- args[6]
destination_3 <- args[7]
destination_4 <- args[8]
destination_5 <- args[9]

var_price_revenue <- read_csv(paste(root,origin_1,sep=""))
var_price_margin <- read_csv(paste(root,origin_2,sep=""))
price_sector <- read_csv(paste(root,origin_3,sep=""))
market_cap_sector <- read_csv(paste(root,origin_4,sep=""))

#Code for fitting a linear model between the variation in revenue and the variation in price

hyp_1_test_1 <- tidy(summary(lm(var_price_revenue$var_price~var_price_revenue$var_revenue)))

write_csv(hyp_1_test_1,paste(root,destination_1,sep=""))

#Number of observations where revenue increased and price increased
up_up <- var_price_revenue %>% filter(var_revenue>0,var_price>0) %>% 
  nrow()
up_down <- var_price_revenue %>% filter(var_revenue>0,var_price<0) %>% 
  nrow()
down_up <- var_price_revenue %>% filter(var_revenue<0,var_price>0) %>% 
  nrow()
down_down <- var_price_revenue %>% filter(var_revenue<0,var_price<0) %>% 
  nrow()

hyp_1_test_2 <-  data_frame(revenue = c("Increase","Increase","Decrease","Decrease"),
                     revenue = c("Increase","Decrease","Increase","Decrease"),
                     num_obs = c(up_up,up_down,down_up,down_down))

write_csv(hyp_1_test_2,paste(root,destination_2,sep=""))