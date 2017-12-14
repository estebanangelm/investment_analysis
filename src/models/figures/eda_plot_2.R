# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates the figures for the final report. 
#
# Usage: Rscript eda_plot_2.R data/processed/market_cap_sector.csv results/figures/eda_plot_2.png

library(tidyverse)
library(forcats)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]

destination_1 <- args[2]


market_cap_sector <- read_csv(paste(root,origin_1,sep=""))


######################################################################################
# Plots for EDA
######################################################################################

ggplot(market_cap_sector)+
  geom_col(aes(x=fct_reorder(sector,total_market_cap),y=total_market_cap),alpha=0.6,color="#4B86B4",fill="#4B86B4")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")+
  scale_y_continuous("Market Cap",labels = scales::dollar_format())+
  scale_x_discrete("")+
  ggtitle("Market Capitalization per Sector")

ggsave(paste(root,destination_1,sep=""))

options(warn = 0)
