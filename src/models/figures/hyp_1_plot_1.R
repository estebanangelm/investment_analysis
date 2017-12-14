# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates the figures for the final report. 
#
# Usage: Rscript hyp_1_plot_1.R data/processed/var_price_revenue.csv results/figures/hyp_1_plot_1.png 

library(tidyverse)
library(forcats)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]

destination_1 <- args[2]

var_price_revenue <- read_csv(paste(root,origin_1,sep=""))

######################################################################################
#Plots for Hypothesis 1
######################################################################################

hyp_1_plot_1 <- ggplot(var_price_revenue)+
  geom_point(aes(x=var_revenue,y=var_price),alpha=0.3,color="#4B86B4")+
  coord_cartesian(xlim = c(-0.5,0.5))+
  theme_minimal()+
  geom_smooth(aes(x=var_revenue,y=var_price),method="lm")+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_continuous("Revenue Variation",labels = scales::percent_format())+
  ggtitle("Price Variation vs Revenue Variation")

ggsave(paste(root,destination_1,sep=""))

options(warn = 0)
