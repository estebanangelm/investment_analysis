# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates the figures for the final report. 
#
# Usage: Rscript hyp_1_plot_2.R data/processed/var_price_revenue.csv results/figures/hyp_1_plot_2.png

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

(hyp_1_plot_2 <- ggplot(var_price_revenue %>% filter(var_revenue != "NA"))+
  geom_boxplot(aes(x=var_revenue>0,y=var_price),alpha=0.3,color="#4B86B4",fill="#4B86B4")+
  theme_minimal()+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_discrete("YoY Revenue Increase")+
  ggtitle("Price Variation vs Revenue Variation"))

ggsave(paste(root,destination_1,sep=""))

options(warn = 0)
