# Esteban Angel, Dec 2017
#
# This script takes the processed datasets and creates the figures for the final report. 
#
# Usage: Rscript data_analysis_figures.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv 
#        data/processed/price_sector.csv data/processed/market_cap_sector.csv results/figures/hyp_1_plot_1.png 
#        results/figures/hyp_1_plot_2.png results/figures/hyp_2_plot_1.png results/figures/eda_plot_1.png 
#        results/figures/eda_plot_2.png

library(tidyverse)
library(forcats)

#Code for disabling R warnings in the terminal
options(warn = -1)

root <- ""

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

(hyp_1_plot_2 <- ggplot(var_price_revenue %>% filter(var_revenue != "NA"))+
  geom_boxplot(aes(x=var_revenue>0,y=var_price),alpha=0.3,color="#4B86B4",fill="#4B86B4")+
  theme_minimal()+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_discrete("YoY Revenue Increase")+
  ggtitle("Price Variation vs Revenue Variation"))

ggsave(paste(root,destination_2,sep=""))

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

ggsave(paste(root,destination_3,sep=""))

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

ggsave(paste(root,destination_4,sep=""))

ggplot(market_cap_sector)+
  geom_col(aes(x=fct_reorder(sector,total_market_cap),y=total_market_cap),alpha=0.6,color="#4B86B4",fill="#4B86B4")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")+
  scale_y_continuous("Market Cap",labels = scales::dollar_format())+
  scale_x_discrete("")+
  ggtitle("Market Capitalization per Sector")

ggsave(paste(root,destination_5,sep=""))

options(warn = 0)
