# Make File
# Esteban Angel December 2017
# This script runs all the scripts for creating the report.
#
# usage: make all

all: doc/report/report.md

#########################
# Scripts for Data Import
#########################

data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv: src/data/data_import.R
	Rscript src/data/data_import.R fundamentals prices securities data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv

#########################
# Script for Data Wrangling
#########################

data/processed/market_cap_sector.csv data/processed/prices_sector.csv data/processed/var_price_margin.csv data/processed/var_price_revenue.csv  : data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv src/data/data_wrangling.R
	Rscript src/data/data_wrangling.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv

#########################
# Script for creating Figures
#########################

results/figures/eda_plot_1.png results/figures/eda_plot_2.png results/figures/hyp_1_plot_1.png results/figures/hyp_1_plot_2.png results/figures/hyp_2_plot_1.png: data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv src/models/data_analysis_figures.R
	Rscript src/models/data_analysis_figures.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv results/figures/hyp_1_plot_1.png results/figures/hyp_1_plot_2.png results/figures/hyp_2_plot_1.png results/figures/eda_plot_1.png results/figures/eda_plot_2.png

#########################
# Script for creating Tests
#########################

results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv results/tests/hyp_2_test_1.csv: data/processed/var_price_revenue.csv data/processed/var_price_margin.csv src/models/data_analysis_tests.R
	Rscript src/models/data_analysis_tests.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv results/tests/hyp_2_test_1.csv

#########################
# Script for creating Final Report
#########################

doc/report/report.md: src/reports/report.Rmd results/figures/eda_plot_1.png results/figures/eda_plot_2.png results/figures/hyp_1_plot_1.png results/figures/hyp_1_plot_2.png results/figures/hyp_2_plot_1.png results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv results/tests/hyp_2_test_1.csv
	Rscript -e 'ezknitr::ezknit("src/reports/report.Rmd", out_dir="./doc/report/")'

#########################
# Clean Intermediate Files
#########################

clean:
	rm -f data/original/fundamentals.csv
	rm -f data/original/prices.csv
	rm -f data/original/securities.csv
	rm -f data/processed/market_cap_sector.csv
	rm -f data/processed/price_sector.csv
	rm -f data/processed/var_price_margin.csv
	rm -f data/processed/var_price_revenue.csv
	rm -f results/tests/hyp_1_test_1.csv
	rm -f results/tests/hyp_1_test_2.csv
	rm -f results/tests/hyp_2_test_1.csv
	rm -f Rplots.pdf
	rm -f doc/report/report.md
	rm -f doc/report/report.html
