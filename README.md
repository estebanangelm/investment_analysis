# Investment Analysis
The purpose of this data analysis project is identifying some patterns of successful and unsuccessful companies in the Standard & Poors index. The S&P 500 is an index of 505 companies in the United States stock market which have a market capitalization of at least $6.1 billion. In other words, it's a group of the most relevant public companies in the United States.

[More information about the S&P 500](https://www.investopedia.com/terms/s/sp500.asp)

This patterns can help us to select them or discard them from our portfolio. There are two approaches to making investment decisions:

- **Fundamental analysis:** takes the real business indicators from a company to help decide about investments. This is the approach investors like Warren Buffet use, contrasting the real situation of the business with its temporal price in the market. If a company has solid indicators and they aren't reflected in the stock price, there's a temporal opportunity for creating wealth from that difference.

- **Technical analysis:** tries to find patterns in the time series of prices. It's focused in the short term. For this project, all my analysis will be fundamental, based on the financial information of the companies and not the technical analysis.

[More information about Fundamental vs Technical Analysis ](https://www.investopedia.com/university/technical/techanalysis2.asp)


## Hypotheses

For this project I will try to test some hypothesis about the companies in the S&P 500:

1. Companies that increase their revenue year on year also increase their stock price.

2. Information Technology companies have higher price returns than the rest of the companies in other sectors.

3. Companies with high profitability have high investment returns for stockholders.

These hypotheses are general and can give us a snapshot of internal business variables that affect the performance of a stock in the market. In the future, the idea with this project is going to another level of fundamental analysis. I want to find the relation between the quality of the people leading a business and the results of the companies and also analyzing the official communications using NLP.

## Project Workflow

This data analysis project will follow the following steps:

1. **Download the financial data from the last four years of the S&P**. This includes three tables of data: the list of companies with their profile information, the financial statements for these companies in the last four years and the price history of the stocks in the index for the last four years.

2. **Exploratory data analysis**: this part of the analysis includes some general plots and analysis of the results of the companies in the S&P 500 index and the evolution in the stock prices.

3. **Hypothesis validation**: each hypothesis will be analyzed on separate scripts.

4. **Results report**: the results of the EDA and the hypothesis validation will be stored in a final document.

## Data Sources

The data sources used for this project come from the [Kaggle's New York Stock Exchange Dataset](https://www.kaggle.com/dgawlik/nyse/data). For the convenience of the user these datasets are hosted on an Amazon S3 Bucket. This project includes three datasets with connections between them:

1. [Securities](https://s3.ca-central-1.amazonaws.com/investment-analysis/securities.csv): includes the list of the companies that 
2. [Fundamentals](https://s3.ca-central-1.amazonaws.com/investment-analysis/fundamentals.csv): includes the financial statements (income statement, balance sheet and cashflow) of the companies listed in the S&P 500 for the last 5 years.
3. [Prices](https://s3.ca-central-1.amazonaws.com/investment-analysis/prices-split-adjusted.csv): includes the daily price (open, high, low and close) for each company in the last 5 years in the S&P 500.

