# Driver script
# Date: December 2017
# Author: Esteban Angel
# This is the master driver script which executes the other scripts.
# usage: bash run_all.sh

#Runs script for importing data
Rscript src/data/data_import.R fundamentals prices securities data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv

#Runs script for  data wrangling
Rscript src/data/data_wrangling.R data/original/fundamentals.csv data/original/prices.csv data/original/securities.csv data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv

#Runs script for creating the figures
Rscript src/models/data_analysis_figures.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv data/processed/price_sector.csv data/processed/market_cap_sector.csv results/figures/hyp_1_plot_1.png results/figures/hyp_1_plot_2.png results/figures/hyp_2_plot_1.png results/figures/eda_plot_1.png results/figures/eda_plot_2.png

#Runs script for creating the tests
Rscript src/models/data_analysis_tests.R data/processed/var_price_revenue.csv data/processed/var_price_margin.csv results/tests/hyp_1_test_1.csv results/tests/hyp_1_test_2.csv results/tests/hyp_2_test_1.csv

#Run scripts for creating the report
Rscript -e 'ezknitr::ezknit("src/reports/report.Rmd", out_dir="./doc/report/")'
