# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates some statistical analysis for testing the hypotheses. 
#
# Usage: Rscript hyp_2_test_1.R data/processed/var_price_margin.csv results/tests/hyp_2_test_1.csv

library(tidyverse)
library(forcats)
library(broom)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]

destination_1 <- args[2]

var_price_margin <- read_csv(paste(root,origin_1,sep=""))

######################################################################################
## Tests for Hypothesis 2
######################################################################################

#Code for fitting a linear model between operating margin and the variation in price

hyp_2_test_1 <- tidy(summary(lm(var_price_margin$var_price~var_price_margin$operating_margin)))

write_csv(hyp_2_test_1,paste(root,destination_1,sep=""))

#Code for enabling R warnings in the terminal again
options(warn = 0)