# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates some statistical analysis for testing the hypotheses. 
#
# Usage: Rscript hyp_1_test_2.R data/processed/var_price_revenue.csv results/tests/hyp_1_test_2.csv

library(tidyverse)
library(forcats)
library(broom)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]

destination_1 <- args[2]


var_price_revenue <- read_csv(paste(root,origin_1,sep=""))

######################################################################################
## Tests for Hypothesis 1
######################################################################################

#Code for finding the number of observations with different movements in price and revenue
up_up <- var_price_revenue %>% filter(var_revenue>0,var_price>0) %>% nrow()
up_down <- var_price_revenue %>% filter(var_revenue>0,var_price<0) %>% nrow()
down_up <- var_price_revenue %>% filter(var_revenue<0,var_price>0) %>% nrow()
down_down <- var_price_revenue %>% filter(var_revenue<0,var_price<0) %>% nrow()

hyp_1_test_2 <-  data_frame(revenue = c("Increase","Increase","Decrease","Decrease"),
                     price = c("Increase","Decrease","Increase","Decrease"),
                     num_obs = c(up_up,up_down,down_up,down_down))

write_csv(hyp_1_test_2,paste(root,destination_1,sep=""))

#Code for enabling R warnings in the terminal again
options(warn = 0)