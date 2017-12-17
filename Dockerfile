# Docker file for the project investment_analysis
# Esteban Angel, Dec, 2017

# use rocker/tidyverse as the base image
FROM rocker/tidyverse

# install the ezknitr packages
RUN Rscript -e "install.packages('ezknitr', repos = 'http://cran.us.r-project.org')"
