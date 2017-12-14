# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates some statistical analysis for testing the hypotheses. 
#
# Usage: Rscript data_analysis_tests.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv 
#        results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv results/tests/hyp_2_test_1.csv

library(tidyverse)
library(forcats)
library(broom)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]
origin_2 <- args[2]

destination_1 <- args[3]
destination_2 <- args[4]
destination_3 <- args[5]

var_price_revenue <- read_csv(paste(root,origin_1,sep=""))
var_price_margin <- read_csv(paste(root,origin_2,sep=""))

######################################################################################
## Tests for Hypothesis 1
######################################################################################

#Code for fitting a linear model between the variation in revenue and the variation in price

hyp_1_test_1 <- tidy(summary(lm(var_price_revenue$var_price~var_price_revenue$var_revenue)))

write_csv(hyp_1_test_1,paste(root,destination_1,sep=""))

#Code for finding the number of observations with different movements in price and revenue
up_up <- var_price_revenue %>% filter(var_revenue>0,var_price>0) %>% nrow()
up_down <- var_price_revenue %>% filter(var_revenue>0,var_price<0) %>% nrow()
down_up <- var_price_revenue %>% filter(var_revenue<0,var_price>0) %>% nrow()
down_down <- var_price_revenue %>% filter(var_revenue<0,var_price<0) %>% nrow()

hyp_1_test_2 <-  data_frame(revenue = c("Increase","Increase","Decrease","Decrease"),
                     price = c("Increase","Decrease","Increase","Decrease"),
                     num_obs = c(up_up,up_down,down_up,down_down))

write_csv(hyp_1_test_2,paste(root,destination_2,sep=""))

######################################################################################
## Tests for Hypothesis 2
######################################################################################

#Code for fitting a linear model between operating margin and the variation in price

hyp_2_test_1 <- tidy(summary(lm(var_price_margin$var_price~var_price_margin$operating_margin)))

write_csv(hyp_2_test_1,paste(root,destination_3,sep=""))

#Code for enabling R warnings in the terminal again
options(warn = 0)