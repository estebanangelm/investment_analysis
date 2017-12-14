# Make File
# Esteban Angel December 2017
# This script runs all the scripts for creating the report.
#
# usage: make all

all: src/reports/report.Rmd

#########################
# Scripts for Data Import
#########################

#data/original/fundamentals.csv : src/data/import/fundamentals.R
	#Rscript src/data/import/fundamentals.R fundamentals data/original/fundamentals.csv

#data/original/prices.csv : src/data/import/prices.R
	#Rscript src/data/import/prices.R prices data/original/prices.csv

#data/original/securities.csv : src/data/import/securities.R
	#Rscript src/data/import/securities.R securities data/original/securities.csv

#########################
# Scripts for Data Wrangling
#########################

data/processed/market_cap_sector.csv : src/data/wrangling/market_cap_sector.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv
	Rscript src/data/wrangling/market_cap_sector.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/market_cap_sector.csv

data/processed/prices_sector.csv : src/data/wrangling/prices_sector.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv
	Rscript src/data/wrangling/prices_sector.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/price_sector.csv

data/processed/var_price_margin.csv : src/data/wrangling/var_price_margin.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv
	Rscript src/data/wrangling/var_price_margin.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/var_price_margin.csv

data/processed/var_price_revenue.csv : src/data/wrangling/var_price_revenue.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv
	Rscript src/data/wrangling/var_price_revenue.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/var_price_revenue.csv

#########################
# Scripts for creating Figures
#########################

results/figures/eda_plot_1.png : src/models/figures/eda_plot_1.R data/processed/prices_sector.csv
	Rscript src/models/figures/eda_plot_1.R data/processed/price_sector.csv results/figures/eda_plot_1.png

results/figures/eda_plot_2.png : src/models/figures/eda_plot_2.R data/processed/market_cap_sector.csv
	Rscript src/models/figures/eda_plot_2.R data/processed/market_cap_sector.csv results/figures/eda_plot_2.png

results/figures/hyp_1_plot_1.png : src/models/figures/hyp_1_plot_1.R data/processed/var_price_revenue.csv
	Rscript src/models/figures/hyp_1_plot_1.R data/processed/var_price_revenue.csv results/figures/hyp_1_plot_1.png

results/figures/hyp_1_plot_2.png : src/models/figures/hyp_1_plot_2.R data/processed/var_price_revenue.csv
	Rscript src/models/figures/hyp_1_plot_2.R data/processed/var_price_revenue.csv results/figures/hyp_1_plot_2.png

results/figures/hyp_2_plot_1.png : src/models/figures/hyp_2_plot_1.R data/processed/var_price_margin.csv
	Rscript src/models/figures/hyp_2_plot_1.R data/processed/var_price_margin.csv results/figures/hyp_2_plot_1.png

#########################
# Scripts for creating Tests
#########################

results/tests/hyp_1_test_1.csv : src/models/tests/hyp_1_test_1.R data/processed/var_price_revenue.csv
	Rscript src/models/tests/hyp_1_test_1.R data/processed/var_price_revenue.csv results/tests/hyp_1_test_1.csv

results/tests/hyp_1_test_2.csv : src/models/tests/hyp_1_test_2.R data/processed/var_price_revenue.csv
	Rscript src/models/tests/hyp_1_test_2.R data/processed/var_price_revenue.csv results/tests/hyp_1_test_2.csv

results/tests/hyp_2_test_1.csv : src/models/tests/hyp_2_test_1.R data/processed/var_price_margin.csv
	Rscript src/models/tests/hyp_2_test_1.R data/processed/var_price_margin.csv results/tests/hyp_2_test_1.csv

#########################
# Script for creating Final Report
#########################

src/reports/report.Rmd: results/figures/eda_plot_1.png results/figures/eda_plot_2.png results/figures/hyp_1_plot_1.png results/figures/hyp_1_plot_2.png results/figures/hyp_2_plot_1.png results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv results/tests/hyp_2_test_1.csv
	Rscript -e 'ezknitr::ezknit("src/reports/report.Rmd", out_dir="./doc/report/")'
