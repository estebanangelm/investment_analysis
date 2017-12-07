library(tidyverse)
library(forcats)

options(warn = -1)

var_price_revenue <- read_csv('../../data/processed/var_price_revenue.csv')
var_price_margin <- read_csv('../../data/processed/var_price_margin.csv')
price_sector <- read_csv('../../data/processed/price_sector.csv')
market_cap_sector <- read_csv('../../data/processed/market_cap_sector.csv')

#Hypothesis 1

hyp_1_plot_1 <- ggplot(var_price_revenue)+
  geom_point(aes(x=var_revenue,y=var_price),alpha=0.3,color="#4B86B4")+
  coord_cartesian(xlim = c(-0.5,0.5))+
  theme_minimal()+
  geom_smooth(aes(x=var_revenue,y=var_price),method="lm")+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_continuous("Revenue Variation",labels = scales::percent_format())+
  ggtitle("Price Variation vs Revenue Variation")

ggsave("../../results/figures/hyp_1_plot_1.png")

(hyp_1_plot_2 <- ggplot(var_price_revenue %>% filter(var_revenue != "NA"))+
  geom_boxplot(aes(x=var_revenue>0,y=var_price),alpha=0.3,color="#4B86B4",fill="#4B86B4")+
  theme_minimal()+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_discrete("YoY Revenue Increase")+
  ggtitle("Price Variation vs Revenue Variation"))

ggsave("../../results/figures/hyp_1_plot_2.png")

#Hypothesis 2

(hyp_2_plot_1 <- ggplot(var_price_margin)+
  geom_point(aes(x=operating_margin,y=var_price),alpha=0.3,color="#4B86B4")+
  coord_cartesian(xlim = c(-100,100))+
  theme_minimal()+
  geom_smooth(aes(x=operating_margin,y=var_price),method="lm")+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  scale_x_continuous("Revenue Variation")+
  ggtitle("Price Variation vs Revenue Variation"))

ggsave("../../results/figures/hyp_1_plot_1.png")

#EDA 1

ggplot(price_sector)+
  geom_boxplot(aes(x=sector,y=var_price,fill=(sector == "Information Technology")),alpha=0.6)+
  geom_jitter(aes(x=sector,y=var_price),alpha=0.3,color="#4B86B4")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")+
  scale_y_continuous("Price Variation",labels = scales::percent_format())+
  ggtitle("Returns per sector")

ggsave("../../results/figures/eda_plot_1.png")

#EDA 2

ggplot(market_cap_sector)+
  geom_col(aes(x=fct_reorder(sector,total_market_cap),y=total_market_cap),alpha=0.6,color="#4B86B4",fill="#4B86B4")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position="none")+
  scale_y_continuous("Market Cap",labels = scales::dollar_format())+
  scale_x_discrete("")+
  ggtitle("Market Capitalization per Sector")

ggsave("../../results/figures/eda_plot_2.png")




options(warn = 0)
