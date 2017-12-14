# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates the figures for the final report. 
#
# Usage: Rscript eda_plot_1.R data/processed/price_sector.csv results/figures/eda_plot_1.png 

library(tidyverse)
library(forcats)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

args <- commandArgs(trailingOnly = TRUE)

origin_1 <- args[1]
destination_1 <- args[2]

price_sector <- read_csv(paste(root,origin_1,sep=""))

######################################################################################
# Plots for EDA
######################################################################################

ggplot(price_sector)+
  geom_boxplot(aes(x=sector,y=var_price,fill=(sector == "Information Technology")),alpha=0.6)+
  geom_jitter(aes(x=sector,y=var_price),alpha=0.3,color="#4B86B4")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  ggtitle("Returns per sector")

ggsave(paste(root,destination_1,sep=""))

options(warn = 0)
