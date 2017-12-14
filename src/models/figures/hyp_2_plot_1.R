# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates the figures for the final report. 
#
# Usage: Rscript hyp_2_plot_1.R data/processed/var_price_margin.csv results/figures/hyp_2_plot_1.png 

library(tidyverse)
library(forcats)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]

destination_1 <- args[2]

var_price_margin <- read_csv(paste(root,origin_1,sep=""))

######################################################################################
#Plots for Hypothesis 2
######################################################################################

(hyp_2_plot_1 <- ggplot(var_price_margin)+
  geom_point(aes(x=operating_margin,y=var_price),alpha=0.3,color="#4B86B4")+
  coord_cartesian(xlim = c(-100,100))+
  theme_minimal()+
  geom_smooth(aes(x=operating_margin,y=var_price),method="lm")+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_continuous("Operating Profit")+
  ggtitle("Price Variation vs Operating Profit"))

ggsave(paste(root,destination_1,sep=""))

options(warn = 0)
